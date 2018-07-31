/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.parserweb.bo.OfferedLot;
import com.altaik.parserweb.bo.OfferedPurchase;
import com.altaik.parserweb.bo.RobotClient;
import com.altaik.parserweb.db.BrokerBaseManager;
import com.altaik.parserweb.repositories.OfferedPurchaseRepository;
import com.altaik.parserweb.service.RobotService;
import java.util.HashMap;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

/**
 *
 * @author admin
 */
@Path("/app/robot")
public class RobotController {

    @Inject
    BrokerBaseManager dbManager;

    // Robot api
    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.TEXT_PLAIN)
    @Path("/login")
    public Response Login(@FormParam("sn") String serialNumber, @FormParam("dn") String diskNumber, @Context HttpServletRequest req) {
        Response res;
        HttpSession session = req.getSession(true);
        
        RobotService authenticator = RobotService.getInstance(dbManager);
        if (authenticator.Login(session.getId(), diskNumber, serialNumber)) {
            res = Response.status(Response.Status.OK).build();
        } else {
            res = Response.status(Response.Status.NOT_FOUND).build();
        }
        return res;
    }

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.TEXT_HTML)
    @Path("/auction")
    public Viewable SaveAuction(@FormParam("number") String number, @Context HttpServletRequest req) {
        Map<String, Object> map = new HashMap<>();
        HttpSession session = req.getSession(true);
        RobotService authenticator = RobotService.getInstance(dbManager);
        if (authenticator.Verify(session.getId())) {
            RobotClient client = authenticator.getRobotClient(session.getId());

            OfferedPurchaseRepository purchaseBP = new OfferedPurchaseRepository(dbManager);

            OfferedPurchase purchase = new OfferedPurchase();
            purchase.number = number;
            int auctionId = purchaseBP.SaveAuction(client, purchase);
            map.put("auctionId", auctionId);
            return new Viewable("/auction.jsp", map);
        } else {
            map.put("type", "Verify");
            map.put("description", "you are not authorized");
            return new Viewable("/errorpage.jsp", map);
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.TEXT_HTML)
    @Path("/auction/{idAuction}/lot")
    public Viewable Save(@PathParam("idAuction") int auctionId, @FormParam("number") String number, @FormParam("minSum") Double minSum, @FormParam("discount") Double discount, @Context HttpServletRequest req) {
//        boolean isError = false;
        HttpSession session = req.getSession(true);
        RobotService authenticator = RobotService.getInstance(dbManager);

        if (authenticator.Verify(session.getId())) {
            RobotClient client = authenticator.getRobotClient(session.getId());
            OfferedLot lot = new OfferedLot();
            lot.number = number;
            lot.minSum = minSum;
            lot.discount = discount;
            OfferedPurchaseRepository purchaseBP = new OfferedPurchaseRepository(dbManager);
            purchaseBP.SaveLot(client, auctionId, lot);

            return new Viewable("/success.jsp");
        } else {
            Map<String, Object> map = new HashMap<>();

            map.put("type", "Verify");
            map.put("description", "you are not authorized");
            return new Viewable("/errorpage.jsp", map);
        }
    }
}
