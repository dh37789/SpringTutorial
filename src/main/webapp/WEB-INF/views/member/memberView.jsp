<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='http://code.jquery.com/jquery-latest.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath }/js/regex.js'></script>
<script type="text/javascript">
	$(function(){
		$('input[name=mem_name]').val('${memberInfo.mem_name}');
		
		$('input[name=mem_regno1]').val('${memberInfo.mem_regno1 }');
		$('input[name=mem_regno2]').val('${memberInfo.mem_regno2 }');
		
		var mem_bir = '${memberInfo.mem_bir }';
		$('input[name=mem_bir1]').val(mem_bir.split('-')[0]);
		$('input[name=mem_bir2]').val(mem_bir.split('-')[1]);
		$('input[name=mem_bir3]').val(mem_bir.split('-')[2].substring(0,2));

		$('input[name=mem_id]').val('${memberInfo.mem_id }');
		
		$('input[name=mem_pass]').val('${memberInfo.mem_pass }');
		
		var mem_hometel = '${memberInfo.mem_hometel }';
		$('select[name=mem_hometel1] option[value="' + mem_hometel.split('-')[0] + '"]').attr('selected', true)
		$('input[name=mem_hometel2]').val(mem_hometel.split('-')[1]);
		$('input[name=mem_hometel3]').val(mem_hometel.split('-')[2]);
		
		var mem_hp = '${memberInfo.mem_hp }';
		$('select[name=mem_hp1] option[value="' + mem_hp.split('-')[0] + '"]').attr('selected', true)
		$('input[name=mem_hp2]').val(mem_hp.split('-')[1]);
		$('input[name=mem_hp3]').val(mem_hp.split('-')[2]);
		
		var mem_mail = '${memberInfo.mem_mail }';
		$('input[name=mem_mail1]').val(mem_mail.split('@')[0]);
		$('select[name=mem_mail2] option[value="' + mem_mail.split('@')[1] + '"]').attr('selected', true)
		
		var mem_zip = '${memberInfo.mem_zip }';
		$('input[name=mem_zip1]').val(mem_zip.split('-')[0]);
		$('input[name=mem_zip2]').val(mem_zip.split('-')[1]);
		
		$('input[name=mem_add1]').val('${memberInfo.mem_add1 }');
		
		$('input[name=mem_add2]').val('${memberInfo.mem_add2 }');
		
		$('input[name=mem_like]').val('${memberInfo.mem_like }');
		
		$('input[name=mem_job]').val('${memberInfo.mem_job }');

		$('#btn4').click(function(){
			location.href="${pageContext.request.contextPath }/member/MemberList.do";
		});
		$('#zipSearch').click(function(){
			var url = '${pageContext.request.contextPath }/03/zipcodeSearch.jsp';
			var options = 'toolbar=no, location=no, directories=no, status=no,' + 
						  'menubar=no, scrollbars=no, resizable=no, copyhistory=no,' + 
						  'width=380, height=400';
			// 모달리스 팝업 - 포커스가 자유자재로 이동한다.
			// 모달 팝업
			window.open(url, '우편번호 검색', options);
		});
		$('form').submit(function(){
			$('input[name=mem_hometel]').val($('select[name=mem_hometel1]').val()+'-'+$('input[name=mem_hometel2]').val()+'-'+$('input[name=mem_hometel3]').val());
			$('input[name=mem_zip]').val($('input[name=mem_zip1]').val()+'-'+$('input[name=mem_zip2]').val());
			$('input[name=mem_hp]').val($('select[name=mem_hp1]').val()+'-'+$('input[name=mem_hp2]').val()+'-'+$('input[name=mem_hp3]').val());
			$('input[name=mem_mail]').val($('input[name=mem_mail1]').val()+'@'+$('select[name=mem_mail2]').val());
			$('form[name=memberForm]').append('<input type="hidden" name="mem_id" value="' + $('input[name=mem_id]').val() +'"/>');
			if(!$('input[name=mem_pass]').val().regexPWD()){
				alert('비밀번호를 입력해 주세요.');
				return false;
			};
			var pass = $('input[name=mem_pass]').val();
			if(!pass.regexPWD()){
				alert('비밀번호를 입력해 주세요.');
				return false;
			}
			if($('input[name=mem_pass_confirm]').val() != pass){
				alert('동일한 비밀번호를 입력해 주세요.');
				return false;
			}
			if(!$('input[name=mem_hometel]').val().regexHOMETEL()){
				alert('집전화를 바르게 입력해주세요.');
				return false;
			};
			if(!$('input[name=mem_hp]').val().regexHP()){
				alert($('input[name=mem_hp]').val())
				alert('휴대폰번호를 바르게 입력해주세요.');
				return false;
			};
			if(!$('input[name=mem_job]').val().regexJOB()){
				alert('직업을 바르게 입력해주세요.');
				return false;
			};
			if(!$('input[name=mem_mail]').val().regexMAIL()){
				alert('메일을 바르게 입력해주세요.');
				return false;
			}
			if(!$('input[name=mem_like]').val().regexLIKE()){
				alert('취미을 바르게 입력해주세요.');
				return false;
			};
			return true;
		})
		$('#btn3').click(function(){
			location.href = "${pageContext.request.contextPath }/member/deleteMemberInfo/${memberInfo.mem_id }.do";
		})
	})
</script>
</head>
<style>
.fieldName {text-align: center; background-color: #f4f4f4;}
.tLine {background-color: #d2d2d2; height: 1px;}
.btnGroup { text-align: right; }
td {text-align: left; }
</style>
<body>
<form name="memberForm" action="${pageContext.request.contextPath }/member/updateMemberInfo.do"  method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr><td rowspan="13" class="pic" colspan="2" style="vertical-align: bottom; width: 150px; text-align: center;">
			<img src="${pageContext.request.contextPath }/image/btn_pic.gif" alt="사진올리기" class="btn" title="인적사항에 올릴 증명	을 검색합니다." 
				style="cursor: pointer;"/><br/>
			<div style="width: 100%" align="center">
				size : 235x315 이하
			</div>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">성 명</td>
		<td>
			<input type="text" name="mem_name" value="" disabled="disabled"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">주민등록번호</td>
		<td>
			<input type="text" name="mem_regno1" size="6" value="" disabled="disabled"/>
  			<input type="text" name="mem_regno2" size="7" value="" disabled="disabled"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">생년월일</td>
		<td>
				<input type="hidden" name="mem_bir" />
				<input type="text" name="mem_bir1" size="4" value="" disabled="disabled"/>년
				<input type="text" name="mem_bir2" size="2" value="" disabled="disabled"/>월
				<input type="text" name="mem_bir3" size="2" value="" disabled="disabled"/>일
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">아이디</td>
		<td>
			<input type="text" name="mem_id" value="" disabled="disabled">
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호</td>
		<td>
			<input type="text" name="mem_pass" value="" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호확인</td>
		<td>
			<input type="text" name="mem_pass_confirm" value="" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
	<tr>
		<td class="fieldName" width="100px" height="25">전화번호</td>
		<td>
			<div>
			<input type="hidden" name="mem_hometel"/>
			<select name="mem_hometel1">
				<option value="02" >02</option>
				<option value="031" >031</option>
				<option value="032" >032</option>								        	
				<option value="033" >033</option>				        	
				<option value="041" >041</option>
				<option value="042" >042</option>				        	
				<option value="043" >043</option>				        	
				<option value="051" >051</option>				        	
				<option value="052" >052</option>
				<option value="053" >053</option>				        					        	
				<option value="061" >061</option>
				<option value="062" >062</option>
				<option value="063" >063</option>				        					        					        	
				<option value="064" >064</option>				        					        					        	
				<option value="070" >070</option>				        					        					        	
			</select>	- 	
			<input type="text" name="mem_hometel2" size="4" value="" /> - 
			<input type="text" name="mem_hometel3" size="4" value="" />
			</div>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">핸드폰</td>
		<td>
			<input type="hidden" name="mem_hp"/>
			<select name="mem_hp1">
				<option value="010" >010</option>
				<option value="016" >016</option>				        	
				<option value="017" >017</option>				        	
				<option value="019" >019</option>				        	
			</select>	-
			<input type="text" name="mem_hp2" size="4" value="" /> - 
			<input type="text" name="mem_hp3" size="4" value="" />
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">이메일</td>
		<td>
			<input type="hidden" name="mem_mail" />
			<input type="text" name="mem_mail1" value="" /> @
			<select name="mem_mail2">
				<option value="naver.com" >naver.com</option>
				<option value="daum.net" >daum.net</option>
				<option value="hanmail.net" >hanmail.net</option>
				<option value="nate.com" >nate.com</option>
				<option value="gmail.com" >gmail.com</option>				
			</select>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
		
	<tr>
		<td class="fieldName" width="100px" height="25">주소</td>
		<td>
			<input type="hidden" name="mem_zip" />
			<input type="text" name="mem_zip1" id="mem_zip1" size="3" value="" /> - 
			<input type="text" name="mem_zip2" id="mem_zip2" size="3" value="" />
			<button type="button" id="zipSearch" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">우편번호검색</button><br>
			<input type="text" name="mem_add1" id="mem_add1" value="" />
			<input type="text" name="mem_add2" id="mem_add2" value="" />
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">직 업</td>
		<td>
			<input type="text" name="mem_job" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">취 미</td>
		<td>
			<input type="text" name="mem_like" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr><td colspan="2" height="20"></td></tr>
	
	<tr>
		<td class="btnGroup" colspan="2" >
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn1" type="submit">수정하기</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn2" type="reset">취소</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn3" type="button">삭제</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn4" type="button">목록</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>








