/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.config;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.ext.Provider;

/**
 *
 * @author admin
 */
@Provider
public class RequestFilter implements ContainerRequestFilter {

    @Context
    HttpServletRequest req;

    @Override
    public void filter(ContainerRequestContext crc) throws IOException {
//        String path = crc.getUriInfo().getPath();
//        HttpSession session = req.getSession();
//        if (path.matches("^app/.*") && session.getAttribute("userid") == null) {
//            ResponseBuilder builder = null;
//            builder = Response.status(Response.Status.NOT_FOUND);
//            throw new WebApplicationException(builder.build());
//        }
    }

}
