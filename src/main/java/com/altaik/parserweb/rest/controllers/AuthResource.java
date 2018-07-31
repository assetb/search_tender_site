/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.db.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.Path;
import javax.ws.rs.POST;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author admin
 */
@Stateless
@Path("/auth")
public class AuthResource {

    @Inject
    IDatabaseManager dbManager;

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Path("/login")
    public String Login(@FormParam("login") String login, @FormParam("password") String pass, @Context HttpServletRequest req) {
        try {
            HttpSession  session = req.getSession();
            ResultSet rows = dbManager.Execute("Select id FROM users WHERE email = '" + login + "' and password = '" + pass + "';");

            if (rows != null && rows.first()) {
                return "OK";
            }
        } catch (SQLException ex) {
            Logger.getLogger(AuthResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "fail";
    }
}
