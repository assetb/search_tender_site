<%-- 
    Document   : cabinet
    Created on : 06.08.2015, 9:32:15
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Личный кабинет</title>
        <link rel="stylesheet" href="css/foundation.css" type="text/css"/>
        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>
        <link rel="stylesheet" href="css/bootstrap-multiselect.css" type="text/css"/>
        <style type="text/css">
            body { padding-top: 140px; }
            @media screen and (max-width: 768px) {
                body { padding-top: 0px; }
            }        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp" />
        <div class="fixed">
            <jsp:include page="mainnav.jsp" />
        </div>
        <%if (null != session.getAttribute("isAuthorized")) {%>
        <div class="row">
            <div class="col-xs-3 centered" role="complementary">
                <nav class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-top: 85px">
                    <ul class="nav navbar-nav ">
                        <li><a href="#profile-form">Настройка профиля</a></li>
                        <li><a href="#search-form">Настройка рассылки</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-xs-9" role="main">
                <div class="container">
                    <div id="profile-form" class="row">
                        <section class="inner-article-title ss-gray">
                            <div class="inner-banner-cabinet small-text-center medium-text-left small-35 large-24 column">
                                <h1>Настройка профиля</h1>
                            </div>
                        </section>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Дата регистрации</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Имя ответственного</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Компания</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Email</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Skype</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">WWW</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Город</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Адрес</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Индекс</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">БИН</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">ИИК</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">Банк</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-xs-2 control-label">БИК</label>
                        <div class="col-xs-10">

                        </div>
                    </div>
                </div>
                <div class="container">
                    <div id="search-form" class="row">
                        <section class="inner-article-title ss-blue">
                            <div class="inner-banner-cabinet small-text-center medium-text-left small-35 large-24 column">
                                <h1>Настройка рассылки</h1>
                            </div>
                        </section>
                    </div>
                    <form method="post" action="cabinet.jsp" class="form-horizontal">
                        <input type="hidden" name="is" value="yes">
                        <div class="form-group">
                            <label class="col-xs-2 control-label">Регион</label>
                            <div class="col-xs-10">
                                <select class="form-control" name='region' id="region" multiple="multiple">
                                    <option  value="16">г. Алматы</option>
                                    <option  value="15">г. Астана</option>
                                    <option  value="1">Акмолинская область</option>
                                    <option  value="2">Актюбинская область</option>
                                    <option  value="3">Алматинская область</option>
                                    <option  value="4">Атырауская область</option>
                                    <option  value="5">Западно-Казахстанская область</option>
                                    <option  value="6">Жамбылская область</option>
                                    <option  value="7">Карагандинская область</option>
                                    <option  value="8">Костанайская область</option>
                                    <option  value="9">Кызылординская область</option>
                                    <option  value="10">Мангистауская область</option>
                                    <option  value="11">Южно-Казахстанская область</option>
                                    <option  value="12">Павлодарская область</option>
                                    <option  value="13">Северо-Казахстанская область</option>
                                    <option  value="14">Восточно-Казахстанская область</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">Способ</label>
                            <div class="col-xs-10">
                                <select id="method" class="form-control" name='method' multiple="multiple">
                                    <option  value="1">Аукцион</option>
                                    <option  value="2">Закуп из одного источника</option>
                                    <option  value="3">Запрос ценовых предложений</option>
                                    <option  value="4">Запрос ценовых предложений на понижение</option>
                                    <option  value="5">Конкурс с применением двухэтапных процедур</option>
                                    <option  value="6">Конкурс посредством электронных закупок</option>
                                    <option  value="7">Открытый конкурс</option>
                                    <option  value="8">Открытый конкурс на понижение</option>
                                </select>
                            </div>

                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">Источник</label>
                            <div class="col-xs-10">
                                <select id="source" class="form-control" name='source' multiple="multiple">
                                    <option  value="1">Государственные закупки</option>
                                    <option  value="2">Самрук-Казына</option>
                                    <option  value="3">Реестр недропользователей</option>
                                </select>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-xs-10 col-xs-offset-2">
                                <input type="text" name="keyword" placeholder="Введите ключевок слово закупки" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">Мин. сумма</label>
                            <div class="col-xs-10">
                                <input type="text" name="minsum" placeholder="0" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">Макс. сумма</label>
                            <div class="col-xs-10">
                                <input type="text" name="maxsum" placeholder="10000000000" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">Прием заявок с</label>
                            <div class="col-xs-10">
                                <input type="text" id="publications" name="publications" value="07.07.2015"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">Прием заявок по</label>
                            <div class="col-xs-10">
                                <input type="text" id="publicatione" name="publicatione" value="07.09.2015"/>
                            </div>
                        </div>



                        <div class="form-group">
                            <div class="col-xs-10 col-xs-offset-2">
                                <button type="submit" class="btn btn-default">Настроить</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="container">
                    <div class="col-xs-10 col-xs-offset-2">
                        <c:out value="${sessionScope[email]}"/>
                    </div>
                    <c:choose>
                        <c:when test="${not empty param.is}">
                            <!--sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/altatender" user="root" password="te76ba"/-->
                            <div class="col-xs-10 col-xs-offset-2">
                                <c:out value="${sessionScope[email]}"/>
                            </div>
                            <sql:query var="selectresult" dataSource="${db}">
                                SELECT id, email,password FROM users WHERE email = 'aset.b@rambler.ru' and password = 'aset'
                            </sql:query>
                            <div class="col-xs-10 col-xs-offset-2">
                                <c:out value="${selectresult.rowCount}"/>
                            </div>
                            <div class="col-xs-4"><c:out value="${selectresult.rows[0].id}"/></div><div class="col-xs-4"><c:out value="${selectresult.rows[0].email}"/></div><div class="col-xs-4"><c:out value="${selectresult.rows[0].password}"/></div>
                                <c:choose>
                                    <c:when test="${selectresult.rowCount == 0}">
                                    <p>Вы не зарегистрированы.</p>
                                </c:when>
                                <c:otherwise>

                                    <sql:update dataSource="${db}" var="updateresult">
                                        INSERT INTO deliveries (userid,region,method,source,keyword1,minsum,maxsum,startday,endday) VALUES (?,?,?,?,?,?,?,?,?)
                                        <sql:param value="${selectresult.rows[0].id}"/>
                                        <sql:param value="${param.region}"/>
                                        <sql:param value="${param.method}"/>
                                        <sql:param value="${param.source}"/>
                                        <sql:param value="${param.q}"/>
                                        <sql:param value="${param.minsum}"/>
                                        <sql:param value="${param.maxsum}"/>
                                        <sql:param value="${param.startday}"/>
                                        <sql:param value="${param.endday}"/>
                                    </sql:update>
                                    <p>Данные внесены.</p>
                                </c:otherwise>
                            </c:choose>

                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        <%} else {%>
        <p>Авторизуйтесь.</p>
        <%}%>
        <%@include file="footer.jsp" %>


        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#region').multiselect({
                    includeSelectAllOption: true,
                    nonSelectedText: ' - ',
                    allSelectedText: 'Все'
                });
                $('#method').multiselect({
                    includeSelectAllOption: true,
                    nonSelectedText: ' - ',
                    allSelectedText: 'Все'
                });
                $('#source').multiselect({
                    includeSelectAllOption: true,
                    nonSelectedText: ' - ',
                    allSelectedText: 'Все'
                });
            });
        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>    
    </body>
</html>
