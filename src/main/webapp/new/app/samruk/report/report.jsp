<%-- 
    Document   : report
    Created on : 27.09.2016, 14:01:26
    Author     : admin
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Аукцион ${it.number}</title>
        <def:importStyles/>
    </head>
    <body>
        <def:templatePage>
            <div class="row">
                <div>
                    <span>Аукцион</span>
                </div>
                <hr>
                <c:if test="${isUpdate == true}">
                    <div class="row">
                        <div class="success label">Обновленно</div>
                    </div>
                </c:if>
                <form method="post">
                    <div class="row">
                        <div class="large-4 columns">
                            <label>Номер
                                <input required="true" type="text" name="number" value="${it.number}" />
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Дата проведения ${it.date}</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-12 columns">
                            <label>Коментарии
                                <textarea type="text" name="comments">${it.comments}</textarea>
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-2 column">Тип</div>
                        <select class="large-10 column" name="typeid">
                            <option hidden="true">Не выбран</option>
                            <c:forEach var="type" items="${it.types}">
                                <option ${it.typeId == type.id ? "selected" : ""} name="${type.id}">${type.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <div class="large-2 column">Статус</div>
                        <select  class="large-10 column" name="statusid">
                            <option hidden="true">Не выбран</option>
                            <c:forEach var="status" items="${it.statuses}">
                                <option ${it.statusId == status.id ? "selected" : ""} name="${status.id}">${status.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <div class="large-2 column">Торг проводится на</div>
                        <select class="large-10 column" name="siteid">
                            <option hidden="true">Не выбран</option>
                            <c:forEach var="site" items="${it.sites}">
                                <option ${it.siteId == site.id ? "selected" : ""} name="${site.id}">${site.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <div class="large-2 column">Трейдер</div>
                        <select class="large-10 column" name="traderid">
                            <option hidden="true">Не выбран</option>
                            <c:forEach var="trader" items="${it.traders}">
                                <option ${it.traderid == trader.id ? "selected" : ""} name="${trader.id}">${trader.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
                <div>
                    <span>Лоты</span>
                </div>
                <hr>
                <div role="grid">
                    <div class="row text-center">
                        <div class="column large-2">№</div>       
                        <div class="column large-2">Описание</div>
                        <div class="column large-2">Кол-во</div>
                        <div class="column large-2">Цена</div>
                        <div class="column large-2">Сумма</div>
                        <div class="column large-2"></div>                 
                    </div>
                    <c:forEach var="lot" items="${it.lots}">
                        <form method="POST" action="<c:url value="${it.id}/lot/${lot.id}"/>">
                            <div class="row collapse">
                                <div class="column large-2">
                                    <input type="text" class="form-control" name="number" value="${lot.number}"/>
                                </div>       
                                <div class="column large-2">
                                    <input type="text" class="form-control" name="description" value="${lot.description}"/>
                                </div>
                                <div class="column large-2">
                                    <input type="text" class="form-control" name="amount" value="${lot.amount}"/>
                                </div>
                                <div class="column large-2">
                                    <input type="text" class="form-control" name="price" value="${lot.price}"/>
                                </div>
                                <div class="column large-2">
                                    <input type="text" class="form-control" name="sum" value="${lot.sum}"/>
                                </div>
                                <div class="column large-2">
                                    <input type="submit" value="Сохранить" class="prefix button button-bar"/>
                                </div>                 
                            </div>
                        </form>
                    </c:forEach>

                    <form method="POST" action="<c:url value="${it.id}/lot"/>">
                        <div class="row collapse">
                            <div class="column large-2">
                                <input type="text" class="form-control" name="number" value=""/>
                            </div>       
                            <div class="column large-2">
                                <input type="text" class="form-control" name="description" value=""/>
                            </div>
                            <div class="column large-2">
                                <input type="text" class="form-control" name="amount" value=""/>
                            </div>
                            <div class="column large-2">
                                <input type="text" class="form-control" name="price" value=""/>
                            </div>
                            <div class="column large-2">
                                <input type="text" class="form-control" name="sum" value=""/>
                            </div>
                            <div class="column large-2">
                                <input type="submit" value="Добавить" class="prefix button button-bar"/>
                            </div>                 
                        </div>
                    </form>
                </div>
            </div>
        </def:templatePage>
    </body>
</html>
