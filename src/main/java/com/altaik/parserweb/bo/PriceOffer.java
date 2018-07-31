/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.bo;

/**
 *
 * @author admin
 */
public class PriceOffer {
    private int id;
    private int prociratoryId;
    private int lotId;
    private Double price;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProciratoryId() {
        return prociratoryId;
    }

    public void setProciratoryId(int prociratoryId) {
        this.prociratoryId = prociratoryId;
    }

    public int getLotId() {
        return lotId;
    }

    public void setLotId(int lotId) {
        this.lotId = lotId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
