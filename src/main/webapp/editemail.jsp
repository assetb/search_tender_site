<%-- 
    Document   : showdetails
    Created on : 05.11.2015, 11:05:21
    Author     : Smaile
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="UTF-8" />

<c:if test="${sessionScope.roleid == null || sessionScope.roleid < 9 || sessionScope.roleid > 100}">
    <c:redirect url="index.jsp"/>
</c:if>

<c:if test="${param.email != null}">
    <sql:query var="result" dataSource="${db}" sql="SELECT id FROM users WHERE email = ?">
        <sql:param value="${param.email}"/>
    </sql:query>
    <c:if test="${result != null && result.rowCount > 0}">
        <c:set var="client_id" value="${result.rows[0].id}"/>
    </c:if>
</c:if>
<c:choose>
    <c:when test="${param.type == 'check' && param.email != null && client_id != null}">
        <c:redirect url="showdetails.jsp?client_id=${client_id}"/>
    </c:when>
    <c:when test="${param.type == 'bind' && param.email != null && client_id != null && param.customer_id != null}">
        <sql:update dataSource="${db}" sql="UPDATE customer SET userid=? WHERE id=?">
            <sql:param>${client_id}</sql:param>
            <sql:param>${param.customer_id}</sql:param>
        </sql:update>
        <c:redirect url="showdetails.jsp?id=${param.customer_id}"/>
    </c:when>
</c:choose>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Проверка пользователя</title>
        <link href='http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/foundation.min.css" />
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/filtergrid.css" />
        <link rel="stylesheet" href="css/cabinet.css" />
        <link rel="stylesheet" href="css/style.css" />
        <script src="js/vendor/modernizr.js"></script>
        <style type="text/css">
            body { padding-top: 140px; }
            @media screen and (max-width: 768px) {
                body { padding-top: 0px; }
            }        </style>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <div class="fixed">
            <%@include file="mainnav.jsp" %>
        </div>

        <div class="off-canvas-wrap move-right" data-offcanvas>
            <!--<div class="inner-wrap">-->
            <div class="row">
                <a class="button small" onclick="history.back()">Назад</a>
                <div>
                    Проверка пользователя.
                </div>
                <form method="post" action="editemail.jsp">
                    <c:if test="${param.customer_id != null}">
                        <input hidden name="customer_id" value="${param.customer_id}"/>
                    </c:if>
                    <div class="row">
                        <div class="large-10 columns">
                            <input type="email" placeholder="Введите email пользователя" value="${param.email}" required name="email"/>
                        </div>
                        <div class="large-2 columns">
                            <button  class="button  postfix" name="type" value="${param.customer_id == null ?'check':'bind'}" type="submit">Проверить</button>
                        </div>
                    </div>
                    <div class="row">
                        <c:if test="${param.email != null && client_id == null}">
                            <span class="alert label">
                                Указанный email не зарегистрирован
                            </span>
                        </c:if>
                    </div>
                </form>
            </div>                
            <!--</div>-->
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script language="javascript" type="text/javascript" src="js/actb.js"></script><!-- External script -->
        <script language="javascript" type="text/javascript" src="js/tablefilter.js"></script>
        <script src="js/vendor/fastclick.js"></script>
        <script src="js/foundation.min.js"></script>
        <!--<script src="js/foundation/foundation.js"></script>-->
        <script src="js/foundation/foundation.offcanvas.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script language="javascript" type="text/javascript">
                    //<![CDATA[
                    setFilterGrid("clientstable");
                    //]]>
        </script>
        <script>
            $("#clear").click(function () {
                //    $("#insert").text("");
                $('#form_profile')[0].reset();
                $("form div").removeClass("error");
                $("form label").removeClass("error");
                $('#addPopup').foundation("reveal", "close");
            });
        </script>
        <script>
            $(document).foundation();

            function sideNav() {
                if ($(window).width() < 769) {
                    $('.off-canvas-wrap').removeClass('move-right');
                    $('.left-off-canvas-toggle').show();
                } else {
                    $('.off-canvas-wrap').addClass('move-right');
                    $('.left-off-canvas-toggle').hide();
                }
            }

            $(window).resize(function () {
                sideNav();
            });
        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
