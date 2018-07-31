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
        <title>JSP Page</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
            <div class="row included section">
                <c:forEach var="bar" items="${it}">
                    <div class="large-4 columns">
                        <h3><a href="<c:url value="${bar.url}"/>">${bar.title}</a></h3>
                        <div>${bar.description}</div>
                    </div>
                </c:forEach>
            </div>
        </def:templatePage>
    </body>
</html>
