<%-- 
    Document   : table
    Created on : 06.09.2016, 15:40:57
    Author     : admin
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="h" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="count"%>
<%@attribute name="urlpage"%>

<%-- any content can be specified here e.g.: --%>
<div class="row ad-block">
    <div id="ajaxinfo"></div>
    <div id="moreInfo" class="reveal-modal" data-reveal></div>
    <h:enumpages countpages="${count}" urlpage="${urlpage}"/>
    <jsp:doBody/>
    <h:enumpages countpages="${count}" urlpage="${urlpage}"/>
</div>