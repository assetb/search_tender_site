<%-- 
    Document   : registry
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Properties"%>

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


            <section class="inner-banner-container ss-gradient">
                <div class="banner-wrapper row">
                    <div class="inner-banner small-8 column">
                        <h1>Регистрация</h1>
                    </div>
                    <div class="banner-social-links small-4 column">
                        <!--                        <a href="https://www.facebook.com/AltaTender" class="social-link" target="_blank"><span class="fc-webicon facebook"></span></a>
                                                <a href="https://twitter.com/AltaTender" class="social-link" target="_blank"><span class="fc-webicon twitter"></span></a>
                                                <a href="https://kz.linkedin.com/pub/альта-и-к/103/57a/38b" class="social-link" target="_blank"><span class="fc-webicon linkedin"></span></a>
                                                <a href="https://www.youtube.com/" class="social-link" target="_blank"><span class="fc-webicon youtube"></span></a>
                        -->                   </div>
                </div>
            </section>

            <div id="content" class="inner-page-content row">

                <div id="inner-content" class="medium-22 large-24 column clearfix">

                    <div id="main" class="eightcol first clearfix" role="main">


                        <article id="post-1121" role="article" itemscope itemtype="http://schema.org/BlogPosting" class="inner-page-article">

                            <section class="entry-content clearfix" itemprop="articleBody">
                                <div class='gf_browser_chrome gform_wrapper' id='gform_wrapper_1' >
                                    <%if (null == session.getAttribute("isAuthorized")) {%>
                                    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://88.204.230.204:50505/altatender" user="AltaikDB" password="AcU!ysP14D,B4z" scope="application"/>
                                    <c:choose>
                                        <c:when test="${not empty param.input_3}">
                                            <sql:query var="selectusers1" dataSource="${db}">
                                                SELECT email,password FROM users WHERE email = ? and password = ?
                                                <sql:param value="${param.input_3}"/>
                                                <sql:param value="${param.input_4}"/>
                                            </sql:query>
                                            <c:choose>
                                                <c:when test="${selectusers1.rowCount == 0}">
                                                    <sql:update dataSource="${db}" var="updateusers">
                                                        INSERT INTO users (email,password) VALUES (?,?)
                                                        <sql:param value="${param.input_3}"/>
                                                        <sql:param value="${param.input_4}"/>
                                                    </sql:update>
                                                    <sql:query var="selectusers" dataSource="${db}">
                                                        SELECT id FROM users WHERE email = ? and password = ?
                                                        <sql:param value="${param.input_3}"/>
                                                        <sql:param value="${param.input_4}"/>
                                                    </sql:query>
                                                    <c:forEach var="row" items="${selectusers.rows}">
                                                        <c:set var="userid" value="${row.id}"/>
                                                    </c:forEach>

                                                    <c:set var="now" value="<%=new java.util.Date()%>"/>
                                                    <fmt:formatDate var="year" value="${now}" pattern="yyyy" />
                                                    <fmt:formatDate var="month" value="${now}" pattern="MM" />
                                                    <fmt:formatDate var="day" value="${now}" pattern="dd" />

                                                    <sql:update dataSource="${db}" var="updatecustomer">
                                                        INSERT INTO customer (userid,runame,tel,firstname,lastname,regdate) VALUES (?,?,?,?,?,'${day}.${month}.${year}')
                                                        <sql:param value="${userid}"/>
                                                        <sql:param value="${param.input_1}"/>
                                                        <sql:param value="${param.input_5}"/>
                                                        <sql:param value="${param.input_2}"/>
                                                        <sql:param value="${param.input_6}"/>
                                                    </sql:update>

                                                    <p>Спасибо за регистрацию.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>Пользователь с таким email и паролем уже существует.</p>
                                                </c:otherwise>
                                            </c:choose>
                                            <%
//                                                session.setAttribute("email", request.getParameter("input_3"));
//                                                session.setAttribute("password", request.getParameter("input_4"));
//                                                session.setAttribute("isAuthorized", "true");
                                            %>
                                        </c:when>
                                        <c:otherwise>
                                            <jsp:include page="registryform.jsp"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <%} else {%>
                                    <p>Передите в личный кабинет чтобы настроить рассылку.</p>
                                    <%
                                        session.setAttribute("email", request.getParameter("input_3"));
                                        session.setAttribute("password", request.getParameter("input_4"));
                                        session.setAttribute("isAuthorized", "true");
                                    %>
                                    <c:redirect url="index.jsp"/>
                                    <%}%>
                                </div>
                                <p>&nbsp;</p>
                            </section> <!-- end article section -->

                        </article> <!-- end article -->


                    </div> <!-- end #main -->

                </div> <!-- end #inner-content -->
                <aside class="side-bar medium-12 medium-offset-1 large-10 large-offset-1 column">
                    <h2>Описание</h2>
                    <!--                    <ul>
                                            <li><a href="https://www.goswiff.com/all/south-east-asia-smartphone-adoption-growth-continues/">South East Asia smartphone adoption growth continues</a></li>
                                            <li><a href="https://www.goswiff.com/all/3-common-misconceptions-about-mcommerce/">3 common misconceptions about mCommerce</a></li>
                                            <li><a href="https://www.goswiff.com/all/why-offer-an-mpos-solution-to-merchants/">Why offer an mPOS solution to merchants?</a></li>
                                            <li><a href="https://www.goswiff.com/all/goswiff-wins-innotribe-startup-challenge-in-singapore/">goSwiff wins Innotribe Startup Challenge in Singapore</a></li>
                                            <li><a href="https://www.goswiff.com/all/apac-middle-east-and-africa-lead-for-mcommerce/">APAC, Middle East and Africa lead for mCommerce</a></li>
                                        </ul>-->
                </aside>

            </div> <!-- end #content -->
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


        <!--        <script type='text/javascript' src='js/comment-reply.min.js'></script>
                <script>
                    window.scrollReveal = new scrollReveal({init: false, enter: 'bottom', move: '20px', easing: 'ease-in-out' });
                    scrollReveal.init();
                </script>-->
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>