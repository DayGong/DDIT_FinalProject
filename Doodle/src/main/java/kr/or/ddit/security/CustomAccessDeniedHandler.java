package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("handle");
		
		//DB작업
		//로그작업
		//메시지발송
		
		response.sendRedirect("/main");
	}
	/*
	 공지사항 등록 화면(/notice/register)은 
	 일반회원(member/java)이 접근할 수 없는 페이지이고,
	 관리자(admin/java)만 접근 가능하므로..
	 지정된 접근 거부 처리자(CustomAccessDeniedHander)에서 
	 접근 거부 처리 페이지(/accessError)로 리다이렉트 시킴
	 */
	
}
