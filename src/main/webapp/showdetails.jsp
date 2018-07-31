<%--
    Document   : showdetails
    Created on : 05.11.2015, 11:05:21
    Author     : Smaile
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="UTF-8" />

<c:set var="isEmployee" value="${(sessionScope.userid!=null && sessionScope.roleid!= null && sessionScope.roleid > 9 && sessionScope.roleid < 100)? true : false}"/>
<c:set var="isHeadEmployee" value="${(sessionScope.userid != null && sessionScope.roleid == 20)? true : false}"/>

<c:choose>
    <c:when test="${param.type != null && param.type == 'update'}">
        <sql:update dataSource="${db}" sql="update customer set bin=?, runame=?, kzname=?, lastname=?, firstname=?, tel=?, email=?, url=? WHERE id = ?">
            <sql:param value="${param.bin != null ? param.bin : ''}"/>
            <sql:param value="${param.runame != null ? param.runame : ''}"/>
            <sql:param value="${param.kzname != null ? param.kzname : ''}"/>
            <sql:param value="${param.lastname != null ? param.lastname : ''}"/>
            <sql:param value="${param.firstname != null ? param.firstname : ''}"/>
            <sql:param value="${param.tel != null ? param.tel : ''}"/>
            <sql:param value="${param.email != null ? param.email : ''}"/>
            <sql:param value="${param.url != null ? param.url : ''}"/>
            <sql:param value="${param.id != null ? param.id : ''}"/>
        </sql:update>
        <c:set var="isUpdate" value="${true}"/>
    </c:when>
    <c:when test="${param.type != null && param.type == 'new'}">
        <%
            Date date = new Date();
            String dateFormat = new SimpleDateFormat("dd.MM.yyyy").format(date);
        %>
        <sql:transaction dataSource="${db}">
            <sql:update sql="INSERT INTO customer(bin, runame, kzname, lastname, firstname, tel, email, url, userid, regdate, managerid) VALUES (?,?,?,?,?,?,?,?,?,?,?);">
                <sql:param value="${param.bin != null ? param.bin : ''}"/>
                <sql:param value="${param.runame != null ? param.runame : ''}"/>
                <sql:param value="${param.kzname != null ? param.kzname : ''}"/>
                <sql:param value="${param.lastname != null ? param.lastname : ''}"/>
                <sql:param value="${param.firstname != null ? param.firstname : ''}"/>
                <sql:param value="${param.tel != null ? param.tel : ''}"/>
                <sql:param value="${param.email != null ? param.email : ''}"/>
                <sql:param value="${param.url != null ? param.url : ''}"/>
                <sql:param value="${param.client_id != null ? param.client_id : null}"/>
                <sql:param value="<%=dateFormat%>"/>
                <sql:param value="${isEmployee == true ? sessionScope.userid : null}"/>
            </sql:update>
            <sql:query var="nextIdTable" sql="SELECT LAST_INSERT_ID() as lastId"/>
        </sql:transaction>
        <c:redirect url="showdetails.jsp?id=${nextIdTable.rows[0].lastId}"/>
    </c:when>
</c:choose>


<!DOCTYPE html>
<html class="no-js" lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Компания ${row.runame}</title>
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
                <div class="row">
                    <a class="button"  href="<c:url value="maincrm.jsp">
                           <c:param name="p" value="${param.p != null ? param.p : 1}"/>
                       </c:url>">
                        Вернуться назад
                    </a>
                </div>
                <c:if test="${param.id != null}">
                    <sql:query var="rowsselected" dataSource="${db}" sql="SELECT * FROM customer WHERE id = ${param.id}"/>
                    <c:set var="row" value="${rowsselected.rows[0]}"/>
                </c:if>
                <div class="row">
                    <div class="large-4 columns">
                        <span>Статус</span>
                        <select update="customer" name="status" wherename="id" wherevalue="${param.id}">
                            <sql:query var="status" dataSource="${db}" sql="SELECT orderid, name FROM statusenum;"/>
                            <option hidden>Не указан</option>
                            <c:forEach var="stat" items="${status.rows}">
                                <option ${(row.status == stat.orderid) ? 'selected' : ''} id="${stat.orderid}">${stat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <c:if test="${isHeadEmployee == true && row != null}">
                        <div class="large-4 columns">
                            <span>Менеджер</span>
                            <select update="customer" name="managerid" wherename="id" wherevalue="${param.id}">
                                <sql:query var="users" dataSource="${db}" sql="SELECT id, email FROM users WHERE role BETWEEN 10 and 19;"/>
                                <option hidden="true">Менаджер не выбран</option>
                                <c:forEach var="user" items="${users.rows}">
                                    <option ${(row.managerid == user.id) ? 'selected' : ''} id="${user.id}">${user.email}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>
                </div>

                <div class="row">
                    <div>
                        <span>Информация о компании</span>
                    </div>
                    <hr>
                    <c:if test="${isUpdate == true}">
                        <div class="row">
                            <div class="success label">Обновленно</div>
                        </div>
                    </c:if>
                    <form action="<c:url value="showdetails.jsp">
                              <c:param name="p" value="${param.p}"/>
                          </c:url>" method="post">
                        <c:if test="${param.id != null}">
                            <input hidden name="id" value="${param.id}"/>
                        </c:if>
                        <c:if test="${param.client_id}">
                            <input hidden name="client_id" values="${param.client_id}"/>
                        </c:if>
                        <div class="row">
                            <div class="large-4 columns">
                                <label>БИН
                                    <input type="text" maxlength="12" name="bin" placeholder="введите БИН" value="${ row != null ? row.bin : ''}" />
                                </label>
                            </div>
                            <c:if test="${row != null}">
                                <div class="large-4 columns">
                                    <label>Логин компании:
                                        <c:if test="${row.userid != null}">
                                            <sql:query dataSource="${db}" var="login">
                                                SELECT email FROM users WHERE id = ${row.userid}
                                            </sql:query>
                                            ${login.rows[0].email}
                                        </c:if>
                                        <a class="button prefix" href="<c:url value="editemail.jsp"><c:param name="customer_id" value="${row.id}"/></c:url>">Указать email</a>
                                        </label>
                                    </div>
                            </c:if>
                            <div class="large-4 columns">
                                <label>Дата регистрации ${row!=null ? row.regdate : ''}</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Наимменование компании(рус.)*
                                    <input required="true" type="text" name="runame" placeholder="введите наимменование компании" value="${row!= null?row.runame.replace('"', '&quot;').replace('\'', '&apos;'):''}" />
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-12 columns">
                                <label>Наимменование компании(каз.)
                                    <input type="text" name="kzname" placeholder="введите наимменование компании(каз.)" value="${row!=null?row.kzname.replace('"', '&quot;').replace('\'', '&apos;'):''}" />
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <label>Директор</label>
                            <div class="large-6 columns">
                                <label>Фамилия
                                    <input type="text" placeholder="Введите фамилию директора" name="lastname" value="${row!=null?row.lastname:''}"/>
                                </label>
                            </div>
                            <div class="large-6 columns">
                                <label>Имя
                                    <input type="text" placeholder="Введите имя директора" name="firstname" value="${row!=null?row.firstname:''}"/>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-6 columns">
                                <label>Телефон компании
                                    <input type="text" name="tel" value="${row!=null?row.tel:''}">
                                </label>
                            </div>
                            <div class="large-6 columns">
                                <label>Эл. адрес компании
                                    <c:if test="${row == null}">
                                        <sql:query var="result" dataSource="${db}">
                                            SELECT email FROM users WHERE id = ?
                                            <sql:param value="${param.client_id}"/>
                                        </sql:query>
                                        <c:set var="email" value="${result.rows[0].email}"/>
                                    </c:if>
                                    <input type="text" name="email" value="${row!=null ? row.email : email}">
                                </label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="large-6 columns">
                                <label>Веб-сайт компании
                                    <input type="url" name="url" value="${row!=null?row.url:''}">
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <button type="submit" class="button" name="type" value="${param.id!=null? 'update' : 'new'}">${param.id != null?'Сохранить':'Создать'}</button>
                        </div>
                    </form>
                </div>
                <c:choose>
                    <c:when test="${row != null && isEmployee == true}">
                        <div class="row">
                            <sql:query var="contacts" dataSource="${db}">
                                SELECT p.* FROM personinfo p, contacts c WHERE c.customerid = ${row.id} and p.id = c.bindid
                            </sql:query>
                            <table id="table"  width="100%">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="text-center"><h5>Информация о контактных лицах</h5></th>
                                </tr>
                                <tr>
                                    <th width="calc(100% / 4 - 15px)">Фамилия</th>
                                    <th width="calc(100% / 4 - 15px)">Имя</th>
                                    <th width="calc(100% / 4 - 15px)">Телефон</th>
                                    <th width="calc(100% / 4 - 15px)">Email</th>
                                    <th width="15px"></th>
                                </tr>
                                </thead>
                                <c:forEach var="contact" items="${contacts.rows}">
                                    <tr>
                                        <td>${contact.lastname}</td>
                                        <td>${contact.firstname}</td>
                                        <td>${contact.tel}</td>
                                        <td>${contact.email}</td>
                                        <td>
                                            <a  class="icon_pencil-edit" title="Редактировать" href="<c:url value="personinfo.jsp">
                                                    <c:param name="customer_id" value="${row.id}"/>
                                                    <c:param name="client_id" value="${contact.id}"/>
                                                </c:url>"/></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td colspan="5">
                                        <a class="text-center prefix" href="<c:url value="personinfo.jsp">
                                               <c:param name="customer_id" value="${row.id}"/>
                                           </c:url>">Добавить</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="row">
                            <sql:query var="history" dataSource="${db}">
                                SELECT * FROM history WHERE customerid = ${row.id}
                            </sql:query>
                            <div>
                                <table role="grid" width="100%">
                                    <thead>
                                        <tr>
                                            <th colspan="4" class="text-center"><h5>История переговоров</h5></th>
                                    </tr>
                                    <tr>
                                        <th width="calc(100% - 100px - 15px)">Дата</th>
                                        <th width="calc(100% - 40% - 15px)">Содержание беседы</th>
                                        <th width="calc(100% - 20% - 15px)">Результат беседы</th>
                                        <th width="15px"></th>
                                    </tr>
                                    </thead>
                                    <c:forEach var="history" items="${history.rows}">
                                        <tr>
                                            <td>${history.date}</td>
                                            <td>${history.description}</td>
                                            <td>${history.result}</td>
                                            <td>
                                                <a  class="icon_pencil-edit" title="Редактировать"  href="<c:url value="history.jsp">
                                                        <c:param name="customer_id" value="${row.id}"/>
                                                        <c:param name="history_id" value="${history.id}"/>
                                                    </c:url>"/>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="4">
                                            <a class="text-center prefix" href="<c:url value="history.jsp">
                                                   <c:param name="customer_id" value="${row.id}"/>
                                               </c:url>">Добавить</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>


                        <div class="row">
                            <sql:query var="deliveries" dataSource="${db}">
                                SELECT id, keyword1, keyword2, keyword3 FROM deliveries WHERE userid = ${row.userid}
                            </sql:query>
                            <div>
                                <table role="grid" width="100%">
                                    <thead>
                                        <tr>
                                            <th colspan="4" class="text-center"><h5>Ключевые слова</h5></th>
                                    </tr>
                                    <tr>
                                        <th>Ключевое слово 1</th>
                                        <th>Ключевое слово 2</th>
                                        <th>Ключевое слово 3</th>
                                        <th width="15px"></th>
                                    </tr>
                                    </thead>
                                    <c:forEach var="delivery" items="${deliveries.rows}">
                                        <tr>
                                            <td>${delivery.keyword1}</td>
                                            <td>${delivery.keyword2}</td>
                                            <td>${delivery.keyword3}</td>
                                            <td><a class="icon_pencil-edit" title="Редактировать" href="<c:url value="deliveries.jsp">
                                                       <c:param name="customer_id" value="${param.id}"/>
                                                       <c:param name="userid" value="${row.userid}"/>
                                                       <c:param name="delivery" value="${delivery.id}"/>
                                                   </c:url>"></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${deliveries.rowCount < 1}">
                                        <tr>
                                            <td colspan="4">
                                                <a class="text-center prefix" ${deliveries.rowCount > 0 ? '' : ''} href="<c:url value="deliveries.jsp">
                                                       <c:param name="customer_id" value="${param.id}"/>
                                                       <c:param name="userid" value="${row.userid}"/>
                                                   </c:url>">Добавить</a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${row != null && isEmployee == false}">
                        <a href="<c:url value="index.jsp"/>">Вернуться на главную</a>
                    </c:when>
                </c:choose>
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
