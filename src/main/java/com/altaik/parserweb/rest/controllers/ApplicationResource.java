/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import org.glassfish.jersey.server.mvc.Template;

/**
 *
 * @author admin
 */
@Stateless
@Path("/app")
public class ApplicationResource {

    public static class MenuBar {

        private String url;
        private String title;
        private String description;

        public MenuBar(String url, String title, String description) {
            this.url = url;
            this.title = title;
            this.description = description;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

    }

    @GET
    @Path("/menu")
    @Template(name = "/app/menu.jsp")
    public List<MenuBar> Menu(@Context HttpServletRequest req) {
        String baseUrl = "/rest";
        List<MenuBar> bars = new ArrayList<>();

        bars.add(new MenuBar(baseUrl + "/app/reports", "Отчеты по Аукционам", "Отчеты по результатам торгов."));
        bars.add(new MenuBar(baseUrl + "/app/delivery", "Модуль рассылки", "Приложение массовой отправки писема в автоматическом режиме."));
        bars.add(new MenuBar(baseUrl + "/app/ets/CabinetUI/History/Index", "ETS.Net", "Автоматизация бизнесс процессов брокерской деятельности."));

        return bars;
    }

}
