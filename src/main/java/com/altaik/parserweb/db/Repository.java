package com.altaik.parserweb.db;


import com.altaik.bo.Lot;
import com.altaik.db.DatabaseManager;
import com.altaik.parser.sendmails.ets.bo.ProcPurchase;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Vladimir Kovalev (v.kovalev@altatender.kz) on 12.03.2018
 * @project sendmails
 */
@Singleton
public class Repository {
    @Inject
    DatabaseManager context;

    private Logger logger = Logger.getLogger(Repository.class.getName());

    public List<Lot> getLots(String purchaseId){
        return context.getLotsByProccessedPurchase(purchaseId);
    }

    public ProcPurchase getPurchase(int envelopeId, String purchaseNumber) {
        try {
//        String s = String.format("select count(id) from envelope_purchases where envelope_id=%d and purchase_number='%s';", envelopeId, purchaseNumber);
//
//        ResultSet execute = context.Execute(s);
//
//        if(execute != null && execute.first()){
//            execute.
//        }

        String query = String.format("SELECT p.id, p.source, p.number, p.runame, p.customer, p.organizer, p.status, p.startday, p.endday, p.attribute, p.isum, p.type, p.venue, p.method FROM procpurchase as p where p.number='%s' limit 1;", purchaseNumber);

        ResultSet resultSet = context.Execute(query);

            if (resultSet != null && resultSet.first()) {
                ProcPurchase procpurchase = new ProcPurchase();
                procpurchase.id = resultSet.getInt("id");
                procpurchase.isource = resultSet.getInt("source");
                procpurchase.number = resultSet.getString("number");
                procpurchase.ruName = resultSet.getString("runame");
                procpurchase.customer = resultSet.getString("customer");
                procpurchase.organizer = resultSet.getString("organizer");
                procpurchase.status = resultSet.getString("status");
                procpurchase.startDay = resultSet.getString("startday");
                procpurchase.endDay = resultSet.getString("endday");
                procpurchase.attribute = resultSet.getString("attribute");
                procpurchase.fsum = resultSet.getFloat("isum");
                procpurchase.type = resultSet.getString("type");
                procpurchase.ivenue = resultSet.getInt("venue");
                procpurchase.imethod = resultSet.getInt("method");
                return procpurchase;
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error get purchase by envelopeId({0}) and purchaseNumber({1}): {2}", new Object[]{
                    envelopeId, purchaseNumber, e
            });
        }

        return null;
    }
}
