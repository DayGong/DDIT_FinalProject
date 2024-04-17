package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;

/*   /notice/register -> loginForm -> 로그인 -> CustomLoginSuccessHandler(성공)
 			-> 사용자 작업.. -> /notice/register 로 리다이렉트 해줌
 (스프링 시큐리티에서 기본적으로 사용되는 구현 클래스)
*/

@Slf4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		response.sendRedirect("/");
	}
}
