<%-- 
    Document   : enumpages
    Created on : 06.09.2016, 15:51:28
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="countpages"%>
<%@attribute name="urlpage"%>

<%-- any content can be specified here e.g.: --%>
<c:set var="count" value="${countpages / 20}"/>
<ul class="pagination" style="margin-bottom: 10px">
    <c:forEach var="i" begin="0" end="${count}" step="1">
        <c:set var="i" value="${i+1}"/>
        <li ${(param.p == null && i == 1) || i == param.p ? 'class="current"' : ''}>
            <a style="margin:0 10px;" href="<c:url value="${urlpage}">
               <c:forEach var="paramRequest" items="${param}">
                    <c:if test="${paramRequest.key != 'p'}">
                        <c:param name="${paramRequest.key}" value="${paramRequest.value}"/>
                    </c:if>
                </c:forEach>
                <c:param name="p" value="${i}"/>
                </c:url>"/>${i}</a>
        </li>
    </c:forEach>
</ul>