/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.db;

import com.altaik.db.IDatabaseManager;

import javax.inject.Singleton;

/**
 *
 * @author admin
 */
@Singleton
public class DatabaseManager extends com.altaik.db.DatabaseManager implements IDatabaseManager {

    public DatabaseManager() {
        super(false, true);
    }

}
