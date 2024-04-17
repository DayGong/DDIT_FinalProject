package kr.or.ddit.util.etc;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.PatternMatchUtils;

import kr.or.ddit.util.service.CheckService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("UrlAccessFilter")
public class UrlAccessFilter implements Filter {
	
	@Autowired
	CheckService checkService;
	
	private static final String[] whiteList = {
			"/", "/signUp", "/idDupChk", "/childChk", "/signUpMember",
			"/login", "/error/*", "/echo/*", "/admin/*", "/resources/*",
			"/alram/*", "/upload/*", "/stomp/*", "/header/*"
			};
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		log.info("UrlAccessFilter init");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) request;
		String uri = httpReq.getRequestURI();
		String clasCode = httpReq.getParameter("clasCode");
		String schulCode = httpReq.getParameter("schulCode");
		HttpServletResponse httpRes = (HttpServletResponse) response;
//
//		// uri 에 따라 확인하는 절차
//		log.info("========== doFilter uri:"+uri);
//		log.info("========== doFilter clasCode:"+clasCode);
//		log.info("========== doFilter schulCode:"+schulCode);
//
		// 로그인 확인
		if(!PatternMatchUtils.simpleMatch(whiteList, uri)) {
			if(!isAuthenticated()) {
				// 로그인 폼으로
				httpRes.sendRedirect("/");
				return;
			}
		}; 
//
//		// 반코드 검사
//		if(clasCode != null && !clasCode.equals("")) {
//			// true = 1, false = 0
//			boolean isBelongCl = checkService.checkBelongCl(httpReq, clasCode);
//			if(!isBelongCl) {
//				log.info("비정상적인 반코드 파라미터");
//				httpRes.sendRedirect("/error/errorUriAccess");
//				return;
//			}
//		}
//		
//		// 학교코드 검사
//		if(schulCode != null && !schulCode.equals("")) {
//			// true = 1, false = 0
//			boolean isBelongSch = checkService.checkBelongSch(httpReq, schulCode);
//			if(!isBelongSch) {
//				log.info("비정상적인 학교코드 파라미터");
//				httpRes.sendRedirect("/error/errorUriAccess");
//				return;
//			}
//		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		log.info("UrlAccessFilter destroy");
		
	}
	
	// 로그인 했는지 확인
	public boolean isAuthenticated() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
	        return false;
	    }
	    return authentication.isAuthenticated();
	}
}
