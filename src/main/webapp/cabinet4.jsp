<%-- 
    Document   : cabinet2
    Created on : 12.08.2015, 11:25:54
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="css/foundation-select.css" />
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

                <a class="left-off-canvas-toggle" href="#"><i class="fi-list" style="right: 2rem;"></i></a>

                <!-- Off Canvas Menu -->
                <aside class="crap-canvas-menu left-off-canvas-menu">
                    `
                    <div class="icon-bar vertical five-up">
                        <a class="item" href="<c:url value='cabinet2.jsp'/>">
                            <i class="fi-torso small"></i>
                            <label>Профиль</label>
                        </a>
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
                <header class="row">
                    <div class="small-12 columns">
                        <h1 class="text-center">Личный кабинет</h1>
                    </div>
                </header>






                <c:if test="${not empty param.save}">
                    <sql:update dataSource="${db}">
                        UPDATE users SET password = ? WHERE id = ?
                        <sql:param value="${param.passwd}"/>
                        <sql:param value="${sessionScope.userid}"/>
                    </sql:update>
                </c:if>

                <div class="row ad-block">
                    <div class="small-12 columns">
                        <h1>Изменение пароля</h1>
                        <form data-abide id="form_delivery" method="post" action="<c:url value='cabinet4.jsp'/>">
                            <div class="row">
                                <div class="small-12 columns">
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="passwd" class="right inline">Новый пароль</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="password" id="passwd" name="passwd" required="" placeholder="" >
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label class="right inline">Повтор пароля</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="password" required="" data-equalto="password">
                                            <small class="error">Пароль должен совпадать</small>
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
        <script src="js/vendor/fastclick.js"></script>
        <script src="js/foundation.min.js"></script>
        <script src="js/foundation/foundation.offcanvas.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script src="js/foundation/foundation.dropdown.js"></script>
        <script src="js/foundation-select.js"></script>
        <script>
            $("#clear").click(function () {
                $('#form_delivery')[0].reset();
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
