/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.service;

import com.altaik.db.DatabaseManager;
import com.altaik.db.IDatabaseManager;
import com.altaik.parserweb.bo.RobotClient;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public final class RobotService {

    private static RobotService authenticator;
    private IDatabaseManager db;
    private final Map<String, RobotClient> clients = new HashMap<>();

    public RobotService(IDatabaseManager db) {
        this.db = db;
    }

    public RobotService(Properties props) {
        this((IDatabaseManager) new DatabaseManager(props));
    }

    public RobotService() {
        this((IDatabaseManager) new DatabaseManager());
    }

    public boolean Login(String sessionId, String diskNumber, String serialNumber) {
        if (sessionId == null || diskNumber == null || serialNumber == null) {
            return false;
        }

        try {
            ResultSet rows = db.Execute("SELECT id, userid FROM robots WHERE serial = '" + serialNumber + "' and volume = '" + diskNumber + "';");
            if (rows != null && rows.first()) {
                RobotClient robot = new RobotClient(rows.getInt("id"), rows.getInt("userid"), diskNumber, serialNumber, sessionId);                
                addClient(sessionId, robot);
                
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RobotService.class.getName()).log(Level.SEVERE, "Error query in Auth", ex);
        }
        return false;
    }

    public boolean Verify(String sessionId) {
        return clients.get(sessionId) != null;
    }

    public RobotClient getRobotClient(String sessionId) {
        return clients.get(sessionId);
    }

    public boolean Verify(String sessionId, String key, String diskNumber, String serialNumber) {
        RobotClient client = clients.get(sessionId);
        if (client == null) {
            return false;
        }
        return client.sessionId.equals(sessionId) && client.diskNumber.equals(diskNumber) && client.serialNumber.equals(serialNumber);
    }

    public void Logout(String sessionId) {
        removeClient(sessionId);
    }

    private void addClient(String sessionId, RobotClient robot) {
        clients.put(sessionId, robot);
    }

    private void removeClient(String sessionId) {
        clients.remove(sessionId);
    }
    
    public static RobotService getInstance(IDatabaseManager databaseManager) {
        if (authenticator == null) {
            authenticator = new RobotService(databaseManager);
        }
        return authenticator;
    }
    public static RobotService getInstance() {
        if (authenticator == null) {
            authenticator = new RobotService();
        }
        return authenticator;
    }
}
