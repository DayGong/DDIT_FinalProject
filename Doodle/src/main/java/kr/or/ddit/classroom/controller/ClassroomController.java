package kr.or.ddit.classroom.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.classroom.service.ClassroomService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.ChldrnClasVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.SkedVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/class")
@Controller
public class ClassroomController {

	@Autowired
	ClassroomService classroomService;
	@Autowired
	SessionService sessionService;
	
	// 학급클래스 메인
	@PostMapping("/classMain")
	public String main(HttpServletRequest request, Model model,
			@RequestParam(value = "clasCode", required = false) String clasCode,
			@RequestParam(value = "childId", required = false) String childId) {
		// 세션에 저장된 회원의 아이디 가져오기
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		
		// 학급 클래스 입장 시 클래스 정보 세션에 저장
		if(childId != null && !childId.equals("")) {
			sessionService.setClassSession(request, clasCode, childId);
		}

		sessionService.setClassSession(request, clasCode);
		
		// 해당 클래스의 담임 교사 정보 가져 오기
		HrtchrVO hrtchrVO = classroomService.clasInfoSelect(clasCode);
		
		log.debug("loginAccount -> " + loginAccount);
		log.debug("main -> hrtchrVO: " + hrtchrVO);
		
		model.addAttribute("clasCode", clasCode);
		model.addAttribute("hrtchrVO", hrtchrVO);
		request.setAttribute("hrtchrVO", hrtchrVO);

		return "class/classMain";
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
	
	//학급 시간표 조회
	@GetMapping("/schedule")
	public String schedule(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");

		return "class/schedule";
	}
	
	// 학급 시간표 목록
	@ResponseBody
	@PostMapping("/scheduleList")
	public List<SkedVO> scheduleList(HttpSession session, @RequestBody SkedVO skedVO){
		ClasVO clasVO = (ClasVO) session.getAttribute("CLASS_INFO");
		skedVO.setClasCode(clasVO.getClasCode());
		
		List<SkedVO> scheduleList = this.classroomService.scheduleList(skedVO);
		
		log.debug("skedVO->"+skedVO);
		log.debug("scheduleList -> "+scheduleList);
		
		return scheduleList;
	}
	
	// 학급 시간표 등록
	@GetMapping("/scheduleCreate")
	public String scheduleCreate(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");

		return "class/scheduleCreate";
	}
	
	// 학급시간표 등록 ajax
	@ResponseBody
	@PostMapping("/scheduleCreateAjax")
	public int scheduleCreateAjax(HttpSession session,@RequestBody  List<SkedVO> skedVOList){
		int result = this.classroomService.scheduleCreate(skedVOList);
		log.debug("skedVO-> {}",skedVOList);
		
		return result;
	}
	
	// 학급 시간표 수정
	@GetMapping("/scheduleUpdate")
	public String scheduleUpdate(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");

		return "class/scheduleUpdate";
	}
	
	// 오늘의 시간표 목록
	@ResponseBody
	@PostMapping("/todaySchedule")
	public List<SkedVO> todaySchedule(HttpServletRequest request, SkedVO skedVO){
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		skedVO.setClasCode(clasVO.getClasCode());
		
		List<SkedVO> todayScheduleList = this.classroomService.todaySchedule(clasVO.getClasCode());
		
		log.debug("skedVO->"+skedVO);
		log.debug("todayScheduleList -> "+todayScheduleList);
		
		return todayScheduleList;
	}
	
	// 학기 중복 확인
	@ResponseBody
	@PostMapping("/checkScheduleSemstr")
	public int checkScheduleSemstr(HttpSession session, @RequestBody SkedVO skedVO) {
		ClasVO clasVO = (ClasVO) session.getAttribute("CLASS_INFO");
		skedVO.setClasCode(clasVO.getClasCode());
		
		int result = this.classroomService.checkScheduleSemstr(skedVO);
		
		log.debug("skedVO->"+skedVO);
		log.debug("result ->"+result);
		
		return result;
	}
	
	/** 학급클래스(반) 목록 불러오기 */
	@ResponseBody
	@PostMapping("/classroomListAjax")
	public ArticlePage<ClasVO> classroomListAjax(@RequestBody(required = false) Map<String, Object> map) {
		ArticlePage<ClasVO> data = this.classroomService.classroomListAjax(map);
		
		return data;
	}
	
	//클래스 생성 페이지
	@GetMapping("/classCreate")
	public String classCreate(@RequestParam(value="schulCode")String schulCode, Model model, SchulPsitnMberVO schulPsitnMberVO, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		model.addAttribute("schulVO", schulVO);
		
	    return "class/classCreate";
	}
	
	//클래스 생성
	@ResponseBody
	@PostMapping("/classCreateAjax")
	public int classCreateAjax(@RequestBody ClasVO clasVO, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		
		//클래스 생성 전 중복체크
		int dupCnt = classroomService.classDupCheck(clasVO);
		
		log.debug("clasVO->:" +clasVO );
		log.debug("clasVOclasVO->:" +clasVO );
		log.debug("classCreateAjax->dupCnt:" +dupCnt);
		
		if(dupCnt>0) {//중복됨
			return 0;//실패
		}else {//중복안됨
			int result = this.classroomService.classCreateAjax(clasVO);
			
			//2) HRTCHR 테이블에 insert
			HrtchrVO hrtchrVO = new HrtchrVO();
			hrtchrVO.setSchulCode(clasVO.getSchulCode());
			hrtchrVO.setClasCode(clasVO.getClasCode());
			hrtchrVO.setMberId(memberVO.getMberId());
		
			clasVO.setHrtchrVO(hrtchrVO);
			
			result += this.classroomService.hrtchrCreate(clasVO);
			
			log.debug("인서트 후 ->:" +clasVO );
			log.debug("getMberId->:" +memberVO.getMberId() );			
			log.debug("result : " +result);
			
			return 1;//성공
		}
	}

	//학급클래스 목록
	@GetMapping("/classList")
	public String classList(HttpServletRequest request, Model model) {
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");// 세션에 저장된 클래스 정보 가져오기

		model.addAttribute("schulVO", schulVO);
		return "class/classList";
	}
	
	//학급클래스 목록 ajax
	@ResponseBody
	@PostMapping("/classListAjax")
	public ArticlePage<ClasVO> classListAjax(@RequestBody Map<String,Object> map) {
		ArticlePage<ClasVO> clasVOList = this.classroomService.classListAjax(map);
		
		return clasVOList;
	}
	
	//클래스 가입시 학교 코드 가져오기
	@ResponseBody
	@PostMapping("/selectSchulCode")
	public String selectSchulCode(@RequestBody ClasVO clasVO) {
		String schulCode = classroomService.selectSchulCode(clasVO.getClasCode());
		log.debug("schulCode-> " + schulCode);
		
		return schulCode;
	}
		
	//클래스 가입요청
	@ResponseBody
	@PostMapping("/classJoinReqAjax")
	public int classJoinReqAjax(@RequestBody ClasStdntVO clasStdntVO, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		clasStdntVO.setMberId(memberVO.getMberId());
		int result = classroomService.classJoinReqAjax(clasStdntVO);
		log.debug("인서트 후 clasStdntVO-> " + clasStdntVO);
		
		return result;
	}
	
	//클래스 가입신청 취소
	@ResponseBody
	@PostMapping("/classJoinReqCancelAajx")
	public int classJoinReqCancelAajx(@RequestBody ClasStdntVO clasStdntVO, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		clasStdntVO.setMberId(memberVO.getMberId());
		//가입취소(delete)
		int result = this.classroomService.classJoinReqCancelAajx(clasStdntVO);
		log.debug("classJoinReqCancelAajx->result"+result);
		
		return result;
	}
	
	//클래스 가입신청 목록
	@GetMapping("/classJoinReqList")
	public String classJoinReqList(HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		log.debug("CLAS_INFO >> {}",clasVO);
		
		return "class/classJoinReqList";
	}
	
	//클래스 가입신청 목록
	@ResponseBody
	@PostMapping("/classJoinReqListAjax")
	public  ArticlePage<ClasStdntVO> classJoinReqListAjax(@RequestBody(required=false) Map<String,Object> map) {
		ArticlePage<ClasStdntVO> ClasStdntVOList = this.classroomService.classJoinReqListAjax(map);
		
		return ClasStdntVOList;
	}
	
	//클래스 가입신청 처리
	@ResponseBody
	@PostMapping("/classJoinAjax")
	public int classJoinAjax(@RequestBody(required=false) ClasStdntVO clasStdntVO) {
		Date clasStdntJoinDate = clasStdntVO.getClasStdntJoinDate();
		int result = classroomService.classJoinAjax(clasStdntVO);
		
		log.debug("clasStdntVO!"+clasStdntVO);
		log.debug("clasStdntJoinDate~~"+clasStdntJoinDate);
		log.debug("classJoinAjax->result"+result);
		
		return result;
	}
	
	//선생님화면)학생 구성원 목록
	@GetMapping("/classTStudList")
	public String classTStudList(HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		
		log.debug("CLAS_INFO >> " + clasVO);
		
		return "class/classTStudList";
	}
	
	//선생님화면)학생 구성원 목록
	@ResponseBody
	@PostMapping("/classTStudListAjax")
	public ArticlePage<ClasStdntVO> classTStudListAjax(@RequestBody Map<String,Object> map) {
		ArticlePage<ClasStdntVO> ClasStdntVOList = this.classroomService.classTStudListAjax(map);
		
		return ClasStdntVOList;
	}
	
	//선생님화면)학부모 구성원 목록
	@GetMapping("/classTParentList")
	public String classTParentList(HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		
		log.debug("CLAS_INFO >> " + clasVO);
		
		return "class/classTParentList";
	}
	
	//선생님화면)학부모 구성원 목록
	@ResponseBody
	@PostMapping("/classTParentListAjax")
	public ArticlePage<ClasStdntVO> classTParentListAjax(@RequestBody Map<String,Object> map) {
		ArticlePage<ClasStdntVO> ClasStdntVOList = this.classroomService.classTParentListAjax(map);
		
		return ClasStdntVOList;
	}
	
	//구성원 상세정보
	@ResponseBody
	@PostMapping("/classMberDetailAjax")
	public MemberVO classMberDetailAjax(@RequestBody Map<String, String> map) {
		String mberId = (String)map.get("mberId");
		MemberVO memberVO = this.classroomService.classMberDetailAjax(mberId);
		log.debug("memberVOList랍니다"+memberVO);
		
		return memberVO;
	}
	
	//초대코드 보내기
	@ResponseBody
	@PostMapping("/classMailSend")
	public String classMailSend(@RequestBody Map<String, Object> memberVO) {
		//데이터 추출
		List<String> mberIds = (List<String>) memberVO.get("mberIds"); // 값을 List형식으로 가져오기
		String clasCode = (String) memberVO.get("clasCode"); // 값을 String형식으로 가져오기
		//이메일 값 가져오기
		List<String> mberEmail = this.classroomService.getEmailByMemberId(mberIds,clasCode);
		
		return "success";
	}
	
	//초대코드로 가입하기
	@ResponseBody
	@PostMapping("/classInvCodeJoin")
	public int classInvCodeJoin(@RequestBody ChldrnClasVO chldrnClasVO, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		chldrnClasVO.setMberId(memberVO.getMberId());
		
		//학부모 클래스 소속 중복체크
		int classDupCnt = this.classroomService.classDupCnt(chldrnClasVO);
		
		log.debug("chldrnClasVO!!!! {}" , chldrnClasVO);
		log.debug("classDupCnt~~ {}", classDupCnt);
		
		return classDupCnt;
	}  
	
	//학생 구성원 수정
	@ResponseBody
	@PostMapping("/classStudUpdateAjax")
	public int classStudUpdateAjax(String schulCode, String clasCode, String[] mberId
				, String[] clasInNo, String[] cmmnStdntClsfNm, String[] cmmnClasPsitnSttusNm){
		List<ClasStdntVO> clasStdntVOList = new ArrayList<ClasStdntVO>();
		int cnt = 0;
		//학생이 6명 -> 6회전
		for(String str : mberId) {
			ClasStdntVO vo = new ClasStdntVO();
			vo.setSchulCode(schulCode);
			vo.setClasCode(clasCode);
			vo.setMberId(str);
			vo.setClasInNo(Integer.parseInt(clasInNo[cnt]));
			vo.setCmmnStdntClsf(cmmnStdntClsfNm[cnt]);
			vo.setCmmnClasPsitnSttus(cmmnClasPsitnSttusNm[cnt]);
			clasStdntVOList.add(vo); //빈껍데기
			cnt++;
		}
		int result = this.classroomService.classStudUpdateAjax(clasStdntVOList);
		
		log.debug("clasStdntVOList : " + clasStdntVOList);
		log.debug("resultresult"+result);
		
		return result;
	}
	
	//학생, 학부모화면) 학생조회
	@GetMapping("/classStdntList")
	public String classStdntList(HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		log.debug("CLAS_INFO >> " + clasVO);
		
		return "class/classStdntList";
	}

	//학생, 학부모화면) 학생조회
	@ResponseBody
	@PostMapping("/classStdntListAjax")
	public ArticlePage<ClasStdntVO> classStdntListAjax(@RequestBody Map<String,Object> map) {
		ArticlePage<ClasStdntVO> clasStdntVOList = this.classroomService.classStdntListAjax(map);
		
		return clasStdntVOList;
	}
	
	//클래스 관리 할 수 있는 윈도우 창
	@GetMapping("/viewClassMgmt")
	public String viewClassMgmt(@RequestParam(value = "clasCode") String clasCode, HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");// 세션에 저장된 클래스 정보 가져오기
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("clasVO", clasVO);
		model.addAttribute("schulVO", schulVO);
		
		return "noTiles/class/viewClassMgmt";
	}
	
	//클래스 수정
	@ResponseBody
	@PostMapping("/classUpdateAjax")
	public int classUpdateAjax(@RequestBody ClasVO clasVO) {
		//수정
		int result = classroomService.classUpdateAjax(clasVO);
		log.debug("clsVO->{}",clasVO);
		
		if(result==1) {
			return result;
		}else {
			return 0;
		}
	}
	
	//클래스 삭제
	@ResponseBody
	@PostMapping("/classDeleteAjax")
	public int classDeleteAjax(@RequestBody ClasVO clasVO) {
		//삭제
		int result = classroomService.classDeleteAjax(clasVO);
		log.debug("clasCode==>"+clasVO.getClasCode());

		if(result==1) {
			return result;
		}else {
			return 0;
		}
	}
	
	//클래스 가입 거절 목록
	@GetMapping("/classJoinRJList")
	public String classJoinRJList(HttpServletRequest request, Model model) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		log.debug("CLAS_INFO >> {}",clasVO);
		
		return "class/classJoinRJList";
	}
	
	@ResponseBody
	@PostMapping("/classJoinRJListAjax")
	public  ArticlePage<ClasStdntVO> classJoinRJListAjax(@RequestBody(required=false) Map<String,Object> map) {
		ArticlePage<ClasStdntVO> ClasStdntVOList = this.classroomService.classJoinRJListAjax(map);
		
		return ClasStdntVOList;
	}
	
	//내가 속해있는 클래스 가져오기
	@ResponseBody
	@PostMapping("/getMberClasCode")
	public List<ClasStdntVO> getMberClasCode(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		List<ClasStdntVO> ClasStdntVO = classroomService.getMberClasCode(memberVO.getMberId());
		
	    return ClasStdntVO;
	}
}


