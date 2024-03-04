package kr.or.ddit.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.student.service.StudentService;

@RequestMapping("/student")
@Controller
public class StudentContoller {
	
	@Autowired
	StudentService studentService;
	
	//학생 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		return "student/mypage";
	}
	
	//학부모 인증(학생이)
	@GetMapping("/parentCertification")
	public String parentCertification() {
		return "student/parentCertification";
	}
}
