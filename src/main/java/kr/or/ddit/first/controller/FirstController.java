package kr.or.ddit.first.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

// http://localhost/SpringToddler/first/hello.first
@Controller
public class FirstController {
	
	@RequestMapping("/first/hello.first")
	public String hello(){
		// 반환값 view를 결정
		return "first/hello";
	}
}
