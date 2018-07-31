/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.config;

import com.altaik.parserweb.rest.controllers.*;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.mvc.MvcFeature;
import org.glassfish.jersey.server.mvc.jsp.JspMvcFeature;

/**
 *
 * @author admin
 */
//@ApplicationPath("/app")
public class Application extends ResourceConfig {

    private static final Logger LOG = Logger.getLogger(Application.class.getName());

    public Application() {
        LOG.log(Level.INFO, "Start rest application");
//        resouces
        register(ReportController.class);
        register(AuthResource.class);
        register(ApplicationResource.class);
        register(RobotController.class);
        register(DeliveryController.class);
        register(RequestFilter.class);
        register(GetwayController.class);
        register(SearchController.class);
        register(CatalogController.class);
        register(BrokerApiController.class);
//        inject
        register(new Beans());
//        fraemworks
        register(MvcFeature.class);
        register(JspMvcFeature.class);
        register(MultiPartFeature.class);

//        register(new LoggingFilter(LOG, true));
//        property();
        property(JspMvcFeature.TEMPLATE_BASE_PATH, "/new");
    }
}
