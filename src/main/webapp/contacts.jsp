<%-- 
    Document   : contacts
    Created on : 12.08.2015, 10:04:06
    Author     : Aset
--%>

<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Контакты</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/style.css" />
        <script src="js/vendor/modernizr.js"></script>
    </head>
    <body>
        <%if (null != request.getParameter("send")) {
//                String emails = "aset.b@rambler.ru,info@altatender.kz";
                String emails = "info@altatender.kz";
                String subject = "Сообщение от " + request.getParameter("yourname") + " email: " + request.getParameter("youremail") + " телефон: " + request.getParameter("yourphone");
                String mesTxt = "<p>" + subject + "</p>";
                mesTxt = mesTxt + "<p>" + request.getParameter("question") + "</p>";
                mesTxt = "<html><body>" + mesTxt;
                mesTxt = mesTxt + "</body></html>";

                String outgoingMailServer = "88.204.230.205";
                String outgoingMailPort = "25";
                final String username = "delivery@altatender.kz";
                final String password = "ghjc20vjnh";

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", outgoingMailServer);
                props.put("mail.smtp.port", outgoingMailPort);

                javax.mail.Session mailsession = Session.getInstance(props,
                        new javax.mail.Authenticator() {
                            @Override
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(username, password);
                            }
                        });

                Message message = new MimeMessage(mailsession);
                message.setHeader("Content-Type", "text/html; charset=UTF-8");
                message.setFrom(new InternetAddress(username, "Альта и К"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emails));
                message.setSubject(subject);
                ((MimeMessage) message).setText(mesTxt, "utf8", "html");

                Transport.send(message);

//            Sendmail sendmail = new Sendmail();
//                sendmail.Send(emails, subject, mesTxt);
            }%>
        <%@include file="menu.jsp" %>
        <div class="fixed">
            <%@include file="mainnav.jsp" %>
        </div>

        <section class="inner-banner-container ss-gradient" style="background-image: url(img/7.jpg);">
            <div class="banner-wrapper row">
                <div class="inner-banner small-8 column">
                    <h1>Свяжитесь с нами</h1>
                </div>
                <div class="banner-social-links small-4 column">
                </div>
            </div>
        </section>
        <div class="row">
            <div class="large-7 columns">
                <!--                <h3>Свяжитесь с нами</h3>
                                <p></p>-->

                <div class="section-container tabs" data-section>
                    <section class="section">
                        <h5 class="title"><a href="#panel1"></a></h5>
                        <div class="content" data-slug="panel1">
                            <form data-abide id="form_contacts" method="post" action="<c:url value='contacts.jsp'/>">
                                <input type="hidden" name="send">
                                <div class="row collapse">
                                    <div class="large-2 columns">
                                        <label class="inline">Ваше имя</label>
                                    </div>
                                    <div class="large-9 large-offset-1 columns">
                                        <input type="text" id="yourname" name="yourname" placeholder="Имя Отчество Фамилия">
                                    </div>
                                </div>
                                <div class="row collapse">
                                    <div class="large-2 columns">
                                        <label class="inline"> Email</label>
                                    </div>
                                    <div class="large-9 large-offset-1 columns">
                                        <input type="email" id="youremail" name="youremail" placeholder="somebody@somewhere.com" required="">
                                        <small class="error">Необходимо указать email в правильном формате.</small>
                                    </div>
                                </div>
                                <div class="row collapse">
                                    <div class="large-2 columns">
                                        <label class="inline">Укажите телефон для связи с Вами</label>
                                    </div>
                                    <div class="large-9 large-offset-1 columns">
                                        <input type="tel" id="yourphone" name="yourphone" placeholder="7-7$$-$$$-$$$$" required="" onkeypress="InputPhone(this, event);">
                                        <small class="error">Необходимо указать телефон в правильном формате (вводите только цифры).</small>
                                    </div>
                                </div>
                                <label>Вопрос</label>
                                <textarea rows="4" name="question"></textarea>
                                <button type="submit" class="radius button">Отправить</button>
                            </form>
                        </div>
                    </section>
                </div>
            </div>


            <div class="large-7 end" style="padding: 1rem;">
                <p>
                   Нас можно найти по адресу: г.Алматы, мкр.Думан-2 дом 18 кв.55
                </p>
                <h5>Карта</h5>
                <p>
                    <iframe src="https://www.google.com/maps/d/embed?mid=zvs2j_splhmg.k91zYyeVNtdQ&zoom=10" width="990" height="500" frameborder="0" style="border:0" allowfullscreen></iframe>
                    <!--            <a href="" data-reveal-id="mapModal"><img src="http://placehold.it/400x280"></a><br/>
                                <a href="" data-reveal-id="mapModal"></a>
                              </p>
                              <p>
                                г.Алматы<br/>
                                улица
                              </p>-->
            </div>

        </div>


        <!--      <div class="reveal-modal" id="mapModal">
        <h4>Где мы</h4>
        <p><img src="http://placehold.it/800x600"/></p>
     
         
        <a href="#" class="close-reveal-modal">×</a>
      </div>-->
        <script src="js/vendor/jquery.js"></script>
        <script src="js/vendor/fastclick.js"></script>
        <script src="js/foundation/foundation.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script src="js/foundation/foundation.topbar.js"></script>
        <script>
                                            $(document).foundation();
        </script>
        <script>
            function InputPhone(object, event) {
                if (object.value.length > 13)
                    event.preventDefault();
                if (object.value.match(/[^0-9\-]/))
                    object.value = object.value.replace(/[^0-9\-]/g, '');
                if (object.value.length === 1 || object.value.length === 5 || object.value.length === 9)
                    object.value = object.value + '-';};
        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
