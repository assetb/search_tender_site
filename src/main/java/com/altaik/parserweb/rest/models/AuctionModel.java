/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

import java.lang.reflect.Field;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class AuctionModel {

    private int id;
    private Date date;
    private int sectionId;
    private int typeId;
    private String number;
    private int statusId;
    private String comments;
    private boolean ndsincluded;
    private boolean signstatusid;
    private boolean published;
    private int ownerId;
    private int siteId;
    private int regulationId;
    private int traderId;
    private int customerId;
    private int brokerId;

    private List<BaseModel> types = new ArrayList<>();
    private List<BaseModel> statuses = new ArrayList<>();
    private List<BaseModel> sites = new ArrayList<>();
    private List<BaseModel> traders = new ArrayList<>();
    private List<LotModel> lots = new ArrayList<>();

    public void set(String key, Object value) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
        Field field = getClass().getDeclaredField(key);
        field.set(this, value);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public int getSiteId() {
        return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }

    public int getSectionId() {
        return sectionId;
    }

    public void setSectionId(int sectionId) {
        this.sectionId = sectionId;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public boolean isNdsincluded() {
        return ndsincluded;
    }

    public void setNdsincluded(boolean ndsincluded) {
        this.ndsincluded = ndsincluded;
    }

    public boolean isSignstatusid() {
        return signstatusid;
    }

    public void setSignstatusid(boolean signstatusid) {
        this.signstatusid = signstatusid;
    }

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getRegulationId() {
        return regulationId;
    }

    public void setRegulationId(int regulationId) {
        this.regulationId = regulationId;
    }

    public int getTraderId() {
        return traderId;
    }

    public void setTraderId(int traderId) {
        this.traderId = traderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getBrokerId() {
        return brokerId;
    }

    public void setBrokerId(int brokerId) {
        this.brokerId = brokerId;
    }

    public List<BaseModel> getTypes() {
        return types;
    }

    public void setTypes(List<BaseModel> types) {
        this.types = types;
    }

    public List<BaseModel> getStatuses() {
        return statuses;
    }

    public void setStatuses(List<BaseModel> statuses) {
        this.statuses = statuses;
    }

    public List<BaseModel> getSites() {
        return sites;
    }

    public void setSites(List<BaseModel> sites) {
        this.sites = sites;
    }

    public List<BaseModel> getTraders() {
        return traders;
    }

    public void setTraders(List<BaseModel> traders) {
        this.traders = traders;
    }
    
    public static AuctionModel Parse(ResultSet row) throws SQLException{
        AuctionModel auction = new AuctionModel();
        
        auction.setId(row.getInt("id"));
        auction.setNumber(row.getString("number"));
        auction.setDate(row.getDate("date"));
        auction.setSectionId(row.getInt("sectionid"));
        auction.setTypeId(row.getInt("typeid"));
        auction.setNumber(row.getString("number"));
        auction.setStatusId(row.getInt("statusid"));
        auction.setComments(row.getString("comments"));
        auction.setTraderId(row.getInt("traderid"));
        
        
        return auction;
    }

    public List<LotModel> getLots() {
        return lots;
    }

    public void setLots(List<LotModel> lots) {
        this.lots = lots;
    }
}
