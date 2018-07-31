<%-- 
    Document   : searchform
    Created on : 21.07.2015, 13:56:02
    Author     : Aset
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="search-form">
    <div class="theme-wrapper s2">
        <form method="get" action="search.jsp" class="form-tenders-search" style="min-height: 120px; max-height: 120px;">
            <input type="hidden" name="sortBy" value="hot">
            <div class="s21">
                <button type="submit" class="btn btn-theme">Поиск</button>
                <select multiple="multiple" class="regions-select" style="display:none;">
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

                <select multiple="multiple" class="methods-select" style="display:none;">
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

                <select multiple="multiple" class="sources-select" style="display:none;">
                    <option  value="3">Государственные закупки</option>
                    <option  value="2">Самрук-Казына</option>
                    <option  value="1">Реестр недропользователей</option>
                </select>
                <input type="hidden" name="sources" value="" />

                <input type="text" name="q" placeholder="Введите наименование или номер закупки" class="input-theme" value="" />
                <div class="clear"></div>
            </div>

            <div class="s22">
                <div class="input-control-theme">
                    <label>Мин. сумма</label>
                    <input type="text" name="sums" placeholder="0" class="input-theme" value="" />
                </div>

                <div class="input-control-theme">
                    <label>Макс. сумма</label>
                    <input type="text" name="sume" placeholder="10000000000" class="input-theme" value="" />
                </div>

                <div class="input-control-theme">
                    <label>Прием заявок с</label>
                    <input type="text" id="publications" name="publications" value="03.07.2015" class="input-theme" />
                </div>

                <div class="input-control-theme">
                    <label>Прием заявок по</label>
                    <input type="text" id="publicatione" name="publicatione" value="03.09.2015" class="input-theme" />
                </div>

                <div class="input-control-theme" style="margin-right:0;">
                    <label>Вид деятельности</label>
                    <select multiple="multiple" class="categories-ddl-list" style="display:none;">
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
</div>

<script type='text/javascript'> jQuery(document).ready(function () {
        jQuery(document).trigger('gform_post_render', [1, 1])
    });</script>
