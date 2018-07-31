/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.db;

import com.altaik.db.AConnection;
import com.altaik.db.IDatabaseManager;

import javax.inject.Singleton;
import java.util.Properties;

/**
 * @author admin
 */
@Singleton
public class BrokerBaseManager extends com.altaik.db.DatabaseManager implements IDatabaseManager {

    public BrokerBaseManager() {
        properties = new Properties();
        properties.put("dbname", "brokerbase");
        connection = new AConnection(properties);
        connection.getConnection();
    }
}
