<%-- 
    Document   : personinfo
    Created on : 05.11.2015, 14:39:53
    Author     : Smaile
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="UTF-8" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Содержание беседы</title>
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
            <div class="inner-wrap">
                <div class="row">
                    <div>
                        <a class="button" href="<c:url value="showdetails.jsp">
                               <c:param name="id" value="${param.customer_id}"/>
                           </c:url>">Назад</a>
                    </div>
                    <a class="left-off-canvas-toggle" href="#"><i class="fi-list"></i></a>
                        <c:if test="${param.type != null}">
                            <c:choose>
                                <c:when test="${param.type == 'update'}">
                                    <sql:update dataSource="${db}">
                                    UPDATE history SET result=?, description=? WHERE id=?
                                    <sql:param value="${param.result != null ? param.result : ''}"/>
                                    <sql:param value="${param.description != null ? param.description: ''}"/>
                                    <sql:param value="${param.history_id}"/>
                                </sql:update>
                                <div class="row success label">Сохраненно</div>
                            </c:when>
                            <c:when test="${param.type == 'new'}">
                                <sql:update dataSource="${db}">
                                    INSERT INTO history(customerid, date, result, description) VALUES (?,?,?,?);
                                    <sql:param value="${param.customer_id}"/>
                                    <sql:param value="<%=new Date()%>"/>
                                    <sql:param value="${param.result}"/>
                                    <sql:param value="${param.description}"/>
                                </sql:update>
                                <c:redirect url="showdetails.jsp">
                                    <c:param name="id" value="${param.customer_id}"/>
                                </c:redirect>
                            </c:when>
                            <c:when test="${param.type == 'delete'}">
                                <sql:update dataSource="${db}">
                                    DELETE FROM history WHERE id = ?;
                                    <sql:param value="${param.history_id}"/>
                                </sql:update>
                                <c:redirect url="showdetails.jsp">
                                    <c:param name="id" value="${param.customer_id}"/>
                                </c:redirect>>
                            </c:when>
                        </c:choose>
                    </c:if>
                    <c:if test="${param.history_id != null && !param.history_id.isEmpty()}">
                        <sql:query var="history" dataSource="${db}">
                            SELECT * FROM history WHERE id = ${param.history_id}
                        </sql:query>
                    </c:if>
                    <c:set var="row" value="${history.rows[0]}"/>
                    <form method="post" action="<c:url value="history.jsp"/>">
                        <input hidden name="history_id" value="${param.history_id}">
                        <input hidden name="customer_id" value="${param.customer_id}">
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Дата ${row.date}</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Результат беседы
                                    <input type="text" name="result" value="${row.result}">
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Описание
                                    <textarea name="description">${row.description}</textarea>
                                </label>
                            </div>
                        </div>
                        <button class="button" type="submit" name="type" value="${param.history_id !=  null ? 'update' : 'new'}">Сохранить</button>
                        <c:if test="${param.history_id != null}">
                            <button class="button" type="submit" name="type" value="delete">Удалить</button>
                        </c:if>
                        <a class="button" href="<c:url value="showdetails.jsp">
                               <c:param name="id" value="${param.customer_id}"/>
                           </c:url>">Отмена</a>
                    </form>
                </div>
            </div>
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
