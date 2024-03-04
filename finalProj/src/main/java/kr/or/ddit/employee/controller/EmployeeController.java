package kr.or.ddit.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/employee")
@Controller
public class EmployeeController {
	//직원 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		return "employee/mypage";
	}
}
