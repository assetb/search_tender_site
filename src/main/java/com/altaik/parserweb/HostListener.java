/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb;

import com.altaik.parserweb.service.RobotService;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class HostListener implements HttpSessionListener{

    private static final Logger LOG = Logger.getLogger(HostListener.class.getName());

    @Override
    public void sessionCreated(HttpSessionEvent hse) {
        LOG.log(Level.INFO, "Session create {0}", hse.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent hse) {
        RobotService authenticator = RobotService.getInstance();
        authenticator.Logout(hse.getSession().getId());
        
        LOG.log(Level.INFO, "Session destroy {0}", hse.getSession().getId());
    }
    
}
