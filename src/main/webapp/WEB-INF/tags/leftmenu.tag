<%-- 
    Document   : leftmenu
    Created on : 06.09.2016, 16:20:08
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%-- any content can be specified here e.g.: --%>
<a class="left-off-canvas-toggle" href="#"><i class="fi-list"></i></a>

<!-- Off Canvas Menu -->
<aside class="crap-canvas-menu left-off-canvas-menu">
    `
    <div class="crap-icon-bar icon-bar vertical five-up">
        <a class="item" href="<c:url value='cabinet2.jsp'/>">
            <i class="fi-torso small"></i>
            <label>Профиль</label>
        </a>
        <c:if test="${sessionScope.roleid > 9 && sessionScope.roleid < 100}">
            <a class="item" href="<c:url value='maincrm.jsp'/>">
                <i class="fi-mail"></i>
                <label>Реестр клиентов</label>
            </a>
            <a class="item" href="<c:url value='/rest/app/menu'/>">
                <i class="fi-list"></i>
                <label>Меню</label>
            </a>
        </c:if>
        <a class="item" href="<c:url value='cabinet3.jsp'/>">
            <i class="fi-mail"></i>
            <label>Рассылки</label>
        </a>
        <a class="item">
            <i class="fi-list"></i>
            <label>Перечень рассылок</label>
        </a>
        <a class="item">
            <i class="fi-star"></i>
            <label>Избранное</label>
        </a>
        <a class="item" href="<c:url value='cabinet4.jsp'/>">
            <i class="fi-alert"></i>
            <label>Пароль</label>
        </a>


    </div>

</aside>