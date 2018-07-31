<%-- 
    Document   : successful
    Created on : 21.09.2016, 11:34:08
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="message"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Успешно</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
                <jsp:doBody/>
        </def:templatePage>
    </body>
</html>