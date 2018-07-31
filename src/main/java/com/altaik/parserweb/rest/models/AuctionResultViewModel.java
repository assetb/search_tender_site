/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class AuctionResultViewModel {

    private int id;
    private Date auctiondate;
    private int traderid;
    private String auctionnumber;
    private int customerid;
    private int siteid;
    private Double startprice;
    private Double sum;
    
    private String site;

    public static AuctionResultViewModel Parse(ResultSet rows) throws SQLException {
        AuctionResultViewModel auction = new AuctionResultViewModel();
        
        auction.setId(rows.getInt("id"));
        auction.setTraderid(rows.getInt("traderid"));
        auction.setAuctiondate(rows.getDate("auctiondate"));
        auction.setAuctionnumber(rows.getString("auctionnumber"));
        auction.setCustomerid(rows.getInt("customerid"));
        auction.setSiteid(rows.getInt("siteid"));
        auction.setStartprice(rows.getDouble("startprice"));
        auction.setSum(rows.getDouble("sum"));
        auction.setSite(rows.getString("site"));
        
        return auction;
    }

    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Date getAuctiondate() {
        return auctiondate;
    }
    
    public void setAuctiondate(Date auctiondate) {
        this.auctiondate = auctiondate;
    }
    
    public int getTraderid() {
        return traderid;
    }
    
    public void setTraderid(int traderid) {
        this.traderid = traderid;
    }
    
    public String getAuctionnumber() {
        return auctionnumber;
    }
    
    public void setAuctionnumber(String auctionnumber) {
        this.auctionnumber = auctionnumber;
    }
    
    public int getCustomerid() {
        return customerid;
    }
    
    public void setCustomerid(int customerid) {
        this.customerid = customerid;
    }
    
    public int getSiteid() {
        return siteid;
    }
    
    public void setSiteid(int siteid) {
        this.siteid = siteid;
    }
    
    public Double getStartprice() {
        return startprice;
    }
    
    public void setStartprice(Double startprice) {
        this.startprice = startprice;
    }
    
    public Double getSum() {
        return sum;
    }
    
    public void setSum(Double sum) {
        this.sum = sum;
    }
    
    public String getSite() {
        return site;
    }
    
    public void setSite(String site) {
        this.site = site;
    }
}
