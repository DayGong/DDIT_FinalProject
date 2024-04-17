package kr.or.ddit.approval.controller;



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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.etc.AuthManager;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SanctnDocSearchVO;
import kr.or.ddit.vo.SanctnDocVO;
import kr.or.ddit.vo.VwStdntStdnprntVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/approval")
@Slf4j
@Controller
public class ApprovalController {
	/** 체험 학습 신청 과정
	 1. 체험학습 신청서 제출 - 학교장 허가 현장체험학습 신청서를 정해진 기간 전까지 보호자가 작성하여 담임교사에게 제출합니다.
		(학교별 서식에 따라 작성하시면 됩니다.)
	 
	 2. 신청서 결재 - 이 과정은 학교에서 진행되는 과정입니다.
	 
	 3. 허가 여부 통보 - 체험학습 출발 전까지 보호자에게 체험학습 허가 통보서를 서면 또는 문자로 통보하게 됩니다.
		각 학교별 방식에 따르겠지요?
	 
	 4. 현장체험 학습 실시 - 목적에 맞는 안전한 현장체험 학습을 하면 됩니다.
		
	 5. 보고서 제출 - 현장학습 보고서는 종료 후 정해진 기간 안에 학교의 서식 양식에 따라서 작성하면 됩니다.
		직접 학교 홈페이지에서 출력할 수도 있고 학교 담임선생님께 부탁하면 가정으로 보내주시기도 합니다.
	 
	 6. 보고서 제출
		
	 7. 출결 처리 및 사후 관리 - 이는 학교에서 처리하는 과정으로 학교의 학생부 기록으로 남게 됩니다.

	 */
	
	@Autowired
	ApprovalService approvalService;
	
	@Autowired
	SessionService sessionService;// 세션서비스 추가
	
	@Autowired
	AuthManager authManager;
	
	//체험학습 문서 목록 페이지
	@GetMapping("/approvalList")
	public String approvalList() {
		return "approval/approvalList";
	}
	
	//체험학습 문서 목록 데이터
	@ResponseBody
	@PostMapping("/loadSanctnDocList")
	public ArticlePage<SanctnDocVO> loadSanctnDocList(HttpServletRequest request, SanctnDocSearchVO sanctnDocSearchVO){
		
		ArticlePage<SanctnDocVO> sanctnDocPage = this.approvalService.loadSanctnDocList(request, sanctnDocSearchVO);
		log.debug("loadSanctnDocList->sanctnDocPage : " + sanctnDocPage);
		
		return sanctnDocPage;
	}
	
	//체험학습 문서 상세
	@GetMapping("/approvalDetail")
	public String approvalDetail(@RequestParam(value = "docCode", required = false) String docCode, Model model, SanctnDocVO sanctnDocVO) {
		log.debug("approvalDetail->docCode : " + docCode);
		
		sanctnDocVO = this.approvalService.approvalDetail(docCode);
		log.debug("approvalDetail->sanctnDocVO : " + sanctnDocVO);
		
		model.addAttribute("sanctnDocVO", sanctnDocVO);
		
		String cmmnDocKnd = sanctnDocVO.getCmmnDocKnd();
		
		if(cmmnDocKnd.equals("A25001")) {
			return "approval/applyDetail";
		}else {
			return "approval/reportDetail";
		}
	}
	
	//학부모-체험학습 문서 수정
	@ResponseBody
	@PostMapping("/approvalUpdate")
	public int approvalUpdate(SanctnDocVO sanctnDocVO) {
		log.debug("approvalUpdate->sanctnDocVO : " + sanctnDocVO);
		
		int result = this.approvalService.approvalUpdate(sanctnDocVO);
		log.debug("approvalUpdate->result : " + result);
		
		String docCode = sanctnDocVO.getDocCode();
		
		sanctnDocVO = this.approvalService.approvalDetail(docCode);
		log.debug("approvalUpdate->sanctnDocVO후 : " + sanctnDocVO);
		
		return result;
	}
	
	//학부모-체험학습 문서 삭제
	@ResponseBody
	@PostMapping("/approvalDelete")
	public int approvalDelete(@RequestBody(required = false) SanctnDocVO sanctnDocVO) {

		int result = approvalService.approvalDelete(sanctnDocVO);
		return result;
	}
	
	//학부모-체험학습 신청서
	@GetMapping("/fieldStudyApply")
	public String fieldStudyApply(@RequestParam(value = "clasCode", required = false) String clasCode, Model model, HttpServletRequest request, VwStdntStdnprntVO vwStdntStdnprntVO) {
		log.debug("fieldStudyApply->clasCode : " + clasCode);
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String stdnprntId = memberVO.getMberId();
		log.debug("fieldStudyApply->stdnprntId : " + stdnprntId);
		
		ClasStdntVO clasStdntVO = (ClasStdntVO)request.getSession().getAttribute("CLASS_STD_INFO");
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		log.debug("fieldStudyApply->clasStdntCode : " + clasStdntCode);
		
		vwStdntStdnprntVO.setStdnprntId(stdnprntId);
		vwStdntStdnprntVO.setClasStdntCode(clasStdntCode);
		
		// 교외체험학습 관련 학부모와 학생의 정보
		vwStdntStdnprntVO = this.approvalService.studentInfo(vwStdntStdnprntVO);
		log.debug("fieldStudyApply->vwStdntStdnprntVO : " + vwStdntStdnprntVO);
		
		model.addAttribute("vwStdntStdnprntVO", vwStdntStdnprntVO);
		
		return "approval/fieldStudyApply";
	}
	//학부모-체험학습 보고서
	@GetMapping("/fieldStudyReport")
	public String fieldStudyReport(@RequestParam(value = "clasCode", required = false) String clasCode, Model model, HttpServletRequest request, VwStdntStdnprntVO vwStdntStdnprntVO) {
		log.debug("fieldStudyReport->clasCode : " + clasCode);
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String stdnprntId = memberVO.getMberId();
		log.debug("fieldStudyApply->stdnprntId : " + stdnprntId);
		
		ClasStdntVO clasStdntVO = (ClasStdntVO)request.getSession().getAttribute("CLASS_STD_INFO");
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		log.debug("fieldStudyReport->clasStdntCode : " + clasStdntCode);
		
		vwStdntStdnprntVO.setStdnprntId(stdnprntId);
		vwStdntStdnprntVO.setClasStdntCode(clasStdntCode);
		
		// 교외체험학습 관련 학부모와 학생의 정보
		vwStdntStdnprntVO = this.approvalService.studentInfo(vwStdntStdnprntVO);
		log.debug("fieldStudyReport->vwStdntStdnprntVO : " + vwStdntStdnprntVO);
		
		model.addAttribute("vwStdntStdnprntVO", vwStdntStdnprntVO);
		
		return "approval/fieldStudyReport";
	}
	
	//학부모-제출문서 등록
	@ResponseBody
	@PostMapping("/insertDoc")
	public int insertDoc(SanctnDocVO sanctnDocVO) {
		log.debug("insertDoc->sanctnDocVO : " + sanctnDocVO);
		
		int result = this.approvalService.insertDoc(sanctnDocVO);
		
		log.debug("insertDoc->result : " + result);
		
		return result;
	}
	
	
	//선생님-체험학습 거절
	@ResponseBody
	@PostMapping("/approvalRefuse")
	public int approvalRefuse(@RequestBody(required = false) SanctnDocVO sanctnDocVO) {

		int result = approvalService.approvalRefuse(sanctnDocVO);
		return result;
	}
	
	//체험학습 결재
	@ResponseBody
	@PostMapping("/approvalSign")
	public int approvalSign(HttpServletRequest request, SanctnDocVO sanctnDocVO, MultipartFile uploadFile) {
		log.debug("approvalSign->sanctnDocVO : " + sanctnDocVO);
		int result = approvalService.approvalSign(request, sanctnDocVO, uploadFile);
		log.debug("approvalSign->result : " + result);
		return result;
	}
}
