package kr.or.ddit.second.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

// http://localhost/SpringToddler/second/hello.second
@Controller
public class SecondController {
	@RequestMapping("/second/hello.second")
	public String hello(){
		// 최종적으로 전달 되는곳은 ViewResolver 
		return "second/hello";
	}
}
