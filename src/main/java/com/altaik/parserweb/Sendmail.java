/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Aset
 */
public class Sendmail {
    String outgoingMailServer = "88.204.230.205";
    String outgoingMailPort = "25";
    String username = "delivery@altatender.kz";
    String password = "ghjc20vjnh";

    Properties props;
    Session session;

    public void Send(String emails, String subject, String mesText) {

        if (null == props) {
            props = new Properties();
            props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", outgoingMailServer);
            props.put("mail.smtp.port", outgoingMailPort);
        }

        if (null == session) {
            session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });
        }

        try {
            Message message = new MimeMessage(session);
            message.setHeader("Content-Type", "text/html; charset=UTF-8");
            message.setFrom(new InternetAddress(username, "Альта и К"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emails));
            message.setSubject(subject);
            ((MimeMessage) message).setText(mesText, "utf8", "html");

            Transport.send(message);

//            Transport transport = session.getTransport("smtps");
//            transport.connect(outgoingMailServer, 465, username, password);
//            transport.sendMessage(message, message.getAllRecipients());
//            transport.close();
            System.out.println("Message sent.");

        } catch (MessagingException | UnsupportedEncodingException ex) {
            Logger.getLogger(Sendmail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
}
