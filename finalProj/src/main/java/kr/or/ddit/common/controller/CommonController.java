package kr.or.ddit.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.common.service.CommonService;

@Controller
public class CommonController {
	
	@Autowired
//	CommonService commonService;
	
	//메인페이지
	@GetMapping("/")
	public String main() {
		return "common/main";
	}
	
	//회원가입
	@GetMapping("/signUp")
	public String signUp() {
		return "common/signUp";
	}
	
	//로그인
	@GetMapping("/login")
	public String loginForm() {
		return "common/loginForm";
	}
	
	//아이디 찾기
	@GetMapping("/searchId")
	public String searchId() {
		return "common/searchId";
	}
	
	//비밀번호 찾기
	@GetMapping("/searchPwd")
	public String searchPwd() {
		return "common/searchPwd";
	}
	
	//FAQ 게시판 목록
	@GetMapping("/faq")
	public String faq() {
		return "common/faq";
	}
	
	//학원 조회
	@GetMapping("/academy")
	public String academy() {
		return "common/academy";
	}
}
