/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.service;

import com.altaik.mailingofletters.RunningAttribute;
import com.altaik.mailingofletters.service.Sender;
import com.altaik.mailingofletters.utils.ReaderFiles;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Singleton;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
@Singleton
@ApplicationScoped
public class DeliveryThread extends Thread {

    private boolean isRun = false;
    protected Properties props;
    protected Sender sender;
    private static DeliveryThread deliveryThread;

    public static DeliveryThread getInstance() {
        return deliveryThread;
    }

    public static void setInstance(DeliveryThread deliveryThread) {
        DeliveryThread.deliveryThread = deliveryThread;
    }

    public static void clearInstance() {
        deliveryThread = null;
    }

    public void Settings(Properties props) {
        if (isRun) {
            return;
        }
        this.props = props;
    }

    @Override
    public void run() {
        isRun = true;
        List<String> emails = ReaderFiles.ReadFileEmails(props.getProperty(RunningAttribute.SRCEMAIL.getKey()));
        if (emails == null || emails.isEmpty()) {
            Logger.getLogger(DeliveryThread.class.getName()).log(Level.SEVERE, "Not found emails or list is empty.");
            return;
        }

        sender = new Sender((Properties) props.clone());
        sender.Init();
        sender.Send(emails, props.getProperty(RunningAttribute.MESSAGE.getKey()));

        isRun = false;

        interrupt();
    }

    public boolean isIsRun() {
        return isRun;
    }

}
