package kr.or.ddit.classroom.controller;

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

import kr.or.ddit.classroom.service.UnitTestService;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.UnitEvlScoreVO;
import kr.or.ddit.vo.UnitEvlVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/unitTest")
@Slf4j
@Controller
public class UnitTestController {

	@Autowired
	UnitTestService unitTestService;

	// 단원평가 게시판 목록 페이지로 이동
	@GetMapping("/list")
	public String list() {
		return "unitTest/unitTestList";
	}
	
	// 단원평가 생성 페이지로 이동
	@GetMapping("/create")
	public String create() {
		return "unitTest/createUnitTest";
	}

	// 단원평가 생성(insert) ajax
	@ResponseBody
	@PostMapping("/createUnitTest")
	public int createUnitTest(HttpServletRequest request , UnitEvlVO ue) {
		return unitTestService.createUnitTest(request, ue);
	}

	// 단원평가 상세 조회로 이동
	@PostMapping("/detail")
	public String detail(Model model, @RequestParam String unitEvlCode) {
		model.addAttribute("unitEvlCode", unitEvlCode);
		return "unitTest/unitTestDetail";
	}
	
	// 단원평가 상세 정보 ajax
	@ResponseBody
	@PostMapping("/getUnitTestDetail")
	public UnitEvlVO getUnitTestDetail(@RequestBody String unitEvlCode) {
		UnitEvlVO unitEvlVO = unitTestService.detail(unitEvlCode);
		unitEvlVO.setQuesVOList(unitTestService.getQuesList(unitEvlCode));
		
		return unitEvlVO;
	}

	// 단원평가 수정
	@PostMapping("/modify")
	public String modify(Model model, @RequestParam(value = "unitEvlCode") String unitEvlCode) {
		model.addAttribute("unitEvlCode", unitEvlCode);
		return "unitTest/unitTestModify";
	}
	
	// 단원평가 삭제
	@ResponseBody
	@PostMapping("/deleteUnitTest")
	public int deleteUnitTest(@RequestBody String unitEvlCode) {
		return unitTestService.deleteUnitTest(unitEvlCode);
	}
	
	// 수정 완료
	@ResponseBody
	@PostMapping("/updateUnitTest")
	public int updateUnitTest(UnitEvlVO ue) {
		return unitTestService.updateUnitTest(ue);
	}
	
	// 단원평가 응시 페이지로 이동
	@PostMapping("/exam")
	public String exam(Model model, @RequestParam(value = "unitEvlCode", required = false) String unitEvlCode) {
		UnitEvlVO unitEvlVO = unitTestService.detail(unitEvlCode);
		unitEvlVO.setQuesVOList(unitTestService.getQuesList(unitEvlCode));
		model.addAttribute("unitEvlVO", unitEvlVO);

		log.debug("unitEvlVO:"+unitEvlVO);
		
		return "unitTest/unitTestExam";
	}

	// 성적표 insert ajax
	@ResponseBody
	@PostMapping("/makeGc")
	public int makeGc(HttpServletRequest http, @RequestBody String unitEvlCode) {
		return unitTestService.makeGc(http, unitEvlCode);
	}
	
	// 시험 종료 후 학생 답안 생성
	@PostMapping("/finishGc")
	public int finishGc(HttpServletRequest request, @RequestBody Map<String, Object> map) {
		return unitTestService.finishGc(request, map);
	}
	
	// 학생 답안 삭제
	@ResponseBody
	@PostMapping("/deleteStdRes")
	public int deleteStdRes(@RequestBody Map<String,Object> map) {
		return unitTestService.deleteStdRes(map);
	}
	
	// 상담에서 사용
	// 한명의 학생이 반에 대한 본인의 모든 시험 결과 모두 가져오기
	@ResponseBody
	@PostMapping("/getStdGcList")
	public List<UnitEvlScoreVO> getStdGcList(@RequestBody Map<String, Object> map){
		return unitTestService.getStdGcList(map);
	}
	
	// 하나의 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	@ResponseBody
	@PostMapping("/getOneUnitEvlAndAllGc")
	public List<UnitEvlScoreVO> getOneUnitEvlAllGc(HttpServletRequest request, @RequestBody String unitEvlCode){
		return unitTestService.getOneUnitEvlAndAllGc(request, unitEvlCode);
	}

	// 모든 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	@ResponseBody
	@PostMapping("/getAllUnitEvlAndAllGc")
	public List<UnitEvlScoreVO> getAllUnitEvlAndAllGc(HttpServletRequest request){
		return unitTestService.getAllUnitEvlAndAllGc(request);
	}
	
	// 학생의 학부모 정보 구하기
	@ResponseBody
	@PostMapping("/getParents")
	public List<FamilyRelateVO> getParents(@RequestBody String mberId){
		return unitTestService.getParents(mberId);
	}
	
	// 진행중인 반 단원평가
	@ResponseBody
	@PostMapping("/getDoingExam")
	public List<UnitEvlVO> getDoingExam(HttpServletRequest request){
		return unitTestService.getDoingExam(request);
	}
}
