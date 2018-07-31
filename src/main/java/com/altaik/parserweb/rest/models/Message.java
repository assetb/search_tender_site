/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

/**
 *
 * @author admin
 */
public class Message<T> {
    public int code;
    public String description;
    public T data;
    
}
