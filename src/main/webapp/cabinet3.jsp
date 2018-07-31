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
            }
        </style>
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
                    <div class="icon-bar vertical five-up">
                        <a class="item" href="<c:url value='cabinet2.jsp'/>">
                            <i class="fi-torso small"></i>
                            <label>Профиль</label>
                        </a>
                        <c:if test="${sessionScope.roleid > 9 && sessionScope.roleid < 100}">
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
                <header class="row">
                    <div class="small-12 columns">
                        <h1 class="text-center">Личный кабинет</h1>
                    </div>
                </header>






                <c:if test="${not empty param.save}">
                    <c:set var="query" value=""/>
                    <sql:query var="selectuserid" dataSource="${db}">
                        SELECT c.userid FROM users u,deliveries c WHERE u.id=c.userid AND u.email=? AND password=?
                        <sql:param value="${sessionScope.email}"/>
                        <sql:param value="${sessionScope.password}"/>
                    </sql:query>
                    <c:choose>
                        <c:when test="${selectuserid.rowCount == 0}">
                            <c:set var="query" value="INSERT INTO deliveries (userid, keyword1,keyword2,keyword3) values (${sessionScope.userid},'${param.keyword1}','${param.keyword2}','${param.keyword3}')"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="query" value="UPDATE deliveries SET keyword1='${param.keyword1}',keyword2='${param.keyword2}',keyword3='${param.keyword3}' WHERE userid=${sessionScope.userid}"/>
                        </c:otherwise>
                    </c:choose>
                    <sql:update dataSource="${db}" var="updatequery">
                        ${query}
                    </sql:update>

                    <sql:update dataSource="${db}">
                        DELETE FROM userregions WHERE userid=${sessionScope.userid}
                    </sql:update>
                    <c:forEach items="${paramValues['region']}" var="updatedregion">
                        <sql:update dataSource="${db}">
                            INSERT INTO userregions (userid,region) values(<c:out value="${sessionScope.userid}"/>,<c:out value="${updatedregion}"/>)
                        </sql:update>
                    </c:forEach>

                    <sql:update dataSource="${db}">
                        DELETE FROM usermethods WHERE userid=${sessionScope.userid}
                    </sql:update>
                    <c:forEach items="${paramValues['method']}" var="updatedmethod">
                        <sql:update dataSource="${db}">
                            INSERT INTO usermethods (userid,method) values(<c:out value="${sessionScope.userid}"/>,<c:out value="${updatedmethod}"/>)
                        </sql:update>
                    </c:forEach>

                    <sql:update dataSource="${db}">
                        DELETE FROM usersources WHERE userid=${sessionScope.userid}
                    </sql:update>
                    <c:forEach items="${paramValues['source']}" var="updatedsource">
                        <sql:update dataSource="${db}">
                            INSERT INTO usersources (userid,source) values(<c:out value="${sessionScope.userid}"/>,<c:out value="${updatedsource}"/>)
                        </sql:update>
                    </c:forEach>



                </c:if>

                <sql:query var="selectprofile" dataSource="${db}">
                    SELECT * FROM users u,deliveries c WHERE u.id=c.userid AND u.email=? AND password=?
                    <sql:param value="${sessionScope.email}"/>
                    <sql:param value="${sessionScope.password}"/>
                </sql:query>

                <c:forEach var="lrow" items="${selectprofile.rows}">
                    <c:set var="userid" value="${lrow.userid}"/>
                    <c:set var="keyword1" value="${lrow.keyword1}"/>
                    <c:set var="keyword2" value="${lrow.keyword2}"/>
                    <c:set var="keyword3" value="${lrow.keyword3}"/>
                </c:forEach>

                <div class="row ad-block">
                    <div class="small-12 columns">
                        <h1>Рассылка</h1>
                        <form data-abide id="form_delivery" method="get" action="<c:url value='cabinet3.jsp'/>">
                            <div class="row">
                                <div class="small-12 columns">
                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label for="keyword1" class="right inline">Ключевое слово</label>
                                        </div>
                                        <div class="small-9 small-offset-1 columns">
                                            <input type="text" id="keyword1" name="keyword1" required="" placeholder="Ключевое слово или выражение" <c:if test="${not empty keyword1}">value="${keyword1}"</c:if> >
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="small-2 columns">
                                                <label for="keyword2" class="right inline">Ключевое слово</label>
                                            </div>
                                            <div class="small-9 small-offset-1 columns">
                                                <input type="text" id="keyword2" name="keyword2" placeholder="Ключевое слово или выражение" <c:if test="${not empty keyword2}">value="${keyword2}"</c:if> >
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="small-2 columns">
                                                <label for="keyword3" class="right inline">Ключевое слово</label>
                                            </div>
                                            <div class="small-9 small-offset-1 columns">
                                                <input type="text" id="keyword3" name="keyword3" placeholder="Ключевое слово или выражение" <c:if test="${not empty keyword3}">value="${keyword3}"</c:if> >
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="small-2 columns">
                                                <label class="right inline" for="region">Регион</label>
                                            </div>
                                            <div class="small-8 small-offset-1 columns">
                                                <input type="hidden" name="regions">
                                                <select name='region' id="region" multiple="multiple" class="medium" data-prompt="---------------">
                                                <sql:query var="regionsenum" dataSource="${db}" sql="SELECT r.id, r.name, if(u.id is null, false, true) AS selected FROM regionsenum AS r LEFT JOIN userregions AS u ON u.userid = ? AND u.region = r.id ORDER BY r.id;">
                                                    <sql:param value="${sessionScope.userid}"/>
                                                </sql:query>
                                                <c:forEach var="region" items="${regionsenum.rows}">
                                                    <option value="${region.id}" ${region.selected == 1 ? 'selected': ''}>${region.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="small-1 column">
                                            <input type="reset" class="button tiny">
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label class="right inline" for="method">Способ</label>
                                        </div>
                                        <div class="small-8 small-offset-1 columns">
                                            <select id="method" name='method' multiple="multiple" data-prompt="---------------">
                                                <sql:query var="methodsenum" dataSource="${db}" sql="SELECT m.id, m.name, if(u.id is null, false, true) AS selected FROM methodsenum AS m LEFT JOIN usermethods AS u ON u.userid = ? and m.id = u.method ORDER BY m.id;">
                                                    <sql:param value="${sessionScope.userid}"/>
                                                </sql:query>
                                                <c:forEach var="method" items="${methodsenum.rows}">
                                                    <option value="${method.id}" ${method.selected == 1 ? 'selected': ''}>${method.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="small-1 column">
                                            <input type="reset" class="button tiny">
                                        </div>

                                    </div>


                                    <div class="row">
                                        <div class="small-2 columns">
                                            <label class="right inline" for="source">Источник</label>
                                        </div>
                                        <div class="small-8 small-offset-1 columns">
                                            <select id="source" name='source' multiple="multiple" data-prompt="---------------">
                                                <sql:query var="sites" dataSource="${db}" sql="SELECT siteid, sitename, if(u.id is null, false, true) as selected FROM sites AS s LEFT JOIN usersources AS u ON u.userid = ? AND s.siteid = u.source ORDER BY s.siteid;">
                                                    <sql:param value="${sessionScope.userid}"/>
                                                </sql:query>
                                                <c:forEach var="site" items="${sites.rows}">
                                                    <option value="${site.siteid}" ${site.selected == 1 ? 'selected' : ''}>${site.sitename}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="small-1 column">
                                            <input onclick="SelectClear(event)" type="reset" class="button tiny">
                                        </div>
                                    </div>


                                    <!--                                        <div class="row">
                                                                                <div class="small-2 columns">
                                                                                    <label for="test" class="right inline">Test</label>
                                                                                </div>
                                                                                <div class="small-9 small-offset-1 columns">
                                                                                    <input type="text" id="test" name="test" value="${smethods}">
                                                                                </div>
                                                                            </div>-->



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
        <script src="js/foundation.js"></script>
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
                                                    $('#region').selectedIndex = 0;
                                                    $('#method').selectedIndex = 0;
                                                    $('#source').selectedIndex = 0;
                                                });
//            $("#save").click(function (){
//                alert('ok');
//                    $('#regions').val('');
//                    $('#region :selected').each(function (i, selected) {
//                        alert('ok1');
//                        if ($('#regions').val() !== "") {
//                        alert('ok2');
//                            $('#regions').val($('#regions').val() + ',' + $(this).val());
//                            alert('#regions: ' + $('#regions').val());
//                            alert('#region '+$('#region').val());
//                        }
//                        else {
//                        alert('ok3');
//                            $('#regions').val($(this).val());
//                        }
//                    });
//                
//            });
        </script>
        <script>
            $('select').foundationSelect();
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
