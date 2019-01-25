<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 댓글등록</title>
<script type="text/javascript">
$(function(){
	// 섬머노트를 div를 활용한 textarea에 추가.
	// http://summernote.org 활용
    $('#bo_content').summernote({
			height: 150,
			codemirror: {
			theme: 'monokai'
		}
    });
    
    $('#BoardList').click(function(){
    	location.href="${pageContext.request.contextPath}/freeboard/freeboardList.do";
    });
    
    
    $('#insertReply').click(function(){
    	$('input[name="bo_content"]').val($('#bo_content').summernote('code'));
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
    	
    	if(!$('#bo_pwd').val().regexPWD()){
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
    
    	BootstrapDialog.show({
            message: '${LOGIN_MEMBERINFO.mem_name}님!! 댓글 등록하시겠습니까??',
            buttons: [{
                label: '확인',
                cssClass: 'btn-primary',
                action: function(){
                	$('form').append('<input type="hidden" name="bo_no" value="${param.bo_no }">');
                	$('form').append('<input type="hidden" name="bo_writer" value="${LOGIN_MEMBERINFO.mem_id }">');
                	$('form').append('<input type="hidden" name="bo_group" value="${param.bo_group }">');
                	$('form').append('<input type="hidden" name="bo_seq" value="${param.bo_seq }">');
                	$('form').append('<input type="hidden" name="bo_depth" value="${param.bo_depth }">');
                	$('form').append('<input type="hidden" name="bo_ip" value="${pageContext.request.remoteAddr }">');
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
    });
    $('#p_rnum').text('${param.rnum }');
    $('#p_title').text('${param.bo_title }');
    $('#p_writer').text('${param.bo_writer }' + '의 댓글');
    $('#bo_mail').val('${LOGIN_MEMBERINFO.mem_mail }');
});
</script>
</head>
<body>
<div class="row">
	 <div class="col-sm-3">
		 <label class="col-sm-2 control-label">No :</label>
  		 <p id="p_rnum" class="form-control-static"></p>
	 </div>
	 <div class="col-sm-8">
	 	<label class="col-sm-2 control-label">제목 :</label>
    	<p id="p_title" class="form-control-static"></p>
	 </div>
	 <div class="col-sm-1">
	 	<p id="p_writer" class="text-right text-danger bg-danger">의 댓글</p>
	 </div>
</div>
<hr /> 
<form class="form-horizontal" role="form" action="${pageContext.request.contextPath }/freeboard/freeboardInsertReply.do" method="post">
	
	
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
			<input type="password" class="form-control" id="bo_pwd" name="bo_pwd">
			
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_mail">메일:</label>
		<div class="col-sm-10"> 
			<input type="text" class="form-control" id="bo_mail" name="bo_mail" value="">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_content">내용:</label>
		<div class="col-sm-10"> 
			<div id="bo_content"></div>
			<input type="hidden" name="bo_content">
		</div>
	</div>
	<div class="form-group"> 
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" class="btn btn-success" style="float: right;" id="insertReply">댓글등록</button>
			<button type="reset" class="btn btn-danger" >취소</button>
			<button type="button" class="btn btn-info" id="BoardList">목록</button>
		</div>
	</div>
</form>
</body>
</html>