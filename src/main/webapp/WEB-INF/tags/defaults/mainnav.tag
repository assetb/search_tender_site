<%-- 
    Document   : mainnav
    Created on : 26.09.2016, 9:51:42
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%-- any content can be specified here e.g.: --%>
<nav class="main-nav">
    <div class="row top_info_strip" style="font-size: medium; background-color: #2b7fde;color: whitesmoke;font-weight: 700;max-width: 100%">
        <div class="small-2 small-offset-2 columns">
            <span class="icon-mail"></span>
            <span class="contact-data">info@altatender.kz</span>
        </div>
        <div class="small-2 small columns">
            <span class="currentTime"></span>
        </div>
        <div class="small-2 small columns">
            <span class="icon_phone"></span>
            <span class="contact-data">+7 727 390 43 02</span>
        </div>
        <div class="small-4 small columns">
            <span class="icon_mobile"></span>
            <span class="contact-data">+7 747 528 16 04</span>
        </div>
    </div>

    <a href="<c:url value="/index.jsp"/>" class="logo">
        <img src="<c:url value="/img/logo.png"/>" alt="AltaIK Logo">
    </a>

    <ul class="main-navigation">
        <li class="dropdown">
            <span><a href="<c:url value='/search.jsp'/>">Тендер</a></span>
        </li>
        <li class="dropdown">
            <a href="<c:url value='/about.jsp'/>">О компании</a>
        </li>
        <li class="dropdown">
            <a href="<c:url value='/services.jsp'/>">Услуги</a>
        </li>
        <!--        <li class="dropdown">
                    <a href="test.jsp">Тест</a>
                </li>-->
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

    <a href="<c:url value='/contacts.jsp'/>" class="button">Свяжитесь с нами</a>
</nav>