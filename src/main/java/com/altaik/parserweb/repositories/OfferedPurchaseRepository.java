/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.repositories;

import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.bo.OfferedLot;
import com.altaik.parserweb.bo.OfferedPurchase;
import com.altaik.parserweb.bo.RobotClient;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class OfferedPurchaseRepository {

    private static final Logger logger = Logger.getLogger(OfferedPurchaseRepository.class.getName());
    private static int SOURCE_SAMRUK_ID = 3;
    private final IDatabaseManager dbManager;

    public OfferedPurchaseRepository(IDatabaseManager dbManager) {
        this.dbManager = dbManager;
    }

    public int SaveAuction(RobotClient robot, OfferedPurchase purchase) {
        try {
            ResultSet rows;
            rows = dbManager.Execute("SELECT id FROM auctions WHERE number = '" + purchase.number + "' and siteid = '"+SOURCE_SAMRUK_ID+"';");
            if (rows == null || !rows.first()) {
                dbManager.Insert("INSERT INTO auctions(number, date, siteid) VALUE('" + purchase.number + "', now(), '"+SOURCE_SAMRUK_ID+"');");
            }
            rows = dbManager.Execute("SELECT id FROM auctions WHERE number = '" + purchase.number + "' and siteid = '"+SOURCE_SAMRUK_ID+"';");
            if (rows != null && rows.first()) {
                int purchaseId = rows.getInt("id");
                return purchaseId;
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error save offered puchase.", ex);
        }
        return 0;
    }

    public boolean SaveLot(RobotClient robot, int auctionId, OfferedLot lot) {
        try {
            int lotId = 0;
            ResultSet rows = dbManager.Execute("SELECT id FROM lots WHERE auctionid = '" + auctionId + "' and number = '" + lot.number + "';");
            if (rows != null && rows.first()) {
                lotId = rows.getInt("id");
            } else {
                dbManager.Insert("INSERT INTO lots(auctionid, number) VALUE(" + auctionId + ", '" + lot.number + "');");
                ResultSet rowId = dbManager.getLastInsertId();
                rowId.first();
                lotId = rowId.getInt(1);
            }

            rows = dbManager.Execute("SELECT id FROM procuratories WHERE auctionid = " + auctionId + " and lotid = " + lotId + ";");
            if (rows != null && rows.first()) {
                dbManager.Update("UPDATE procuratories SET minimalprice = '" + lot.minSum + "' WHERE auctionId = " + auctionId + " and lotId = " + lotId + ";");
            } else {
                dbManager.Insert("INSERT INTO procuratories(auctionid, lotid, minimalprice) VALUE('" + auctionId + "', '" + lotId + "', '" + lot.minSum + "');");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OfferedPurchaseRepository.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return true;
    }
}
