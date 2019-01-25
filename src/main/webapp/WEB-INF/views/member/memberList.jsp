<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='http://code.jquery.com/jquery-latest.js'></script>
<script type="text/javascript">
   $(function(){
      $('tr:gt(0)').click(function(){
         var mem_id = $(this).find('td:eq(0)').text();
         location.href = '${pageContext.request.contextPath }/member/memberView.do?mem_id='+ mem_id;
      })
   })
</script>
</head>
<body>
<div id="list">
   <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" style="width: 100%;">
      <thead>
         <tr>
            <th class="mdl-data-table__cell--non-numeric">아이디</th>
            <th class="mdl-data-table__cell--non-numeric">패스워드</th>
            <th class="mdl-data-table__cell--non-numeric">이름</th>
            <th class="mdl-data-table__cell--non-numeric">주민번호1</th>
            <th class="mdl-data-table__cell--non-numeric">주민번호2</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach var="memberInfo" items="${memberList }">
         <tr>
            <td class="mdl-data-table__cell--non-numeric">${memberInfo.mem_id }</td>
            <td class="mdl-data-table__cell--non-numeric">${memberInfo.mem_pass }</td>
            <td class="mdl-data-table__cell--non-numeric">${memberInfo.mem_name }</td>
            <td class="mdl-data-table__cell--non-numeric">${memberInfo.mem_regno1 }</td>
            <td class="mdl-data-table__cell--non-numeric">${memberInfo.mem_regno2 }</td>
         </tr>
      </c:forEach>
      </tbody>
   </table>
</div>
<div class="searchForm" align="right" style="margin-top: 10px;">
   <form method="post" action="${pageContext.request.contextPath }/03/main.jsp">
      <select name="search_keycode">
         <option value="ALL">전체</option>
         <option value="ID">아이디</option>
         <option value="NAME">이름</option>
      </select>
      <input type="text" id="search_keyword" name="search_keyword">
      <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent" type="submit">검색</button>
      <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent" type="button">글쓰기</button>
   </form>
</div>
</body>
</html>
