<%-- 
    Document   : cabinet2
    Created on : 12.08.2015, 11:25:54
    Author     : Aset
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="UTF-8" />

<c:set var="isEmployee" value="${(sessionScope.userid!=null && sessionScope.roleid!= null && sessionScope.roleid > 9 && sessionScope.roleid < 100)? true : false}"/>
<c:set var="isHeadEmployee" value="${(sessionScope.userid != null && sessionScope.roleid == 20)? true : false}"/>

<c:if test="${isEmployee == false}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" 
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Реестр клиентов</title>
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

                <a class="left-off-canvas-toggle" href="#"><i class="fi-list"></i></a>

                <!-- Off Canvas Menu -->
                <aside class="crap-canvas-menu left-off-canvas-menu">
                    `
                    <div class="crap-icon-bar icon-bar vertical five-up">
                        <a class="item" href="<c:url value='cabinet2.jsp'/>">
                            <i class="fi-torso small"></i>
                            <label>Профиль</label>
                        </a>
                        <c:if test="${isEmployee == true}">
                            <a class="item" href="<c:url value='maincrm.jsp'/>">
                                <i class="fi-mail"></i>
                                <label>Реестр клиентов</label>
                            </a>
                        </c:if>
                        <a class="item" href="<c:url value='cabinet3.jsp'/>">
                            <i class="fi-mail"></i>
                            <label>Рассылки</label>
                        </a>
                        <a class="item">
                            <i class="fi-list"></i>
                            <label>Перечень рассылок</label>
                        </a>
                        <a class="item">
                            <i class="fi-star"></i>
                            <label>Избранное</label>
                        </a>
                        <a class="item" href="<c:url value='cabinet4.jsp'/>">
                            <i class="fi-alert"></i>
                            <label>Пароль</label>
                        </a>
                    </div>

                </aside>

                <!-- main content goes here -->
                <!--                <header class="row">
                                    <div class="small-12 columns">
                                        <h1 class="text-center">Реестр клиентов</h1>
                                    </div>
                                </header>-->
                <div class="panel">

                    <sql:query var="selectStatus" sql="SELECT orderid, name FROM statusenum;" dataSource="${db}"/>
                    <sql:query var="selectManagers" sql="SELECT id, email FROM users WHERE 9 < role < 100;" dataSource="${db}"/>

                    <form action="<c:url value="maincrm.jsp"/>" method="post">
                        <div class="row">
                            <input type="text" placeholder="Наименование компании" name="runame" value="${param.runame != null ? param.runame : ''}"/>
                        </div>
                        <div class="row collapse">
                            <c:if test="${isHeadEmployee}">
                                <div class="large-4 columns">
                                    <select name="managerid">
                                        <option value="" >Выбрать менеджера</option>
                                        <option value="-1" ${param.managerid != null && param.managerid == '-1' ? 'selected': ''}>Менеджер не указан</option>
                                        <c:forEach var="manager" items="${selectManagers.rows}">
                                            <option value="${manager.id}" ${param.managerid != null && param.managerid == manager.id? 'selected' : ''}>${manager.email}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:if>
                            <div class="large-4 columns">
                                <select name="status">
                                    <option value="">Выбрать статус</option>
                                    <c:forEach var="status" items="${selectStatus.rows}">
                                        <option value="${status.orderid}" ${param.status != null && param.status == status.orderid ? 'selected' : ''}>${status.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="large-4 columns">
                                <button class="button postfix" type="submit">Фильтровать</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="row ad-block">
                    <div id="ajaxinfo"></div>
                    <div id="moreInfo" class="reveal-modal" data-reveal></div>
                    <!--<a href="<c:url value="showdetails.jsp"/>">Добавить новую компанию</a>-->

                    <jsp:useBean id="queryValues" class="java.util.ArrayList"/>
                    <%
                        if (pageContext.getAttribute("isHeadEmployee") != null && !(Boolean) pageContext.getAttribute("isHeadEmployee")) {
                            queryValues.add("managerid = " + session.getAttribute("userid"));
                        } else if (request.getParameter("managerid") != null && request.getParameter("managerid") != "") {
                            if (Long.parseLong(request.getParameter("managerid")) == -1) {
                                queryValues.add("managerid is null");
                            } else {
                                queryValues.add("managerid = " + request.getParameter("managerid"));
                            }
                        }

                        if (request.getParameter("status") != null && request.getParameter("status") != "") {
                            queryValues.add("status = " + request.getParameter("status"));
                        }

                        if (request.getParameter("runame") != null && request.getParameter("runame") != "") {
                            queryValues.add("runame LIKE '%" + request.getParameter("runame") + "%'");
                        }
                    %>

                    <jsp:useBean id="selectWhere" class="java.lang.String"/>
                    <%
                        if (queryValues.size() == 0) {
                            selectWhere = "";
                        } else {
                            selectWhere = " WHERE ";
                            boolean isFirst = true;
                            for (Object value : queryValues) {
                                String stringValue = (String) value;
                                if (isFirst) {
                                    isFirst = false;
                                    selectWhere += " " + stringValue;
                                } else {
                                    selectWhere += " AND " + stringValue;
                                }
                            }
                        }
                    %>
                    <c:set var="selectQuery">
                        SELECT c.id, c.runame,  c.tel, c.status
                        <c:if test="${isHeadEmployee == true}">,c.managerid</c:if>
                        FROM customer c <%=selectWhere%> ORDER BY c.updatedate DESC LIMIT ${param.p != null ? (param.p-1)*20 : 0}, 20</c:set>
                    <c:set var="selectCount" value="SELECT count(c.id) as count FROM customer c"/>
                    <sql:query var="selectactions" dataSource="${db}" sql="${selectQuery}"/>
                    <sql:query var="countCustomer" dataSource="${db}">${selectCount}<%=selectWhere%></sql:query>

                    <h:table count="${countCustomer.rows[0].count}" urlpage="maincrm.jsp">
                        <table id="table" style="border: 0;" width="100%">
                            <thead>
                                <tr style="background-color: #008CBA;">
                                    <c:if test="${isHeadEmployee == true}">
                                        <th style="color: whitesmoke;" width="250px">Менеджер</th>
                                        </c:if>
                                    <th style="color: whitesmoke;" >Компания</th>
                                    <th style="color: whitesmoke;" width="250px">Статус</th>
                                    <th style="color: whitesmoke;" width="20%">Телефон компании</th>
                                    <!--<th width="30%">Содержание беседы</th>-->
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${selectactions.rows}">                          
                                    <tr style="background-color: white; border-bottom: 1px solid #ddd;">
                                        <c:if test="${isHeadEmployee}">
                                            <td>
                                                <select update="customer" style="margin: 0;" name="managerid" wherename="id" wherevalue="${row.id}">
                                                    <option hidden="true">Менаджер не выбран</option>
                                                    <c:forEach var="user" items="${selectManagers.rows}">
                                                        <option ${(row.managerid == user.id) ? 'selected' : ''} id="${user.id}">${user.email}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </c:if>
                                        <td>
                                            <a href="<c:url value="showdetails.jsp">
                                                   <c:param name="id" value="${row.id}"/>
                                                   <c:param name="p" value="${param.p != null ? param.p: 1}"/>
                                               </c:url>">
                                                ${row.runame != null ? row.runame : 'Нет наименования'}
                                            </a>
                                        </td>
                                        <td>
                                            <select update="customer" style="margin: 0;" name="status" wherename="id" wherevalue="${row.id}">
                                                <option hidden="true">Не указан</option>
                                                <c:forEach var="stat" items="${selectStatus.rows}">
                                                    <option ${(row.status == stat.orderid) ? 'selected' : ''} id="${stat.orderid}">${stat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>${row.tel != null || row.tel != '' ? row.tel : 'Телефон не указан'}</td>
                                        <!--<td>${row.result != null ? row.result : 'нет записей'}</td>-->
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </h:table>
                    <!--</div>-->
                </div>

                <!-- close the off-canvas menu -->
                <a class="exit-off-canvas"></a>

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
            var moreinfo = $("table#table a[name][source]");
            moreinfo.click(function (event) {
                var el = $(event.target);
                $("div#moreInfo").foundation('reveal', 'open', {
                    url: "moreinfo.jsp",
                    data: {source: el.attr("source"), name: el.attr("name"), value: el.attr("value")}
                });
            });

            $('*[update]').change(function (event) {
                var el = $(event.target);
                var update = el.attr("update");
                var name = el.attr("name");
                var wherename = el.attr("wherename");
                var wherevalue = el.attr("wherevalue");
                var value;
                if (el.is('select')) {
                    value = el.children("option:selected").attr("id");
                } else {
                    value = el.attr('value');
                }
                $.ajax({
                    type: "POST",
                    url: "updatefield.jsp",
                    data: {update: update, wherevalue: wherevalue, wherename: wherename, name: name, value: value}
                }).done(function (responce) {
                    var el = $("#ajaxinfo");
                    if (!el)
                        return;
                    el.html(responce);
                });
            });

        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
