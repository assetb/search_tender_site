/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.bo;

import com.altaik.bo.User;

/**
 *
 * @author admin
 */
public class RobotClient {

    public RobotClient(int id, int userid, String diskNumber, String serialNumber, String sessionId) {
        this.id = id;
        this.userid = userid;
        this.diskNumber = diskNumber;
        this.serialNumber = serialNumber;
        this.sessionId = sessionId;
    }
    public int id;
    public int userid;
    public String diskNumber;
    public String serialNumber;
    public String sessionId;
}
