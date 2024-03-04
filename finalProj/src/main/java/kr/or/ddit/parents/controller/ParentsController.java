package kr.or.ddit.parents.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.parents.service.ParentsService;

@RequestMapping("/parents")
@Controller
public class ParentsController {
	
	@Autowired
	ParentsService parentsService;
	
	//학부모 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		return "parents/mypage";
	}
	
	//학부모 인증 신청(학생에게)
	@GetMapping("/parentCertification")
	public String parentCertification() {
		return "parents/parentCertification";
	}
	
	//학급클래스 신청
	@GetMapping("/classRequest")
	public String classRequest() {
		return "parents/classRequest";
	}
	
	//상담 신청
	@GetMapping("/consultRequest")
	public String consultRequest() {
		return "parents/consultRequest";
	}
	
	//방과후학교 신청
	@GetMapping("/afterSchoolRequest")
	public String afterSchoolRequest() {
		return "parents/afterSchoolRequest";
	}
	
	//방과후학교 결제
	@GetMapping("/afterSchoolPay")
	public String afterSchoolPay() {
		return "parents/afterSchoolPay";
	}
}
