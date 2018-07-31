<%-- 
    Document   : registry1
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Тендерные услуги | Данные по тендерам | Alta и К</title>
        <meta name="description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера."/>
        <link rel="canonical" href="https://www.alta.kz/" />
        <meta property="og:locale" content="en_US" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="Тендерные услуги | Данные по тендерам | Alta и К" />
        <meta property="og:description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера." />
        <meta property="og:url" content="https://www.alta.kz/" />
        <meta property="og:site_name" content="Альта и К" />
        <link rel="apple-touch-icon" href="img/apple-icon-touch.png">
        <link rel="shortcut icon" type="image/png" href="img/favicon.png">  

        <link rel="stylesheet" href="css/style.css" />

        <script type="text/javascript" src="js/jquery.min.js"></script>

        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap-multiselect.css" type="text/css" />
        <script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
    </head>




    <body>
        <div class="fixed">
            <nav class="main-nav">
                <span class="thin-strip blue-strip"></span>
                <a href="index.jsp" class="logo"><img src="img/logo.png" alt="AltaIK Logo" style="height: auto; max-width: 100%"></a>
                <ul class="main-navigation">
                    <li class="dropdown">
                        <span><a href="search.jsp">Поиск</a></span>
                    </li>
                    <li class="dropdown">
                        <a href="services.jsp">Услуги</a>
                    </li>
                    <li class="dropdown">
                        <a href="about.jsp">О компании</a>
                    </li>
                    <%if (null != session.getAttribute("isAuthorized")) {%>
                    <li class="dropdown">
                        <span><a href="cabinet.jsp">Личный кабинет</a></span>

                    </li>
                    <li class="dropdown">
                        <span><a href="logout.jsp">Выход</a></span>

                    </li>
                    <%} else {%>
                    <li class="dropdown">
                        <span><a href="registry.jsp">Регистрация/Вход</a></span>
                    </li>
                    <%}%>

                </ul>
                <a href="about.jsp" class="button" style="color: white; padding: 1px">Свяжитесь с нами</a>
            </nav>
        </div>


    </body>
</html>