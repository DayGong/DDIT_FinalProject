package kr.or.ddit.school.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.school.service.SchoolService;

@RequestMapping("/school")
@Controller
public class SchoolController {
	
	@Autowired
	SchoolService schoolService;
	
	//학교 공지사항 게시판 목록
	@GetMapping("/notice")
	public String notice() {
		return "school/notice";
	}
	
	//학교 교육정보 게시판 
	@GetMapping("/eduInfo")
	public String eduInfo() {
		return "school/eduInfo";
	}
	
	//교직원 관리
	@GetMapping("/employeeManage")
	public String employeeManage() {
		return "school/employeeManage";
	}
	
	//자료실 
	@GetMapping("/dataRoom")
	public String dataRoom() {
		return "school/dataRoom";
	}
	
	//급식
	@GetMapping("/meal")
	public String meal() {
		return "school/meal";
	}
	
	//학사일정
	@GetMapping("/academicCalendar")
	public String academicCalendar() {
		return "school/academicCalendar";
	}
	
	//시간표
	@GetMapping("/schedule")
	public String schedule() {
		return "school/schedule";
	}
	
	//학생(전교생) 관리 
	@GetMapping("/studentsManage")
	public String studentsManage() {
		return "school/studentsManage";
	}
	
	//방과후학교
	@GetMapping("/afterSchool")
	public String afterSchool() {
		return "school/afterSchool";
	}
	
	//학급 클래스 목록
	@GetMapping("/classList")
	public String classList() {                                
		return "school/classList";
	}
	
}
