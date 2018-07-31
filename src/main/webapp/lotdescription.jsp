<%-- 
    Document   : registry1
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Properties"%>

<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://88.204.230.204:50505/altatender" user="AltaikDB" password="AcU!ysP14D,B4z"/>
<!DOCTYPE html>
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Тендерные услуги | Данные по тендерам | Alta и К</title>
        <meta name="description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера."/>
        <link rel="canonical" href="http://www.altatender.kz/" />
        <meta property="og:locale" content="en_US" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="Тендерные услуги | Данные по тендерам | Alta и К" />
        <meta property="og:description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера." />
        <meta property="og:url" content="http://www.altatender.kz/" />
        <meta property="og:site_name" content="Альта и К" />
        <META name="description" content="Поиск подходящей закупки.">
        <META name="keywords" content="тендера Казахстана,госзакупки,поиск тендеров,база тендеров,самрук">
        <link rel="apple-touch-icon" href="img/logo_Alta.jpg">
        <link rel="shortcut icon" type="image/png" href="img/logo_Alta.jpg">  

        <link rel='stylesheet' id='bsf-Defaults-css'  href='css/Defaults.css' type='text/css' media='all' />
        <link rel='stylesheet' id='tablepress-default-css'  href='css/default.min.css' type='text/css' media='all' />
        <link rel='stylesheet' id='footable-core-min-css'  href='css/footable.core.min.css' type='text/css' media='all' />
        <link rel='stylesheet' id='footable-metro-min-css'  href='css/footable.metro.min.css' type='text/css' media='all' />

        <link rel='shortlink' href='http://www.altatender.kz/' />
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
        <link rel="stylesheet" href="css/foundation.css" type="text/css" />
        <link rel="stylesheet" href="css/foundation-select.css" type="text/css" />

        <link rel='stylesheet' href='css/style.css' type='text/css'/>
        <link rel="stylesheet" href="css/search.css" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/search10.css" />

        <script src="js/vendor/modernizr.js"></script>

        <!--        <style>table .lot { border: 0px solid black; background-color: whitesmoke; cellspacing:0; vertical-align:top; margin:10px; width:100%;} table .lot td {padding:1px;border:0;text-align:left}</style>-->
    </head>




    <body>
        <%@include file="menu.jsp" %>
        <div class="fixed">
            <%@include file="mainnav.jsp" %>
        </div>


        <section class="inner-banner-container ss-gradient">
            <div class="banner-wrapper small-text-justify medium-text-left small-12 columns">
                <h1>Поиск</h1>
            </div>

            <div id="search-form" class="row theme-wrapper s-up">
                <form method="get" action="<c:url value='search.jsp'/>" class="form-tenders-search s-theme">
                    <input type="hidden" name="is" value="yes">
                    <input type="hidden" name="topage" value="1">
                    <div class="s1 row">
                    </div>
                    <div class="s2 row">
                        <div class="small-11 columns">
                            <input type="text" name="q" placeholder="Введите наименование или номер закупки" value="<c:if test="${not empty param.q}"><c:out value="${param.q}"/></c:if>" class="input-theme"/>
                            </div>
                            <div class="small-1 columns">
                                <button type="submit" class="btn btn-theme-green">Поиск</button>
                            </div>
                        </div>

                        <div class="row s3">
                            <div class="small-4 columns">
                            <sql:query var="selectRegions" sql="SELECT id, name FROM regionsenum;" dataSource="${db}"/>
                            <select multiple="multiple" class="regions-select" name="regions" id="regions" data-prompt="Выбрать регионы">
                                <c:forEach var="region" items="${selectRegions.rows}">
                                    <c:set var="isSelected" value="${false}"/>
                                    <c:forEach var="p" items="${paramValues['regions']}">
                                        <c:if test="${p == region.id}">
                                            <c:set var="isSelected" value="${true}"/>
                                        </c:if>
                                    </c:forEach>
                                    <option value="${region.id}" ${isSelected == true ? 'selected' : ''}>${region.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="small-4 columns">
                            <sql:query var="selectMethods" sql="SELECT id, name FROM methodsenum;" dataSource="${db}"/>
                            <select multiple="multiple" class="methods-select" name="methods" id="methods" data-prompt="Выбрать способ закупа">
                                <c:forEach var="method" items="${selectMethods.rows}">
                                    <c:set var="isSelected" value="${false}"/>
                                    <c:forEach var="p" items="${paramValues['methods']}">
                                        <c:if test="${p == method.id}">
                                            <c:set var="isSelected" value="${true}"/>
                                        </c:if>
                                    </c:forEach>
                                    <option value="${method.id}" ${isSelected == true ? 'selected' : ''}>${method.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="small-4 columns">
                            <sql:query var="selectSites" sql="SELECT siteid, sitename FROM sites;" dataSource="${db}"/>
                            <select multiple="multiple" class="sources-select" name="sources" id="sources" data-prompt="Выбрать источники">
                                <c:forEach var="site" items="${selectSites.rows}">
                                    <c:set var="isSelected" value="${false}"/>
                                    <c:forEach var="p" items="${paramValues['sources']}">
                                        <c:if test="${p == site.siteid}">
                                            <c:set var="isSelected" value="${true}"/>
                                        </c:if>
                                    </c:forEach>
                                    <option value="${site.siteid}" ${isSelected == true ? 'selected' : ''}>${site.sitename}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row s4">
                        <div class="small-3 columns">
                            <label>Мин. сумма</label>
                            <input type="text" name="minsum" placeholder="0" class="input-theme" value="" />
                        </div>

                        <div class="small-3 columns">
                            <label>Макс. сумма</label>
                            <input type="text" name="maxsum" placeholder="10000000000" class="input-theme" value="" />
                        </div>

                        <c:set var="now" value="<%= Calendar.getInstance()%>"/>
                        <%
                            Calendar calendar = Calendar.getInstance();
                        %>
                        <fmt:formatDate var="fNow" value="<%= calendar.getTime()%>" pattern="dd.MM.yyyy" />
                        <% calendar.add(Calendar.MONTH, 1);%>
                        <fmt:formatDate var="fNext" value="<%= calendar.getTime()%>" pattern="dd.MM.yyyy" />


                        <div class="small-3 columns">
                            <label>Прием заявок с</label>
                            <input type="text" id="bidfrom" name="bidfrom" placeholder="${not empty param.bidfrom ? param.bidfrom : fNow}" class="input-theme" value=""/>
                        </div>

                        <div class="small-3 columns">
                            <label>Прием заявок по</label>
                            <input type="text" id="bidto" name="bidto" placeholder="${not empty param.bidto ? param.bidto : fNext}" class="input-theme" value=""/>
                        </div>


                    </div>
                </form>
            </div>
        </section>

        <%if (null != request.getParameter("neg")) {%>

        <div class="theme-wrapper" id="tenders">
            <c:set var="query" value="select p.id,s.sitename, CONCAT(s.link, '') as sitelink, p.link,l.number,p.runame as pruname,l.runame,l.rudescription,p.customer,p.startday,p.endday,m.name, p.isdocs, p.docszip,l.sum,l.deliveryplace,l.deliveryterms,l.deliveryschedule,l.quantity,l.unit,l.price,p.attribute, p.additionalinformation from procpurchase p left join methodsenum m on p.method=m.id left join sites s on p.source=s.siteid left join lots l on p.number=l.negnumber where p.number = '${param.neg}'"/>

            <sql:query var="selectresult" dataSource="${db}">
                ${query} 
            </sql:query>

            <div class="theme-wrapper">
                <div class="tender-info">
                    <div style="margin-right:250px;">
                        <c:forEach var="row" items="${selectresult.rows}" varStatus="loop">
                            <c:if test="${loop.index == 0}">
                                <table style="text-align: left" class="lot">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <b>ОБЪЯВЛЕНИЕ</b>
                                            </td>
                                            <td>
                                                <b>№ ${param.neg}</b>
                                            </td>
                                        </tr>
                                        <c:if test="${(row.runame != null && !row.runame.isEmpty())}">
                                            <tr>
                                                <td>

                                                </td>
                                                <td>${row.runame}</td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td>Источник:</td>
                                            <td>
                                                <a href="${row.link != null && !row.link.isEmpty() ? row.link : row.sitelink}">${row.sitename}</a>
                                            </td>
                                        </tr>
                                        <tr><td>Организатор:</td><td>${row.customer}</td></tr>
                                        <tr><td>Метод:</td><td>${row.name}</td></tr>
                                        <tr><td>Дата начала:</td><td>${row.startday}</td></tr>
                                        <tr><td>Дата окончания:</td><td>${row.endday}</td></tr>
                                        <tr><td>Дополнительное описание:</td><td>${row.additionalinformation}</td></tr>
                                        <tr>
                                            <td>Документация</td>
                                            <td>
                                                <c:if test="${row.isdocs==1}">  
                                                    <c:set var="pathToFile" value="${row.docszip}"/>
                                                    <%
                                                        String pathToFile = "/home/archive/" + (String) pageContext.getAttribute("pathToFile");
                                                        File f = new File(pathToFile);
                                                        if (f != null && f.exists() && !f.isDirectory()) {
                                                    %>
                                                    <c:choose>
                                                        <c:when test="${sessionScope != null && sessionScope.userid != null}">
                                                            <a href="${row.docszip}">Скачать</a>        
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a data-reveal-id="myModal">Скачать</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <% }%>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </c:if>
                            <table>
                                <!--                                <th style="width: 200px;display: none"></th><th style="display: none"></th>-->
                                <!--                                <tr>
                                                                    <td><b>Лот на площадке</b></td><td>${row.sitename}<c:if test="${not empty row.number}">${row.number}</c:if></td>
                                                            </tr>-->
                                <c:if test="${not empty row.number}"><tr>
                                        <td><b>№</b></td>
                                        <td>${row.number}</td>
                                    </tr></c:if>
                                <c:if test="${not empty row.runame}"><tr>
                                        <td><b>Лот</b></td>
                                        <td>${row.runame}</td>
                                    </tr></c:if>

                                <c:if test="${not empty row.rudescription}"><tr>
                                        <td><b>Описание</b></td>
                                        <td>${row.rudescription}</td>
                                    </tr></c:if>

                                <c:if test="${not empty row.quantity}"><tr>
                                        <td><b>Количество</b></td>
                                        <td><c:out value="${row.quantity}"/></td>
                                    </tr></c:if>
                                <c:if test="${not empty row.unit}"><tr>
                                        <td><b>Единица измерения</b></td>
                                        <td><c:out value="${row.unit}"/></td>
                                    </tr></c:if>
                                <c:if test="${not empty row.price}"><tr>
                                        <td><b>Цена за единицу</b></td>
                                        <td><c:out value="${row.price}"/></td>
                                    </tr></c:if>
                                <c:if test="${not empty row.sum}"><tr>
                                        <td><b>Сумма</b></td>
                                        <td><c:out value="${row.sum}"/></td>
                                    </tr></c:if>

                                <c:if test="${not empty row.attribute}"><tr>
                                        <td><b>Условия оплаты</b></td>
                                        <td><c:out value="${row.attribute}"/></td>
                                    </tr></c:if>

                                <c:if test="${not empty row.deliveryplace}"><tr>
                                        <td><b>Место поставки</b></td>
                                        <td><c:out value="${row.deliveryplace}"/></td>
                                    </tr></c:if>

                                <c:if test="${not empty row.deliveryterms}"><tr>
                                        <td><b>Условия доставки</b></td>
                                        <td><c:out value="${row.deliveryterms}"/></td>
                                    </tr></c:if>
                                <c:if test="${not empty row.deliveryschedule}"><tr>
                                        <td><b>Сроки поставки</b></td>
                                        <td><c:out value="${row.deliveryschedule}"/></td>
                                    </tr></c:if>
                                </table>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <!--%@include file="footer.jsp" %-->
        <!--        </div>-->
        <div id="myModal" class="reveal-modal" data-reveal aria-labelledby="modalTitle" aria-hidden="true" role="dialog">
            <h3>Внимание.</h3>
            <p>Документация доступна только для авторизованных пользователей.</p>
            <p><a href="<c:url value="logon.jsp"/>">Авторизуйтесь</a> или <a href="<c:url value="registry.jsp"/>">зарегистрируетесь</a> если вы ещё не зарегистрировы.
            </p>
            <a class="close-reveal-modal" aria-label="Close">&#215;</a>
        </div>

        <script src="js/vendor/jquery.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>
        <script src="js/foundation.min.js"></script>
        <script src="js/foundation/foundation.offcanvas.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script src="js/foundation/foundation.dropdown.js"></script>
        <script src="js/foundation-select.js"></script>
        <script type="text/javascript" src="js/search2.js"></script>
        <script>
            $(function () {
                $("#bidfrom").datepicker({
                    showButtonPanel: true;
                });
                $("#bidto").datepicker();
            });
        </script>
        <script>
            $('select').foundationSelect();
            $(document).foundation();
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                initDateSelector('#bidfrom', true);
                initDateSelector('#bidto', true);

                $('.form-tenders-search').submit(function () {

//        ga('send', 'event', 'button', 'search');
                    $('input[name=regions]').val('');
                    $('.regions-select :selected').each(function (i, selected) {
                        if ($('input[name=regions]').val() !== "") {
                            $('input[name=regions]').val($('input[name=regions]').val() + ',' + $(this).val());
                        } else {
                            $('input[name=regions]').val($(this).val());
                        }
                    });
                    $('input[name=methods]').val('');
                    $('.methods-select :selected').each(function (i, selected) {
                        if ($('input[name=methods]').val() !== "") {
                            $('input[name=methods]').val($('input[name=methods]').val() + ',' + $(this).val());
                        } else {
                            $('input[name=methods]').val($(this).val());
                        }
                    });
                    $('input[name=sources]').val('');
                    $('.sources-select :selected').each(function (i, selected) {
                        if ($('input[name=sources]').val() !== "") {
                            $('input[name=sources]').val($('input[name=sources]').val() + ',' + $(this).val());
                        } else {
                            $('input[name=sources]').val($(this).val());
                        }
                    });
                    $('input[name=categories]').val('');
                    $('.categories-select :selected').each(function (i, selected) {
                        if ($('input[name=categories]').val() !== "") {
                            $('input[name=categories]').val($('input[name=categories]').val() + ',' + $(this).val());
                        } else {
                            $('input[name=categories]').val($(this).val());
                        }
                    });
                });
                if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) === false) {
                    $("input[name=q]").focus();
                }
            });</script>
            <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>