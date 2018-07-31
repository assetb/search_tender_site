/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class LotModel extends BaseModel{

    private int id;
    private int auctionId;
    private String number;
    private String description;
    private int unitId;
    private Double amount;
    private Double price;
    private Double sum;
    private String paymentTerm;
    private String deliveryTime;
    private String deliveryPlace;
    private int dks;
    private String contractNumber;
    private Double step;
    private Double warranty;
    private int localContent;
    private int attachmentId;

    public static LotModel Parse(ResultSet row) throws SQLException {
        LotModel lot = new LotModel();

        lot.setId(row.getInt("id"));
        lot.setDescription(row.getString("number"));
        lot.setDescription(row.getString("description"));
        lot.setAmount(row.getDouble("amount"));
        lot.setPrice(row.getDouble("price"));
        lot.setSum(lot.getAmount() * lot.getPrice());
        return lot;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUnitId() {
        return unitId;
    }

    public void setUnitId(int unitId) {
        this.unitId = unitId;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public String getPaymentTerm() {
        return paymentTerm;
    }

    public void setPaymentTerm(String paymentTerm) {
        this.paymentTerm = paymentTerm;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getDeliveryPlace() {
        return deliveryPlace;
    }

    public void setDeliveryPlace(String deliveryPlace) {
        this.deliveryPlace = deliveryPlace;
    }

    public int getDks() {
        return dks;
    }

    public void setDks(int dks) {
        this.dks = dks;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public Double getStep() {
        return step;
    }

    public void setStep(Double step) {
        this.step = step;
    }

    public Double getWarranty() {
        return warranty;
    }

    public void setWarranty(Double warranty) {
        this.warranty = warranty;
    }

    public int getLocalContent() {
        return localContent;
    }

    public void setLocalContent(int localContent) {
        this.localContent = localContent;
    }

    public int getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(int attachmentId) {
        this.attachmentId = attachmentId;
    }
    
    

    public void set(String key, Object value) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
        Field field = getClass().getDeclaredField(key);
        field.set(this, value);
    }
}
