<%-- 
    Document   : menu
    Created on : 26.09.2016, 9:53:40
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%-- any content can be specified here e.g.: --%>
<div class="nav-container">
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left">
        <span class="thin-strip blue-strip"></span>
        <div class="container">
            <a class="show-menu hamburger-button left-off-canvas-toggle menu-icon">Menu</a>
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
            <!--            <li>
                            <span><a href="<c:url value='/rates.jsp'/>">Тарифы</a></span>
                        </li-->
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