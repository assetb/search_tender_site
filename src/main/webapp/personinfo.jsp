<%-- 
    Document   : personinfo
    Created on : 05.11.2015, 14:39:53
    Author     : Smaile
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="UTF-8" />

<c:if test="${sessionScope.roleid == null || sessionScope.roleid < 9 || sessionScope.roleid > 100}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Компания ${row.runame}</title>
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
                        <a class="button" href="<c:url value="showdetails.jsp"><c:param name="id" value="${param.customer_id}"/></c:url>">Назад</a>
                        </div>
                        <a class="left-off-canvas-toggle" href="#"><i class="fi-list"></i></a>
                        <c:if test="${param.type != null}">
                            <c:choose>
                                <c:when test="${param.type == 'update'}">
                                    <sql:update dataSource="${db}">
                                    UPDATE personinfo SET firstname=?, lastname=?, tel=?, email=? WHERE id=?
                                    <sql:param value="${param.firstname != null ? param.firstname : ''}"/>
                                    <sql:param value="${param.lastname != null ? param.lastname : ''}"/>
                                    <sql:param value="${param.tel != null ? param.tel : ''}"/>
                                    <sql:param value="${param.email != null ? param.email : ''}"/>
                                    <sql:param value="${param.client_id}"/>
                                </sql:update>
                                <div class="row success label">Сохраненно</div>
                            </c:when>
                            <c:when test="${param.type == 'new'}">
                                <sql:transaction dataSource="${db}"  >
                                    <sql:update  var="result">
                                        INSERT INTO personinfo (firstname, lastname, tel, email) VALUES (?,?,?,?);
                                        <sql:param value="${param.firstname != null ? param.firstname : ''}"/>
                                        <sql:param value="${param.lastname != null ? param.lastname : ''}"/>
                                        <sql:param value="${param.tel != null ? param.tel : ''}"/>
                                        <sql:param value="${param.email != null ? param.email : ''}"/>
                                    </sql:update>
                                    <sql:query var="nextIdTable" >
                                        SELECT LAST_INSERT_ID() as lastId
                                    </sql:query>
                                    <sql:update>
                                        INSERT INTO contacts(customerid, bindid) VALUES (?,?);
                                        <sql:param value="${param.customer_id}"/>
                                        <sql:param value="${nextIdTable.rows[0].lastId}"/>
                                    </sql:update>
                                </sql:transaction> 
                                <c:redirect url="showdetails.jsp">
                                    <c:param name="id" value="${param.customer_id}"/>
                                </c:redirect>
                            </c:when>
                            <c:when test="${param.type == 'delete'}">
                                <sql:update dataSource="${db}">
                                    DELETE FROM personinfo WHERE id = ?;
                                    <sql:param value="${param.client_id}"/>
                                </sql:update>
                                <sql:update dataSource="${db}">
                                    DELETE FROM contacts WHERE bindid = ?;
                                    <sql:param value="${param.client_id}"/>
                                </sql:update>
                                <c:redirect url="showdetails.jsp?">
                                    <c:param name="id" value="${param.customer_id}"/>
                                </c:redirect>
                            </c:when>
                        </c:choose>
                    </c:if>
                    <c:if test="${param.client_id != null && !param.client_id.isEmpty()}">
                        <sql:query var="personinfo" dataSource="${db}">
                            SELECT * FROM personinfo WHERE id = ${param.client_id}
                        </sql:query>
                    </c:if>
                    <c:set var="row" value="${personinfo.rows[0]}"/>
                    <form method="post" action="<c:url value="personinfo.jsp"/>">
                        <input hidden name="customer_id" value="${param.customer_id}">
                        <input hidden name="client_id" value="${param.client_id}">
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Фамилия
                                    <input type="text" name="lastname" value="${row.lastname}">
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Имя
                                    <input type="text" name="firstname" value="${row.firstname}">
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-6 columns">
                                <label>Телефон
                                    <input type="text" name="tel" value="${row.tel}">
                                </label>
                            </div>
                            <div class="large-6 columns">
                                <label>Email
                                    <input type="email" name="email" value="${row.email}">
                                </label>
                            </div>
                        </div>
                        <button class="button" type="submit" name="type" value="${param.client_id !=  null ? 'update' : 'new'}">Сохранить</button>
                        <c:if test="${param.client_id != null}">
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
