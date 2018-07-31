/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.altaik.parserweb.rest.controllers;

import com.altaik.mailingofletters.RunningAttribute;
import com.altaik.mailingofletters.service.Sender;
import com.altaik.parserweb.service.DeliveryThread;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.server.mvc.Viewable;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 * @author Vladimir Kovalev (v.kovalev@altatender.kz) on 12.03.2018
 */
@Path("/app/delivery")
public class DeliveryController {
    
    private static final Logger logger = Logger.getLogger(Sender.class.getName());
    DeliveryThread deliveryThread;
    
    @GET
//    @Template(name = "/app/delivery.jsp")
    public Viewable GetDelivery() {
        deliveryThread = DeliveryThread.getInstance();
        if (deliveryThread != null && deliveryThread.isAlive()) {
            return new Viewable("/app/delivery_working.jsp");
        } else {
            return new Viewable("/app/delivery.jsp", new Delivery());
        }
    }
    
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Viewable StartSender(
            @FormDataParam("from") int fromId,
            @FormDataParam("subject") String subject,
            @FormDataParam("message") InputStream message,
            @FormDataParam("file_list_emails") InputStream listEmails,
            @FormDataParam("timeout") int timeout) {
        try {
            UUID uuidMessage = UUID.randomUUID();
            java.nio.file.Path pathMessage = Files.createTempFile(uuidMessage.toString(), ".html");
            
            java.nio.file.Files.copy(message, pathMessage, StandardCopyOption.REPLACE_EXISTING);
            
            UUID uuidListEmails = UUID.randomUUID();
            java.nio.file.Path pathListEmails = Files.createTempFile(uuidListEmails.toString(), ".txt");
            
            java.nio.file.Files.copy(listEmails, pathListEmails, StandardCopyOption.REPLACE_EXISTING);
            
            String userEmail = null, userPass = null, host = null, port = null;
            
            for (MailsSettings setting : (new Delivery()).getFroms()) {
                if (setting.getId() == fromId) {
                    userEmail = setting.getUseremail();
                    userPass = setting.getUserpass();
                    host = setting.getHost();
                    port = setting.getPort();
                    break;
                }
            }
            if (userEmail != null && userPass != null) {
                
                Properties props = new Properties();
                
                props.put(RunningAttribute.MESSAGE.getKey(), pathMessage.toString());
                props.put(RunningAttribute.SRCEMAIL.getKey(), pathListEmails.toString());
                props.put(RunningAttribute.SUBJECT.getKey(), subject);
                props.put(RunningAttribute.USERNAME.getKey(), userEmail);
                props.put(RunningAttribute.USERPASS.getKey(), userPass);
                props.put(RunningAttribute.HOST.getKey(), host);
                props.put(RunningAttribute.PORT.getKey(), port);
                props.put(RunningAttribute.SLEEPTIMEOUT.getKey(), String.valueOf(timeout * 1000));
                
                if (DeliveryThread.getInstance() != null) {
                    DeliveryThread.clearInstance();
                }
                
                DeliveryThread.setInstance(new DeliveryThread());
                deliveryThread = DeliveryThread.getInstance();
                if (!deliveryThread.isAlive()) {
                    deliveryThread.Settings((Properties) props.clone());
                    deliveryThread.start();
                }
            }
            return new Viewable("/success.jsp");
        } catch (IOException ex) {
            Logger.getLogger(DeliveryController.class.getName()).log(Level.SEVERE, "Method StartSender. Fatal error: ", ex);
            return new Viewable("/errorpage.jsp");
        }
    }
    
    public static class Delivery {
        
        private List<MailsSettings> froms = new ArrayList<>();
        
        public Delivery() {
            froms.add(new MailsSettings(3, "v.kovalev", "v.kovalev@altatender.kz", "Smail931", "88.204.230.205", "25"));
            froms.add(new MailsSettings(0, "Альта и К", "info@altaik.kz", "2exz4Y#!;4$&<of", "smtp.altaik.kz", "25"));
            froms.add(new MailsSettings(1, "Корунд-777", "info@korund-777.kz", "zyjgtwUr59yQjmPX", "smtp.korund-777.kz", "25"));
            froms.add(new MailsSettings(2, "Альта и К(altatender.kz)", "delivery@altatender.kz", "ghjc20vjnh", "88.204.230.205", "25"));
            froms.add(new MailsSettings(4, "Ак Алтын Ко", "altanko@bk.ru", "akaltinko4579851", "smtp.mail.ru", "465"));
            froms.add(new MailsSettings(5, "Альтаир-Нур", "altairnurbroker@gmail.com", "cozvmqqlicgdqmyq", "smtp.google.com", "465"));
        }
        
        public List<MailsSettings> getFroms() {
            return froms;
        }
        
        public void setFroms(List<MailsSettings> froms) {
            this.froms = froms;
        }
    }
    
    public static class MailsSettings {
        
        private int id;
        private String name;
        private String useremail;
        private String userpass;
        private String host;
        private String port;
        
        public MailsSettings(int id, String name, String useremail, String userpass, String host, String port) {
            this.id = id;
            this.name = name;
            this.useremail = useremail;
            this.userpass = userpass;
            this.host = host;
            this.port = port;
        }
        
        public int getId() {
            return id;
        }
        
        public void setId(int id) {
            this.id = id;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getUseremail() {
            return useremail;
        }
        
        public void setUseremail(String useremail) {
            this.useremail = useremail;
        }
        
        public String getUserpass() {
            return userpass;
        }
        
        public void setUserpass(String userpass) {
            this.userpass = userpass;
        }
        
        public String getHost() {
            return host;
        }
        
        public void setHost(String host) {
            this.host = host;
        }
        
        public String getPort() {
            return port;
        }
        
        public void setPort(String port) {
            this.port = port;
        }
    }
}
