package com.altaik.parserweb.rest.controllers;

import com.altaik.parser.sendmails.ets.bo.ProcPurchase;
import com.altaik.parserweb.db.Repository;
import com.altaik.parserweb.service.AltaCoreService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.IOException;

/**
 * @author Vladimir Kovalev (v.kovalev@altatender.kz) on 12.03.2018
 * @project sendmails
 */
@Path("api/broker")
public class BrokerApiController {

    @Inject
    Repository repository;

    @GET
    @Produces(MediaType.APPLICATION_OCTET_STREAM)
    @Path("/donwload/order/{envelopeId}/{purchaseNumber}")
    public Response Donwload(@PathParam("envelopeId") int envelopeId, @PathParam("purchaseNumber") String purchaseNumber) throws IOException {
        ProcPurchase purchase = repository.getPurchase(envelopeId, purchaseNumber);
        purchase.lots = repository.getLots(purchase.number);
        File file = AltaCoreService.generateOrder(purchase);

        Response.ResponseBuilder responce = Response.ok((Object) file);

        responce.header("Content-Disposition",
                String.format("attachment; filename=\"%s\"", file.getName()));

        return responce.build();
    }
}
