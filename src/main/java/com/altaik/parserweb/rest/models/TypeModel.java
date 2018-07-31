/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class TypeModel extends BaseModel {

    public static TypeModel Parse(ResultSet row) throws SQLException {
        return (TypeModel) BaseModel.Parse(row);
    }
}
