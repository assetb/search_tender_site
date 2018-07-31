<%-- 
    Document   : templatePage
    Created on : 26.09.2016, 9:47:42
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/defaults" prefix="def" %>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%-- any content can be specified here e.g.: --%>
<def:menu/>
<div class="fixed">
    <def:mainnav/>
</div>
<div class="off-canvas-wrap move-right" data-offcanvas>
    <jsp:doBody/>
</div>
    <script src="<c:url value="/js/vendor/jquery.js"/>"></script>
<script language="javascript" type="text/javascript" src="<c:url value="../../../js/actb.js"/>"></script><!-- External script -->
<script language="javascript" type="text/javascript" src="<c:url value="../../../js/tablefilter.js"/>"></script>
<script src="<c:url value="/js/vendor/fastclick.js"/>"></script>
<script src="<c:url value="/js/foundation.min.js"/>"></script>
<!--<script src="<c:url value="/js/foundation/foundation.js"/>"></script>-->
<script src="<c:url value="/js/foundation/foundation.offcanvas.js"/>"></script>
<script src="<c:url value="/js/foundation/foundation.abide.js"/>"></script>
<script language="javascript" type="text/javascript">
    //<![CDATA[
    setFilterGrid("clientstable");
    //]]>
</script>
<script>
    $("#clear").click(function () {
        //    $("#insert").text("");
        $('#form_profile')[0].reset();
        $("form div").removeClass("error");
        $("form label").removeClass("error");
        $('#addPopup').foundation("reveal", "close");
    });
</script>
<script>
    $(document).foundation();

    function sideNav() {
        if ($(window).width() < 769) {
            $('.off-canvas-wrap').removeClass('move-right');
            $('.left-off-canvas-toggle').show();
        } else {
            $('.off-canvas-wrap').addClass('move-right');
            $('.left-off-canvas-toggle').hide();
        }
    }

    $(window).resize(function () {
        sideNav();
    });
    var moreinfo = $("table#table a[name][source]");
    moreinfo.click(function (event) {
        var el = $(event.target);
        $("div#moreInfo").foundation('reveal', 'open', {
            url: "<c:url value="/moreinfo.jsp"/>",
            data: {source: el.attr("source"), name: el.attr("name"), value: el.attr("value")}
        });
    });

    var updateStatus = $("select[name=\"updatestatus\"]").change(function (event) {
        var el = $(event.target);
        var typeReq = el.attr("name");
        var cusId = el.parent("td").parent("tr").attr("id");
        var statusId = el.children("option:selected").attr("id");
        $.ajax({
            type: "POST",
            url: "<c:url value="/moreinfo.jsp"/>",
            data: {type: typeReq, id: cusId, status: statusId}
        }).done(function (responce) {
            alert("OK");
        });
    });

</script>
