<%-- 
    Document   : success
    Created on : 21.09.2016, 12:04:46
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<!DOCTYPE html>
<h:successful>
    <div class="text-center row">
        <h3>Запрос успешно обработан</h3>
        <div class="medium-12 column">
            <a onClick="history.go(-1);return true;">Назад</a> |
            <a class="btn btn-default" type="button" href="<c:url value="/index.jsp"/>">Вернуться на главную страницу</a>
        </div>
    </div>
</h:successful>
