package kr.or.ddit.common.mapper;

import org.springframework.web.bind.annotation.GetMapping;

public interface CommonMapper {

	//메인페이지
	public String main();
	
	//회원가입
	public String signUp(); 
	
	//로그인
	@GetMapping("/login")
	public String loginForm();
	
	//아이디 찾기
	public String searchId();
	
	//비밀번호 찾기
	public String searchPwd();
	
	//FAQ 게시판 목록
	public String faq();
	
	//학원 조회
	public String academy();
}
