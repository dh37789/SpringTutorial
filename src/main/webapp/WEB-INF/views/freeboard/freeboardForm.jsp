<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 등록</title>

<script type="text/javascript">
$(function(){
	// 섬머노트를 div를 활용한 textarea에 추가.
	// http://summernote.org 활용
    $('#bo_content').summernote({
    		lang: 'ko-KR',
			height: 150,
			codemirror: {
			theme: 'monokai'
		}
    });
    
    // 목록
    $('#BoardList').click(function(){
    	location.href = "${pageContext.request.contextPath}/freeboard/freeboardList.do";
    });
    
    // 게시물 등록
    $('#Boardinsert').click(function(){
		$('input[name=bo_content]').val($('#bo_content').summernote('code'));
    	
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
    		    message: '메일을 입력하세요!'
    		});
    		return;
    	}
    	
    	var board = $('#bo_content').summernote('code');
        // remove whitespace after tags
//     	board = board.replace(/[\u2018\u2019\u201A]/g, "'")
//     	.replace(/[\u201C\u201D\u201E]/g, '"')
//     	.replace(/\u2026/g, '...')
//     	.replace(/[\u2013\u2014]/g, '-')
//     	.replace(/\>[\t ]+$/g, ">");
        // smart single quotes and apostrophe
        
        // smart double quotes
        
        // ellipsis
        
        // dashes
   		board = replaceWordChars(board);
		if (board=='<p>&nbsp;</p>') {
    		BootstrapDialog.show({
		 	    title: '입력 오류',
		 	    message: '본문을 입력해 주세요!'
		 	});
    		return;
		}
    	///
    	var flag = true;
        $('input[type=file]:gt(0)').each(function(idx, itag){
            if ($(this).val().length != 0) {
              if (!/\.(jpg|jpeg|gif|png)$/.test($(itag).val().toLowerCase())) {
                 flag = false;
                 return;
              }
           }
        });
      
       if (!flag) {
         BootstrapDialog.show({
               title: '파일을 다시 올려주세요!',
               message: '이미지만 첨부 가능합니다.'
           });
           return;
        }
       //
//        $('#formadd').append('<input type="hidden" name="currentPage" value="1">');
       
    	BootstrapDialog.show({
        message: '${LOGIN_MEMBERINFO.mem_name}님!! 정말 등록하시겠습니까??',
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
		
    });
});
    // 포커스 처리
    // $('#bo_content').summernote( {focus: true} );
    // 값 취득
    // $('#bo_content').summernote('code');
    // 값 추가
    // $('#bo_content').summernote('code', '<font color="red">추가글</font>');
    // 에디터 제거
    // $('#bo_content').summernote('destroy');
    
// 	BootstrapDialog.show({
// 	    title: '알럿창',
// 	    message: '알럿창으로 활용하세요!'
// 	});
	
// 	BootstrapDialog.show({
//         message: '컨펌 다이얼로그로 활용하세요!',
//         buttons: [{
//             label: 'Button 1'
//         }, {
//             label: 'Button 2',
//             cssClass: 'btn-primary',
//             action: function(){
//                 alert('Hi Orange!');
//             }
//         }, {
//             icon: 'glyphicon glyphicon-ban-circle',
//             label: 'Button 3',
//             cssClass: 'btn-warning'
//         }, {
//             label: 'Close',
//             action: function(dialogItself){
//                 dialogItself.close();
//             }
//         }]
//     });
var replaceWordChars = function (text) {
    var str = text;
    // 똑똑한 작은 따옴표와 아포스트로피
	str = str.replace(/</g,"&lt;");
	str = str.replace(/>/g,"&gt;");
	str = str.replace(/\"/g,"&quot;");
	str = str.replace(/\'/g,"&#39;");
	str = str.replace(/\n/g,"<br />");
    return str;
}
</script>
</head>
<body>
<form class="form-horizontal" role="form" action="${pageContext.request.contextPath }/freeboard/insertFreeboardInfo.do" method="post"
	enctype="multipart/form-data" id="formadd">
	<div class="form-group">
		<input type="hidden" name="bo_writer" value="${LOGIN_MEMBERINFO.mem_id}">
		<input type="hidden" name="bo_ip" value="${pageContext.request.remoteAddr }">
		<label class="control-label col-sm-2" for="bo_title">제목:</label>
		<div class="col-sm-10">
			<input type="text" class="form-control" id="bo_title" name="bo_title" placeholder="제목 입력...">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_nickname">작성자 대화명:</label>
		<div class="col-sm-10"> 
			<input type="text" class="form-control" id="bo_nickname" name="bo_nickname" placeholder="대화명 입력...">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_pwd">패스워드:</label>
		<div class="col-sm-10"> 
			<input type="password" name="bo_pwd" class="form-control" id="bo_pwd" placeholder="패스워드 입력...">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_mail">메일:</label>
		<div class="col-sm-10"> 
			<input type="text" class="form-control" id="bo_mail" name="bo_mail" placeholder="메일주소 입력..." value="${LOGIN_MEMBERINFO.mem_mail }">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="bo_content">내용:</label>
		<div class="col-sm-10"> 
			<div id="bo_content"></div>
		</div>
			<input type="hidden" name="bo_content">
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="file01">첨부파일1:</label>
		<div class="col-sm-10">
			 <input type="file" class="filestyle" id="file01" name="fileitems" data-buttonName="btn-primary">
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-sm-2" for="file02">첨부파일2:</label>
		<div class="col-sm-10">
			 <input type="file" class="filestyle" id="file02" name="fileitems" data-buttonName="btn-primary">
		</div>
	</div>
	<div class="form-group"> 
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" class="btn btn-info" style="float: right" id="Boardinsert">등록</button>
			<button type="reset" class="btn btn-danger" style="float: right">취소</button>
			<button type="button" class="btn btn-primary" style="float: right" id="BoardList">목록</button>
		</div>
	</div>
</form>
</body>
</html>