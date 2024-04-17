package kr.or.ddit.consultation.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.consultation.service.ConsultationService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.CnsltDiarySearchVO;
import kr.or.ddit.vo.CnsltDiaryVO;
import kr.or.ddit.vo.CnsltVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

/** 학생, 학부모 상담 관리 */

@Slf4j
@RequestMapping("/cnslt")
@Controller
public class ConsultationController {

	@Autowired
	ConsultationService consultationService;

	/** 선생님의 상담 예약 목록을 출력하는 페이지로 이동 */
	@GetMapping("/goToCnsltList")
	public String goToCnsltList(HttpServletRequest request, Model model) {
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.debug("goToCnsltList CLAS_INFO => " + clasVO);
		
		model.addAttribute("clasCode", clasVO.getClasCode());
		
		return "cnslt/parentsViewCnsltList";
	}

	/** 선생님의 상담 예약 목록을 불러오는 메서드 */
	@ResponseBody
	@PostMapping("/loadCnsltResveList")
	public List<Map<String, Object>> loadCnsltResveList(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		List<Map<String, Object>> cnsltJsonArr = this.consultationService.loadCnsltResveList(map, request);
		log.debug("loadCnsltResveList cnsltJsonArr => " + cnsltJsonArr);

		return cnsltJsonArr;
	}

	/** 상담 신청 페이지로 이동하는 메서드 */
	@GetMapping("/goToStdnprntResvePage")
	public String goToStdnprntResvePage(HttpServletRequest request, Model model) {
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.debug("goToStdnprntResvePage CLAS_INFO => " + clasVO);
		
		model.addAttribute("clasCode", clasVO.getClasCode());
		
		return "cnslt/stdnprntResvePage";
	}

	/** 상담 예약 시간을 가져오는 메서드 */
	@ResponseBody
	@GetMapping("/loadTime")
	public List<String> loadTime() {
		List<String> time = this.consultationService.loadTime();
		log.debug("loadTime time => " + time);

		return time;
	}

	/** 상담 예약 내역을 불러오는 메서드 */
	@ResponseBody
	@PostMapping("/loadCnsltResve")
	public List<CnsltVO> loadCnsltResve(@RequestBody CnsltVO cnsltVO, HttpServletRequest request) {
		List<CnsltVO> cnsltTime = this.consultationService.loadCnsltResve(cnsltVO, request);
		log.debug("loadCnsltTime cnsltTime => ", cnsltTime);

		return cnsltTime;
	}

	/** 상담 예약을 저장하는 메서드 */
	@ResponseBody
	@PostMapping("/setCnsltRequest")
	public String setCnsltRequest(@RequestBody CnsltVO cnsltVO) {
		String result = this.consultationService.setCnsltRequest(cnsltVO);
		log.debug("setCnsltRequest result => " + result);

		return result;
	}

	/** 예약 개수를 가져오는 메서드 */
	@ResponseBody
	@PostMapping("/loadResveCnt")
	public String loadResveCnt(@RequestBody CnsltVO cnsltVO) {
		String result = this.consultationService.loadResveCnt(cnsltVO);
		log.debug("loadResveCnt result => " + result);

		return result;
	}

	/** 상담 예약 내역을 수정하는 페이지로 이동하는 메서드 */
	@PostMapping("/modifyCnsltResve")
	public String modifyCnsltResve(String cnsltCode, Model model, HttpServletRequest request) {
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.debug("modifyCnsltResve CLAS_INFO => " + clasVO);
		
		CnsltVO modCnsltVO = this.consultationService.modifyCnsltResve(cnsltCode);
		
		model.addAttribute("modCnsltVO", modCnsltVO);
		model.addAttribute("clasCode", clasVO.getClasCode());
		
		// param 값 전송
		request.setAttribute("cnsltResveDate", modCnsltVO.getCnsltDe());
		request.setAttribute("cnsltResveFlag", "mod");
		
		return "cnslt/stdnprntResvePage";
	}
	
	/** 상담 예약 수정을 실행하는 메서드 */
	@ResponseBody
	@PostMapping("/modifyCnsltResveAct")
	public String modifyCnsltResveAct(@RequestBody CnsltVO cnsltVO) {
		String result = this.consultationService.modifyCnsltResveAct(cnsltVO);
				
		return result;
	}
	
	/** 상담 예약 내역을 삭제하는 메서드 */
	@ResponseBody
	@PostMapping("/deleteCnsltResve")
	public int deleteCnsltResve(@RequestBody CnsltVO cnsltVO) {
		int result = this.consultationService.deleteCnsltResve(cnsltVO);
		log.debug("deleteCnsltResve result => " + result);
				
		return result;
	}
	
	/** 선생님이 상담 내역을 확인하는 메서드 */
	@GetMapping("/goToTeacherCnsltList")
	public String goToResveList(HttpServletRequest request, Model model) {
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.debug("goToResveList CLAS_INFO => " + clasVO);
		
		model.addAttribute("clasCode", clasVO.getClasCode());

		return "cnslt/teacherViewCnsltList";
	}
	
	/** 선생님이 상담 내역을 불러오는 메서드 */
	@ResponseBody
	@PostMapping("/loadTeacherCnsltResveList")
	public List<Map<String, Object>> loadTeacherCnsltResveList(@RequestBody Map<String, Object> map) {
		List<Map<String, Object>> cnsltJsonArr = this.consultationService.loadTeacherCnsltResveList(map);
		log.debug("loadTeacherCnsltResveList cnsltJsonArr => " + cnsltJsonArr);

		return cnsltJsonArr;
	}
	
	/** 상담 상태를 변경하는 메서드 */
	@ResponseBody
	@PostMapping("/changeSttus")
	public int changeSttus(@RequestBody Map<String, Object> map) {
		int result = this.consultationService.changeSttus(map);
		log.debug("changeSttus controller result => " + result);
		
		return result;
	}
	
	/** 상담 일지 자세히보기  */
	@PostMapping("/viewCnsltCnDetail")
	public String viewCnsltCnDetail(String cnsltCode, Model model) {	
		CnsltVO cnsltVO = this.consultationService.viewCnsltCnDetail(cnsltCode);
		log.debug("viewCnsltCnDetail cnsltVO => " + cnsltVO);
		
		model.addAttribute("cnsltVO", cnsltVO);
		
		return "cnslt/viewCnsltCnDetail";
	}
	
	/** 상담 일지 목록 페이지로 이동하는 메서드 */
	@GetMapping("/goToCnsltDiaryList")
	public String goToCnsltDiaryList() {
		return "cnslt/loadCnsltDiaryList";
	}
	
	/** 상담 일지 목록을 불러오는 메서드 */
	@ResponseBody
	@PostMapping("/loadCnsltDiaryList")
	public ArticlePage<CnsltVO> loadCnsltDiaryList(CnsltDiarySearchVO cnsltDiarySearchVO) {
		ArticlePage<CnsltVO> cnsltPage = this.consultationService.loadCnsltDiaryList(cnsltDiarySearchVO);
		log.debug("loadCnsltDiaryList cnsltPage => " + cnsltPage);
		
		return cnsltPage;
	}
	
	/** 상담 정보를 읽고 상담 일지를 작성하는 페이지로 이동하는 메서드 */
	@PostMapping("/insertCnsltCn")
	public String insertCnsltCn(String cnsltCode, Model model) {
		CnsltVO cnsltVO = this.consultationService.viewCnsltCnDetail(cnsltCode);
		log.debug("insertCnsltCn cnsltVO => " + cnsltVO);
		
		model.addAttribute("cnsltVO", cnsltVO);
		
		return "cnslt/insertCnsltCn";
	}
	
	/** 상담 내용을 등록/수정하는 메서드 */
	@ResponseBody
	@PostMapping("/insertCnsltCnAct")
	public int insertCnsltCnAct(CnsltDiaryVO cnsltDiaryVO) {
		log.debug("insertCnsltCnAct cnsltDiaryVO => " + cnsltDiaryVO);
		
		int result = this.consultationService.insertCnsltCnAct(cnsltDiaryVO);
		log.debug("insertCnsltCnAct result => " + result);
		
		return result;
	}
	
	/** 상담 내용을 삭제하는 메서드 */
	@ResponseBody
	@PostMapping("/delCnsltCn")
	public int delCnsltCn (String cnsltCode) {
		log.debug("delCnsltCn cnsltCode => " + cnsltCode);
		int result = this.consultationService.delCnsltCn(cnsltCode);
		log.debug("delCnsltCn result => " + result);
		
		return result;
	}
	
	/** 상담에서 학생 정보를 불러오는 윈도우 창 */
	@GetMapping("/viewChildInfo")
	public String viewChildInfo(@RequestParam(value = "mberId") String mberId, Model model, HttpServletRequest request) {
		// 학생 상세 정보를 불러오는 메서드
		ClasStdntVO clasStdntVO = this.consultationService.viewChildInfo(mberId, request);
		
		model.addAttribute("clasStdntVO", clasStdntVO);
		
		return "noTiles/cnslt/viewChildInfo";
	}

}
