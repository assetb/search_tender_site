<%-- 
    Document   : cabinet2
    Created on : 12.08.2015, 11:25:54
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CRM</title>
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

                <!-- main content goes here -->
                <c:choose>
                    <c:when test="${param.c != null && param.firstname != null && param.lastname != null && ( param.tel != null || param.email != null )}">
                        <sql:transaction  dataSource="${db}">
                            <sql:update>
                                INSERT INTO personinfo(firstname, lastname, tel, email) VALUES ("${param.firstname}", "${param.lastname}", "${param.tel != null?param.tel:''}", "${param.email != null?param.email:''}")
                            </sql:update>
                            <sql:query var="selectLastId">
                                SELECT LAST_INSERT_ID() as lastId
                            </sql:query>
                            <sql:update>
                                INSERT INTO contacts(customerid, bindid) VALUES (${param.c}, ${selectLastId.rows[0].lastId})
                            </sql:update>
                        </sql:transaction>
                        <div>Контакт ${param.firstname} ${param.lastname} создан</div>
                        <a href="maincrm.jsp" class="button">Ок</a>
                    </c:when>
                    <c:otherwise>
                        <header class="row">
                            <div class="small-12 columns">
                                <h1 class="text-center">Добавления нового контакта</h1>
                            </div>
                        </header>

                        <div class="row ad-block">
                            <form type="post" action="#">
                                <div>
                                    <label>Имя</label>
                                    <input type="text" name="firstname" value="${ empty param.firstname? '' : param.firstname }" required />
                                </div>
                                <div>
                                    <label>Фамилия</label>
                                    <input type="text" name="lastname" value="${ empty param.lastname? '' : param.lastname}" required />
                                </div>
                                <div>
                                    <label>Телефон</label>
                                    <input type="text" name="tel" value="${ empty param.tel? '' : param.tel}" required/>
                                </div>
                                <div>
                                    <label>Email</label>
                                    <input type="text" name="email" value="${ empty param.email? '' : param.email}"/>
                                </div>
                                <div>
                                    <button class="button" name="c" value="${param.c}">Добавить</button>
                                    <a class="button" href="maincrm.jsp">Назад</a>
                                </div>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>

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
