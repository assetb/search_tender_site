/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.bo;

import javax.xml.bind.annotation.*;

/**
 *
 * @author Aset
 */
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "offeredlot", propOrder = {"number", "minPrice", "discount"})
public class OfferedLot {
    
    @XmlElement(name = "number")
    public String number;
    
    @XmlElement(name = "minSum")
    public Double minSum;
    
    @XmlElement(name = "discount")
    public Double discount;
    
    @XmlElement(name="isOverStep")
    public boolean isOverStep = false;
    
    @XmlElement(name="priceForOverStep")
    public Double priceForOverStep;
    
    @XmlElement(name="percent")
    public Integer percent = null;
    
    @XmlElement(name="isMaxPrice")
    public Boolean isMaxPrice = false;
    
    @XmlElement(name="isRedone")
    public Boolean isRedone = false;
    
    @XmlElement(name="iSum")
    public int iSum;
    
    @XmlElement(name="stepLowwer")
    public Double stepLowwer;
    
    @XmlElement(name="prevSum")
    public int prevSum;
    
    @XmlElement(name="curSum")
    public int curSum;
    
    @XmlElement(name="dCurSum")
    public Double dCurSum;
    
    @XmlElement(name="minDownPrice")
    public String minDownPrice;

    @XmlElement(name="maxDownPrice")
    public String maxDownPrice;

    @XmlElement(name="nextPrice")
    public String nextPrice;
}
