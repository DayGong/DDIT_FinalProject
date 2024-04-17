package kr.or.ddit.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

//스프링이 자바빈으로 등록해줌

@RequestMapping("/error")
@Slf4j
@Controller
public class ErrorController {
	//요청URI : /error/error400
	@GetMapping("/error400")
	public String error400() {
		//forwarding : jsp
		return "error/error400";
	}
	//요청URI : /error/error404
	@GetMapping("/error404")
	public String error404() {
		//forwarding : jsp
		return "error/error404";
	}
	//요청URI : /error/error500
	@GetMapping("/error500")
	public String error500() {
		//forwarding : jsp
		return "error/error500";
	}
	//요청URI : /error/errorException
	@GetMapping("/errorException")
	public String errorException() {
		//forwarding : jsp
		return "error/errorException";
	}
	
	// 권한 없는 반코드 또는 학교코드
	@GetMapping("/errorUriAccess")
	public String errorUriAccess() {
		//forwarding : jsp
		return "error/errorUriAccess";
	}
}
