<%-- 
    Document   : logout
    Created on : 06.08.2015, 10:33:18
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Выход</title>
    </head>
    <body>
        <% session.invalidate();%>
        <h1>Вы успешно вышли</h1>
        <a href="index.jsp">Вернитесь на главную ...</a>
        <c:redirect url="index.jsp"/>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
