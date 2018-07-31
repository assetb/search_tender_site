/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.config;

import com.altaik.db.DatabaseManager;
import com.altaik.parserweb.db.BrokerBaseManager;
import com.altaik.parserweb.db.Repository;
import org.glassfish.hk2.utilities.binding.AbstractBinder;

/**
 * @author admin
 */
public class Beans extends AbstractBinder {

    @Override
    protected void configure() {
        bind(DatabaseManager.class).to(DatabaseManager.class);
        bind(BrokerBaseManager.class).to(BrokerBaseManager.class);
        bind(Repository.class).to(Repository.class);
//        bind(DeliveryThread.class).to(DeliveryThread.class);
    }

}
