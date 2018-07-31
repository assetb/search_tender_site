<%-- 
    Document   : cabinet_crm_reveal
    Created on : 09.10.2015, 8:48:05
    Author     : Smaile
--%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:query var="selecttable" dataSource="${db}">
    SELECT * FROM ${param.source} WHERE ${param.name} = ${param.value}
</sql:query>
<div>
    <c:choose>
        <c:when test="${param.source == 'customer'}">
            <c:choose>
                <c:when test="${selecttable.rowCount == 1}">
                    <h1 class="title">Информация о компании</h1>
                    <c:set var="row" value="${selecttable.rows[0]}"/>
                    <table class="table" style="width: 100%;">
                        <tr>
                            <td>Наименование(рус.)</td>
                            <td>${row.runame}</td>
                        </tr>
                        <tr>
                            <td>Наименование(каз.)</td>
                            <td>${row.kzname != null ? row.kzname : 'Не указано'}</td>
                        </tr>
                        <tr>
                            <td>БИН</td>
                            <td>${row.bin != null ? row.bin : 'Не указано'}</td>
                        </tr>
                        <tr>
                            <td>Дата регистрации</td>
                            <td>${row.regdate != null ? row.regdate : 'Не указано'}</td>
                        </tr>
                        <tr>
                            <td>Регион</td>
                            <td>${row.region != null ? row.region : 'Не указано'}</td>
                        </tr>
                        <tr>
                            <td>Ф.И.О</td>
                            <td>${row.lastname} ${row.firstname}</td>
                        </tr>
                        <tr>
                            <td>Телефон</td>
                            <td>${row.tel != null ? row.tel : 'Не указано'}</td>
                        </tr>
                        <tr>
                            <td>Эл. почта</td>
                            <td>${row.email != null ? row.email : 'Не указано'}</td>
                        </tr>
                    </table>
                </c:when>
                <c:otherwise>  
                    <div>Нет информации по компании</div>
                </c:otherwise>
            </c:choose>
        </c:when>


        <c:when test="${param.source == 'deliveries'}">
            <div>delireries</div>
            <c:choose>
                <c:when test="${selecttable.rowCount > 0}">
                    <h1 class="title">Информация о параметров поиска</h1>
                    <h3 class="title">Компания</h3>
                    <c:forEach var="row" items="${selecttable.rows}">
                        <table class="table" style="width: 100%;">
                            <tr>
                                <td>Регион</td>
                                <td>
                                    <select>
                                        <option value='' disabled selected style='display:none;'>Выберите регион</option>
                                        <sql:query var="regionsenum" dataSource="${db}" sql="SELECT * FROM regionsenum">
                                        </sql:query>
                                        <c:forEach var="rowRegionsEnum" items="${regionsenum.rows}">
                                            <option value="${rowRegionsEnum.id}" ${rowRegionsEnum.id == row.regind ? 'selected':''}>${rowRegionsEnum.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Метод</td>
                                <td>
                                    <select>
                                        <option value='' disabled selected style='display:none;'>Выберите метод закупки</option>
                                        <sql:query var="methodsenum" dataSource="${db}" sql="SELECT * FROM methodsenum"/>
                                        <c:forEach var="rowMethodsEnum" items="${methodsenum.rows}">
                                            <option value="${rowMethodsEnum.id}" ${rowMethodsEnum.id == row.method ? 'selected':''}>${rowMethodsEnum.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Площадки</td>
                                <td>
                                    <select>
                                        <option value='' disabled selected style='display:none;'>Выберите площадку</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Ключевое слово 1</td>
                                <td><input type="text" placeholder="Введите ключевое слово" value=${row.keyword1 != null ?  row.keword1 : '' }></td>
                            </tr>
                            <tr>
                                <td>Ключевое слово 2</td>
                                <td><input type="text" placeholder="Введите ключевое слово" value=${row.keyword2 != null ? row.keword2 : ''}></td>
                            </tr>
                            <tr>
                                <td>Ключевое слово 3</td>
                                <td><input type="text" placeholder="Введите ключевое слово" value=${row.keyword3 != null ? row.keword3 : ''}></td>
                            </tr>
                            <tr>
                                <td>Минимальная сумма</td>
                                <td><input type="text" placeholder="Введите Минимальную сумму" value=${row.minsum != null ? row.minsum : ''}></td>
                            </tr>
                            <tr>
                                <td>Максимальная сумма</td>
                                <td><input type="text" placeholder="Введите Максимальную сумму" value=${row.maxsum != null ? row.maxsum : ''}></td>
                            </tr>
                        </table>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div>Нет информации о параметрах <a class="button small">Создать параметры</a></div>
                </c:otherwise>
            </c:choose>
        </c:when>      

        <c:when test="${row.source == 'contacts'}">
            <h1>Контакты</h1>
        </c:when>

        <c:otherwise>
            <h1 class="alert-box alert title centered">404</h1>
        </c:otherwise>
    </c:choose>
    <a class="close-reveal-modal" aria-label="Close">&#215;</a>
</div>