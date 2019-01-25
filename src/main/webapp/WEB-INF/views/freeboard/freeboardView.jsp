<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--==============================================================
 * 자유게시판 View 구성
 * @author 오명학
 * @since  2019.01.15.
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 *    수정일              수정자            수정내용
 *    -----------  -------     -------------------
 *    2019.01.15.  오명학            최초작성
 * Copyright (c) 2019 by DDIT  All right reserved
 * </pre>
===============================================================--%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 정보</title>
<!-- 이미지 슬라이드 사이즈 조정 -->
<style type="text/css">
.carousel{
	width:200px;
    height:150px;
    margin-left: 200px;
}
.carousel-inner > .item > img{
    width:200px;
    height:150px;
}       
</style>
<script>
$(function(){
	// 섬머노트를 div를 활용한 textarea에 추가.
	// http://summernote.org 활용
    $('#bo_content').summernote({
			height: 150,
			codemirror: {
			theme: 'monokai'
		}
    });
    $('#bo_title').val('${boardInfo[0].BO_TITLE}');
    $('#bo_nickname').val('${boardInfo[0].BO_NICKNAME}');
    $('#bo_mail').val('${boardInfo[0].BO_MAIL}');
    $('#bo_content').summernote('code', '${boardInfo[0].BO_CONTENT}');
    // 목록
    $('#addBoard').click(function(){
    	$(location).attr('href',
		'${pageContext.request.contextPath}/freeboard/freeboardForm.do');
    });
    $('#boardList').click(function(){
    	location.href = "${pageContext.request.contextPath}/freeboard/freeboardList.do";
    });
    
    $('#replyForm').click(function(){
    	var bo_title = encodeURIComponent('${boardInfo[0].BO_TITLE}');
    	var params = '?bo_group=${boardInfo[0].BO_GROUP}&bo_seq=${boardInfo[0].BO_SEQ}&bo_depth=${boardInfo[0].BO_DEPTH}'
    					+ '&rnum=${rnum}&bo_writer=${boardInfo[0].BO_WRITER}&bo_title=' + bo_title ;
    	$(location).attr('href','${pageContext.request.contextPath }/freeboard/freeboardReplyForm.do'+params);
    })
    $('#boardEdit').click(function(){
    	$('input[name=bo_content]').val($('#bo_content').summernote('code'));
    	if('${LOGIN_MEMBERINFO.mem_id}' != '${boardInfo[0].BO_WRITER}'){
    		BootstrapDialog.show({
    		    title: '수정 불가',
    		    message: '${LOGIN_MEMBERINFO.mem_name}님은 수정할 권한이 없습니다!'
    		});
    		return;
    	}
    	if(!$('#bo_title').val().regexANY()){
    		BootstrapDialog.show({
    		    title: '입력오류',
    		    message: '제목을 입력해주세요!'
    		});
    		return;
    	}
    	if(!$('#bo_nickname').val().regexANY()){
    		BootstrapDialog.show({
    		    title: '입력오류',
    		    message: '대화명을 입력해주세요!'
    		});
    		return;
    	}
    	
    	if(!$('#bo_pwd').val()){
    		BootstrapDialog.show({
    		    title: '입력 오류',
    		    message: '비밀번호를 입력하세요!'
    		});
    		return;
    	}
    	
    	if(!$('#bo_mail').val().regexMAIL()){
    		BootstrapDialog.show({
    		    title: '입력 오류',
    		    message: '메일을 바르게 입력하세요!'
    		});
    		return;
    	}
    	
    	var board = $('#bo_content').summernote('code');
    	if (board=='<p>&nbsp;</p>') {
    		BootstrapDialog.show({
		 	    title: '입력 오류',
		 	    message: '본문을 입력해 주세요!'
		 	});
			return;
		}
    	
    	if($('#bo_pwd').val() != '${boardInfo[0].BO_PWD}'){
    		BootstrapDialog.show({
    		    title: '비밀번호 오류',
    		    message: '비밀번호가 틀렸습니다!'
    		});
    		return;
    	}
    	$('form').append('<input type="hidden" name="bo_content" value="">');
    	$('input[name=bo_content]').val(board);
    	$('form').append('<input type="hidden" name="bo_no" value="${boardInfo[0].BO_NO}">');
    	$('form').append('<input type="hidden" name="bo_writer" value="${boardInfo[0].BO_WRITER}">');
    	BootstrapDialog.show({
            message: '${LOGIN_MEMBERINFO.mem_name}님!! 수정하시겠습니까??',
            buttons: [{
                label: '확인',
                cssClass: 'btn-primary',
                action: function(){
                	$('form').submit();
                }
            }, {
                label: '취소',
                cssClass: 'btn-warning',
                action: function(dialogItself){
                    dialogItself.close();
                }
            }]
        });
    	return;
    });
    // 삭제
    $('#boardDelete').click(function(){
    	var bo_no = '${boardInfo[0].BO_NO}';
    	if('${LOGIN_MEMBERINFO.mem_id}' != '${boardInfo[0].BO_WRITER}'){
    		BootstrapDialog.show({
    		    title: '삭제 불가',
    		    message: '${LOGIN_MEMBERINFO.mem_name}님은 삭제할 권한이 없습니다!'
    		});
    		return;
    	}
    	
    	if(!$('#bo_pwd').val()){
    		BootstrapDialog.show({
    		    title: '비밀번호 오류',
    		    message: '비밀번호를 입력하세요!'
    		});
    		return;
    	}
    	
    	if($('#bo_pwd').val() != '${boardInfo[0].BO_PWD}'){
    		BootstrapDialog.show({
    		    title: '비밀번호 오류',
    		    message: '비밀번호가 틀렸습니다!'
    		});
    		return;
    	}
    	
    	//if(bo_)
    	if($('#bo_pwd').val() == '${boardInfo[0].BO_PWD}'){
	    	BootstrapDialog.show({
		        message: '${boardInfo[0].BO_TITLE}을(를) 정말 삭제하시겠습니까..??',
		        buttons: [
		          {
		            label: '삭제',
		            cssClass: 'btn-primary',
		            action: function(){
// 						$(location).attr('href', 
// 						'${pageContext.request.contextPath}/freeboard/deleteFreeboardInfo.do' +
// 						'?bo_no=${boardInfo[0].BO_NO}&bo_group=${boardInfo[0].BO_GROUP}&bo_seq=${boardInfo[0].BO_SEQ}');
						$(location).attr('href', 
						'${pageContext.request.contextPath}/freeboard/deleteFreeboardInfo.do?bo_no=${boardInfo[0].BO_NO}');
		            }
		        }, {
		            label: '취소',
		            action: function(dialogItself){
		                dialogItself.close();
		            }
		        }]
		    });
      	}
    });
    
});
</script>
</head>
<body>
<form class="form-horizontal" role="form" action="${pageContext.request.contextPath }/freeboard/updateFreeboard.do" method="post">
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_title">제목:</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="bo_title" name="bo_title" >
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_nickname">작성자 대화명:</label>
		<div class="col-sm-10"> 
			<input type="text" class="form-control" id="bo_nickname" name="bo_nickname" >
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_pwd">패스워드:</label>
		<div class="col-sm-10"> 
			<input type="password" class="form-control" id="bo_pwd" name="bo_pwd" >
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_mail">메일:</label>
		<div class="col-sm-10"> 
			<input type="text" class="form-control" id="bo_mail" name="bo_mail" >
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_content">내용:</label>
		<div class="col-sm-10"> 
			<div id="bo_content"><p></p></div>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_content">첨부파일:</label>
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
			<c:if test="${fn:length(boardInfo) eq 2 }">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
			</c:if>
			</ol>
			<div class="carousel-inner" role="listbox" style="height: 200px;">
			<!-- Wrapper for slides -->
			<c:if test="${not empty boardInfo[0].FILE_SAVE_NAME}">
			<c:forEach items="${boardInfo }" var="fileItemInfo" varStatus="stat">
				<c:if test="${stat.index eq 0 }">
					<div class="item active">
				</c:if>
				<c:if test="${stat.index eq 1 }">
					<div class="item">
				</c:if>
					<img src="/files/${fileItemInfo.FILE_SAVE_NAME}" alt="pic1"
					onclick="javascript:location.href='${pageContext.request.contextPath}/freeboard/freeboardFileDownload.do?file_seq=${fileItemInfo.FILE_SEQ }'"
					>
				</div>
			</c:forEach>
			</c:if>
				</div>
			<!-- Left and right controls -->
			<c:if test="${fn:length(boardInfo) eq 2 }">
			<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
			</c:if>
		</div>
	</div>
	<div class="form-group"> 
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" id="addBoard" class="btn btn-success">글쓰기</button>
			<button type="button" id="boardDelete" class="btn btn-danger">삭제</button>
			<button type="button" id="replyForm" class="btn btn-primary">댓글</button>
			<button type="button" id="boardList" class="btn btn-info">목록</button>
			<button type="button" id="boardEdit" class="btn btn-default" style="float: right">수정</button>
		</div>
	</div>
</form>
</body>
</html>