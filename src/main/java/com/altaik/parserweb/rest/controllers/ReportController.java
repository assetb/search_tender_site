/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.repositories.BrokerBaseRepository;
import com.altaik.parserweb.rest.models.*;
import org.glassfish.jersey.server.mvc.Template;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.ws.rs.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * REST Web Service
 *
 * @author admin
 */
@Stateless
@Path("/app/reports")
public class ReportController {

    @Inject
    IDatabaseManager dbManager;

    public ReportController() {
    }

    @GET
    @Template(name = "/app/samruk/report/reports.jsp")
    public Map<String, Object> Report(@QueryParam("source") @DefaultValue(value = "0") int source) {
        Map<String, Object> it = new HashMap<>();
        BrokerBaseRepository repository = new BrokerBaseRepository(dbManager);
        List<AuctionResultViewModel> auctions = repository.getAuctions(source);
        List<SourceModel> sources = repository.getSources(source);
        it.put("auctions", auctions);
        it.put("sources", sources);
        return it;
    }

    @GET
    @Path("/{idAuction}")
    @Template(name = "/app/samruk/report/report.jsp")
    public AuctionModel Auction(@PathParam("idAuction") int idAuction) {
        AuctionModel it = new AuctionModel();

        try {
            ResultSet rows = dbManager.Execute("SELECT * FROM auctions WHERE id = " + idAuction + ";");

            if (rows != null && rows.first()) {
                it = AuctionModel.Parse(rows);

                ResultSet lotRows = dbManager.Execute("SELECT * FROM lots WHERE auctionid = '"+idAuction+"';");
                while (lotRows != null && lotRows.next()) {
                    LotModel lot = new LotModel();
                    it.getLots().add(LotModel.Parse(lotRows));
                }
            }

            ResultSet rowsSites = dbManager.Execute("SELECT id, name FROM sites");
            while (rowsSites != null && rowsSites.next()) {
                it.getSites().add(BaseModel.Parse(rowsSites));
            }
            
            ResultSet rowsTraders = dbManager.Execute("SELECT id, p.name FROM traders as t LEFT JOIN persons as p ON p.id = t.personid");
            while (rowsTraders != null && rowsTraders.next()) {
                it.getTraders().add(BaseModel.Parse(rowsTraders));
            }
            
            ResultSet rowsSatuses = dbManager.Execute("SELECT id, name FROM statuses");
            while (rowsSatuses != null && rowsSatuses.next()) {
                it.getStatuses().add(BaseModel.Parse(rowsSatuses));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return it;
    }
}
