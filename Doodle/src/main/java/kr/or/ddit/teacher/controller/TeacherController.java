package kr.or.ddit.teacher.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.teacher.service.TeacherService;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/teacher")
@Controller
public class TeacherController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	PasswordEncoder passwordEncode;
	
	@Autowired
	TeacherService teacherService;
	
	//교사 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model, HttpServletRequest request, String mberId) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("loginAccount -> " + loginAccount);
		String loginId = loginAccount.getMberId();
		MemberVO memVO = new MemberVO();
		
		// 내 정보 가져오기
		memVO = teacherService.myInfo(loginAccount.getMberId());
		log.info("stdVO: " + memVO);
		
		// 내 학교 정보 가져오기
		List<SchulPsitnMberVO> mySchulList = teacherService.mySchulList(loginId);
		log.info("mypage -> mySchulList: " + mySchulList);
		
		// 내 클래스 정보 가져오기
		List<HrtchrVO> myClassList = teacherService.myClassList(loginId);
		log.info("mypage -> myClassList: " + myClassList);
		
		model.addAttribute("memVO", memVO);
		model.addAttribute("mySchulList", mySchulList);
		model.addAttribute("myClassList", myClassList);
		
		request.setAttribute("memVO", memVO);
		
		return "teacher/mypage";
	}
	
	// 프로필 수정
	@ResponseBody
	@PostMapping("/updateInfo")
	public MemberVO updateProfile(MemberVO memVO
			, MultipartFile uploadFile
			, MultipartHttpServletRequest request) {
		log.info("updateProfile -> memVO: " + memVO);
		log.info("updateProfile -> uploadFile: " + uploadFile);
		
		memVO.setMultipartFile(uploadFile);
		
		MultipartFile multipartFile = memVO.getMultipartFile();
		
		//파일이 없어도 uploadFile은 null이 아님
		/*
		 1. 파일객체가 있음
		  - 파일복사(transferTo)
		  - memVO.setMberImage(파일명)
		 */
		if(multipartFile!=null && multipartFile.getOriginalFilename().length()>0) {	
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + multipartFile.getOriginalFilename();
			
			memVO.setMberImage(uploadFileName);
			
			String savePath = uploadFolder + "\\profile\\" + uploadFileName;
			
			File file = new File(savePath);
			
			try {
				//파일업로드
				multipartFile.transferTo(file);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*
		 2. 파일객체가 없음
		  - 파일복사는 통과함
		  - memVO의 mberImage는 null
		 */
		int result = this.teacherService.updateProfile(memVO);
		log.info("updateProfile -> result: " + result);
		
		//프로필 이미지가 바뀌든 안바뀌든 회원의 정보를 다시 가져옴
		memVO = this.teacherService.myInfo(memVO.getMberId());
		
		return memVO;
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
