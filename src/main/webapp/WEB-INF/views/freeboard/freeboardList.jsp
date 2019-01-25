<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 목록</title>
</head>
<script type='text/javascript'>
	$(function(){
		$('table tr:gt(0)').click(function(){
			var rnum = $(this).find('td:eq(0)').text();
			var bo_no = $(this).find('td:eq(0) input').val();
			var bo_status = $(this).find('td:eq(1) input').val();
			
		
			if(bo_status == 'n'){
				BootstrapDialog.show({
				    title: '실패',
				    message: '삭제된 게시글입니다!'
				});
				return;
			}
			if (bo_no == null) {
				return;
			}	
			$(location).attr('href',
				'${pageContext.request.contextPath}/freeboard/freeboardView.do?bo_no='
						+ bo_no + '&rnum=' + rnum);
			});

		$('#insertBoard').click(function() {
			$(location).attr('href',
				'${pageContext.request.contextPath}/freeboard/freeboardForm.do');
		});
	});
	
	
</script>
<body>
<div id="freeboardList_content">
	<div class="panel panel-green">
    	<div class="panel-heading">자유게시판 목록</div>
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th scope="col" width="5%" style="text-align:center">No</th>
					<th scope="col" width="65%" style="text-align:center">제목</th>
					<th scope="col" width="10%" style="text-align:center">작성자</th>
					<th scope="col" width="10%" style="text-align:center">작성일</th>
					<th scope="col" width="10%" style="text-align:center">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(boardList) eq 0 }">
               <tr id="notfound" ><td colspan="5" style="text-align:center">게시물이 존재하지 않습니다.</td></tr>
            </c:if>
				<c:forEach items="${boardList }" var="board">
				<tr>
					<td style="text-align:center"><input type="hidden" name="bo_no" value="${board.bo_no }"/>${board.rnum }</td>
					<td align="left"><input type="hidden" value="${board.bo_status }"/>
						<c:forEach begin="1" end="${board.bo_depth }" varStatus="stat">
							&nbsp;&nbsp;&nbsp;
							<c:if test="${stat.last }">
							↳
							</c:if>
						</c:forEach>
						<c:if test="${board.bo_status eq 'y' }">
						${board.bo_title}
						</c:if>
						<c:if test="${board.bo_status eq 'n' }">
					<font color="#cc0000">삭제된 게시물 입니다.</font>
						</c:if>
					</td>
					<c:if test="${board.bo_status eq 'y' }">
					<td style="text-align:center">${board.bo_nickname }</td>
					<td style="text-align:center">${fn:substring(board.bo_reg_date, 0, 10) }</td>
					<td style="text-align:center">${board.bo_hit }</td>
					</c:if>
					<c:if test="${board.bo_status eq 'n' }">
					<td></td>
					<td></td>
					<td></td>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		${htmlPage }
	</div>
</div>
<div >
<form action="${pageContext.request.contextPath }/freeboard/freeboardList.do" method="post" class="form-inline pull-right">
		<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
		<select class="form-control" name="search_keycode" >
			<option value="TOTAL">전체</option>
			<option value="TITLE">제목</option>
			<option value="CONTENT">내용</option>
			<option value="WRITER">작성자</option>
		</select>
		<input type="hidden" name="currentPage" value="1">
	    <button type="submit" class="btn btn-primary form-control">검색</button>
	    <button type="button" class="btn btn-info form-control" id="insertBoard">게시글 등록</button>
</form>
</div>	
</body>
</html>