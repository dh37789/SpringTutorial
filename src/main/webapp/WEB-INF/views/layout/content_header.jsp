<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div class="page-title-breadcrumb">
	<ol class="breadcrumb">
		<li><i class="fa fa-home"></i>&nbsp;<a href="/user/noticeboard/noticeBoardList.do?currentPage=1&search_keyword=&search_keycode=">Home</a>&nbsp;&nbsp;</li>
		<c:if test="${fn:containsIgnoreCase(requestScope['javax.servlet.forward.request_uri'] , 'free')}">
			<li><a href="${pageContext.request.contextPath}/freeboard/freeboardList.do?currentPage=1&search_keyword=&search_keycode="><i class="fa fa-angle-right"></i>&nbsp;&nbsp;자유게시판</a></li>
		</c:if>
		<c:if test="${fn:containsIgnoreCase(requestScope['javax.servlet.forward.request_uri'] , 'notice')}">
			<li><a href="/user/noticeboard/noticeBoardList.do?currentPage=1&search_keyword=&search_keycode="><i class="fa fa-angle-right"></i>&nbsp;&nbsp;공지사항</a></li>
		</c:if>
		<c:if test="${fn:containsIgnoreCase(requestScope['javax.servlet.forward.request_uri'] , 'res')}">
			<li><a href="/user/resboard/resboardList.do?currentPage=1&search_keyword=&search_keycode="><i class="fa fa-angle-right"></i>&nbsp;&nbsp;자료실</a></li>
		</c:if>
		<c:if test="${fn:containsIgnoreCase(requestScope['javax.servlet.forward.request_uri'] , 'qna')}">
			<li><a href="/user/qnaboard/qnaList.do?currentPage=1&search_keyword=&search_keycode="><i class="fa fa-angle-right"></i>&nbsp;&nbsp;Q&A게시판</a></li>
		</c:if>
		
<!-- 		<li class="active">목록</li> -->
	</ol>
	<div class="clearfix"></div>
</div>
</body>
</html>