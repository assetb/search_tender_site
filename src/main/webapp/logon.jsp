<%-- 
    Document   : registry
    Created on : 21.07.2015, 7:57:42
    Author     : Aset
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
                    <!--                    <div class="inner-banner small-text-center medium-text-left small-35 large-24 col-xs-9">-->
                    <div class="inner-banner small-8 column">
                        <h1>Вход</h1>
                    </div>
                    <!--                    <div class="banner-social-links show-for-large-up large-10 large-offset-1 col-xs-3">-->
                    <div class="banner-social-links small-4 column">
                        <!--                        <a href="https://www.facebook.com/asetbn" class="social-link" target="_blank"><span class="icon-facebook2"></span></a>
                                                <a href="https://twitter.com/asetbarakbayev" class="social-link" target="_blank"><span class="icon-twitter"></span></a>
                                                <a href="https://www.linkedin.com/profile/view?id=359341502&trk=hp-identity-name" class="social-link" target="_blank"><span class="icon-linkedin"></span></a>
                                                <a href="https://www.youtube.com/channel/UCgmosGiGRxaxkj_CRdK5z5Q" class="social-link" target="_blank"><span class="icon-youtube"></span></a>-->
                        <!--                   <a href="https://www.facebook.com/AltaTender" class="social-link" target="_blank"><span class="fc-webicon facebook"></span></a>
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
                                        <c:when test="${not empty param.input_3 and not empty param.input_4}">
                                            <sql:query var="selectresult" dataSource="${db}">
                                                SELECT id,role,email,password FROM users WHERE email = ? and password = ?
                                                <sql:param value="${param.input_3}"/>
                                                <sql:param value="${param.input_4}"/>
                                            </sql:query>
                                            <c:forEach var="row" items="${selectresult.rows}">
                                                <c:set var="userid" value="${row.id}" scope="session"/>
                                                <c:set var="roleid" value="${row.role}" scope="session"/>

                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${selectresult.rowCount == 0}">
                                                    <p>Пользователь не найден. Введите повторно.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>Вы уже на сайте.</p>
                                                    <%
                                                        HttpSession Session = request.getSession();
                                                        Session.setAttribute("email", request.getParameter("input_3"));
                                                        Session.setAttribute("password", request.getParameter("input_4"));
//                                                        session.setAttribute("userid", request.getParameter("row.id"));
//                                                        session.setAttribute("roleid", request.getParameter("row.role"));

                                                        Session.setAttribute("isAuthorized", "true");
                                                        //response.sendRedirect("index.jsp");
                                                        request.getRequestDispatcher("index.jsp").forward(request, response);
                                                    %>
                                                    <!--c:redirect url="index.jsp"/-->
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                    <%} else {%>
                                    <%}%>
                                    <jsp:include page="logonform.jsp"/>
                                </div>
                                <p>&nbsp;</p>
                            </section> <!-- end article section -->

                        </article> <!-- end article -->


                    </div> <!-- end #main -->

                </div> <!-- end #inner-content -->
                <aside class="side-bar medium-12 medium-offset-1 large-10 large-offset-1 column">
                    <h2>Описание</h2>
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


        <script type='text/javascript' src='js/comment-reply.min.js'></script>
        <script>
            window.scrollReveal = new scrollReveal({init: false, enter: 'bottom', move: '20px', easing: 'ease-in-out'});
            scrollReveal.init();
        </script>
        <jsp:include page="utilities/googleadservice.jspf"/>
    </body>
</html>