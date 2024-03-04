package kr.or.ddit.classroom.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.classroom.service.ClassroomService;

@RequestMapping("/class")
@Controller
public class classroomController {
	
	@Autowired
	ClassroomService classroomService;
	
	//학급클래스 목록
	@GetMapping("/list")
	public String classList() {
		return "class/list";
	}
	
	//학급클래스 소속회원 목록
	@GetMapping("/memberList")
	public String classMemberList() {
		return "class/memberList";
	}
	
	// 결석 사유 신청(체험학습도)
	@GetMapping("/absentReason")
	public String absentReason() {
		return "class/absentReason";
	}
	
	
	//자유 게시판 목록 
	@GetMapping("/freeBoard")
	public String freeBoard() {
		return "class/freeBoard";
	}
	
	//투표/설문조사 게시판 목록
	@GetMapping("/votingSurvey")
	public String votingSurvey() {
		return "class/votingSurvey";
	}
	
	
	//알림장 목록
	@GetMapping("/notice")
	public String notice() {
		return "class/notice";
	}
	
	//과제 게시판 목록
	@GetMapping("/task")
	public String task() {
		return "class/task";
	}
	
	//단원마무리 게시판 목록
	@GetMapping("/unitTest")
	public String unitTest() {
		return "class/unitTest";
	}
	
	//학급 갤러리 목록
	@GetMapping("/gallery")
	public String gallery() {
		return "class/gallery";
	}
	
	//학급 시간표 조회
	@GetMapping("/schedule")
	public String schedule() {
		return "class/schedule";
	}
	
	//온라인 수업
	@GetMapping("/onlineClass")
	public String onlineClass() {
		return "class/onlineClass";
	}
	
	//생활 기록부 조회
	@GetMapping("/lifeRecord")
	public String lifeRecord() {
		return "class/lifeRecord";
	}
}
