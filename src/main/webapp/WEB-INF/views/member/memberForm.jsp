<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type='text/javascript' src='http://code.jquery.com/jquery-latest.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/regex.js'></script>
<script type='text/javascript'>
   $(function(){
      $('form').submit(function(){
         if(!nameCheck($('input[name=mem_name]').val())) return false;
         if(!regnoCheck($('input[name=mem_regno1]').val(), $('input[name=mem_regno2]').val())) return false;
         if(!birCheck($('input[name=mem_bir1]').val(), $('input[name=mem_bir2]').val(), $('input[name=mem_bir3]').val())) return false;
         if(!idCheck($('input[name=mem_id]').val())) return false;
         if(!passCheck($('input[name=mem_pass]').val())) return false;
         if(!pass_confirmCheck($('input[name=mem_pass]').val(), $('input[mem_pass_confirm]').val())) return false;
         if(!hometelCheck($('select[name=mem_hometel1]').val(), $('input[name=hometel2]').val(), $('input[name=hometel3]').val())) return false;
         if(!hpCheck($('select[name=mem_hp1]').val(), $('input[name=mem_hp2]').val(), $('input[name=mem_hp3]').val())) return false;
         if(!mailCheck($('input[name=mem_mail1]').val(), $('select[name=mem_mail2]').val())) return false;
         if(!zipCheck($('input[name=mem_zip1]').val(), 'input[name=mem_zip2]').val()) return false;
         if(!addrCheck($('input[name=mem_add1]').val(), 'input[name=mem_add2]').val()) return false;
         if(!jobCheck($('input[name=mem_job]').val())) return false;
         if(!likeCheck($('input[name=mem_like]').val())) return false;
         return true;
      });
      
      $('button[id=btn3]').click(function(){
         location.href = "/ddit/03/main.jsp?contentPage=memberList.jsp";
      });
      
      $('#zipcodeBtn').click(function(){
         var url = '${pageContext.request.contextPath}/03/zipcodeSearch.jsp';
         var options = 'toolbar=no, location=no, directories=no, status=no,' +
                    'menubar=no, scrollbars=no, resizable=no, copyhistory=no,' +
                    'width=380, height=400';
         // 모달리스 팝업
         // 모달 팝업
         window.open(url, '우편번호검색', options);
      });
      
      $('.idPicbtn').click(function(){
         var url = '${pageContext.request.contextPath}/03/idPicFileupload.jsp';
         var options = 'toolbar=no, location=no, directories=no, status=no,' +
                    'menubar=no, scrollbars=no, resizable=no, copyhistory=no,' +
                    'width=380, height=400';
         // 모달리스 팝업
         // 모달 팝업
         window.open(url, '증명사진 업로드', options);
      });
      
      function nameCheck(name){
         if(name == ''){
            alert('성명을 입력하지 않았습니다');
            return false;
         } else if(!name.validationNM()){
            alert('성명을 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function regnoCheck(regno1, regno2){
         if(regno1 == ''){
            alert('주민등록번호 앞자리를 입력하지 않았습니다');
            return false;
         } else if(regno2 == ''){
            alert('주민등록번호 뒷자리를 입력하지 않았습니다');
            return false;
         } else if(!(regno1 + '-' + regno2).validationREGNO()){
            alert('주민등록번호를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function birCheck(bir1, bir2, bir3){
         if(bir1 == ''){
            alert('탄생연도를 입력하지 않았습니다');
            return false;
         } else if(bir2 == ''){
            alert('탄생월을 입력하지 않았습니다');
            return false;
         } else if(bir3 == ''){
            alert('탄생일을 입력하지 않았습니다');
            return false;
         } else if(!(bir1 + '-' + bir2 + '-' + bir3).validaionBIR()){
            alert('생년월일을 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function idCheck(id){
         if(id == ''){
            alert('아이디를 입력하지 않았습니다');
            return false;
         } else if(!id.validationID()){
            alert('아이디를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function passCheck(pass){
         if(pass == ''){
            alert('패스워드를 입력하지 않았습니다.');
            return false;
         } else if(!pass.validationPWD()){
            alert('패스워드를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function pass_confirmCheck(pass, pass_confirm){
         if(pass_confirm == ''){
            alert('패스워드확인을 입력하지 않았습니다');
            return false;
         } else if(pass_confirm == pass){
            alert('입력한 패스워드와 같은지 확인해주세요');
            return false;
         }
         return true;
      }
      
      function hometelCheck(hometel1, hometel2, hometel3){
         if(hometel2  ==  ''){
            alert('집전화 중간 번호를 입력하지 않았습니다');
            return false;
         } else if(hometel3 == ''){
            alert('집전화 마지막 번호를 입력하지 않았습니다');
            return false;
         } else if(!(hometel1 + '-' + hometel2 + '-' + hometel3).validationHOMETEL()){
            alert('집전화번호를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function hpCheck(hp1, hp2, hp3){
         if(hp2 == ''){
            alert('핸드폰 중간 번호를 입력하지 않았습니다');
            return false;
         } else if(hp3 == ''){
            alert('핸드폰 마지막 번호를 입력하지 않았습니다');
            return false;
         } else if(!(hp1 + '-' + hp2 + '-' + hp3).validationHP()){
            alert('핸드폰번호를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function mailCheck(mail1, mail2){
         if(mail1 == ''){
            alert('메일주소를 입력하지 않았습니다');
            return false;
         } else if(!(mail1 + mail2).validationMAIL()){
            alert('메일주소를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function zipCheck(zip1, zip2){
         if(zip1 == '' || zip2 == ''){
            alert('우편번호를 입력하지 않았습니다');
            return false;
         }
         return true;
      }
      
      function addrCheck(addr1, add2){
         if(addr1 == '' || addr2 == ''){
            alert('주소를 입력하지 않았습니다');
            return false;
         }
         return true;
      }
      
      function jobCheck(job){
         if(job == ''){
            alert('직업을 입력하지 않았습니다');
            return false;
         } else if(!job.validationJOB()){
            alert('직업을 바르게 입력해주세요');
            return false;
         }
         return true;
      }
      
      function likeCheck(like){
         if(like == ''){
            alert('취미를 입력하지 않았습니다');
            return false;
         } else if(!like.validationLIKE()){
            alert('취미를 바르게 입력해주세요');
            return false;
         }
         return true;
      }
   });
   
   function idCheck(){
      if(!$('input[name=mem_id]').val().regexID()){
         alert('아이디를 바르게 입력해주세요.');
         return;
      }
      $.ajax({
         type:'POST',
         dataType:'JSON',
         data:{mem_id : $('input[name=mem_id]').val()},
         url:'${pageContext.request.contextPath}/member/idCheck.do',
         error:function(result){
            alert(result.message);
         },
         success:function(result){
            // {'flag' : 'true' or 'false'}
            // false : undefined, null, ''
            if(eval(result.result.flag)){
               alert('사용할 수 있는 아이디입니다.');
            }else{
               alert('사용할 수 없는 아이디입니다.');
            }
         }
      });
   }
</script>

<style>
.fieldName {text-align: center; background-color: #f4f4f4;}
.tLine {background-color: #d2d2d2; height: 1px;}
.btnGroup { text-align: right; }
td {text-align: left; }
</style>
</head>
<body>
<form name="memberForm" method="post" action="${pageContext.request.contextPath}/member/insertMemberInfo.do">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
   <tr><td class="tLine" colspan="2"></td></tr>
   <tr><td rowspan="13" class="pic" colspan="2" style="vertical-align: bottom; width: 150px; text-align: center;">
         <div id="viewIdPic"></div>
         <img src="${pageContext.request.contextPath }/image/btn_pic.gif" alt="사진올리기" class="idPicbtn" title="인적사항에 올릴 증명   을 검색합니다." 
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
         <input type="text" name="mem_name" value=""/>
      </td>
   </tr>
   <tr><td class="tLine" colspan="2"></td></tr>
   <tr>
      <td class="fieldName" width="100px" height="25">주민등록번호</td>
      <td>
         <input type="text" name="mem_regno1" size="6" value=""/>
           <input type="text" name="mem_regno2" size="7" value=""/>
      </td>
   </tr>
   <tr><td class="tLine" colspan="2"></td></tr>
   
   <tr>
      <td class="fieldName" width="100px" height="25">생년월일</td>
      <td>
            <input type="hidden" name="mem_bir" />
            <input type="text" name="mem_bir1" size="4" value="" />년
            <input type="text" name="mem_bir2" size="2" value="" />월
            <input type="text" name="mem_bir3" size="2" value="" />일
      </td>
   </tr>
   <tr><td class="tLine" colspan="2"></td></tr>
   
   <tr>
      <td class="fieldName" width="100px" height="25">아이디</td>
      <td>
         <input type="text" name="mem_id" value="">&nbsp;&nbsp;<b><a href="javascript:idCheck();">[ID 중복검사]</a></b>
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
            <option value="02">02</option>
            <option value="031">031</option>
            <option value="032">032</option>                                   
            <option value="033">033</option>                       
            <option value="041">041</option>
            <option value="042">042</option>                       
            <option value="043">043</option>                       
            <option value="051">051</option>                       
            <option value="052">052</option>
            <option value="053">053</option>                                              
            <option value="061">061</option>
            <option value="062">062</option>
            <option value="063">063</option>                                                                     
            <option value="064">064</option>                                                                     
            <option value="070">070</option>                                                                     
         </select>   -    
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
            <option value="010">010</option>
            <option value="016">016</option>                       
            <option value="017">017</option>                       
            <option value="019">019</option>                       
         </select>   -
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
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
            <option value="hanmail.net">hanmail.net</option>
            <option value="nate.com">nate.com</option>
            <option value="gmail.com">gmail.com</option>            
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
         <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent" type="button" id="zipcodeBtn">우편번호검색</button><br>
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
         <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn1" type="submit">가입하기</button>
         <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn2" type="reset">취소</button>
         <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn3" type="button">목록</button>
      </td>
   </tr>
</table>
</form>
</body>
</html>
