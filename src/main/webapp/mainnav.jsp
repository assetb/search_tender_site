<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="main-nav">
    <!--        <span class="thin-strip blue-strip"></span>-->
    <div class="row top_info_strip" style="font-size: medium; background-color: #2b7fde;color: whitesmoke;font-weight: 700;max-width: 100%">
        <div class="small-2 small-offset-2 columns">
            <span class="icon-mail"></span>
            <span class="contact-data">info@altatender.kz</span>
        </div>
        <div class="small-2 small columns">
            <span class="currentTime"></span>
        </div>
        <!--        <div class="small-2 columns">
                    <span class="icon_phone"></span><span class="contact-data">+7 727 331 66 41</span>
                </div>-->
        <div class="small-2 small columns">
            <span class="icon_phone"></span>
            <span class="contact-data">+7 727 390 43 02</span>
        </div>
        <div class="small-4 small columns">
            <span class="icon_mobile"></span>    <span class="contact-data">+7 747 528 16 04</span>
        </div>
    </div>

    <a href="<c:url value='/index.jsp'/>" class="logo" style="margin-left:auto">
        <img src="<c:url value="/img/logo.png"/>" alt="AltaIK Logo">
    </a>

    <ul class="main-navigation" style="margin-left: 20px">
        <li class="dropdown">
            <span><a href="<c:url value='/search.jsp'/>">Тендер</a></span>
        </li>
        <li class="dropdown">
            <a href="<c:url value='/about.jsp'/>">О компании</a>
        </li>
        <li class="dropdown">
            <a href="<c:url value='/services.jsp'/>">Услуги</a>
        </li>
        <li class="dropdown">
            <span><a href="http://88.204.230.204:81/SupplierCabinet">Кабинет поставщика</a></span>
        </li>
        <%if (null != session.getAttribute("isAuthorized")) {%>
        <li class="dropdown">
            <span><a href="<c:url value='/cabinet2.jsp'/>">Личный кабинет</a></span>

        </li>
        <li class="dropdown">
            <span><a href="<c:url value='/logout.jsp'/>">Выход</a></span>

        </li>
        <%} else {%>
        <li class="dropdown">
            <span><a href="<c:url value='/registry.jsp'/>">Регистрация</a></span>
        </li>
        <li class="dropdown">
            <span><a href="<c:url value='/logon.jsp'/>">Вход</a></span>
        </li>
        <%}%>
    </ul>
        <a href="<c:url value='/contacts.jsp'/>" class="button" style="margin-right: 15px">Свяжитесь с нами</a>



</nav>
