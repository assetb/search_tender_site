/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.bo.Lot;
import com.altaik.bo.Purchase;
import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.rest.models.Table;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
@Path("web/api/search")
public class SearchController {

    @Inject
    IDatabaseManager dbManager;

    public SearchController() {
    }

    private String arrayToString(List<Integer> array) {
        String arrayString = "";
        for (Integer value : array) {
            arrayString += (arrayString.isEmpty() ? "" : ", ") + value;
        }
        return arrayString;
    }

    @GET
    @Consumes(MediaType.TEXT_HTML)
    @Path("info")
    public String Info() {
        return "This module is designed for communication with search altatendet.kz site system";
    }

    @GET
    @Path("")
    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
    @Produces({MediaType.TEXT_PLAIN, MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Table<Purchase> Search(
            @Context HttpServletResponse response,
            @DefaultValue("") @QueryParam("query") String query,
            @QueryParam("regions") List<Integer> regions,
            @QueryParam("methods") List<Integer> methods,
            @QueryParam("sources") List<Integer> sources,
            @QueryParam("minSum") Double minSum,
            @QueryParam("maxSum") Double maxSum,
            @QueryParam("startDate") String startDate,
            @QueryParam("endDate") String endDate,
            @DefaultValue("1") @QueryParam("sort") int sort,
            @DefaultValue("1") @QueryParam("page") int page,
            @DefaultValue("30") @QueryParam("maxCount") int maxCount) {

        String tabquerybegin = "SELECT p.id,l.negnumber as negnumber, l.number as lotnumber, p.sourcename, p.methodname, p.regionname, p.source,concat(p.runame,'') AS pruname,p.startday as pstarday,p.endday,p.venue,p.method,l.runame as lruname,l.rudescription as rudescription,l.sum as sum,l.deliveryplace, p.isdocs, p.docszip";
        String maxquerybegin = "SELECT count(p.id) as count";
        String queryend = " FROM procpurchase_view p LEFT JOIN lots l ON p.number=l.negnumber WHERE p.dendday >=now()";
        String querycountend = " FROM procpurchase_view p LEFT JOIN lots l ON p.number=l.negnumber WHERE p.dendday >=now()";

        if (!query.isEmpty()) {
            String namelike = query;
            String prunamelike = "";
            String lrunamelike = "";
            String lrudesclike = "";
            String lnumberlike = "";
            String[] keywords = namelike.split(" ");

            for (String keyword : keywords) {
                keyword = keyword.toLowerCase();
                keyword = keyword.replaceAll("(ого|ие|ая|ое|ой|ый|ые|ых|их|а|е|о|ы|у|ю|и|ь)$", "");
                prunamelike += (prunamelike.isEmpty() ? "" : " AND ") + "p.runame LIKE '%" + keyword + "%'";
                lrunamelike += (lrunamelike.isEmpty() ? "" : " AND ") + "l.runame LIKE '%" + keyword + "%'";
                lrudesclike += (lrudesclike.isEmpty() ? "" : " AND ") + "l.rudescription LIKE '%" + keyword + "%'";
                lnumberlike += (lnumberlike.isEmpty() ? "" : " AND ") + "l.negnumber LIKE '%" + keyword + "%'";
            }

            queryend += " AND ((" + prunamelike + ") OR (" + lrunamelike + ") OR (" + lrudesclike + ") OR (" + lnumberlike + "))";
        }
        if (regions != null && regions.size() > 0) {
            queryend += " AND (p.venue IN (" + arrayToString(regions) + ") OR p.venue is null)";
        }

        if (methods != null && methods.size() > 0) {
            queryend += " AND (p.method IN (" + arrayToString(methods) + ") OR p.method is null)";
        }

        if (sources != null && sources.size() > 0) {
            queryend += " AND (p.source IN (" + arrayToString(sources) + ") OR p.method is null)";
        }

        if (minSum != null && minSum > 0) {
            queryend += " AND l.sum >= " + minSum;
        }

        if (maxSum != null && maxSum > 0) {
            queryend += " AND l.sum <= " + maxSum;
        }

        if (startDate != null) {
            queryend += " AND p.dstartday >= STR_TO_DATE('" + startDate + "', '%Y-%m-%d')";
        }
        if (endDate != null) {
            queryend += " AND p.dstartday <= STR_TO_DATE('" + endDate + "', '%Y-%m-%d')";
        }

        if (page < 1) {
            page = 1;
        }

        switch (sort) {
            case (2): {
                queryend += " ORDER BY l.isum desc, p.dendday";
            }
            break;
            default: {
                queryend += " ORDER BY l.isum desc";
            }
            break;
        }

        maxquerybegin += queryend;

        queryend += " LIMIT " + ((page - 1) * maxCount) + "," + maxCount;

        ResultSet countResultSet = dbManager.Execute(maxquerybegin);
        ResultSet queryResultSet = dbManager.Execute(tabquerybegin + queryend);

        Table<Purchase> table = new Table<>();
        table.currentPage = page;

        try {
            if (countResultSet.first()) {
                table.countItems = countResultSet.getInt("count");
            }

            while (queryResultSet.next()) {
                Purchase purchase = new Purchase();
                Lot lot = new Lot();
                purchase.lots = new ArrayList<>();
                purchase.lots.add(lot);

                //purchase
                purchase.number = queryResultSet.getString("negnumber");
//                purchase.source = queryResultSet.getString("sourcename");
                purchase.ruName = queryResultSet.getString("pruname");
                purchase.startDay = queryResultSet.getString("pstarday");
                purchase.endDay = queryResultSet.getString("endday");
                purchase.venue = queryResultSet.getString("regionname");
                purchase.method = queryResultSet.getString("methodname");
                purchase.isDocs = queryResultSet.getInt("isdocs");
                purchase.sum = queryResultSet.getString("sum");

                //lot
                lot.lotNumber = queryResultSet.getString("lotnumber");
                lot.ruName = queryResultSet.getString("lruname");
                lot.ruDescription = queryResultSet.getString("rudescription");
                lot.sum = queryResultSet.getString("sum");
                lot.deliveryPlace = queryResultSet.getString("deliveryplace");
                table.rows.add(purchase);
            }

            table.countItemsShowed = table.rows.size();
            table.countPages = (int) Math.ceil((double) table.countItems / (double) maxCount);
        } catch (Exception ex) {
            response.setStatus(500);
            response.setHeader("X-Error-Description", ex.getMessage());
        }

        return table;
    }
}
