<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/foundation.css" />
<!--<link rel="stylesheet" href="css/fc-webicons.css">-->
<section class="cta-section">
    <div class="row">
        <h1 class="section-title text-center">Будьте с нами на связи</h1>
    </div>
</section>
<section class="icons-section">
    <div class="row">
        <div class="icons-column socials">
            <div class="container-table">
                <div class="container-cell">

                    <a href="https://www.facebook.com/AltaTender" class="social-link"><span class="social_facebook_circle"></span></a>
                    <a href="https://twitter.com/AltaTender" class="social-link" target="_blank"><span class="social_twitter_circle"></span></a>
                    <a href="https://kz.linkedin.com/in/altatender" class="social-link" target="_blank"><span class="social_linkedin_circle"></span></a>
                    <a href="https://www.youtube.com/channel/UCGZe1u-KvqM8UuWuwNXBmfQ" class="social-link" target="_blank"><span class="social_youtube_circle"></span></a>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="cta-section">
    <div class="row">
        <iframe src="https://www.google.com/maps/d/embed?mid=zvs2j_splhmg.k91zYyeVNtdQ&zoom=10" height="300" frameborder="0" style="border:0;width: 100%" allowfullscreen></iframe>
    </div>

</section>
<footer class="clearfix hide-for-small">
    <div class="row">
        <div class="footer-column">
            <h5 class="footer-heading"><a href="search.jsp">Тендер</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="about.jsp">О компании</a></h5>
        </div>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="services.jsp">Услуги</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <%if (null != session.getAttribute("isAuthorized")) {%>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="cabinet2.jsp">Личный кабинет</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="logout.jsp">Выход</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <%} else {%>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="registry.jsp">Регистрация</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <div class="footer-column">
            <h5 class="footer-heading"><a href="logon.jsp">Вход</a></h5>
            <ul class="footer-links">
            </ul>
        </div>
        <%}%>
    </div>
</footer>
