/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.models;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class Table<T> {
    public int countItems;
    public int currentPage;
    public int countItemsShowed;
    public int countPages;
    public List<T> rows = new ArrayList<>(); 
}
