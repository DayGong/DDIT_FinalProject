package kr.or.ddit.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.employee.service.EmployeeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/employee")
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	// 교직원 리스트
	/*
	 * 요청URI : /employee/employeeList?schulCode=7581092 요청파라미터 : schulCode = 7581092
	 * 요청방식 : get
	 */
	@GetMapping("/employeeList")
	public String employeeList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "schulCode", required = true) String schulCode,
			@RequestParam(value = "currentPage", required = true, defaultValue = "1") int currentPage) {

		map.put("schulCode", schulCode);
		map.put("currentPage", currentPage);
		log.debug("employeeList->map : " + map);

		List<SchulVO> schoolEmployeeVOList = this.employeeService.employeeList(map);
		log.debug("employeeList->schoolEmployeeVOList : " + schoolEmployeeVOList);

		model.addAttribute("schoolEmployeeVOList", schoolEmployeeVOList);

		return "employee/employeeList";
	}

	/*
	 * 요청URI : /employee/employeeListAjax? 요청파라미터(json) :
	 * {"schulCode":7581092,"keyword":"신용","currentPage":3} 요청방식 : post
	 * 
	 * 골뱅이ResponseBody : object -> string 으로 변환하는 방식을 serialize required=false :
	 * 선택(map에 아무것도 들어오지 않아도 괜찮다)
	 */
	@ResponseBody
	@PostMapping("/employeeListAjax")
	public ArticlePage<SchulVO> employeeListAjax(@RequestBody(required = true) Map<String, Object> map) {
		// 키값 설정
		log.debug("employeeListAjax->map : " + map);
		String schulCode = (String) map.get("schulCode");
		log.debug("employeeList->schulCode : " + schulCode);

		List<SchulVO> schoolEmployeeVOList = this.employeeService.employeeList(map);
		log.debug("employeeList->schoolEmployeeVOList : " + schoolEmployeeVOList);

		int size = 10;

		String currentPage = map.get("currentPage").toString();

		String keyword = "";
		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}
		log.debug("employeeListAjax->keyword : " + keyword);

		// 데이터 총 갯수 가져오기
		int total = this.employeeService.getEmployeeTotal(map);
		log.debug("employeeListAjax->total : " + total);

		ArticlePage<SchulVO> data = new ArticlePage<SchulVO>(total, Integer.parseInt(currentPage), size,
				schoolEmployeeVOList, keyword, schulCode);
		String url = "/employee/employeeList";
		data.setUrl(url);

		log.debug("employeeList->data : " + data);

		return data;
	}

	/**
	 * 요청URI : /employee/employeeDetail?mberId=758109210011 요청파라미터 :
	 * {mberId=758109210011} 요청방식 : get
	 */
	// 교직원 상세
	@GetMapping("/employeeDetail")
	public String employeeDetail(@RequestParam(value = "schulCode", required = true) String schulCode, @RequestParam(value = "mberId", required = true) String mberId, Model model) {
		log.debug("employeeDetail->schulCode : " + schulCode);
		log.debug("employeeDetail->mberId : " + mberId);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("schulCode", schulCode);
		map.put("mberId", mberId);
		
		SchulVO schulVO = this.employeeService.employeeDetail(map);
		log.debug("employeeDetail->schulVO" + schulVO);

		model.addAttribute("schulVO", schulVO);
		return "employee/employeeDetail";
	}

	// 교직원 등록
	@GetMapping("/employeeCreate")
	public String employeeCreate() {
		return "employee/employeeCreate";
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/employeeCreateAjax")
	public int employeeCreateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {

		log.debug("employeeCreateAjax->memberVO : " + memberVO);
		log.debug("employeeCreateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		int result = this.employeeService.insertMember(memberVO, uploadFile);
		result += this.employeeService.insertSchoolMember(schulPsitnMberVO);
		log.debug("employeeCreateAjax->result : " + result);

		return result;
	}

	// 회원가입 아이디 중복체크
	@ResponseBody
	@PostMapping("/idDupChk")
	public int idDupChk(@RequestBody MemberVO memberVO) {
		log.debug("중복체크 memberVO-> " + memberVO.getMberId());
		int result = employeeService.idDupChk(memberVO);
		log.debug("DB다녀와서 vo -> " + memberVO);

		return result;
	}

	// 교직원 수정
	@Transactional
	@ResponseBody
	@PostMapping("/employeeUpdateAjax")
	public int employeeUpdateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {
		
		log.debug("employeeUpdateAjax->memberVO : " + memberVO);
		log.debug("employeeUpdateAjax->schulPsitnMberVO : " + schulPsitnMberVO);

		int result = this.employeeService.updateMember(memberVO, uploadFile);
		result += this.employeeService.updateEmployeeSchulPsitnMber(schulPsitnMberVO);
		log.debug("employeeUpdateAjax->result " + result);
		
		return result;
	}

	// 교직원 삭제
	@Transactional
	@ResponseBody
	@PostMapping("/employeeDeleteAjax")
	public int employeeDeleteAjax(@RequestBody SchulPsitnMberVO schulPsitnMberVO) {
		log.debug("employeeDeleteAjax->schulPsitnMberVO : " + schulPsitnMberVO);

		String mberId = schulPsitnMberVO.getMberId();

		log.debug("schulPsitnMberVO-> " + schulPsitnMberVO);

		int result = this.employeeService.employeeDeleteAjax(schulPsitnMberVO);
			result += this.employeeService.deleteMember(mberId);
		log.debug("employeeDeleteAjax->result : " + result);

		return result;
	}
	
	// 학생 리스트
	/*
	 * 요청URI : /employee/employeeList?schulCode=7581092 요청파라미터 : schulCode = 7581092
	 * 요청방식 : get
	 */
	@GetMapping("/studentList")
	public String studentList(Model model, Map<String, Object> map, 
			@RequestParam(value = "schulCode", required = false) String schulCode,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		map.put("schulCode", schulCode);
		map.put("currentPage", currentPage);
		log.debug("studentList->map : " + map);

		List<SchulVO> schoolStudentVOList = this.employeeService.studentList(map);
		log.debug("studentList->schoolStudentVOList : " + schoolStudentVOList);

		model.addAttribute("schoolStudentVOList", schoolStudentVOList);

		return "employee/studentList";
	}
	
	@ResponseBody
	@PostMapping("/studentListAjax")
	public ArticlePage<SchulVO> studentListAjax(@RequestBody(required = false) Map<String, Object> map) {
		// 키값 설정
		log.debug("studentListAjax->map : " + map);
		String schulCode = (String) map.get("schulCode");
		log.debug("studentListAjax->schulCode : " + schulCode);

		List<SchulVO> schoolStudentVOList = this.employeeService.studentList(map);
		log.debug("studentListAjax->schoolStudentVOList : " + schoolStudentVOList);

		int size = 10;

		String currentPage = map.get("currentPage").toString();

		String keyword = "";
		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}
		log.debug("studentListAjax->keyword : " + keyword);

		// 데이터 총 갯수 가져오기
		int total = this.employeeService.getStudentTotal(map);
		log.debug("studentListAjax->total : " + total);

		ArticlePage<SchulVO> data = new ArticlePage<SchulVO>(total, Integer.parseInt(currentPage), size,
				schoolStudentVOList, keyword, schulCode);
		String url = "/employee/studentList";
		data.setUrl(url);

		log.debug("studentList->data : " + data);

		return data;
	}
	
	// 학생 상세
	@GetMapping("/studentDetail")
	public String studentDetail(@RequestParam(value = "schulCode", required = true) String schulCode, @RequestParam(value = "mberId", required = true) String mberId, Model model) {
		log.debug("studentDetail->schulCode : " + schulCode);
		log.debug("studentDetail->mberId : " + mberId);

		Map<String,Object> map = new HashMap<String, Object>();
		map.put("schulCode", schulCode);
		map.put("mberId", mberId);
		
		SchulVO schulVO = this.employeeService.studentDetail(map);
		log.debug("studentDetail->schulVO" + schulVO);

		model.addAttribute("schulVO", schulVO);
		return "employee/studentDetail";
	}
	
	// 학생 등록
	@GetMapping("/studentCreate")
	public String studentCreate() {
		return "employee/studentCreate";
	}

	@ResponseBody
	@PostMapping("/studentCreateAjax")
	public int studentCreateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {

		log.debug("studentCreateAjax->memberVO : " + memberVO);
		log.debug("studentCreateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		int result = this.employeeService.insertMember(memberVO, uploadFile);
		result += this.employeeService.insertSchoolStudent(schulPsitnMberVO);
		log.debug("studentCreateAjax->result : " + result);

		return result;
	}
	
	// 학생 수정
	@ResponseBody
	@PostMapping("/studentUpdateAjax")
	public int studentUpdateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {

		log.debug("studentUpdateAjax->memberVO : " + memberVO);
		log.debug("studentUpdateAjax->schulPsitnMberVO : " + schulPsitnMberVO);

		int result = this.employeeService.updateMember(memberVO, uploadFile);
		result += this.employeeService.updateStudentSchulPsitnMber(schulPsitnMberVO);
		log.debug("studentUpdateAjax->result " + result);
		
		return result;
	}
	
	// 학생 삭제
	@Transactional
	@ResponseBody
	@PostMapping("/studentDeleteAjax")
	public int studentDeleteAjax(@RequestBody SchulPsitnMberVO schulPsitnMberVO) {
		log.debug("studentDeleteAjax->schulPsitnMberVO : " + schulPsitnMberVO);

		String mberId = schulPsitnMberVO.getMberId();
		

		log.debug("schulPsitnMberVO-> " + schulPsitnMberVO);

		int result = this.employeeService.studentDeleteAjax(schulPsitnMberVO);
			result += this.employeeService.deleteMember(mberId);
		log.debug("studentDeleteAjax->result : " + result);

		return result;
	}
	
	//엑셀 파일 업로드로 등록
	@ResponseBody
	@PostMapping("/excelResgistration")
	public List<HashMap<Integer, String>>excelResgistration(@RequestParam("upload") MultipartFile upload){
		
		List<HashMap<Integer, String>> excelList = employeeService.excelResgistration(upload);
		
		return excelList;
	}
	
	//아이디 최대값
	@ResponseBody
	@PostMapping("/selectMaxId")
	public String selectMaxId(@RequestBody String cmmnDetailCode) {
		log.debug("selectMaxId->cmmnDetailCode : " + cmmnDetailCode);
		String result = this.employeeService.selectMaxId(cmmnDetailCode);
		log.debug("selectMaxId->result : " + result);
		return result;
	}
}
