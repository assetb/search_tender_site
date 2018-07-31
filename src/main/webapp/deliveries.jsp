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

<c:if test="${param.delivery != null}">
    <c:set var="deliveryId" value="${param.delivery}" scope="request"/>
</c:if>



<c:if test="${param.type != null}">
    <sql:transaction dataSource="${db}">

        <c:choose>
            <c:when test="${param.type == 'new'}">
                <sql:update>
                    INSERT INTO deliveries(userid, keyword1, keyword2, keyword3) VALUES (?,?,?,?);
                    <sql:param value="${param.userid}"/>
                    <sql:param value="${param.keyword1}"/>
                    <sql:param value="${param.keyword2}"/>
                    <sql:param value="${param.keyword3}"/>
                </sql:update>
                <sql:query var="nextIdTable" >
                    SELECT LAST_INSERT_ID() as lastId
                </sql:query>
                <c:set var="deliveryId" value="${nextIdTable.rows[0].lastId}" scope="request"/>
            </c:when>
            <c:when test="${param.type == 'update'}">
                <sql:update>
                    UPDATE deliveries SET keyword1 = ?, keyword2 = ?, keyword3 = ? WHERE id = ?;
                    <sql:param value="${param.keyword1}"/>
                    <sql:param value="${param.keyword2}"/>
                    <sql:param value="${param.keyword3}"/>
                    <sql:param value="${requestScope.deliveryId}"/>
                </sql:update>
            </c:when>
        </c:choose>

        <sql:update>
            DELETE FROM usermethods WHERE deliveryid = ?;
            <sql:param value="${requestScope.deliveryId}"/>
        </sql:update>
        <sql:update>
            DELETE FROM usersources WHERE deliveryid = ?;
            <sql:param value="${requestScope.deliveryId}"/>
        </sql:update>
        <sql:update>
            DELETE FROM userregions WHERE deliveryid = ?;
            <sql:param value="${requestScope.deliveryId}"/>
        </sql:update>

        <c:choose>
            <c:when test="${param.type == 'delete'}">
                <sql:update>
                    DELETE FROM deliveries WHERE id = ?;
                    <sql:param value="${requestScope.deliveryId}"/>
                </sql:update>
                <sql:update>
                    DELETE FROM usersumrange WHERE deliveryid = ?;
                    <sql:param value="${requestScope.deliveryId}"/>
                </sql:update>
                <c:redirect url="showdetails.jsp">
                    <c:param name="id" value="${param.customer_id}"/>
                </c:redirect>
            </c:when>
            <c:otherwise>
                <c:forEach var="method" items="${paramValues['method']}">
                    <sql:update>
                        INSERT INTO usermethods(deliveryid, method, userid) VALUES(?, ?, ?);
                        <sql:param value="${requestScope.deliveryId}"/>
                        <sql:param value="${method}"/>
                        <sql:param value="${param.userid}"/>
                    </sql:update>
                </c:forEach>
                <c:forEach var="region" items="${paramValues['region']}">
                    <sql:update>
                        INSERT INTO userregions(deliveryid, region, userid) VALUES(?, ?, ?);
                        <sql:param value="${requestScope.deliveryId}"/>
                        <sql:param value="${region}"/>
                        <sql:param value="${param.userid}"/>
                    </sql:update> 
                </c:forEach>
                <c:forEach var="site" items="${paramValues['site']}">
                    <sql:update>
                        INSERT INTO usersources(deliveryid, source, userid) VALUES(?, ?, ?);
                        <sql:param value="${requestScope.deliveryId}"/>
                        <sql:param value="${site}"/>
                        <sql:param value="${param.userid}"/>
                    </sql:update>
                </c:forEach>
                <sql:query var="sums">
                    SELECT id, minsum, maxsum FROM usersumrange u WHERE ((u.deliveryid = ? AND u.userid = ?) OR (u.deliveryid IS null AND u.userid = ?)) LIMIT 1;
                    <sql:param value="${requestScope.deliveryId}"/>
                    <sql:param value="${param.userid}"/>
                    <sql:param value="${param.userid}"/>
                </sql:query>
                <c:choose>
                    <c:when test="${param.minsum == 0 && param.maxsum == 0 && sums.rowCount > 0}">
                        <sql:update>
                            DELETE FROM usersumrange WHERE id = ?;
                            <sql:param value="${sums.rows[0].id}"/>
                        </sql:update>
                    </c:when>
                    <c:when test="${param.minsum != 0 || param.maxsum != 0}">
                        <c:choose>
                            <c:when test="${sums.rowCount > 0}">
                                <%
                                    String updateQuery = request.getParameter("minsum") != "" && request.getParameter("maxsum") != "" ? "minsum=" + request.getParameter("minsum") + "," + "maxsum=" + request.getParameter("maxsum") : request.getParameter("minsum") != "" ? "minsum=" + request.getParameter("minsum") : "maxsum=" + request.getParameter("maxsum");
                                %>
                                <sql:update>UPDATE usersumrange SET <%=updateQuery%> WHERE id=${sums.rows[0].id};</sql:update>
                            </c:when>
                            <c:otherwise>
                                <%
                                    String queryColums = request.getParameter("minsum") != "" && request.getParameter("maxsum") != "" ? "minsum,maxsum" : request.getParameter("minsum") != "" ? "minsum" : "maxsum";
                                    String queryValues = request.getParameter("minsum") != "" && request.getParameter("maxsum") != "" ? request.getParameter("minsum") + "," + request.getParameter("maxsum") : request.getParameter("minsum") != "" ? request.getParameter("maxsum") : request.getParameter("maxsum");
                                %>
                                <sql:update>INSERT INTO usersumrange(<%=queryColums%>,deliveryid, userid) VALUES(<%=queryValues%>,${requestScope.deliveryId}, ${param.userid});</sql:update>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                </c:choose>
            </c:otherwise>
        </c:choose>

    </sql:transaction>
    <c:set var="isSave" value="true"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ключевые слова</title>
        <link href='http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/foundation.min.css" />
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/foundation-select.css" />
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
        <div class="ad-block">
            <div class="row">
                <form data-abide action="<c:url value="deliveries.jsp"><c:param name="customer_id" value="${param.customer_id}"/></c:url>" method="post">
                    <c:if test="${requestScope.deliveryId != null}">
                        <sql:query var="selectDeliveries" dataSource="${db}">
                            SELECT d.keyword1, d.keyword2, d.keyword3, c.runame  FROM deliveries d LEFT JOIN customer c ON c.userid = d.userid WHERE d.id = ?
                            <sql:param value="${requestScope.deliveryId}"/>
                        </sql:query>
                        <c:set var="delivery" value="${selectDeliveries.rows[0]}"/>
                        <input hidden name="delivery" value="${requestScope.deliveryId}"/>
                    </c:if>
                    <input hidden name="userid" value="${param.userid}"/>
                    <div class="row">
                        <div class="columns large-2">
                            <a class="button arrow_carrot-2left" href="<c:url value="showdetails.jsp"><c:param name="id" value="${param.customer_id}"/></c:url>">
                                    <span>Назад</span>
                                </a>
                            </div>
                            <div class="columns large-8">
                            <c:if test="${requestScope.deliveryId == null}">
                                <sql:query var="customer" dataSource="${db}">
                                    SELECT runame FROM customer WHERE userid = ?
                                    <sql:param value="${param.userid}"/>
                                </sql:query>
                            </c:if>
                            <h4>Форма заполнения ключевых слов для компании <i>${delivery != null && delivery.runame != null ? delivery.runame : customer.rowCount > 0 ? customer.rows[0].runame : 'нет названия'}</i></h4>
                            <h6>* - поля обязательные для заполениея</h6>
                        </div>

                        <div class="columns large-2">
                            <c:if test="${isSave != null}">
                                <div class=" text-center alert-box success icon_check">
                                    <span>Сохронено</span>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="row">
                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Вводите слова без окончаний и фразы разделяйте запятой. Например: 'постельная' - 'постель', 'мебельные услуги, строительные услуги'">
                                    Ключевое слово 1*
                                </span>
                            </label>
                        </div>
                        <div class="columns large-10">
                            <input type="text" name="keyword1" value="${delivery.keyword1}"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Вводите слова без окончаний и фразы разделяйте запятой. Например: 'постельная' - 'постель', 'мебельные услуги, строительные услуги'">
                                    Ключевое слово 2
                                </span>
                            </label>
                        </div>
                        <div class="columns large-10">
                            <input type="text" name="keyword2" value="${delivery.keyword2}"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Вводите слова без окончаний и фразы разделяйте запятой. Например: 'постельная' - 'постель', 'мебельные услуги, строительные услуги'">
                                    Ключевое слово 3
                                </span>
                            </label>
                        </div>
                        <div class="columns large-10">
                            <input type="text" name="keyword3" value="${delivery.keyword3}"/>
                        </div>
                    </div>
                    <div class="row">

                        <sql:query var="sites" dataSource="${db}">
                            SELECT siteid, sitename, if(u.id is null, false, true) as selected FROM sites AS s LEFT JOIN usersources AS u ON ((u.deliveryid = ? AND u.userid = ?) OR (u.deliveryid IS null AND u.userid = ?)) AND s.siteid = u.source ORDER BY s.siteid;
                            <sql:param value="${requestScope.deliveryId}"/>
                            <sql:param value="${param.userid}"/>
                            <sql:param value="${param.userid}"/>
                        </sql:query>

                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Настройка поиска по площадкам. Можно выбрать несколько пунктов.">Площадки</span>
                            </label>
                        </div>

                        <div class="columns large-10">
                            <select  id="sites" name='site' multiple="multiple" data-prompt="Не выбрано">
                                <c:forEach var="site" items="${sites.rows}">
                                    <option value="${site.siteid}" ${site.selected == 1 ? 'selected' : ''}>${site.sitename}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">

                        <sql:query var="methodsenum" dataSource="${db}">
                            SELECT m.id, m.name, if(u.id is null, false, true) AS selected FROM methodsenum AS m LEFT JOIN usermethods AS u ON ((u.deliveryid = ? AND u.userid = ?) OR (u.deliveryid IS null AND u.userid = ?)) and m.id = u.method ORDER BY m.id;
                            <sql:param value="${requestScope.deliveryId}"/>
                            <sql:param value="${param.userid}"/>
                            <sql:param value="${param.userid}"/>
                        </sql:query>

                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Настройка поиска по способам закупки. Можно выбрать несколько пунктов.">Способы закупа</span>
                            </label>
                        </div>
                        <div class="columns large-10">
                            <select  width="100%" id="methods" name='method' multiple="multiple" data-prompt="Не выбрано"  data-customforms="disabled">
                                <c:forEach var="method" items="${methodsenum.rows}">
                                    <option value="${method.id}" ${method.selected == 1 ? 'selected' : ''}>${method.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">

                        <sql:query var="regionsenum" dataSource="${db}">
                            SELECT r.id, r.name, if(u.id is null, false, true) AS selected FROM regionsenum AS r LEFT JOIN userregions AS u ON ((u.deliveryid = ? AND u.userid = ?) OR (u.deliveryid IS null AND u.userid = ?)) AND u.region = r.id ORDER BY r.id;
                            <sql:param value="${requestScope.deliveryId}"/>
                            <sql:param value="${param.userid}"/>
                            <sql:param value="${param.userid}"/>
                        </sql:query>

                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Настройка поиска по регионам. Можно выбрать несколько пунктов.">Регионы</span>
                            </label>
                        </div>
                        <div class="columns large-10">
                            <select  id="regions" name='region' multiple="multiple" data-prompt="Не выбрано">
                                <c:forEach var="region" items="${regionsenum.rows}">
                                    <option value="${region.id}" ${region.selected == 1 ? 'selected' : ''}>${region.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="columns large-2">
                            <label>
                                <span data-tooltip class=" text-center has-tip tip-right" title="Укажите предпологаемую сумму закупа. Минимальная цена не может быть больше максимальной.">Предпологаемая сумма закупки</span>
                            </label>
                        </div>
                        <sql:query var="sumrange" dataSource="${db}">
                            SELECT minsum, maxsum FROM usersumrange u WHERE (u.deliveryid = ? AND u.userid = ?) OR (u.deliveryid IS null AND u.userid = ?);
                            <sql:param value="${requestScope.deliveryId}"/>
                            <sql:param value="${param.userid}"/>
                            <sql:param value="${param.userid}"/>
                        </sql:query>
                        <div class="columns large-5">
                            <input placeholder="Минимальная в тенге" type="text" name="minsum" value="${sumrange.rowCount > 0 ? sumrange.rows[0].minsum : ''}"/>
                        </div>
                        <div class="columns large-5">
                            <input placeholder="Максимальная в тенге" type="text" name="maxsum" value="${sumrange.rowCount > 0 ? sumrange.rows[0].maxsum : ''}"/>
                        </div>
                    </div>
                    <div class="row">
                        <button class="large-3 columns icon_drive" type="submit" name="type" value="${deliveryId != null ? 'update':'new'}">
                            <span>Сохранить</span>
                        </button>
                        <button class="large-3 columns icon_trash" type="submit" name="type" value="delete">
                            <span>Удалить</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script src="js/vendor/fastclick.js"></script>
        <script src="js/foundation.min.js"></script>
        <script src="js/foundation.js"></script>
        <script src="js/foundation/foundation.offcanvas.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script src="js/foundation/foundation.dropdown.js"></script>
        <script src="js/foundation-select.js"></script>
        <script>
            $('select[multiple]').foundationSelect();
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
