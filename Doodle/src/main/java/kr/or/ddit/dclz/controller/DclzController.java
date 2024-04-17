package kr.or.ddit.dclz.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dclz.service.DclzService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.DclzVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dclz")
public class DclzController {

	@Autowired
	DclzService dclzService;
	
	// 출결 관리 페이지
	@GetMapping("/main")
	public String main(){
		return "dclz/dclzMain";
	}
	
	// (학생) 등교 하교 기록
	@ResponseBody
	@PostMapping("/insertStdDclz")
	public int insertStdDclz(HttpServletRequest request){
		int cnt = dclzService.insertStdDclz(request);
		log.info("cnt : "+cnt);
		return cnt;
	}

	// (교사) 학생 등교 하교 기록
	@ResponseBody
	@PostMapping("/insertDclz")
	public int insertDclz(HttpServletRequest request ,@RequestBody String clasStdntCode){
		if(!request.isUserInRole("ROLE_A01002")){ return 0; }
		int cnt = dclzService.insertDclz(clasStdntCode);
		log.info("cnt : "+cnt);
		return cnt;
	}

	// 출결 정보 get
	@ResponseBody
	@PostMapping("/getAllDclz")
	public List<DclzVO> getAllDclz(HttpServletRequest request){
		return dclzService.getAllDclz(request);
	}
	
	// 반학생 정보 get
	@ResponseBody
	@PostMapping("/getAllClasStd")
	public List<ClasStdntVO> getAllClasStd(HttpServletRequest request){
		if(!request.isUserInRole("ROLE_A01002")){ return null; }
		return dclzService.getAllClasStd(request);
	}
	
	// 출결 처리 상태 목록 get
	@ResponseBody
	@PostMapping("/getDclzCmmn")
	public List<CmmnDetailCodeVO> getDclzCmmn(HttpServletRequest request){
		if(!request.isUserInRole("ROLE_A01002")){ return null; }
		return dclzService.getDclzCmmn();
	}

	// 출결 처리 상태 변경
	@ResponseBody
	@PostMapping("/updateDclzCmmn")
	public int updateDclzCmmn(HttpServletRequest request, @RequestBody Map<String, Object> map){
		if(!request.isUserInRole("ROLE_A01002")){ return 0; }
		
		// 잘못된 상태 값
		String cmmnDetailCode = (String) map.get("cmmnDetailCode");
		log.info("cmmnDetailCode: " + cmmnDetailCode);
		log.info("cmmnDetailCode.substring(0,3): " + cmmnDetailCode.substring(0,3));
		if(!cmmnDetailCode.substring(0,3).equals("A06")) { return 0; }
		
		// 접속 반 세션과 일치하지 않은 학생일 때 불가
//		ClasVO clasVO = (ClasVO)request.getSession().getAttribute("CLAS_INFO");
//		String clasStdntCode = (String) map.get("clasStdntCode");
//		ClasStdntVO std = dclzService.getClasStdntVOWithClasStdntCode(clasStdntCode);
//		if(std.getClasCode() != clasVO.getClasCode()) {
//			return 0;
//		}
		
		return dclzService.updateDclzCmmn(map);
	}
	
	// 최근 출결 정보
	@ResponseBody
	@PostMapping("/getRecentAtend")
	public List<DclzVO> getRecentAtend(HttpServletRequest request, @RequestBody Map<String, Object> map){
		String sendClasCode = (String)map.get("clasCode");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션 클래스 코드와 입력 클래스코드가 같지 않음.
		if(sendClasCode != null && !sendClasCode.equals(clasVO.getClasCode())) {
			return null;
		};
		// 전체 검색 시 교장과 행정직만 가능.
		if(sendClasCode == null && !(request.isUserInRole("A14001") || request.isUserInRole("A14003"))){
			return null;
		}
		
		return dclzService.getRecentAtend(map);
	}
}
