<%-- 
    Document   : registry1
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Properties"%>

<!DOCTYPE html>
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js"><!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Тендерные услуги | Данные по тендерам | Alta и К</title>
        <meta name="description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера."/>
        <link rel="canonical" href="https://www.altatender.kz/" />
        <meta property="og:locale" content="en_US" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="Тендерные услуги | Данные по тендерам | Alta и К" />
        <meta property="og:description" content="Альта и К обеспечивает полные спектр услуг для получения желаемого тендера." />
        <meta property="og:url" content="https://www.altatender.kz/" />
        <meta property="og:site_name" content="Альта и К" />
        <link rel="apple-touch-icon" href="img/logo_Alta.jpg">
        <link rel="shortcut icon" type="image/png" href="img/logo_Alta.jpg">  

        <link rel='shortlink' href='https://www.altaik.kz/' />

        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/foundation.min.css" />
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/foundation-select.css" type="text/css" />

        <link rel='stylesheet' id='bsf-Defaults-css'  href='css/Defaults.css' type='text/css' media='all' />
        <link rel='stylesheet' id='tablepress-default-css'  href='css/default.min.css' type='text/css' media='all' />
        <link rel='stylesheet' id='footable-core-min-css'  href='css/footable.core.min.css' type='text/css' media='all' />
        <link rel='stylesheet' id='footable-metro-min-css'  href='css/footable.metro.min.css' type='text/css' media='all' />

        <link rel='stylesheet' href='css/style.css' type='text/css'/>
        <link rel="stylesheet" href="css/search.css" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/search10.css" />

        <script src="js/vendor/modernizr.js"></script>
    </head>

    <body>
        <%@include file="menu.jsp" %>
        <div class="fixed">
            <%@include file="mainnav.jsp" %>
        </div>

        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://88.204.230.204:50505/altatender" user="AltaikDB" password="AcU!ysP14D,B4z"/>

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

        <%if (null != request.getParameter("is")) {%>
        <div class="theme-wrapper" id="tenders">
            <c:set var="tabquerybegin" value="SELECT p.id,l.negnumber as negnumber,p.source,concat(p.runame,'') AS pruname,p.startday as pstarday,p.endday,p.venue,p.method,l.runame as lruname,l.rudescription as rudescription,l.sum as sum,l.deliveryplace, p.isdocs, p.docszip"/>
            <c:set var="maxquerybegin" value="SELECT count(p.id) as count"/>
            <c:set var="queryend" value=" FROM procpurchase p LEFT JOIN lots l ON p.number=l.negnumber WHERE p.dendday >=now()"/>
            <c:set var="querycountend" value=" FROM procpurchase p LEFT JOIN lots l ON p.number=l.negnumber WHERE p.dendday >=now()"/>
            <c:if test="${not empty param.q}">
                <c:set value="${param.q}" var="namelike"/>
                <c:set var="prunamelike" value=""/>
                <c:set var="lrunamelike" value=""/>
                <c:set var="lrudesclike" value=""/>
                <c:set var="lnumberlike" value=""/>
                <c:set var="keywords" value="${fn:split(namelike, ' ')}"/>
                <c:forEach items="${keywords}" var="keyword" varStatus="loop">
                    <c:set value="${fn:toLowerCase(keyword)}" var="keyword"/>
                    <c:choose>
                        <c:when test="${fn:endsWith(keyword, 'ого')}">
                            <c:set var="keyword" value="${fn:substring(keyword, 0, fn:length(keyword)-3)}"/>
                        </c:when>
                        <c:when test="${fn:endsWith(keyword, 'ие') || fn:endsWith(keyword, 'ая') || fn:endsWith(keyword, 'ое') || fn:endsWith(keyword, 'ой') || fn:endsWith(keyword, 'ый') || fn:endsWith(keyword, 'ые') || fn:endsWith(keyword, 'ых') || fn:endsWith(keyword, 'их')}">
                            <c:set var="keyword" value="${fn:substring(keyword, 0,fn:length(keyword)-2)}"/>
                        </c:when>
                        <c:when test="${fn:endsWith(keyword, 'а') || fn:endsWith(keyword, 'о') || fn:endsWith(keyword, 'е') || fn:endsWith(keyword, 'ы') || fn:endsWith(keyword, 'у') || fn:endsWith(keyword, 'ю') || fn:endsWith(keyword, 'и') || fn:endsWith(keyword, 'ь')}">
                            <c:set var="keyword" value="${fn:substring(keyword, 0,fn:length(keyword)-1)}"/>
                        </c:when>
                    </c:choose>
                    <c:if test="${loop.index > 0}">
                        <c:set var="prunamelike" value="${prunamelike} AND "/>
                        <c:set var="lrunamelike" value="${lrunamelike} AND "/>
                        <c:set var="lrudesclike" value="${lrudesclike} AND "/>
                        <c:set var="lnumberlike" value="${lnumberlike} AND "/>
                    </c:if>
                    <c:set var="prunamelike" value="${prunamelike} p.runame LIKE '%${keyword}%'"/>
                    <c:set var="lrunamelike" value="${lrunamelike} l.runame LIKE '%${keyword}%'"/>
                    <c:set var="lrudesclike" value="${lrudesclike} l.rudescription LIKE '%${keyword}%'"/>
                    <c:set var="lnumberlike" value="${lnumberlike} l.negnumber LIKE '%${keyword}%'"/>
                </c:forEach>
                <c:set var="queryend" value="${queryend} AND ((${prunamelike}) OR (${lrunamelike}) OR (${lrudesclike}) OR (${lnumberlike}))"/>
            </c:if>

            <c:if test="${not empty paramValues['regions']}">
                <c:set var="queryend" value="${queryend} AND (p.venue IN (${fn:join(paramValues['regions'],',')}) OR p.venue is null)"/>
            </c:if>
            <c:if test="${not empty paramValues['methods']}">
                <c:set var="queryend" value="${queryend} AND (p.method IN (${fn:join(paramValues['methods'],',')}) OR p.method is null)"/>
            </c:if>
            <c:if test="${not empty paramValues['sources']}">
                <c:set var="queryend" value="${queryend} AND p.source IN (${fn:join(paramValues['sources'],',')})"/>
            </c:if>
            <c:if test="${not empty param.minsum}">
                <c:set var="queryend" value="${queryend} AND l.sum >= (${param.minsum})"/>
            </c:if>
            <c:if test="${not empty param.maxsum}">
                <c:set var="queryend" value="${queryend} AND l.sum <= (${param.maxsum})"/>
            </c:if>
            <c:if test="${not empty param.bidfrom}">
                <c:set var="queryend" value="${queryend} AND p.dstartday >= str_to_date('${param.bidfrom}', '%d.%m.%Y')"/>
            </c:if>
            <c:if test="${not empty param.bidto}">
                <c:set var="queryend" value="${queryend} AND p.dstartday <= str_to_date('${param.bidto}', '%d.%m.%Y')"/>
            </c:if>
            <c:choose>
                <c:when test="${not empty param.sort}">
                    <c:choose>
                        <c:when test="${param.sort == 1}">
                            <c:set var="queryend" value="${queryend} ORDER BY l.isum desc"/>
                        </c:when>
                        <c:when test="${param.sort == 2}">
                            <c:set var="queryend" value="${queryend} ORDER BY l.isum desc,p.dendday"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="queryend" value="${queryend} ORDER BY l.isum desc"/>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:set var="queryend" value="${queryend} ORDER BY l.isum desc"/>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${param.topage == 1}">
                    <sql:query var="selectmax" dataSource="${db}">
                        ${maxquerybegin}${queryend}
                    </sql:query>
                    <c:set var="maxcount" value="${selectmax.rows[0].count}" scope="session"/>
                    <c:if test="${maxcount > 20}">
                        <c:set var="queryend" value="${queryend} LIMIT 0,20"/>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <c:set var="queryend" value="${queryend} LIMIT ${(param.topage-1)*20},20"/>
                </c:otherwise>
            </c:choose>


            <sql:query var="selectresult" dataSource="${db}">
                ${tabquerybegin}${queryend}
            </sql:query>
            <div class="row">
                <div class="small-4 columns" style="padding-top: 7px">
                    <span>Всего найдено: <u><span><c:out value="${maxcount}"/></span></u> закупок</span>
                </div>
                <div class="small-8 columns" style="padding-top: 3px">
                    <c:set var="parlink" value=""/>
                    <c:if test="${not empty param.q}"><c:set var="parlink" value="${parlink}&q=${param.q}"/></c:if>
                    <c:if test="${not empty param.regions}"><c:forEach var="region" items="${paramValues['regions']}"><c:set var="parlink" value="${parlink}&regions=${region}"/></c:forEach></c:if>
                    <c:if test="${not empty param.methods}"><c:forEach var="method" items="${paramValues['methods']}"><c:set var="parlink" value="${parlink}&methods=${method}"/></c:forEach></c:if>
                    <c:if test="${not empty param.sources}"><c:forEach var="source" items="${paramValues['sources']}"><c:set var="parlink" value="${parlink}&sources=${source}"/></c:forEach></c:if>
                    <c:if test="${not empty param.minsum}"><c:set var="parlink" value="${parlink}&minsum=${param.minsum}"/></c:if>
                    <c:if test="${not empty param.maxsum}"><c:set var="parlink" value="${parlink}&maxsum=${param.maxsum}"/></c:if>
                    <c:if test="${not empty param.bidto}"><c:set var="parlink" value="${parlink}&bidto=${param.bidto}"/></c:if>
                    <c:if test="${not empty param.bidfrom}"><c:set var="parlink" value="${parlink}&bidfrom=${param.bidfrom}"/></c:if>

                        <ul class="pagination" style="margin-bottom: 10px">
                        <c:if test="${param.topage-3>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-3}${parlink}'/>">${param.topage-3}</a></li></c:if>
                        <c:if test="${param.topage-2>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-2}${parlink}'/>">${param.topage-2}</a></li></c:if>
                        <c:if test="${param.topage-1>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-1}${parlink}'/>">${param.topage-1}</a></li></c:if>
                        <li class="current"><a href="">${param.topage}</a></li>
                        <c:if test="${(param.topage+1)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+1}${parlink}'/>">${param.topage+1}</a></li></c:if>
                        <c:if test="${(param.topage+2)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+2}${parlink}'/>">${param.topage+2}</a></li></c:if>
                        <c:if test="${(param.topage+3)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+3}${parlink}'/>">${param.topage+3}</a></li></c:if>
                        </ul>                    
                    </div>
                    <!--                    <div class="small-4 columns">
                                            <select class="sort-select" name="sort" id="sort" data-prompt="Выбрать сортировку">
                                                <option  value="1"<c:if test="${not empty param.sort and param.sort == 1}"><c:out value=" selected "/></c:if>>По дате окончания</option>
                                                <option  value="2"<c:if test="${not empty param.sort and param.sort == 2}"><c:out value=" selected "/></c:if>>По сумме</option>
                                            </select>
                                        </div>-->
                </div>

                <table id="tableid">
                    <thead>
                        <tr>
                            <th width="2%">№</th>
                            <th width="4%">Источник</th>
                            <th>Описание</th>
                            <th width="10%">Прием заявок</th>
                            <th width="12%">Сумма(тенге)</th>
                            <th width="8%">Документация</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="row" items="${selectresult.rows}" varStatus="loop">
                        <% TreeMap row = (TreeMap) pageContext.getAttribute("row"); %>
                        <tr>
                            <td><c:out value="${(param.topage-1)*20+loop.index+1}"/></td>
                            <td>
                                <c:forEach var="site" items="${selectSites.rows}">
                                    <c:if test="${site.siteid == row.source}">
                                        <div>${site.sitename}</div>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <div>${row.pruname}</div>
                                <div><a href="<c:url value='lotdescription.jsp?neg=${row.negnumber}'/>">${row.runame}</a></div>
                                <div>${row.rudescription}</div>
                            </td>
                            <td>
                                <%
                                    if (row != null) {
                                        DateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                        Date dtStartDay = df.parse((String) row.get("startday"));
                                        Date dtEndDay = df.parse((String) row.get("endday"));
                                        out.print("c " + df.format(dtStartDay) + " по " + df.format(dtEndDay));
                                    }
                                %>
                            </td>
                            <td style="text-align: center;">
                                <%
                                    if (row != null) {
                                        String sum = (String) row.get("sum");
                                        sum = sum.replace(",", ".").replace(" ", "");
                                        Double dSum = Double.valueOf(sum);
                                        out.println(String.format("%.0f", dSum).replaceAll("(?=(\\d{3})+(?!\\d))", " "));
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if (row != null) {
                                        Integer isdocs = (Integer) row.get("isdocs");
                                        File f = new File("/home/archive/" + (String) row.get("docszip"));
                                        if ((isdocs != null && isdocs > 0) && (f != null && f.exists() && !f.isDirectory())) {
                                            Integer userid = (Integer) session.getAttribute("userid");
                                            if (userid != null) {
                                                out.print("<a href=\""+(String) row.get("docszip")+"\">Скачать</a>");
                                            } else {
                                                out.print("<a data-reveal-id=\"myModal\">Скачать</a>");
                                            }
                                        } else {
                                            out.print("<span style=\"color: #888;\">Не найдена</span>");
                                        }
                                    }
                                %>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="row">
                <div class="small-4 columns" style="padding-top: 7px">
                    <span>Всего найдено: <u><span><c:out value="${maxcount}"/></span></u> закупок</span>
                </div>
                <div class="small-8 columns" style="padding-top: 3px">
                    <c:set var="parlink" value=""/>
                    <c:if test="${not empty param.q}"><c:set var="parlink" value="${parlink}&q=${param.q}"/></c:if>
                    <c:if test="${not empty param.regions}"><c:forEach var="region" items="${paramValues['regions']}"><c:set var="parlink" value="${parlink}&regions=${region}"/></c:forEach></c:if>
                    <c:if test="${not empty param.methods}"><c:forEach var="method" items="${paramValues['methods']}"><c:set var="parlink" value="${parlink}&methods=${method}"/></c:forEach></c:if>
                    <c:if test="${not empty param.sources}"><c:forEach var="source" items="${paramValues['sources']}"><c:set var="parlink" value="${parlink}&sources=${source}"/></c:forEach></c:if>
                    <c:if test="${not empty param.minsum}"><c:set var="parlink" value="${parlink}&minsum=${param.minsum}"/></c:if>
                    <c:if test="${not empty param.maxsum}"><c:set var="parlink" value="${parlink}&maxsum=${param.maxsum}"/></c:if>
                    <c:if test="${not empty param.bidto}"><c:set var="parlink" value="${parlink}&bidto=${param.bidto}"/></c:if>
                    <c:if test="${not empty param.bidfrom}"><c:set var="parlink" value="${parlink}&bidfrom=${param.bidfrom}"/></c:if>

                        <ul class="pagination" style="margin-bottom: 10px">
                        <c:if test="${param.topage-3>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-3}${parlink}'/>">${param.topage-3}</a></li></c:if>
                        <c:if test="${param.topage-2>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-2}${parlink}'/>">${param.topage-2}</a></li></c:if>
                        <c:if test="${param.topage-1>0}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage-1}${parlink}'/>">${param.topage-1}</a></li></c:if>
                        <li class="current"><a href="">${param.topage}</a></li>
                        <c:if test="${(param.topage+1)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+1}${parlink}'/>">${param.topage+1}</a></li></c:if>
                        <c:if test="${(param.topage+2)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+2}${parlink}'/>">${param.topage+2}</a></li></c:if>
                        <c:if test="${(param.topage+3)*20<sessionScope.maxcount}"><li><a href="<c:url value='search.jsp?is=yes&topage='/><c:out value='${param.topage+3}${parlink}'/>">${param.topage+3}</a></li></c:if>
                        </ul>                    
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
        <script src="js/scripts.js"></script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>