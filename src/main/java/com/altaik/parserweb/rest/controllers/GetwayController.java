/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import org.glassfish.jersey.server.mvc.ErrorTemplate;
import org.glassfish.jersey.server.mvc.Template;

import javax.ejb.Stateless;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.client.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

/**
 *
 * @author admin
 */
@Stateless
@Path("/app/ets")
public class GetwayController {

//    private final String URL_WEB_APP = "http://10.1.1.3:89/BLL";
    private String urlToEtsServer = "http://localhost:51038/rest/app/ets/";

    @Context
    ServletContext context;
    
    @Context
    ServletConfig config;
    
    @Context
    UriInfo urlInfo;

    @Context
    HttpServletRequest request;

    @GET
    @Path("{subResources:[a-zA-Z0-9_/]+}")
    @Template(name = "/app/getway.jsp") @ErrorTemplate(name = "/page_not_found.jsp")
//    @Produces({MediaType.WILDCARD})
//    @Consumes({MediaType.WILDCARD})
    public String SubResources(@PathParam("subResources") String subResource) {

        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(context.getInitParameter("url_to_ets_server") + subResource);
        Invocation.Builder builder = webTarget.request();
        Response response;
        Response responceClient = builder.get();
        String body = responceClient.readEntity(String.class);
        responceClient.close();
        
        return body.replaceAll("/ets/", (urlInfo.getBaseUri() + urlInfo.getPath().replaceAll(subResource, "")));
    }
    
    @POST
    @Path("{subResources:[a-zA-Z0-9_/]+}")
    @Template(name = "/app/getway.jsp")
//    @Produces({})
//    @Consumes({MediaType.APPLICATION_FORM_URLENCODED})
    public String SubResourcesPost(@PathParam("subResources") String subResource, MultivaluedMap<String, String> formParams) {

        Client client = ClientBuilder.newClient();
        WebTarget webTarget = client.target(context.getInitParameter("url_to_ets_server") + subResource);
        Invocation.Builder builder = webTarget.request();
        Response response;
        Response responceClient = builder.post(Entity.entity(formParams, request.getContentType()));
        String body = responceClient.readEntity(String.class);
        responceClient.close();
        
        return body.replaceAll("/ets/", (urlInfo.getBaseUri() + urlInfo.getPath().replaceAll(subResource, "")));
    }
}
