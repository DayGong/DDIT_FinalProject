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
	@GetMapping("/employeeList")
	public String employeeList(Model model, Map<String, Object> map, HttpServletRequest request,
			@RequestParam(value = "schulCode", required = true) String schulCode,
			@RequestParam(value = "currentPage", required = true, defaultValue = "1") int currentPage) {

		map.put("schulCode", schulCode);
		map.put("currentPage", currentPage);

		List<SchulVO> schoolEmployeeVOList = this.employeeService.employeeList(map);
		model.addAttribute("schoolEmployeeVOList", schoolEmployeeVOList);
		
		log.debug("employeeList->map : " + map);
		log.debug("employeeList->schoolEmployeeVOList : " + schoolEmployeeVOList);

		return "employee/employeeList";
	}

	@ResponseBody
	@PostMapping("/employeeListAjax")
	public ArticlePage<SchulVO> employeeListAjax(@RequestBody(required = true) Map<String, Object> map) {
		// 키값 설정
		int size = 10;
		String keyword = "";
		String schulCode = (String) map.get("schulCode");
		String currentPage = map.get("currentPage").toString();
		String url = "/employee/employeeList";

		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}

		List<SchulVO> schoolEmployeeVOList = this.employeeService.employeeList(map);
		
		// 데이터 총 갯수 가져오기
		int total = this.employeeService.getEmployeeTotal(map);

		ArticlePage<SchulVO> data = new ArticlePage<SchulVO>(total, Integer.parseInt(currentPage), size, schoolEmployeeVOList, keyword, schulCode);
		data.setUrl(url);

		log.debug("employeeListAjax->map : " + map);
		log.debug("employeeList->schulCode : " + schulCode);
		log.debug("employeeList->schoolEmployeeVOList : " + schoolEmployeeVOList);
		log.debug("employeeListAjax->keyword : " + keyword);
		log.debug("employeeListAjax->total : " + total);
		log.debug("employeeList->data : " + data);

		return data;
	}

	// 교직원 상세
	@GetMapping("/employeeDetail")
	public String employeeDetail(@RequestParam(value = "schulCode", required = true) String schulCode, @RequestParam(value = "mberId", required = true) String mberId, Model model) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("schulCode", schulCode);
		map.put("mberId", mberId);

		SchulVO schulVO = this.employeeService.employeeDetail(map);
		
		model.addAttribute("schulVO", schulVO);
		
		log.debug("employeeDetail->schulCode : " + schulCode);
		log.debug("employeeDetail->mberId : " + mberId);
		log.debug("employeeDetail->schulVO" + schulVO);

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
		int result = this.employeeService.insertMember(memberVO, uploadFile);
		result += this.employeeService.insertSchoolMember(schulPsitnMberVO);
		
		log.debug("employeeCreateAjax->memberVO : " + memberVO);
		log.debug("employeeCreateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("employeeCreateAjax->result : " + result);

		return result;
	}

	// 회원가입 아이디 중복체크
	@ResponseBody
	@PostMapping("/idDupChk")
	public int idDupChk(@RequestBody MemberVO memberVO) {
		int result = employeeService.idDupChk(memberVO);
		
		log.debug("중복체크 memberVO-> " + memberVO.getMberId());
		log.debug("DB다녀와서 vo -> " + memberVO);

		return result;
	}

	// 교직원 수정
	@Transactional
	@ResponseBody
	@PostMapping("/employeeUpdateAjax")
	public int employeeUpdateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {
		int result = this.employeeService.updateMember(memberVO, uploadFile);
		result += this.employeeService.updateEmployeeSchulPsitnMber(schulPsitnMberVO);
		
		log.debug("employeeUpdateAjax->memberVO : " + memberVO);
		log.debug("employeeUpdateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("employeeUpdateAjax->result " + result);
		
		return result;
	}

	// 교직원 삭제
	@Transactional
	@ResponseBody
	@PostMapping("/employeeDeleteAjax")
	public int employeeDeleteAjax(@RequestBody SchulPsitnMberVO schulPsitnMberVO) {
		String mberId = schulPsitnMberVO.getMberId();
		int result = this.employeeService.employeeDeleteAjax(schulPsitnMberVO);
			result += this.employeeService.deleteMember(mberId);
			
		log.debug("employeeDeleteAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("employeeDeleteAjax->result : " + result);

		return result;
	}
	
	// 학생 리스트
	@GetMapping("/studentList")
	public String studentList(Model model, Map<String, Object> map, 
			@RequestParam(value = "schulCode", required = false) String schulCode,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		map.put("schulCode", schulCode);
		map.put("currentPage", currentPage);
		List<SchulVO> schoolStudentVOList = this.employeeService.studentList(map);

		model.addAttribute("schoolStudentVOList", schoolStudentVOList);

		log.debug("studentList->map : " + map);
		log.debug("studentList->schoolStudentVOList : " + schoolStudentVOList);
		
		return "employee/studentList";
	}
	
	@ResponseBody
	@PostMapping("/studentListAjax")
	public ArticlePage<SchulVO> studentListAjax(@RequestBody(required = false) Map<String, Object> map) {
		// 키값 설정
		String schulCode = (String) map.get("schulCode");
		List<SchulVO> schoolStudentVOList = this.employeeService.studentList(map);
		int size = 10;
		String currentPage = map.get("currentPage").toString();
		String url = "/employee/studentList";
		String keyword = "";
		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}
		
		// 데이터 총 갯수 가져오기
		int total = this.employeeService.getStudentTotal(map);

		ArticlePage<SchulVO> data = new ArticlePage<SchulVO>(total, Integer.parseInt(currentPage), size, schoolStudentVOList, keyword, schulCode);
		data.setUrl(url);

		log.debug("studentListAjax->map : " + map);
		log.debug("studentListAjax->schulCode : " + schulCode);
		log.debug("studentListAjax->schoolStudentVOList : " + schoolStudentVOList);
		log.debug("studentListAjax->keyword : " + keyword);
		log.debug("studentListAjax->total : " + total);
		log.debug("studentList->data : " + data);

		return data;
	}
	
	// 학생 상세
	@GetMapping("/studentDetail")
	public String studentDetail(@RequestParam(value = "schulCode", required = true) String schulCode, @RequestParam(value = "mberId", required = true) String mberId, Model model) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("schulCode", schulCode);
		map.put("mberId", mberId);
		
		SchulVO schulVO = this.employeeService.studentDetail(map);
		
		model.addAttribute("schulVO", schulVO);
		
		log.debug("studentDetail->schulCode : " + schulCode);
		log.debug("studentDetail->mberId : " + mberId);
		log.debug("studentDetail->schulVO" + schulVO);

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
		int result = this.employeeService.insertMember(memberVO, uploadFile);
		result += this.employeeService.insertSchoolStudent(schulPsitnMberVO);

		log.debug("studentCreateAjax->memberVO : " + memberVO);
		log.debug("studentCreateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("studentCreateAjax->result : " + result);
		
		return result;
	}
	
	// 학생 수정
	@ResponseBody
	@PostMapping("/studentUpdateAjax")
	public int studentUpdateAjax(MemberVO memberVO, SchulPsitnMberVO schulPsitnMberVO, MultipartFile uploadFile) {
		int result = this.employeeService.updateMember(memberVO, uploadFile);
		result += this.employeeService.updateStudentSchulPsitnMber(schulPsitnMberVO);
		
		log.debug("studentUpdateAjax->memberVO : " + memberVO);
		log.debug("studentUpdateAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("studentUpdateAjax->result " + result);
		
		return result;
	}
	
	// 학생 삭제
	@Transactional
	@ResponseBody
	@PostMapping("/studentDeleteAjax")
	public int studentDeleteAjax(@RequestBody SchulPsitnMberVO schulPsitnMberVO) {
		String mberId = schulPsitnMberVO.getMberId();
		int result = this.employeeService.studentDeleteAjax(schulPsitnMberVO);
		result += this.employeeService.deleteMember(mberId);

		log.debug("studentDeleteAjax->schulPsitnMberVO : " + schulPsitnMberVO);
		log.debug("schulPsitnMberVO-> " + schulPsitnMberVO);
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
		String result = this.employeeService.selectMaxId(cmmnDetailCode);
		
		log.debug("selectMaxId->cmmnDetailCode : " + cmmnDetailCode);
		log.debug("selectMaxId->result : " + result);
		
		return result;
	}
}
