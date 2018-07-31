<%-- 
    Document   : registry1
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--[if lt IE 7]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js"><!--<![endif]-->
    <%@include file="head.jsp" %>
    <body class="page page-id-1121 page-child parent-pageid-10 page-template page-template-page-sidebar page-template-page-sidebar-php">
        <%@include file="menu.jsp" %>
        <div class="push-content cbp-spmenu-push">
            <div class="fixed">
                <%@include file="mainnav.jsp" %>
            </div>

            <section class="inner-banner-container ss-gradient" style="background-image: url(img/7.jpg);">
                <div class="banner-wrapper row">
                    <div class="news-banner text-center small-35 column">
                        <h1>Услуги</h1>
                        <h2>Что мы можем для Вас сделать???</h2>
                    </div>
                </div>
            </section>

            <section class="service-section ss-gray">
                <div class="row">
                    <div class="clearfix" data-equalizer>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Гибкая и удобная система поиска тендеров,</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">с индивидуальной системой настройки. Уделив настройке системы поиска небольшое количество времени, Вы сразу же получаете доступ к самой свежей и актуальной информацию о государственных закупках и коммерческих тендерах.</h2>
                            </div>
                        </div>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Удобная система уведомлений через email или мобильное приложение.</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">Моментальные оповещения, о появлении новых тендеров, всегда будут приходить непосредственно на Ваш e-mail. Будете в курсе всех последних новостей и событий о проводимых коммерческих тендерах или госзакупок.</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="service-section ss-gray">
                <div class="row">
                    <div class="clearfix" data-equalizer>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Услуга по выпуску, настройке, обслуживанию и пользованию сертификатов ЭЦП.</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">Нет времени и сил получить ЭЦП? Тогда доверьте это нам! Наши специалисты ТОО «Альта и К» сделают всю работу за Вас и для Вас.</h2>
                            </div>
                        </div>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Компании ТОО «Альта и К» аккредитована на трёх основных тендерных площадках.</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">Специалисты ТОО «Альта и К» всегда могут предоставить выход своим клиентам на торговых площадках Самрук-Казына (tender.sk.kz), NadLoc (reestr.nadloc.kz) и на портале Государственных закупок Казахстана (goszakup.gov.kz).</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="service-section ss-gray">
                <div class="row">
                    <div class="clearfix" data-equalizer>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Легкий способ управления подачами заявок на тендеры через наше удобное веб приложение.</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">Забудьте о каких-либо неудобствах, подавайте заявки непосредственно на нашем сайте www.altatender.kz, всю остальную работу (загрузка документации и подача ценового предложения) мы сделаем за вас, от лица вашей компании.</h2>
                            </div>
                        </div>
                        <div data-equalizer-watch>
                            <div class="merchants-text">
                                <h1 class="section-title small-text-center large-text-left dark-padded">Бесплатная (Пробная версия) рассылка тендеров.</h1>
                                <h2 class="section-sub-title small-text-center large-text-left dark-padded">Тестовый период по рассылке тендеров на e-mail составляет 30 дней. За этот период вы сможете в полной мере и совершено бесплатно просматривать всю доступную информацию по закупкам.</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <%@include file="footer.jsp" %>
        </div>



        <script src="js/vendor/jquery.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>
        <script src="js/foundation.min.js"></script>
        <script src="js/foundation/foundation.offcanvas.js"></script>
        <script src="js/foundation/foundation.abide.js"></script>
        <script src="js/foundation/foundation.dropdown.js"></script>
        <script src="js/foundation-select.js"></script>
        <script type="text/javascript" src="js/search2.js"></script>
        <script src="js/scripts.js"></script>
        <jsp:include page="utilities/googleadservice.jsp"/>
    </body>
</html>