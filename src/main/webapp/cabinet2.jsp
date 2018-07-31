<%-- 
    Document   : cabinet2
    Created on : 12.08.2015, 11:25:54
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>
<!DOCTYPE html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Личный кабинет</title>
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

                <h:leftmenu/>

                <!-- main content goes here -->
                <header class="row">
                    <div class="small-12 columns">
                        <h1 class="text-center">Личный кабинет</h1>
                    </div>
                </header>





                <c:if test="${not empty param.save}">
                    <c:set var="query" value=""/>
                    <sql:query var="selectuserid" dataSource="${db}">
                        SELECT c.userid FROM users u,customer c WHERE u.id=c.userid AND u.email=? AND password=?
                        <sql:param value="${sessionScope.email}"/>
                        <sql:param value="${sessionScope.password}"/>
                    </sql:query>
                    <c:choose>
                        <c:when test="${selectuserid.rowCount == 0}">
                            <c:set var="query" value="INSERT INTO customer (userid, runame,tel,email,firstname,lastname) values (${sessionScope.userid},'${param.company}','${param.phone}','${param.email}','${param.firstname}','${param.lastname}')"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="query" value="UPDATE customer SET runame='${param.company}',tel='${param.phone}',email='${param.email}',firstname='${param.firstname}',lastname='${param.lastname}' WHERE userid=${sessionScope.userid}"/>
                        </c:otherwise>
                    </c:choose>
                    <sql:update dataSource="${db}" var="updatequery">
                        ${query}
                    </sql:update>
                </c:if>

                <sql:query var="selectprofile" dataSource="${db}">
                    SELECT * FROM users u,customer c WHERE u.id=c.userid AND u.email=? AND password=?
                    <sql:param value="${sessionScope.email}"/>
                    <sql:param value="${sessionScope.password}"/>
                </sql:query>
                <div class="row ad-block">
                    <div class="small-12 columns">
                        <h1>Данные о компании</h1>
                        <form data-abide id="form_profile" method="get" action="<c:url value='cabinet2.jsp'/>">
                            <div class="row">
                                <div class="small-12 columns">
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="company" class="right inline">Компания</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="text" id="company" name="company" required="" placeholder="Наименование компании" <c:out value=' value="${selectprofile.rows[0].runame}"' escapeXml="false"/> >
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="firstname" class="right inline">Имя</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="text" id="firstname" name="firstname" required="" placeholder="Имя ответственного или псевдоним" <c:out value=' value="${selectprofile.rows[0].firstname}"' escapeXml="false"/>  >
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="lastname" class="right inline">Фамилия</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="text" id="lastname" name="lastname" required="" placeholder="Фамилия ответственного или псевдоним" <c:out value=' value="${selectprofile.rows[0].lastname}"' escapeXml="false"/> >
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="email" class="right inline">Email</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="email" id="email" name="email" required="" placeholder="" <c:out value=' value="${selectprofile.rows[0].email}"' escapeXml="false"/> >
                                        </div>
                                        <small class="error">Email обязателен.</small>
                                    </div>
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="phone" class="right inline">Телефон</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="text" id="phone" name="phone" required="" placeholder="" <c:out value=' value="${selectprofile.rows[0].tel}"' escapeXml="false"/> >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" id="save" class="button round" name="save" value="submit">Сохранить</button>
                            <button type="button" id="clear" class="button round">Очистить</button>
                        </form>                        
                    </div>
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

            var updateStatus = $("select[name=\"updatestatus\"]").change(function (event) {
                var el = $(event.target);
                var typeReq = el.attr("name");
                var cusId = el.parent("td").parent("tr").attr("id");
                var statusId = el.children("option:selected").attr("id");
                $.ajax({
                    type: "POST",
                    url: "moreinfo.jsp",
                    data: {type: typeReq, id: cusId, status: statusId}
                }).done(function (responce) {
                    alert("OK");
                });
            });

        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
