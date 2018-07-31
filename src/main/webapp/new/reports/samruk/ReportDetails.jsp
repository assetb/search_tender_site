<%-- 
    Document   : ReportForSamruk
    Created on : 05.09.2016, 15:31:05
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:requestEncoding value="UTF-8" />

<jsp:useBean id="ListLots" scope="page" class="com.altaik.parserweb.bo.Lots"/>

<c:choose>
    <c:when test="${sessionScope.userid == null || sessionScope.roleid == null}">
        <c:redirect url="/index.jsp"/>
    </c:when>
</c:choose>
<!DOCTYPE html>
<html class="no-js" lang="en" 
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:f="http://xmlns.jcp.org/jsf/core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Отчет по торгам Самрук</title>
        <link href='http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="<c:url value="/css/normalize.css"/>">
        <link rel="stylesheet" href="<c:url value="/css/foundation.min.css"/>" />
        <!--<link rel="stylesheet" href="/css/foundation.css" />-->
        <link rel="stylesheet" href="<c:url value="/css/filtergrid.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/cabinet.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/style.css"/>" />
        <script src="<c:url value="/js/vendor/modernizr.js"/>"></script>
        <style type="text/css">
            body { padding-top: 140px; }
            @media screen and (max-width: 768px) {
                body { padding-top: 0px; }
            }
        </style>
    </head>
    <body>
        <%--<c:import url="/menu.jsp"/>--%>
        <%@include file="/menu.jsp" %>
        <div class="fixed">
            <%@include file="/mainnav.jsp" %>
        </div>
        <div class="off-canvas-wrap move-right" data-offcanvas>
            <div class="inner-wrap">
                <c:choose>
                    <c:when test="${param.type != null}">
                            <sql:update dataSource="${db}" sql="INSERT INTO pastauctions(number, startsum, lastsum, finished) VALUE(?, ?, ?, ?) ON DUPLICATE KEY UPDATE startsum=?, lastsum=?, finished=?;">
                                <sql:param value="${param.number}"/>
                                <sql:param value="${param.startsum != null ? param.startsum : 0}"/>
                                <sql:param value="${param.lastsum != null ? param.lastsum : 0}"/>
                                <sql:param value="${param.finished != null ? 1: 0}"/>
                                <!--params by update-->
                                <sql:param value="${param.startsum != null ? param.startsum : 0}"/>
                                <sql:param value="${param.lastsum != null ? param.lastsum : 0}"/>
                                <sql:param value="${param.finished != null ? 1: 0}"/>                                
                            </sql:update>
                            <sql:query dataSource="${db}" var="nextIdTable" sql="SELECT id from pastauctions where number=?;">
                                <sql:param value="${param.number}"/>
                            </sql:query>
                            <c:forEach var="lot" items="${ListLots.Parse(param)}">
                                <sql:update dataSource="${db}" sql="INSERT INTO pastauctionlots(priceofferid, number, rang, minprice, lastprice, count) VALUE(?,?,?,?,?,?) ON DUPLICATE KEY UPDATE rang=?, minprice=?, lastprice=?, count=?;">
                                    <sql:param value="${nextIdTable.rows[0].id}"/>
                                    <sql:param value="${lot.number}"/>
                                    <sql:param value="${lot.rang}"/>
                                    <sql:param value="${lot.minprice}"/>
                                    <sql:param value="${lot.lastprice}"/>
                                    <sql:param value="${lot.count}"/>
                                    <!--params by update-->
                                    <sql:param value="${lot.rang}"/>
                                    <sql:param value="${lot.minprice}"/>
                                    <sql:param value="${lot.lastprice}"/>
                                    <sql:param value="${lot.count}"/>
                                </sql:update>
                            </c:forEach>
                        <c:if test="${param.type == 'new'}">
                            <c:redirect url="ReportsList.jsp"/>
                        </c:if>
                    </c:when> 
                </c:choose>
                <sql:query var="auctions" sql="SELECT id, number, startsum, lastsum, createdate, finished, trader FROM pastauctions WHERE id = ${param.auctionid};" dataSource="${db}"/>
                <sql:query var="lots" sql="SELECT id, number, rang, minprice, lastprice, count FROM pastauctionlots WHERE priceofferid = ${param.auctionid};" dataSource="${db}"/>
                <c:set var="auction" value="${auctions.rows[0]}"/>

                <div class="row ad-block">
                    <c:choose>
                        <c:when test="${param.type != null}">
                            <div data-alert class="alert-box success radius">
                                Данные сохранены.
                                <a href="#" class="close">&times;</a>
                            </div>
                        </c:when>
                    </c:choose>
                    <form method="POST">
                        <input hidden name="auctionid" value="${param.auctionid}"/>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Номер аукциона
                                    <input type="text" name="number" ${param.auctionid > 0? 'readonly' : ''} value="${auction.number}"/></label>
                                <label>Трейдер
                                    <input type="text" name="trader" value="${auction.trader}" />
                                </label>
                                <label>Стартовая сумма
                                    <input required="true" type="text" name="startsum" value="${auction.startsum + 0.0}" />
                                </label>
                                <label>Итоговая сумма
                                    <input required="true" type="text" name="lastsum" value="${auction.lastsum + 0.0}" />
                                </label>
                                <label>Дата создания
                                    <span>${auction.cratedate}</span>
                                </label>
                                <label>Завершен
                                    <input type="checkbox" name="finished" ${auction.finished != null ? 'checked' : ''} />
                                </label>
                            </div>
                            <table id="tlots" style="width: 100%;">
                                <tr>
                                    <th>Номер лота</th>
                                    <th>Ранг</th>
                                    <th>Кол-во</th>
                                    <th>Итоговая цена(тг.)</th>
                                    <th>Минимальная цена(тг.)</th>
                                </tr>

                                <c:forEach var="lot" items="${lots.rows}">
                                    <tr>
                                        <td><input type="text" readonly name="lot:number:${lot.id}" value="${lot.number}"/></td>
                                        <td><input type="text" name="lot:rang:${lot.id}" value="${lot.rang + 0}"/></td>
                                        <td><input type="text" name="lot:count:${lot.id}" value="${lot.count + 0.0}"/></td>
                                        <td><input type="text" name="lot:lastprice:${lot.id}" value="${lot.lastprice + 0.0}"/></td>
                                        <td><input type="text" name="lot:minprice:${lot.id}" value="${lot.minprice + 0.0}"/></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${param.auctionid == 0}">
                                    <tr>
                                        <td colspan="5"><button class="text-center prefix" onclick="addLot()" type="button">Добавить лот</button></td>
                                    </tr>
                                </c:if>
                            </table>
                            <div class="row">
                                <button type="submit" class="button" name="type" value="${param.auctionid > 0? 'update' : 'new'}">
                                    ${param.auctionid > 0?'Сохранить':'Создать'}
                                </button>
                                <a class="button" href="<c:url value="ReportsList.jsp"/>">Назад</a>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="<c:url value="/js/vendor/jquery.js"/>"></script>
        <script language="javascript" type="text/javascript" src="<c:url value="/js/actb.js"/>"></script><!-- External script -->
        <script language="javascript" type="text/javascript" src="<c:url value="/js/tablefilter.js"/>"></script>
        <script src="<c:url value="/js/vendor/fastclick.js"/>"></script>
        <script src="<c:url value="/js/foundation.min.js"/>"></script>
        <!--<script src="js/foundation/foundation.js"></script>-->
        <script src="<c:url value="/js/foundation/foundation.offcanvas.js"/>"></script>
        <script src="<c:url value="/js/foundation/foundation.abide.js"/>"></script>
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
            function addLot() {
                var tr = $("tr:not(:first-child):not(:last-child)", "#tlots");
                $('<tr><td><input type="text" name="lot:number:' + (tr.length + 1) + '" value="' + (tr.length + 1) + '"/></td>' +
                        '<td><input type="text" name="lot:rang:' + (tr.length + 1) + '"/></td>' +
                        '<td><input type="text" name="lot:count:' + (tr.length + 1) + '"/></td>' +
                        '<td><input type="text" name="lot:lastprice:' + (tr.length + 1) + '"/></td>' +
                        '<td><input type="text" name="lot:minprice:' + (tr.length + 1) + '"/></td></tr>').insertBefore("#tlots tr:last-child");
            }
        </script>
    </body>
</html>
