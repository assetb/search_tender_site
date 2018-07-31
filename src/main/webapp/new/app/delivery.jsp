<%-- 
    Document   : delivery
    Created on : 04.10.2016, 8:42:29
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Модуль рассылки</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
            <div class="row">
                <form method="post" enctype="multipart/form-data">
                    <div class="row">
                        <input hidden name="id_message" value=""/>
                        <div class="large-12 columns">
                            <label>Файл с письмом(.html)
                                <input type="file" required="true" name="message" accept=".html" class="prefix-radius"/>
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <lable>Отправитель
                            <select name="from">
                                <c:forEach var="from" items="${it.froms}">
                                    <option value="${from.id}">${from.name}</option>
                                </c:forEach>
                            </select>
                        </lable>
                    </div>
                    <div class="row">
                        <div class="large-12 columns">
                            <label>Тема письма
                                <input required="true" type="text" name="subject" value="" />
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-2 column">Список получателей</div>
                        <div class="large-10 column" onclick="RecipientsOnFileEvent(event)">
                            <div><input type="radio" disabled name="recipients" value="0"/>Выгрузить из базы Sirius</div>
                            <div><input type="radio" disabled name="recipients" value="1"/>Выгрузить из базы AisAlta</div>
                            <div><input type="radio" disabled name="recipients" value="2"/>Выгрузить из базы Ets.Net</div>
                            <div><input id="load_file_recipients_radio" type="radio" checked name="recipients" value="3"/>Выгрузить из файла</div>
                            <div><input id="load_file_recipients" accept=".txt" name="file_list_emails" type="file"/></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-5">
                            <label>Время задержки между сообщениями(в  секундах)
                                <input class="form-control column" type="number" min="8" required="true" name="timeout" value="8"/>
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <button type="submit">Запустить</button>
                        <button onClick="history.go(-1);return true;">Назад</button>
                    </div>
                </form>
            </div>
        </def:templatePage>
        <script>
            function RecipientsOnFileEvent(event) {
                $("#load_file_recipients").prop('disabled', !$("#load_file_recipients_radio").prop("checked"));
            }
        </script>
    </body>
</html>