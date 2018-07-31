<%-- 
    Document   : menu
    Created on : 26.09.2016, 9:31:38
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Приложение</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
            <div class="row">
                ${it}
            </div>
        </def:templatePage>
    </body>
</html>
