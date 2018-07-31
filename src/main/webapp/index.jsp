<%--<%@page import="jdk.nashorn.internal.objects.NativeFunction.function(boolean, Object, Object[])"%>--%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    boolean isAuthorized = false;
    if (null != session && null != session.getAttribute("isAuthorized")) {
        isAuthorized = true;
    }
%>
<!DOCTYPE html>
<!--html-->
<!--[if lt IE 7]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html lang="en-US" prefix="og: http://ogp.me/ns#" xmlns:og="http://ogp.me/ns#" xmlns:article="http://ogp.me/ns/article#" class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!-->
<!--html lang="en-US" prefix="og: http://ogp.me/ns#" prefix="article:http://ogp.me/ns/article#" class="no-js"--><!--<![endif]-->
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js"><!--<![endif]-->
    <jsp:include page="head.jsp" />
    <body>
        <div class="nav-container">
            <jsp:include page="menu.jsp" />
        </div>

        <div class="push-content cbp-spmenu-push">
            <div class="fixed">
                <jsp:include page="mainnav.jsp" />
            </div>


            <header class="slider">
                <div class="royalSlider rsDefault">

                    <!-- slider -->
                    <div class="rsContent slide-center-text">
                        <div class="rsABlock">
                            <div class="container-table">
                                <div class="container-cell">
                                    <h2 class="slider-title small-text-center large-text-center">Эффективный поиск</h2>
                                </div>
                            </div>
                        </div>
                        <span class="blue-gradient"></span>
                        <a href="index.jsp"><img src="img/1.jpg" class="rsImg"  alt="Альта и К"></a>
                    </div>

                    <!-- slider -->
                    <div class="rsContent slide-center-text">
                        <div class="rsABlock">
                            <div class="container-table">
                                <div class="container-cell">
                                    <h2 class="slider-title small-text-center large-text-center">Полная подготовка тендерной документации</h2>
                                </div>
                            </div>
                        </div>
                        <span class="blue-gradient"></span>
                        <a href="index.jsp"><img src="img/2.jpg" class="rsImg"  alt="Альта и К"></a>
                    </div>

                    <!-- slider -->
                    <div class="rsContent slide-center-text">
                        <div class="rsABlock">
                            <div class="container-table">
                                <div class="container-cell">
                                    <h2 class="slider-title small-text-center large-text-center">Оповещение о интересующих Вас тендерах</h2>
                                </div>
                            </div>
                        </div>
                        <span class="blue-gradient"></span>
                        <a href="index.jsp"><img src="img/4.jpg" class="rsImg"  alt="Партнер"></a>
                    </div>

                    <!-- slider -->
                    <div class="rsContent slide-center-text">
                        <div class="rsABlock">
                            <div class="container-table">
                                <div class="container-cell">
                                    <h2 class="slider-title small-text-center large-text-center">Ежедневное обновление базы тендеров</h2>
                                </div>
                            </div>
                        </div>
                        <span class="blue-gradient"></span>
                        <a href="index.jsp"><img src="img/5.jpg" class="rsImg"  alt="Альта и К"></a>
                    </div>

                </div>
            </header>

            <section class="inner-banner-container-2 ss-white">
                <div class="banner-wrapper-2 small-text-justify medium-text-center small-12 columns">
                    <h1 class="short-search-banner-h1">НАЙТИ ТЕНДЕР</h1>
                </div>

                <div id="search-form" class="row theme-wrapper s-up">
                    <form method="get" action="<c:url value='search.jsp'/>" class="form-tenders-search s-theme">
                        <input type="hidden" name="is" value="yes">
                        <input type="hidden" name="topage" value="1">
                        <div class="s1 row"></div>
                        <div class="s2 s-transparent row">
                            <div class="small-11 columns">
                                <input type="text" name="q" placeholder="Введите наименование или номер закупки" value="<c:if test="${not empty param.q}"><c:out value="${param.q}"/></c:if>" class="input-theme"/>
                                </div>
                                <div class="small-1 columns">
                                    <button type="submit" class="btn btn-theme-green">Поиск</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>
              
                <section class="medium-text-center" style="font-family: serif;">
                    <div class="row">
                        <h2 style="color: tomato">Для всех участников закупок АО «ФНБ «Самрук-Қазына»</h2>
                    </div>
                    <div class="row" style="color: #FFF; font-size: 1.5em; background: url(img/ad.jpg); background-size: cover; height:380px; box-shadow: 0 5px 5px #000; margin-bottom: 10px">
                        <div>
                            В настоящее время большинство закупок АО «ФНБ «Самрук-Қазына» проводятся способами: запрос ценовых предложений с применением торгов на понижение, либо открытый тендер с применением торгов на понижение.
                        </div>
                        <br>
                        <div>
                            Наше, не имеющие аналогов, техническое решение дает возможность за очень короткий промежуток времени перебить цену конкурента. С помощью нашей программы это делается в 3-4 раза быстрее, чем это делает человек.
                        </div>
                        <br>
                        <div>
                            Ваше ценовое предложение практически всегда будет ведущим.
                        </div>
                    </div>
                    <div class="row" style="background-color: #E9ECF1; padding: 10px;">
                        <h4>Принцип работы</h4>
                        <div style="text-align: left">
                            <p>
                                Специально разработанной нами программе задаются исходные данные, № тендера, минимальная цена, шаг понижения: 
                            </p>
                            <ol>
                                <li>
                                    Программа отслеживает ведущее предложение (самое низкое) и как только оно появляется, тут же формирует новое, подписывает его вашим ЭЦП и отправляет. Далее программа продолжает отслеживать котировки. Даже если кто-то перебьет вашу котировку по одному лоту из 20, программа улучшит цену именно на необходимый лот;
                                </li>
                                <li>
                                    Шаг понижения цены задаётся заранее, от 1% до 5%, программа автоматически высчитывает и подает ценовое предложение;
                                </li>
                                <li>
                                    Минимальная цена задаётся заранее, программа не даст предложение ниже, чем ей задали;
                                </li>
                                <li>
                                    Среднее время подачи ЦП нашей программой  20-30 секунд;
                                </li>
                                <li>
                                    Среднее время подачи ЦП человеком – около 3 минут.
                                </li>
                            </ol>
                        </div>
                    </div>
                </section>                

                <section class="service-section ss-white security">
                    <div class="row">
                        <h1 class="section-title padded text-center" data-sr style="visibility: visible;font-family: serif">Компания Альта и К предлагает квалифицированные услуги на рынке тендерных закупок Казахстана.</h1>
                        <h2 class="section-sub-title padded text-center" data-sr style="visibility: visible"></h2>
                        <div class="gray-box-group clearfix" data-equalizer data-sr style="visibility: visible;">
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-2.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Подготовка тендерной документации</h4>
                                <!--                <ul class="text-justify">
                                                    <li>Квалифицированная подготовка и сдача всех необходимых документов</li>
                                                    <li>Получение ЭЦП</li>
                                                    <li>Регистрация на тендерных площадках</li>
                                                </ul>-->
                                <article class="text-left">
                                    <ul class="text-justify">
                                        <li>Квалифицированная подготовка и сдача всех необходимых документов</li>
                                        <li>Получение ЭЦП</li>
                                        <li>Регистрация на тендерных площадках</li>
                                    </ul>
                                </article>
                            </div>
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-1.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Оптимизация затрат и Бизнес-процессов</h4>
                                <article class="text-justify">
                                    <ul class="text-justify">
                                        <li>Качественная и быстрая работа наших сотрудников</li>
                                        <li>Уменьшит Ваши затраты и увеличит отдачу</li>
                                        <li>И поможет открыть для Вас новые возможности.</li>
                                    </ul>
                                </article>
                            </div>
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-3.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Сопутствующие услуги</h4>
                                <article class="text-justify">
                                    <ul class="text-justify">
                                        <li>Юридическое сопровождение</li>
                                        <li>Технико-аналитическое сопровождение</li>
                                        <li>Бухгалтерские услуги</li>
                                    </ul>
                                </article>
                            </div>
                        </div>
                    </div>
                </section>




                <section class="service-section ss-white security">
                    <div class="row">
                        <h1 class="section-title padded text-center" data-sr style="visibility: visible;font-family: serif">Компания Альта и К обладает уникальной информационно-поисковой системой.</h1>
                        <h2 class="section-sub-title padded text-center" data-sr style="visibility: visible"></h2>
                        <div class="gray-box-group clearfix" data-equalizer data-sr style="visibility: visible;">
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-1.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Информационная система</h4>
                                <!--                <ul class="text-justify">
                                                    <li>Быстрый опциональный поиск подходящих тендеров</li>
                                                    <li>Автоматические уведомления о новых тендерах по email и SMS</li>
                                                </ul>-->
                                <p class="text-left">Быстрый опциональный поиск подходящих тендеров.</p>
                                <p class="text-left">Автоматические уведомления о новых тендерах по email и SMS.</p>
                                <p class="text-left">Тендеры Казахстан</p>
                            </div>
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-2.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Аналитика</h4>
                                <article class="text-justify">
                                    <p>Мы предлагаем систему Аналитики нашим клиентам</p>
                                    <ul class="text-center">
                                        <li>По прошедшим тендерам</li>
                                        <li>По ожидаемым тендерам</li>
                                    </ul>
                                </article>
                            </div>
                            <div class="gray-box-single" data-equalizer-watch>
                                <span class="thin-strip gray-box-strip"></span>
                                <img src="img/vas-icon-3.png" alt class="icon">
                                <h4 class="gray-box-header text-center">Автоматизация подачи заявок</h4>
                                <article class="text-justify">
                                    <p>Компания ориентирована на то, чтобы максимально облегчить, ускорить и обезопасить все действия нашего клиента.</p>
                                    <p>Этому служат наши автоматизированные системы, которые приятно удивят Вас.</p>
                                </article>
                            </div>
                        </div>
                        <!--        <a href="https://www.altatender.kz/registry.jsp" class="button flat-top-btn" data-sr style="visibility: visible;">Регистрация</a>-->
                    </div>
                </section>



                <!--<section class="ss-gradient" style="margin-bottom:10rem">
                <div class="section-top clearfix">
                    <div class="section-image show-for-large-up" data-sr style="visibility: visible">
                                <img src="img/ipad-view.png" alt="">
                            </div>
                            <div class="section-titles">
                                <h3 class="section-heading" data-sr style="visibility: visible">ПОЧЕМУ МЫ</h3>
                                <h1 class="section-title dark-padded" data-sr style="visibility: visible">Альта и К - лучший выбор на рынке тендерных закупок Казахстана</h1>
                            </div>
                        </div>
                                <div class="row" data-sr='vFactor 1, wail 5s, scale up 30%' style="visibility: visible; max-width: 80rem; background-color: #efefef">
                                    <div class="small-1 columns">
                                        <img src="img/commerce.gif" class="round-img">
                                    </div>
                                    <div class="small-10 end">
                                        <p class="section-title padded">Решили участвовать в тендере?</p>
                                        <h2 class="section-sub-title padded">Для участия в тендере Вам необходимо иметь ЭЦП, получить регистрацию на тендерных площадках, подать заявку на конкурс или аукцион.</h2>
                                    </div>
                                </div>
                    <br/>
                                <div class="row" data-sr style="visibility: visible; max-width: 80rem; background-color: #efefef">
                                    <div class="small-1 small-offset-2 columns">
                                        <img src="img/gateway.gif" class="round-img">
                                    </div>
                                    <div class="small-8 end">
                                        <h1 class="section-title padded">Ищите подходящую закупку?</h1>
                                        <h2 class="section-sub-title padded">Мы предоставляем уникальную информационную систему с развитой функцией поиска и опциональной системой уведомлений о подходящих тендерах.</h2>
                                    </div>
                                </div>
                    <br/>
                                <div class="row" data-sr style="visibility: visible; max-width: 80rem; background-color: #efefef">
                                    <div class="small-1 small-offset-1 columns">
                                        <img src="img/phonecard.gif" class="round-img">
                                    </div>
                                    <div class="small-9 columns">
                                        <h1 class="section-title padded">Нуждаетесь в подготовке тендерной документации?</h1>
                                        <h2 class="section-sub-title padded">Наша команда профессионалов возьмет на себя полное сопровождение всех процедур, необходимых для участия и победы в тендере.</h2>
                                    </div>
                                </div>
                    <br/>
                                <div class="row" data-sr style="visibility: visible; max-width: 80rem; background-color: #efefef">
                                    <div class="small-1 small-offset-3 columns">
                                        <img src="img/authentication.gif" class="round-img">
                                    </div>
                                    <div class="small-7 columns">
                                        <h1 class="section-title padded">Нуждаетесь в поддержке?</h1>
                                        <h2 class="section-sub-title padded">Мы осуществляем:.</h2>
                                        <ul class="section-sub-title padded">
                                            <li>Юридическую подержку</li>
                                            <li>Техническую поддержку</li>
                                        </ul>
                                    </div>
                                </div>
                    <br/>
                                <div class="row" data-sr style="visibility: visible; max-width: 80rem; background-color: #efefef">
                                    <div class="small-2 columns">
                                        <img src="img/00901.png">
                                    </div>
                                    <div class="small-9 end">
                                        <h1 class="section-title padded">Почему с нами?</h1>
                                        <h2 class="section-sub-title padded">ПРОСТО и КАЧЕСТВЕННО.</h2>
                                    </div>
                                </div>
                            </section>-->


            <%@include file="footer.jsp" %>
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>
        <script src="js/vendor/jquery.fitvids.js"></script>
        <script src='/js/scrollReveal.min.js'></script>
        <script src="js/foundation.min.js"></script>
        <script src="js/foundation/foundation.interchange.js"></script>
        <script src="js/foundation/foundation.equalizer.js"></script>
        <script src="js/foundation-select.js"></script>
        <script type='text/javascript' src='js/comment-reply.min.js'></script>
        <script type="text/javascript" src="js/search2.js"></script>
        <script src="js/classie.js"></script>
        <script src="js/scripts.js"></script>
        <script>
            window.sr = new scrollReveal();
            window.scrollReveal = new scrollReveal({init: false, enter: 'bottom', move: '20px', easing: 'ease-in-out'});
            scrollReveal.init();
        </script>

    </body>
</html>
