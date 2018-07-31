<%-- 
    Document   : ReportForSamruk
    Created on : 05.09.2016, 15:31:05
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>

<fmt:requestEncoding value="UTF-8" />
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



                <!-- Off Canvas Menu -->
                <h:leftmenu/>

                <sql:query var="countAuctions" sql="SELECT count(id) as count FROM pastauctions;" dataSource="${db}"/>
                <sql:query var="countFinished" sql="SELECT count(id) as count FROM pastauctions WHERE finished = 1;" dataSource="${db}"/>
                <sql:query var="sumAuctions" sql="SELECT sum(lastsum) as lastsum, sum(startsum) as startsum FROM pastauctions where finished = 1;" dataSource="${db}"/>
                <sql:query var="profit" sql="SELECT sum(lastsum * 2 / 100) as lastsum FROM pastauctions WHERE finished = 1;" dataSource="${db}"/>


                <div class="row ad-block">
                    <div id="moreInfo" class="reveal-modal" data-reveal></div>
                    <div>
                        <div class="row panel">
                            <div class="column small-6">Кол-во проведенных аукционов</div>
                            <div class="column small-6">${countFinished.rows[0].count} из ${countAuctions.rows[0].count}</div>
                        </div>
                        <div class="row panel">
                            <div class="column small-6">Общая сумма</div>
                            <div class="column small-6">${sumAuctions.rows[0].lastsum + 0.0}</div>
                        </div>
                        <div class="row panel">
                            <div class="column small-6">Доход(2% от итоговой суммы)</div>
                            <div class="column small-6">${profit.rows[0].lastsum + 0.0}</div>
                        </div>
                    </div>
                    <sql:query var="auctions" sql="SELECT id, number, lastsum, startsum FROM pastauctions LIMIT ${param.p != null ? param.p : 0}, 20;" dataSource="${db}"/>
                    <a href="<c:url value="ReportDetails.jsp"><c:param name="auctionid" value="0"/></c:url>">Добавить аукцион</a>
                    <h:table count="${countAuctions.rows[0].count}" urlpage="ReportsLits.jsp">
                        <table width="100%">
                            <tr>
                                <th>Номер аукциона</th>
                                <th>Стартовая сумма</th>
                                <th>Итоговая сумма</th>
                                <th>Трейдер</th>

                            </tr>
                            <c:forEach var="auction" items="${auctions.rows}">
                                <tr>
                                    <td><a href="
                                           <c:url value="/new/reports/samruk/ReportDetails.jsp">
                                               <c:param name="auctionid" value="${auction.id}"/>
                                           </c:url>">${auction.number}</a>
                                    </td>
                                    <td>${auction.startsum + 0.0}</td>
                                    <td>${auction.lastsum + 0.0}</td>
                                    <td>трейдер</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </h:table>
                </div>
                <a class="exit-off-canvas"></a>
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

        </script>
    </body>
</html>
