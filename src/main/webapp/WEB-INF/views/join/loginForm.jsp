<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css" type="text/css">
<title>
<spring:message code="cop.administrator.loginForm"></spring:message>
</title>
<script type="text/javascript" src='http://code.jquery.com/jquery-latest.js'></script>
<!-- 
	javascript RSA 암호화 환경
	1. http://www-cs-students.stanford.edu/~tjw/jsbn
	2. jsbn.js, rsa.js, prng4.js, rng.js
	(순서 중요!!)
 -->
<script type="text/javascript">
//	javascript   인코딩      /   디코딩
//	   escape		     / unescape() : 유니코드 형식의 인코딩 또는 디코딩
//								   URL 표현시 기호(: / ? etc)를 사용
//	   encodeURI()	     / decodeURI() : 유니코드 형식의 인코딩 또는 디코딩
// 									URL 표현시 기호(: / ? etc)
//	 encodeURIComponent()/decodeURIComponent() 유니코드 형식의 니코딩 또는 디코딩
//											     단순 문자열 처리
	$(function(){
		if (eval('${not empty param.message }')) {
			alert('${param.message }');
		}
		$('.loginBtn').click(function(){
			$frm = $('<form action="${pageContext.request.contextPath }/join/loginCheck.do" method="post"></form>');
			$frm.append('<input type="hidden" name="mem_id" value="' + $('input[name=mem_id]').val() +'"/>');
			$frm.append('<input type="hidden" name="mem_pass" value="' + $('input[name=mem_pass]').val() +'"/>');
			$frm.append('<input type="hidden" name="mem_pass" value="b001"/>');
			$(document.body).append($frm);
			$frm.submit();
		})
	})
</script>
</head>
<body>
<!-- http://localhost/StrutsToddler/join/loginForm.do -->
<!-- <form name="loginForm" action="/ddit/03/main.jsp" method="post"> -->
	<table width="770" border="0" align="center" cellpadding="0"
		cellspacing="0" style="margin: 90px;">
		<tr>
			<td height="150" align="center"><img src="${pageContext.request.contextPath }/image/p_login.gif" /></td>
		</tr>
		<tr>
			<td height="174"
				style="background: url(${pageContext.request.contextPath }/image/login_bg.jpg); border: 1px solid #e3e3e3;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="260" height="110" align="center"
							style="border-right: 1px dotted #736357;">
							<img src="${pageContext.request.contextPath }/image/logo.jpg" />
						</td>
						<td>
							<table border="0" align="center" cellpadding="5"
								cellspacing="0">
								<tr>
								
									<td><b><spring:message code="cop.menu.id"></spring:message> </b></td>
									<td><input type="text" name="mem_id" class="box" tabindex="3" height="18" /></td>
									<td rowspan="2">
<%-- 										<input type="IMAGE" src="${pageContext.request.contextPath }/image/login.gif" name='submit' class="loginBtn"/> --%>
										<img src="${pageContext.request.contextPath }/image/login.gif" class="loginBtn"/>
									</td>
								</tr>
								<tr>
									<td><b><spring:message code="cop.password"></spring:message></b></td>
									<td><input type="password" name="mem_pass" class="box" tabindex="3" height="18" /></td>
								</tr>
								<tr>
									<td colspan="3" align="right">
									<spring:message code="cop.menu.id.save"></spring:message> : <input type="checkbox" name="saveID" />
									<a href="${pageContext.request.contextPath }/member/memberForm.do"></a></td>
									<spring:message code="cop.menu.member.joining"></spring:message>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!-- </form> -->
</body>
</html>
