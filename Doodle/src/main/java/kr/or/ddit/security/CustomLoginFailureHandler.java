package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

		String errorMessage = ""; // 기본 예외 메시지
		// exceprion 처리
		if(exception instanceof InternalAuthenticationServiceException) {
			// 아이디 존재하지 않을 때
			errorMessage = "E1";
		}else if(exception instanceof BadCredentialsException) {
			// 비밀번호가 틀릴 때
			errorMessage = "E2";
		}else {
			errorMessage = "E3";
		}

		//auth값 가져오기
		String auth = request.getParameter("auth");

		// 파라미터로 error와 exception을 보내서 controller에서 처리하기 위함. auth값 추가
		setDefaultFailureUrl("/login?ec=" + errorMessage +"&auth=" + auth);

		// 부모클래스의 onAuthenticationFailure로 처리를 위임하자.
		super.onAuthenticationFailure(request, response, exception);
	}
}
