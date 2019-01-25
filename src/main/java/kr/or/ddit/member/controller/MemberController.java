package kr.or.ddit.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.aop.Loggable;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.utils.CryptoGenerator;
import kr.or.ddit.vo.MemberVO;

import org.slf4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


// http://localhost/SpringToddler/member/memberList.do
// http://localhost/SpringToddler/member/memberView.do
// http://localhost/SpringToddler/member/memberForm.do
// http://localhost/SpringToddler/member/updateMemberInfo.do
// http://localhost/SpringToddler/member/deleteMemberInfo.do
// http://localhost/SpringToddler/member/insertMemberInfo.do
@Controller
@RequestMapping("/member/") // member가 중복된다.
public class MemberController{
	@Autowired
	CryptoGenerator crypto;
	@Resource
	IMemberService service;
	@Autowired
	private MessageSourceAccessor messageAccrssor;
//	@Autowired
//	public MemberController(IMemberService service) {
//		this.service = service;
//	}
//	@Autowired
//	public void setAmugetne(IMemberService service){
//		this.service = service;
//	}
	
	@RequestMapping("loginCheck")
	public ModelAndView loginCheck(MemberVO loginInfo, Map<String, String> params,
			HttpSession session, ModelAndView andView) throws Exception{
		String mem_id = crypto.decryptRSA(session, loginInfo.getMem_id());
		String mem_pass = crypto.decryptRSA(session, loginInfo.getMem_pass());
		
		params.put("mem_id", mem_id);
		params.put("mem_pass", mem_pass);
		
		MemberVO memberInfo = this.service.getMember(params);
		
		if (memberInfo == null) {
			String message = this.messageAccrssor.getMessage("fail.common.join", Locale.KOREA);
			andView.addObject("message", message);
		}else{
			session.setAttribute("LOGIN_MEMBERINFO", memberInfo);
		}
		andView.setViewName("forward:/freeboard/freeboardList.do");
		return andView;
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session){
		session.removeAttribute("LOGIN_MEMBERINFO");
		return "forward:/freeboard/freeboardList.do";
	}
	
	@RequestMapping("memberList")
	public ModelAndView memberList(ModelAndView andView, HttpServletRequest request) throws Exception{
		
		Map<String, ?> paramMap = RequestContextUtils.getInputFlashMap(request);
		if (paramMap != null) {
			String value= (String) paramMap.get("message");
			System.out.println("paramMap value : " + value);
		}
		// Model : View에 전달되어지는 데이터
		// View : View(경로, 이름)
//		ModelAndView andView = new ModelAndView();
		
		List<MemberVO> memberList = this.service.memberList(new HashMap<String, String>());
		
		// request.setAttrubute("memberList", memberList);
		andView.addObject("memberList", memberList);
		// ViewResolver에 전달될 View의 경로와 이름
		andView.setViewName("member/memberList");
//		andView.setViewName("redirect:member/memberList");
//		andView.setViewName("forward:member/memberList");
		return andView;
	}
	// 요청시 서블릿 패스 : /member/memberView.do 
//	@RequestMapping("memberView")
//	@RequestMapping(value="memberView",params={"mem_id=d001"}, method=RequestMethod.GET)
	@RequestMapping(value="memberView", method=RequestMethod.GET)
	public Model memberView(@RequestParam(required=true, defaultValue="b001") String mem_id,
			Map<String, String> params,Model model, @RequestHeader("Accept-Language") String language,
			@RequestHeader("Accept") String accept, @CookieValue("JSESSIONID") String sessionID,
			@CookieValue(value="mem_id", required=false, defaultValue="널 대체값") String cookie_id) throws Exception{
		System.out.println("Accpet-Language : " + language);
		System.out.println("Accpet : " + accept);
		System.out.println("JSESSIONID : " + sessionID);
		System.out.println("mem_id : " + cookie_id);
		
		params.put("mem_id", mem_id);
		
		MemberVO memberInfo = this.service.getMember(params);
		
		model.addAttribute("memberInfo", memberInfo);
		// 경로가 없을시에 서블릿 패스를 참조한다.
		return model;
	}
	
	@RequestMapping("updateMemberInfo")
	public String updateMember(MemberVO memberInfo, @RequestBody String params,
			RedirectAttributes redirectAttribute) throws Exception{
		this.service.updateMember(memberInfo);
		
		redirectAttribute.addFlashAttribute("message", "회원정보가 정상적으로 수정되었습니다.");
		return "redirect:/member/memberList.do";
	}
	
	@RequestMapping("deleteMemberInfo/{mem_id}")
	public String deleteMember(@PathVariable String mem_id, Map<String, String> params) throws Exception{
		params.put("mem_id", mem_id);
		this.service.deleteMember(mem_id);
		return "redirect:/member/memberList.do";
	}
	
	@RequestMapping("memberForm")
	public void memberForm(){
	}
	@RequestMapping("insertMemberInfo")
	public String insertMember(MemberVO memberInfo) throws Exception{
		this.service.insertMemberInfo(memberInfo);
		return "redirect:/join/loginForm.do";
	}
//	@RequestMapping("idCheck")
//	@ResponseBody
//	public String idCheck(String mem_id, 
//			Map<String, String> params ,
//			ObjectMapper mapper){
//		params.put("mem_id", mem_id);
//		
//		MemberVO memberInfo = this.service.getMember(params);
//		Map<String, String> jsonMap = new HashMap<String, String>();
//		if (memberInfo == null) {
//			jsonMap.put("flag", "true");
//		}else{
//			jsonMap.put("flag", "false");
//		}
//		
////		ObjectMapper mapper = new ObjectMapper();
//		String jsonData = "";
//		
//		try {
//			jsonData = mapper.writeValueAsString(jsonMap);
//		} catch (JsonProcessingException e) {
//			e.printStackTrace();
//		}
//		return jsonData;
//	}
	
	@RequestMapping("idCheck")
	@ResponseBody
	public ModelAndView idCheck(String mem_id, 
			Map<String, String> params,
			ModelAndView andView) throws Exception{
		params.put("mem_id", mem_id);
		
		MemberVO memberInfo = this.service.getMember(params);
		Map<String, String> jsonMap = new HashMap<String, String>();
		if (memberInfo == null) {
			jsonMap.put("flag", "true");
		}else{
			jsonMap.put("flag", "false");
		}
		
		andView.addObject("result", jsonMap);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
}
