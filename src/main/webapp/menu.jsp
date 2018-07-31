<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="nav-container">
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left">
        <span class="thin-strip blue-strip"></span>
        <div class="container">
            <a class="show-menu hamburger-button left-off-canvas-toggle menu-icon">Меню</a>
        </div>
        <ul>
            <li>
                <span><a href="<c:url value='/search.jsp'/>">Тендер</a></span>
            </li>
            <li>
                <span><a href="<c:url value='/about.jsp'/>">О компании</a></span>
            </li>
            <li>
                <span><a href="<c:url value='/services.jsp'/>">Услуги</a></span>
            </li>
            <li>
                <span><a href="http://88.204.230.204:81/SupplierCabinet">Кабинет поставщика</a></span>
            </li>
            <%--<li>--%>
                <%--<span><a href="<c:url value='/rates.jsp'/>">Тарифы</a></span>--%>
            <%--</li>--%>
            <%if (null != session.getAttribute("isAuthorized")) {%>
            <li>
                <span><a href="<c:url value='/cabinet2.jsp'/>">Личный кабинет</a></span>

            </li>
            <li>
                <span><a href="<c:url value='/logout.jsp'/>">Выход</a></span>

            </li>
            <%} else {%>
        <li>
            <span><a href="<c:url value='/registry.jsp'/>">Регистрация</a></span>
        </li>
        <li>
            <span><a href="<c:url value='/logon.jsp'/>">Вход</a></span>
        </li>
            <%}%>
            <!--        <li>
                        <span><a href="emaildelivery.html">Управление рассылками</a></span>
                    </li>-->

        </ul>
    </nav>
</div>
