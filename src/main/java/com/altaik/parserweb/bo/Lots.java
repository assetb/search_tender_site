/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.bo;

import com.altaik.parserweb.rest.models.LotModel;
import java.util.ArrayList;
import java.util.Map;

/**
 *
 * @author admin
 */
public class Lots extends ArrayList<LotModel> {

    public Lots Parse(Map<String, String> params) {
//        if (params != null) {
//            for (Map.Entry<String, String> entry : params.entrySet()) {
//                String key = entry.getKey();
//                if (key.contains("lot:")) {
//                    int id = Integer.parseInt(key.replaceAll("lot:[a-z]*:", ""));
//                    LotModel lot = getLotById(id);
//                    if (lot == null) {
//                        lot = new LotModel(id);
//                        this.add(lot);
//                    }
//                    if (key.contains("lot:number:")) {
//                        lot.setNumber(entry.getValue());
//                    } else if (key.contains("lot:rang:")) {
//                        lot.setRang(Integer.parseInt(entry.getValue()));
//                    } else if (key.contains("lot:lastprice:")) {
//                        lot.setLastprice(Double.parseDouble(entry.getValue()));
//                    } else if (key.contains("lot:minprice:")) {
//                        lot.setMinprice(Double.parseDouble(entry.getValue()));
//                    } else if (key.contains("lot:count:")) {
//                        lot.setCount(Double.parseDouble(entry.getValue()));
//                    }
//                }
//            }
//        }
        return this;
    }

    private LotModel getLotById(int id) {
        for (LotModel lot : this) {
            if (lot.getId() == id) {
                return lot;
            }
        }
        return null;
    }

    public void AddLot(Integer id, Integer priceofferid, Integer rang, Double lastprice, Double minprice) {
//        LotModel lot = new LotModel(id, priceofferid, rang, lastprice, minprice);
//        this.add(lot);
    }
}
