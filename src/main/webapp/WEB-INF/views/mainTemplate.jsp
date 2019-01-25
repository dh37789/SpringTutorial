<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<script src="${pageContext.request.contextPath }/script/jquery-1.8.3.js"></script>
<script type="text/javascript">
$(function(){
	if (eval('${not empty message}')) {
		BootstrapDialog.show({
			title: '안내',
			message: '${message }'
		});
		return;
	}
});
</script>
<c:remove var="message" scope="request"/>
</head>
<body>
<tiles:insertAttribute name="header"></tiles:insertAttribute>
<%-- <jsp:include page="/WEB-INF/views/user/layout/header.jsp"></jsp:include> --%>
<div id="wrapper">
	<tiles:insertAttribute name="left"></tiles:insertAttribute>
<%-- 	<jsp:include page="/WEB-INF/views/user/layout/left.jsp"></jsp:include> --%>
	<div id="page-wrapper">
	<tiles:insertAttribute name="content_header"></tiles:insertAttribute>
<%-- 		<jsp:include page="/WEB-INF/views/user/content_header.jsp"></jsp:include> --%>
		<div class="page-content">
		<tiles:insertAttribute name="content"></tiles:insertAttribute>
<%-- 			<jsp:include page="${empty contentPage ? '/WEB-INF/views/user/freeboard/freeboardList.jsp' : contentPage}"></jsp:include> --%>
		</div>
		<tiles:insertAttribute name="footer"></tiles:insertAttribute>
<%-- 		<jsp:include page="/WEB-INF/views/user/layout/footer.jsp"></jsp:include> --%>
	</div>
</div>
</body>
</html>