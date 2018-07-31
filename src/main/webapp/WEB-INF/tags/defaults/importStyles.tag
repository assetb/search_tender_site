<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="<c:url value="/css/normalize.css"/>">
<link rel="stylesheet" href="<c:url value="/css/foundation.min.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/foundation.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/filtergrid.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/cabinet.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/style.css"/>" />
<style type="text/css">
    body { padding-top: 140px; }
    @media screen and (max-width: 768px) {
        body { padding-top: 0px; }
    }
</style>
<script src="<c:url value="/js/vendor/modernizr.js"/>"></script>
<jsp:doBody/>
