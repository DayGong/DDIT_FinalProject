package kr.or.ddit.teacher.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.teacher.service.TeacherService;

@RequestMapping("/teacher")
@Controller
public class TeacherController {
	
	@Autowired
	TeacherService teacherService;
	
	//교사 마이페이지
	@GetMapping("/mypage")
	public String mypage() {
		return "teacher/mypage";
	}
	
	//담당 학급 목록
	@GetMapping("/classList")
	public String classList() {
		return "teacher/classList";
	}
	
	//학급 소속 회원 관리페이지
	@GetMapping("/classMemberAdmin")
	public String classMemberAdmin() {
		return "teacher/classMemberAdmin";
	}
	
	// 결석 사유 신청 목록(체험학습 포함)
	@GetMapping("/absentReasonList")
	public String absentReasonList() {
		return "teacher/absentReasonList";
	}
	
	//상담 신청 목록 게시판
	@GetMapping("/consultRequestList")
	public String consultRequestList() {
		return "teacher/consultRequestList";
	}
	
	
	//투표/설문조사 등록
	@GetMapping("/createVotingSurvey")
	public String createVotingSurvey() {
		return "teacher/createVotingSurvey";
	}
	
	//알림장 등록
	@GetMapping("/createNotice")
	public String createNotice() {
		return "teacher/createNotice";
	}
	
	//과제 등록
	@GetMapping("/createTask")
	public String createTask() {
		return "teacher/createTask";
	}
	
	//단원마무리 등록
	@GetMapping("/createUnitTest")
	public String createUnitTest() {
		return "teacher/createUnitTest";
	}
	
	//성적 목록
	@GetMapping("/gradeList")
	public String gradeList() {
		return "teacher/gradeList";
	}
	
	
	//생활기록 학생 목록
	@GetMapping("/lifeRecordList")
	public String lifeRecordList() {
		return "teacher/lifeRecordList";
	}
	 
	//반 통계?? 뭐에대한 통계인지 모르겠어
	
	//학생 출결 목록
	@GetMapping("/attendanceList")
	public String attendanceList() {
		return "teacher/attendanceList";
	}
	
	//시간표 등록
	@GetMapping("/createSchedule")
	public String createSchedule() {
		return "teacher/createSchedule";
	}
	
}
