<%-- 
    Document   : updatefield
    Created on : 13.10.2015, 14:18:41
    Author     : Smaile
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${param.update != null && param.wherevalue != null && param.wherename != null && param.name != null && param.value != null}">
        <sql:update dataSource="${db}">
            Update ${param.update} SET ${param.name} = ${param.value} WHERE ${param.wherename} = ${param.wherevalue}
        </sql:update>
    </c:when>
    <c:otherwise>
        <div class="alert-box alert">Error</div>
    </c:otherwise>
</c:choose>