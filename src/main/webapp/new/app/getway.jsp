<%-- 
    Document   : getwayView
    Created on : 06.10.2016, 9:23:21
    Author     : admin
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
    <def:importStyles/>
</head>
<body>
<def:templatePage>
    <c:out value="${it}"  escapeXml="false"/>
</def:templatePage>
</body>
</html>