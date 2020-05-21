<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<jsp:directive.attribute name="head" required="false" fragment="true"/>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<c:url value="/" var="baseUrl" />
		<c:set value="${fn:length(baseUrl)}" var="baseUrlLen" />
		<c:set var="baseUrl" value="${fn:substring(baseUrl, 0, baseUrlLen - 1)}"/>
		
    	<link rel="stylesheet" type="text/css" media="all" href="${baseUrl}/resources/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" media="all" href="${baseUrl}/resources/style.css"/>
		<jsp:invoke fragment="head"/>
	</head>
	<body>
		<jsp:doBody />
		<script type="text/javascript" src="${baseUrl}/resources/bootstrap.min.js" ></script>
		<script type="text/javascript" src="${baseUrl}/resources/project.js"></script>
	</body>
</html>