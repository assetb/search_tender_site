<%-- 
    Document   : error
    Created on : 11.10.2016, 15:09:56
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="type"%>
<%@attribute name="description"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ошибка</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
            <h1>Ошибка: <b id="error-type">${type}</b></h1>
            <div class="row">Описание:</div>
            <p id="discription">${description}</p>
            <button type="button" class="btn" onClick="history.go(-1);
                return true;">Назад</button>
            <a class="btn" type="button" href="<c:url value="/index.jsp"/>">Вернуться на главную страницу</a>
        </def:templatePage>
    </body>
</html>