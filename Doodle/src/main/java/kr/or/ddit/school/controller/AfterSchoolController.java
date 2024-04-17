package kr.or.ddit.school.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.school.service.AfterSchoolService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AschaDclzVO;
import kr.or.ddit.vo.AschaVO;
import kr.or.ddit.vo.AtnlcReqstVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/afterSchool")
@Slf4j
@Controller
public class AfterSchoolController {
	
	@Autowired
	AfterSchoolService afterSchoolService;
	
	//방과후학교 목록
	@GetMapping
	public String afterSchool(
			HttpServletRequest request, Model model,
			@RequestParam(value="schulCode", required=false) String schulCode) {
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");

		// 학부모일때
		if (request.isUserInRole("ROLE_A01003")) {
			ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO") ;
			model.addAttribute("schulCode", clasStdntVO.getMberId());
			log.debug("CLASS_STD_INFO >> " + clasStdntVO);
		// 교사, 학생일때	
		} else {
			MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
			log.debug("USER_INFO >> " + memberVO);
			model.addAttribute("mberId", memberVO.getMberId());
		}

//		afterSchool->schulCode : 7581092
		log.debug("SCHOOL_INFO >> " + schulVO);
		model.addAttribute("schulCode", schulVO.getSchulCode());
		
		return "afterSchool/afterSchoolList";
	}
	
	// 방과후학교 목록 ajax
	// /afterSchool?currentPage=2&keyword=
	@ResponseBody
	@PostMapping("/afterSchoolList")
	public ArticlePage<AschaVO> afterSchoolListAjax(@RequestBody Map<String, Object> map) {
		//map : {currentPage=2, keyword=, schulCode=7581092}
		log.info("afterSchoolListAjax->map : "+map);
		
		// 방과후학교 리스트
		List<AschaVO> aschaVOList = this.afterSchoolService.afterSchoolList(map);
		log.info("afterSchoolList -> aschaVOList : " + aschaVOList);
		
		// 전체 방과후학교 수
		int total = this.afterSchoolService.getTotalAfterSchool(map);
		//afterSchoolList -> total : 18
		log.info("afterSchoolList -> total : " + total);
		int size = 10;
		
		String keyword = map.get("keyword").toString();
		log.info("afterSchoolList ->keyword : "+keyword);
		
		// 페이지네이션
		ArticlePage<AschaVO> data = new ArticlePage<AschaVO>(total,
				Integer.parseInt(map.get("currentPage").toString()), size, aschaVOList, keyword, map.get("schulCode").toString(), map.get("schulCode").toString());
		
		String url = "/afterSchool/afterSchoolList";
		data.setUrl(url);
		
		log.info("aschaVOList : "+aschaVOList);
		
		return data;
	}
	
	// 방과후학교 상세
	@ResponseBody
	@PostMapping("/afterSchoolDetail")
	public List<AschaVO> afterSchoolDetail(@RequestBody AschaVO aschaVO) {
		log.info("detail->aschaVO : "+aschaVO);
		
		// ajax에서 보낸 데이터
		aschaVO.getSchulCode();
		aschaVO.getAschaCode();
		
		List<AschaVO> aschaVOList = this.afterSchoolService.afterSchoolDetail(aschaVO);
		
		log.info("detail->aschaVOList : "+aschaVOList);
		
		return aschaVOList;
	}
	
	// 방과후학교 생성
	@GetMapping("/afterSchoolCreate")
	public String afterSchoolCreate(@RequestParam(value="schulCode") String schulCode) {
		
		return "afterSchool/afterSchoolCreate";
	}
	
	// 방과후학교 생성 ajax
	@ResponseBody
	@PostMapping("/afterSchoolCreateAjax")
	public int afterSchoolCreateAjax(HttpServletRequest request, Model model,
				AschaVO aschaVO) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("loginAccount -> " + memberVO);
		model.addAttribute("mberId", memberVO.getMberId());
		aschaVO.setMberId(memberVO.getMberId());
		
		log.info("afterSchoolCreateAjax -> aschaVO : "+ aschaVO);
		
		int result = this.afterSchoolService.afterSchoolCreate(aschaVO);
		log.info("afterSchoolCreateAjax -> result :" +result);
		
		return result;
	}
	
	// 방과후학교 수정
	@GetMapping("/afterSchoolUpdate")
	public String afterSchoolUpdate(@RequestParam(value="aschaCode") String aschaCode,
									@RequestParam(value="schulCode") String schulCode) {
		return "afterSchool/afterSchoolUpdate";
	}
	
	// 방과후학교 수정 ajax
	@ResponseBody
	@PostMapping("/afterSchoolUpdateAjax")
	public int afterSchoolUpdateAjax(AschaVO aschaVO) {
		log.info("afterSchoolUpdateAjax -> aschaVO : "+aschaVO);
		
		int result = this.afterSchoolService.afterSchoolUpdate(aschaVO);
		log.info("afterSchoolUpdateAjax -> aschaVO" + aschaVO);
		
		return result;
	}
	
	// 방과후학교 삭제
	@ResponseBody
	@PostMapping("/afterSchoolDelete")
	public int afterSchoolDelete(@RequestBody AschaVO aschaVO) {
		log.info("afterSchoolDelete -> aschaVO :" +aschaVO);
		aschaVO.getAschaCode();
		
		int result = this.afterSchoolService.afterSchoolDelete(aschaVO);
		log.info("afterSchoolDelete -> aschaCode! "+aschaVO);
		
		return result;
	}
	
	// 방과후학교 관리 메인화면
	@GetMapping("/afterSchoolMain")
	public String afterSchoolMain(HttpServletRequest request, Model model,
					@RequestParam(value="mberId") String mberId,
					@RequestParam(value="schulCode") String schulCode) {
		
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("loginAccount -> " + loginAccount);
		
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		model.addAttribute("schulCode", schulVO.getSchulCode());
		
		return "afterSchool/afterSchoolMain";
	}
	
	// 교사의 방과후화면 개설 목록
	@ResponseBody
	@GetMapping("/afterSchoolTeacherList")
	public List<AschaVO> afterSchoolTeacherList(@RequestParam(value = "mberId") String mberId) {
		log.info("afterSchoolTeacherList -> mberId :" + mberId);
		List<AschaVO> aschaVOList = this.afterSchoolService.afterSchoolTeacherList(mberId);
		log.info("aschaVOList :" + aschaVOList);

		return aschaVOList;
	}

	// 과목당 수강중인 학생들
	@ResponseBody
	@PostMapping("/lectureStudentList")
	public List<AschaVO> lectureStudentList(@RequestBody AschaVO aschaVO){
		log.info("lectureStudentList -> aschaVO : "+aschaVO);
		
		List<AschaVO> atnlcReqstVOList=this.afterSchoolService.lectureStudentList(aschaVO);
		log.info("atnlcReqstVOList : "+atnlcReqstVOList);
		
		return atnlcReqstVOList;
	}
	
	// 수강신청 상태 변경
	@ResponseBody
	@PostMapping("/lectureStateUpdate")
	public int lectureStateUpdate(@RequestBody AtnlcReqstVO atnlcReqstVO) {
		log.info("lectureStateUpdate -> aschaVO : "+atnlcReqstVO);
		
		int result = this.afterSchoolService.lectureStateUpdate(atnlcReqstVO);
		
		return result;
	}
	
	// 학생, 학부모 방과후학교 메인화면
	@GetMapping("/afterSchoolStdntMain")
	public String afterSchoolStdntMain(HttpServletRequest request, Model model,
			@RequestParam(value="mberId") String mberId) {
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		model.addAttribute("schulCode", schulVO.getSchulCode());
		
		// 학부모일때
		if (request.isUserInRole("ROLE_A01003")) {
			ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO") ;
			model.addAttribute("schulCode", clasStdntVO.getMberId());
			log.debug("CLASS_STD_INFO >> " + clasStdntVO);
		// 학생일때	
		} else {
			MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
			model.addAttribute("mberId", memberVO.getMberId());
			log.debug("USER_INFO >> " + memberVO);
		}

		return "afterSchool/afterSchoolStdntMain";
	}
	
	// 학생이 수강신청한 방과후학교 목록
	@ResponseBody
	@GetMapping("/afterSchoolLectureList")
	public List<AschaVO> afterSchoolLectureList(@RequestParam(value="mberId") String mberId){
		log.info("afterSchoolLectureList -> mberId : "+ mberId);
		List<AschaVO> aschaVOList = this.afterSchoolService.afterSchoolLectureList(mberId);
		log.info("aschaVOList :" + aschaVOList);
		
		return aschaVOList;
	}
	
	// 결제내역 insert
	@ResponseBody
	@PostMapping("/afterSchoolPayment")
	public int afterSchoolPayment(@RequestBody AtnlcReqstVO atnlcReqstVO) {
		log.info("atnlcReqstVO :" +atnlcReqstVO);
		
		int result = this.afterSchoolService.afterSchoolPayment(atnlcReqstVO);
		log.info("afterSchoolPayment-> result : "+ result);
		
		return result;
	}
	
	// 출석부 목록
	@ResponseBody
	@PostMapping("/attendanceList")
	public List<AschaVO> attendanceList(@RequestBody AschaVO aschaVO){
		log.info("attendanceList -> aschaVO : "+aschaVO);
		List<AschaVO> atnlcReqstVOList=this.afterSchoolService.attendanceList(aschaVO);
		
		return atnlcReqstVOList;
	}
	
	// 출결정보 등록
	@ResponseBody
	@PostMapping("/attendanceInsert")
	public int attendanceInsert(@RequestBody AschaDclzVO aschaDclzVO) {
		log.info("attendanceInsert -> aschaDclzVO : "+aschaDclzVO);
		int result = this.afterSchoolService.attendanceInsert(aschaDclzVO);
		
		return result;
	}

	// 출결정보 수정
	@ResponseBody
	@PostMapping("/attendanceUpdate")
	public int attendanceUpdate(@RequestBody AschaDclzVO aschaDclzVO) {
		log.info("attendanceUpdate -> aschaDclzVO:"+aschaDclzVO);
		int result = this.afterSchoolService.attendanceUpdate(aschaDclzVO);
		
		return result;
	}
	
	// 출결정보 삭제
	@ResponseBody
	@PostMapping("/attendanceDelete")
	public int attendanceDelete(@RequestBody AschaDclzVO aschaDclzVO) {
		log.info("attendanceDelete -> aschaDclzVO :" +aschaDclzVO);
		int result = this.afterSchoolService.attendanceDelete(aschaDclzVO);
		
		return result;
	}

	// 학생, 학부모 방과후학교 )출석부 목록
	@ResponseBody
	@PostMapping("/studAttendanceList")
	public List<AtnlcReqstVO> studAttendanceList(@RequestBody AtnlcReqstVO atnlcReqstVO){
		log.debug("attendanceList -> aschaVO : "+atnlcReqstVO);

		List<AtnlcReqstVO> aschaDclzVOList=this.afterSchoolService.studAttendanceList(atnlcReqstVO);
		log.debug("aschaDclzVOList -> :"+aschaDclzVOList);
		
		return aschaDclzVOList;
	}	
}
