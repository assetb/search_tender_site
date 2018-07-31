<%-- 
    Document   : reports
    Created on : 26.09.2016, 10:45:07
    Author     : admin
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
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
            <form auction="POST">
                <select name="source">
                    <option value="0">Не выбрано</option>
                    <c:forEach var="source" items="${it.sources}">
                        <option ${source.selected ? "selected" : ""} value="${source.id}">${source.name}</option>                        
                    </c:forEach>
                </select>
                <button type="submit">Применить</button>
            </form>
            <tags:table count="" urlpage="">
                <table width="100%">
                    <tr>
                        <th>Дата проведения</th>
                        <th>Номер аукциона</th>
                        <th>Секция</th>
                        <th>Статус</th>
                        <th>Публикация</th>
                    </tr>
                    <c:forEach var="auction" items="${it.auctions}">
                        <tr>
                            <td>${auction.auctiondate}</td>
                            <td><a href="<c:url value="/rest/app/reports/${auction.id}"/>">${auction.auctionnumber}</a>
                            </td>
                            <td>${auction.startprice}</td>
                            <td>${auction.sum}</td>
                            <td>${auction.site}</td>
                        </tr>
                    </c:forEach>
                </table>
            </tags:table>
        </def:templatePage>
    </body>
</html>
