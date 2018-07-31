/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.bo;

import javax.xml.bind.annotation.*;

/**
 *
 * @author admin
 */
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "JsonRequest", propOrder = {"data"})
public class OfferedPurchaseJsonRequest {
    
    @XmlElementWrapper
    @XmlElement(name = "data")
    public OfferedPurchase data;
}
