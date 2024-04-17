package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

/*   /notice/register -> loginForm -> 로그인 -> CustomLoginSuccessHandler(성공)
 			-> 사용자 작업.. -> /notice/register 로 리다이렉트 해줌
 (스프링 시큐리티에서 기본적으로 사용되는 구현 클래스)
*/

@Slf4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	// 부모클래스의 메소드 재정의
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws ServletException, IOException {

		log.warn("onAuthenticationSuccess");

		// auth.getPrincipal() : 사용자 정보를 가져옴
		// 시큐리티에서 사용자 정보는 User 클래스의 객체로 저장됨(CustomUser.java를 참고)
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		
		// 사용자 아이디를 리턴
		log.info("username : " + customUser.getUsername());
		log.info("memberVO : " + customUser.getMemberVO());
		
		String cmmnDetailCode = customUser.getMemberVO().getVwMemberAuthVOList().get(0).getCmmnDetailCode();
		String loginAuth = request.getParameter("auth");
		boolean authCheck = true;
		if("1".equals(loginAuth)) {
			if("ROLE_A01001".equals(cmmnDetailCode)) {
				authCheck = true;
			} else if ("ROLE_A01000".equals(cmmnDetailCode)) {
				authCheck = true;
			} else {
				authCheck = false;
			}
		}else if("2".equals(loginAuth)) {
			if("ROLE_A01003".equals(cmmnDetailCode)) {
				authCheck = true;
			} else if ("ROLE_A01000".equals(cmmnDetailCode)) {
				authCheck = true;
			} else {
				authCheck = false;
			}
		}else if("3".equals(loginAuth)){
			if("ROLE_A14001".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A14002".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A14003".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A14004".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A01002".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A01000".equals(cmmnDetailCode)) {
				authCheck = true;
			}else if("ROLE_A14005".equals(cmmnDetailCode)) {
				authCheck = true;
			}else {
				authCheck = false;
			}
				
			log.info("선생님 authCheck->" + authCheck);
		}
		
		if(authCheck) {
			// 시큐리티에 유저 정보 세팅(CustomUser 객체 세팅)
			Authentication authentication = new UsernamePasswordAuthenticationToken(customUser, customUser.getPassword(), auth.getAuthorities());
			// 세션에 유저 정보 세팅(MemberVO 객체 세팅)
			request.getSession().setAttribute("USER_INFO", customUser.getMemberVO());

			// 관리자인 경우 관리자 페이지로 이동
			log.info("유저 권한 확인 =>> " + auth.getAuthorities());
			if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_A01000"))) {
				response.sendRedirect("/admin/adminMain");
			} else {
				response.sendRedirect("/main");
			}
		}else {
			response.sendRedirect("?ec=E4");
		}
		
		// 부모
		super.onAuthenticationSuccess(request, response, auth);
	}

}
