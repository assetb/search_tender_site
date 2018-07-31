<%-- 
    Document   : search2
    Created on : 04.08.2015, 16:55:35
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Поиск</title>
    </head>
    <body>
        <div>
            <form method="get" action="search2.jsp" style="min-height: 120px; max-height: 120px;">
                <input type="hidden" name="sortBy" value="hot">
                <div>
                    <button type="submit">Поиск</button>
                    <select multiple="multiple">
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
                    <input type="hidden" name="regions" value="" />

                    <select multiple="multiple">
                        <option  value="6">Аукцион</option>
                        <option  value="1">Закуп из одного источника</option>
                        <option  value="5">Запрос ценовых предложений</option>
                        <option  value="7">Запрос ценовых предложений на понижение</option>
                        <option  value="3">Конкурс с применением двухэтапных процедур</option>
                        <option  value="4">Конкурс посредством электронных закупок</option>
                        <option  value="9">Открытый конкурс</option>
                        <option  value="8">Открытый конкурс на понижение</option>
                    </select>
                    <input type="hidden" name="payMethods" value="" />

                    <select multiple="multiple">
                        <option  value="3">Государственные закупки</option>
                        <option  value="2">Самрук-Казына</option>
                        <option  value="1">Реестр недропользователей</option>
                        <option  value="5">Евразийская группа ENRC</option>
                        <option  value="6">Электр. торг. площадка частных организаций/банков</option>
                        <option  value="4">Образовательные учреждения</option>
                        <option  value="7">Электронная торговая площадка &quot;24тендер&quot;</option>
                    </select>
                    <input type="hidden" name="sources" value="" />

                    <input type="text" name="q" placeholder="Введите наименование или номер закупки" value="" />
                    <div></div>
                </div>

                <div>
                    <div>
                        <label>Мин. сумма</label>
                        <input type="text" name="sums" placeholder="0" value="" />
                    </div>

                    <div>
                        <label>Макс. сумма</label>
                        <input type="text" name="sume" placeholder="10000000000" value="" />
                    </div>

                    <div>
                        <label>Прием заявок с</label>
                        <input type="text" id="publications" name="publications" value="03.07.2015"/>
                    </div>

                    <div>
                        <label>Прием заявок по</label>
                        <input type="text" id="publicatione" name="publicatione" value="03.09.2015"/>
                    </div>

                    <div style="margin-right:0;">
                        <label>Вид деятельности</label>
                        <select multiple="multiple">
                            <option  value="1791,1822,1827">СЕЛЬСКОЕ, ЛЕСНОЕ И РЫБНОЕ ХОЗЯЙСТВО</option>
                            <option  value="1853,1856,1859,1863,1870,1959">УГОЛЬ, НЕФТЬ, ПРИРОДНЫЙ ГАЗ, РУДА</option>
                            <option  value="1873,1899,1907">ПРОДУКТЫ ПИЩЕВЫЕ, НАПИТКИ</option>
                            <option  value="1914,1925,1934">ТЕКСТИЛЬ, ОДЕЖДА</option>
                            <option  value="1979">ФАРМАЦЕВТИКА, ПРЕПАРАТЫ</option>
                            <option  value="2014,2031">МЕТАЛЛЫ, ИЗДЕЛИЯ МЕТАЛЛИЧЕСКИЕ</option>
                            <option  value="2049,2060,2071">КОМПЬЮТЕРЫ, ЭЛЕКТРОННОЕ ОБОРУДОВАНИЕ</option>
                            <option  value="2093,2098">АВТОМОБИЛИ, ПРИЦЕПЫ, ТРАНСПОРТНОЕ ОБОРУДОВАНИЕ</option>
                            <option  value="2107,2112">МЕБЕЛЬ, ГОТОВЫЕ ИЗДЕЛИЯ</option>
                            <option  value="2122,2557">РЕМОНТ, УСТАНОВКА</option>
                            <option  value="2132">ЭЛЕКТРОЭНЕРГИЯ, ГАЗ, ВОЗДУШНОЕ КОНДИЦИОНИРОВАНИЕ</option>
                            <option  value="2142,2149,2154,2161">ВОДОСНАБЖЕНИЕ, КАНАЛИЗАЦИЯ, СБОР И УДАЛЕНИЕ ОТХОДОВ</option>
                            <option  value="2170,2177,2185">СТРОИТЕЛЬСТВО</option>
                            <option  value="2199,2206,2255">ТОРГОВЛЯ ОПТОВАЯ И РОЗНИЧНАЯ</option>
                            <option  value="2323,2332,2337,2341,2348">ЛОГИСТИКА, СКЛАДЫ, ПОЧТА, КУРЬЕРЫ</option>
                            <option  value="2351,2356">ПРОЖИВАНИЕ И ПИТАНИЕ</option>
                            <option  value="2361,2369,2375">ИЗДАТЕЛЬСТВО, КИНО, TV, РАДИО, МУЗЫКА</option>
                            <option  value="2383,2388">IT, ПРОГРАММИРОВАНИЕ</option>
                            <option  value="2393,2401,2406">ФИНАНСЫ, СТРАХОВАНИЕ</option>
                            <option  value="2414,2448">НЕДВИЖИМОСТЬ, АРЕНДА</option>
                            <option  value="2419">БУХГАЛТЕРИЯ, ЮРИСТЫ</option>
                            <option  value="2422,2430,2434">КОНСАЛТИНГ, МАРКЕТИНГ, PR, РЕКЛАМА</option>
                            <option  value="2426">АРХИТЕКТУРА, ИНЖЕНЕРИЯ, ПРОЕКТИРОВАНИЕ</option>
                            <option  value="2461,2465,2469,2473,2479">АДМИНИСТРАТИВНОЕ И ВСПОМОГАТЕЛЬНОЕ ОБСЛУЖИВАНИЕ</option>
                            <option  value="2497">ОБРАЗОВАНИЕ</option>
                            <option  value="2509,2515,2520">ЗДРАВООХРАНЕНИЕ И СОЦ. ОБСЛУЖИВАНИЕ НАСЕЛЕНИЯ</option>
                            <option  value="2524,2529,2534,2543">ИСКУССТВО, РАЗВЛЕЧЕНИЯ И ОТДЫХ</option>
                            <option  value="1938,1945,1953,1962,1982,1989,2378,2438,2443,2487,2550,2566,3">ПРОЧЕЕ</option>
                        </select>
                        <input type="hidden" name="categories" value="" />
                    </div>
                    <div class="clear"></div>
                </div>
            </form>
        </div>
        <div>
            <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://88.204.230.204:50505/altatender" user="AltaikDB" password="AcU!ysP14D,B4z"/>
            <sql:query var="selectresult" dataSource="${db}">
                SELECT number, runame, customer FROM purchase
            </sql:query>

            <table border="1">
                <!-- column headers -->
                <tr>
                    <th>Номер</th>
                    <th>Наменование</th>
                    <th>Заказчик</th>
                </tr>
                <!-- column data -->
                <!--c:forEach var="row" items="--><!--${selectresult.rows}"-->
                <tr>
                        <td><!--c:out value="${row.number}"/--></td>
                        <td><!--c:out value="${row.runame}"/--></td>
                        <td><!--c:out value="${row.customer}"/--></td>
                </tr>
                <!--/c:forEach-->
            </table>
        </div>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>
