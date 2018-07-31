<%-- 
    Document   : errorpage
    Created on : 20.09.2016, 16:14:29
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <h1>Error: <b id="error-type">${it.type}</b></h1>
        <div id="discription">${it.description}</div>
        <button type="button" class="btn" onClick="history.go(-1);return true;">Назад</button>
        <a class="btn" type="button" href="<c:url value="/index.jsp"/>">Вернуться на главную страницу</a>
    </body>
</html>
