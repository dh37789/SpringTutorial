<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	   $('form.eq(1)').submit(function(){
	      var flag = true;
	      $('input[type=file]:gt(1)').each(function(idx,itag){
	         if(!/\.(jpg|jpeg|gif|png)$/.test(itag).val().toLowerCase()){
	            alert("이미지 파일만 업로드 가능합니다");
	            flag = false;
	         }
	      })
	      return flag;
	   })   
	})
</script>
</head>
<body>
<!-- 
	브라우저의 보안정책 : 브라우저는 클라이언트 시스템의 파일 시스템 내 존재하는 파일을 대상으로 추가, 수정, 삭제가 불가능
	파일 업로드 규칙 : 파일 업로드 가능한 자원 - <form> or $.ajax()
				 <form method="GET" enctype="multipart/form-data">
	파일전송은 반드시 POST방식으로 전송
 -->
<form action="${pageContext.request.contextPath }/file/fileUpload.do"
	  enctype="multipart/form-data"
	  method="post">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="mem_id" /></td>
		</tr>
		<tr>
			<td>성명</td>
			<td><input type="text" name="mem_name" /></td>
		</tr>
		<tr>
			<td>파일1</td>
			<td><input type="file" name="files"/></td>
		</tr>
		<tr>
			<td>파일2</td>
			<td><input type="file" name="files"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="파일전송" /></td>
		</tr>
	</table>
</form>
<!-- 팀프떄는 seq를 통해서 VO를 가져온다. -->
<img src="/files/${param.fileName }" alt="" width="200" height="150"
	onclick="javascript:location.href='${pageContext.request.contextPath}/file/fileDownload.do?fileName=${param.fileName }';" />
</body>
</html>