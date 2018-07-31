/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.repositories;

import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.rest.models.AuctionResultViewModel;
import com.altaik.parserweb.rest.models.SourceModel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class BrokerBaseRepository {

    private IDatabaseManager dbManager;

    public BrokerBaseRepository(IDatabaseManager dbManager) {
        this.dbManager = dbManager;
    }

    public List<SourceModel> getSources(int selectedSource) {
            List<SourceModel> sources = new ArrayList<>();
        try {
            ResultSet rows = dbManager.Execute("SELECT id, name FROM sites");
            while (rows != null && rows.next()) {
                    SourceModel source = SourceModel.Parse(rows);
                    source.setSelected(source.getId() == selectedSource);
                    sources.add(source);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrokerBaseRepository.class.getName()).log(Level.SEVERE, null, ex);
        }
            return sources;
    }

    public List<AuctionResultViewModel> getAuctions(int source) {

        List<AuctionResultViewModel> auctions = new ArrayList<>();
        ResultSet rows = dbManager.Execute("SELECT `auctionsresultview`.`id`,\n"
                + "    `auctionsresultview`.`auctiondate`,\n"
                + "    `auctionsresultview`.`traderid`,\n"
                + "    `auctionsresultview`.`auctionnumber`,\n"
                + "    `auctionsresultview`.`customerid`,\n"
                + "    `auctionsresultview`.`siteid`,\n"
                + "    `auctionsresultview`.`startprice`,\n"
                + "    `auctionsresultview`.`sum`,\n"
                + "    `auctionsresultview`.`site`\n"
                + "FROM `brokerbase`.`auctionsresultview` " + (source > 0 ? ("WHERE siteid = " + source) : "") + ";");

        try {
            while (rows != null && rows.next()) {
                auctions.add(AuctionResultViewModel.Parse(rows));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrokerBaseRepository.class.getName()).log(Level.SEVERE, "Error select auctions for source", ex);
        }
        return auctions;
    }
}
