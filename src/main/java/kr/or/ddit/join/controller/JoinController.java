package kr.or.ddit.join.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.aop.Loggable;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.IMemberServiceImpl;
import kr.or.ddit.utils.CryptoGenerator;
import kr.or.ddit.vo.MemberVO;

import org.slf4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

// 1.http://localhost/SpringToddler/join/loginForm.do
// 2.http://localhost/SpringToddler/join/loginCheck.do
//					post - ?mem_id=값&mem_pass=값
// 3.http://localhost/SpringToddler/join/logout.do
// <bean name="클래스명 joinController"
//		class="kr.or.ddit.join.controller.JoinController"/>
@Controller
@RequestMapping("/join/")//(1)
public class JoinController{
	@Autowired
	private IMemberService service;
	@Autowired
	private CryptoGenerator cryptoGen;
	@Autowired
	private MessageSourceAccessor messageAccrssor;
	
	@RequestMapping("loginForm")
	public ModelMap loginForm(ModelMap modelMap,
			HttpSession session){
		modelMap.addAttribute("publicKeyMap", cryptoGen.getGeneratePairKey(session));
		return modelMap;
//		return "join/loginForm";//(2)
	}
	//(1), (2)가 일치하지 않아도 괜찮다.
	
	// 지역변수로 선언되어있다면 값이 들어온다.
//	@RequestMapping("loginCheck")
//	public String loginCheck(String mem_id, String mem_pass){
//	@RequestMapping("loginCheck")
//	public String loginCheck(MemberVO member){
	// 단일키 다중값은 배열로 만들면 된다.
	@RequestMapping("loginCheck")
	public String loginCheck(Map<String, String> params, String mem_id,
			String[] mem_pass, HttpSession session, 
			HttpServletRequest request,
			HttpServletRequest response
			) throws Exception{
		// 스프링이 Map을 알아서 인스턴스화 시킨다.
		params.put("mem_id", mem_id);
		params.put("mem_pass", mem_pass[0]);
		
		MemberVO memberInfo = service.getMember(params);
		// dao까진는 잘가지만 쿼리 질의가 잘 되지 않을경우에는 application-ibatis.xml을 확인해준다.
		if (memberInfo== null) {
			String message = "";
			try {
				// fail.common.join
				message = this.messageAccrssor.getMessage("fail.common.join", Locale.KOREA);
				message = URLEncoder.encode("회원이 아닙니다.", "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return "redirect:/join/loginForm.do?message=" + message;
		}else{
			session.setAttribute("LOGIN_MEMBERINFO", memberInfo);
			return "forward:/member/memberList.do";
		}
		
		// 동일한 컨트롤러 또는 다른 컨트롤러를 대상으로
		// 포워딩 또는 리다이렉트 처리.
		// 리다이렉트
		// return "redirect:/join/loginForm.do";
		// 포워딩
		// return "forward:/join/loginForm.do";
	}

//	@Override
//	public void setApplicationContext(ApplicationContext applicationContext)
//			throws BeansException {
//		this.service = (IMemberService) applicationContext.getBean("memberService");
//	}
}
