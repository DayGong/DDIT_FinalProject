package kr.or.ddit.school.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.school.service.SchafsSchedulService;
import kr.or.ddit.school.service.SchoolMainService;
import kr.or.ddit.util.etc.AuthManager;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DietVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/school")
@Slf4j
@Controller
public class SchoolMainController {
	
	@Autowired
	SessionService sessionService;
	@Autowired
	SchoolMainService schoolMainService;
	@Autowired
	SchafsSchedulService schafsSchedulService;
	@Autowired
	AuthManager authManager;
	
	// --------------------------학교 메인 이동--------------------------------
	
	@GetMapping("/main")
	public String main(HttpServletRequest request, @RequestParam(required = false) String schulCode){
		// 학부모는 학교 선택부터
		if(request.isUserInRole("A01003")) {
			// 학교 코드 있으면 바로 해당 학교로 입장.
			if(schulCode != null && !schulCode.equals("")) {
				return "redirect:/school/mainParent?schulCode="+schulCode;
			}
			
			sessionService.deleteClassSession(request); // 반 세션 삭제
			sessionService.deleteSchoolSession(request);// 학교 세션 삭제
			return "school/chooseStd";
		}
		
		sessionService.deleteClassSession(request); // 반 세션 삭제
		// 학교 코드 있으면 그학교로 세션 설정.
		if(schulCode != null && !schulCode.equals("")) {
			sessionService.setSchoolSession(request, schulCode); 	// 학교 세션 설정
		}else {
			sessionService.setSchoolSession(request); 	// 학교 세션 설정
		}
		
		return "school/schoolMain";
	}
	
	@GetMapping("/mainParent")
	public String mainParent(HttpServletRequest request, @RequestParam String schulCode){
		// 들어온 클래스 코드가 접속 가능한지 확인하는 로직 필요
		// ...
		
		// 반 세션 삭제
		sessionService.deleteClassSession(request);
		// 학교 세션 설정
		sessionService.setSchoolSession(request,schulCode);
		
		return "school/schoolMain";
	}
	
	

	/** 학교 메인 화면으로 이동하는 메서드 */
	@PostMapping("/goToSchoolMain")
	public String goToSchoolMain(HttpServletRequest request, Model model, String schulNm, @RequestParam("schulCode") String schulCode){
		
		if(request.isUserInRole("A01003")) {
			return "redirect:/school/mainParent?schulCode="+schulCode;
		}
		
		return "redirect:/school/main?schulCode="+schulCode;
	}
	
	// 학부모 : 자녀와 자녀의 학교 정보 get
	@ResponseBody
	@PostMapping("/getSchoolAndChildren")
	public List<SchulVO> getSchoolAndChildren(HttpServletRequest request) {
		return schoolMainService.getSchoolAndChildren(request);
	}
	
	// --------------------------학교 메인 페이지 기능--------------------------------
	
	
	
	// 가입된 클래스 목록 출력
	@ResponseBody
	@PostMapping("/myClassList")
	public List<ClasVO> myClassList(HttpServletRequest request) {

		// 로그인한 회원 ID
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = memberVO.getMberId();
		// 로그인한 회원의 회원분류
		String auth = authManager.get1Auth(memberVO);

		List<ClasVO> clasVO = schoolMainService.myClassList(request, mberId, auth);
		log.info("memberVO : "+memberVO);
		log.info("clasVO : "+clasVO);
		return clasVO;
	}

	// 메인화면 급식 목록
	@ResponseBody
	@PostMapping("/mainPageMeals")
	public List<DietVO> mainPageMeals(HttpServletRequest request){
		List<DietVO> dietVOList = schoolMainService.mainPageMeals(request);
		return dietVOList;
	}
	
	// 학사일정 목록
	@ResponseBody
	@GetMapping("/scheduleListMain")
	public List<SchafsSchdulVO> scheduleListMain(HttpServletRequest request){
		// 로그인한 회원 ID
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		String schulCode = schulVO.getSchulCode();
		
		List<SchafsSchdulVO> scheduleList = schafsSchedulService.scheduleListMain(schulCode);
		log.info("scheduleList -> " + scheduleList);
		
		return scheduleList;
	}
}
