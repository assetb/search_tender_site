/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.bo.Method;
import com.altaik.bo.Region;
import com.altaik.bo.Source;
import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.db.DatabaseManager;
import com.altaik.parserweb.rest.models.Message;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author admin
 */
@Path("web/api/catalog")
public class CatalogController {

    @Inject
    IDatabaseManager dbManager;

    @GET
    @Path("method")
    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
    @Produces({MediaType.TEXT_PLAIN, MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Message<List<Method>> getMethods() {
        Message<List<Method>> message;

        message = new Message<>();
        message.code = 200;

        try {
            ResultSet queryResultSet = dbManager.Execute("SELECT id, name FROM methodsenum;");
            List<Method> methods = new ArrayList<>();

            while (queryResultSet.next()) {
                Method method = new Method();
                method.id = queryResultSet.getInt("id");
                method.name = queryResultSet.getString("name");
                methods.add(method);
            }

            message.data = methods;
        } catch (Exception ex) {
            message.code = 600;
            message.description = ex.getMessage();
        }

        return message;
    }

    @GET
    @Path("source")
    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
    @Produces({MediaType.TEXT_PLAIN, MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Message<List<Source>> getSources() {
        Message<List<Source>> message;

        message = new Message<>();
        message.code = 200;

        try {
            ResultSet queryResultSet = dbManager.Execute("SELECT siteid as id, sitename as name FROM sites;");
            List<Source> sources = new ArrayList<>();

            while (queryResultSet.next()) {
                Source source = new Source();
                source.id = queryResultSet.getInt("id");
                source.name = queryResultSet.getString("name");
                sources.add(source);
            }

            message.data = sources;
        } catch (Exception ex) {
            message.code = 600;
            message.description = ex.getMessage();
        }

        return message;
    }

    @GET
    @Path("region")
    @Consumes({MediaType.APPLICATION_JSON, MediaType.APPLICATION_FORM_URLENCODED})
    @Produces({MediaType.TEXT_PLAIN, MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Message<List<Region>> getRegions() {
        Message<List<Region>> message;

        message = new Message<>();
        message.code = 200;

        try {
            ResultSet queryResultSet = dbManager.Execute("SELECT id, name FROM regionsenum;");
            List<Region> regions = new ArrayList<>();

            while (queryResultSet.next()) {
                Region region = new Region();
                region.id = queryResultSet.getInt("id");
                region.name = queryResultSet.getString("name");
                regions.add(region);
            }

            message.data = regions;
        } catch (Exception ex) {
            message.code = 600;
            message.description = ex.getMessage();
        }

        return message;
    }
}
