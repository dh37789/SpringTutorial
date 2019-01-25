<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
// $(function(){
// 	$('li').click(function(){
// 		$(this).
// 	});
// });
</script>
<style type="text/css">
a:hover{
	backgroud : pink;
}
</style>
</head>
<body>
<!--BEGIN SIDEBAR MENU-->
<nav id="sidebar" role="navigation" data-step="2"
	data-intro="Template has &lt;b&gt;many navigation styles&lt;/b&gt;"
	data-position="right" class="navbar-default navbar-static-side">
	<div class="sidebar-collapse menu-scroll">
		<ul id="side-menu" class="nav">
			<div></div>
			<li>
				<a onMouseOver="this.style.backgroundColor='#99004d'"
					onMouseOut="this.style.backgroundColor='transparent'"	href="/user/noticeboard/noticeBoardList.do?currentPage=1&search_keyword=&search_keycode=">
					<i class="fa fa-tachometer fa-fw"><div class="icon-bg bg-orange"></div></i>
		
					<span class="menu-title">공지사항</span>
				</a>
			</li>
			<li>
				<a onMouseOver="this.style.backgroundColor='#008000'"
					onMouseOut="this.style.backgroundColor='transparent'" 
				href="${pageContext.request.contextPath}/freeboard/freeboardList.do?currentPage=1&search_keyword=&search_keycode=">
					<i class="fa fa-desktop fa-fw"><div class="icon-bg bg-pink"></div></i>
					<span class="menu-title">자유게시판</span>
				</a>
			</li>
			<li>
				<a onMouseOver="this.style.backgroundColor='#e68a00'"
					onMouseOut="this.style.backgroundColor='transparent'"
				href="/user/resboard/resboardList.do?currentPage=1&search_keyword=&search_keycode=">
					<i class="fa fa-send-o fa-fw"><div class="icon-bg bg-green"></div></i>
					<span class="menu-title">자료실</span>
				</a>
			</li>
			<li>
				<a onMouseOver="this.style.backgroundColor='#5900b3'"
					onMouseOut="this.style.backgroundColor='transparent'"
				
				href="/user/qnaboard/qnaList.do?currentPage=1&search_keyword=&search_keycode=">
					<i class="fa fa-edit fa-fw"><div class="icon-bg bg-violet"></div></i>
					<span class="menu-title">Q&A게시판</span>
				</a>
			</li>
		</ul>
	</div>
</nav>
</body>
</html>