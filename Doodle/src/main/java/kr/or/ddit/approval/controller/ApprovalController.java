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
	/** 
		체험 학습 신청 과정
		1. 체험학습 신청서 제출 - 학교장 허가 현장체험학습 신청서를 정해진 기간 전까지 보호자가 작성하여 담임교사에게 제출합니다.
		2. 신청서 결재 - 담임 선생님과 교장 선생님이 전자서명으로 결재
		3. 출결 처리 및 사후 관리 - 이는 학교에서 처리하는 과정으로 학교의 학생부 기록으로 남게 됩니다.
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
		sanctnDocVO = this.approvalService.approvalDetail(docCode);
		String cmmnDocKnd = sanctnDocVO.getCmmnDocKnd();
		
		log.debug("approvalDetail->docCode : " + docCode);
		log.debug("approvalDetail->sanctnDocVO : " + sanctnDocVO);
		
		model.addAttribute("sanctnDocVO", sanctnDocVO);
		
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
		int result = this.approvalService.approvalUpdate(sanctnDocVO);
		String docCode = sanctnDocVO.getDocCode();
		
		log.debug("approvalUpdate->sanctnDocVO : " + sanctnDocVO);
		log.debug("approvalUpdate->result : " + result);
		
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
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String stdnprntId = memberVO.getMberId();
		ClasStdntVO clasStdntVO = (ClasStdntVO)request.getSession().getAttribute("CLASS_STD_INFO");
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		
		vwStdntStdnprntVO.setStdnprntId(stdnprntId);
		vwStdntStdnprntVO.setClasStdntCode(clasStdntCode);

		// 교외체험학습 관련 학부모와 학생의 정보
		vwStdntStdnprntVO = this.approvalService.studentInfo(vwStdntStdnprntVO);
		
		model.addAttribute("vwStdntStdnprntVO", vwStdntStdnprntVO);
		
		log.debug("fieldStudyApply->clasCode : " + clasCode);
		log.debug("fieldStudyApply->stdnprntId : " + stdnprntId);
		log.debug("fieldStudyApply->clasStdntCode : " + clasStdntCode);
		log.debug("fieldStudyApply->vwStdntStdnprntVO : " + vwStdntStdnprntVO);
		
		return "approval/fieldStudyApply";
	}
	
	//학부모-체험학습 보고서
	@GetMapping("/fieldStudyReport")
	public String fieldStudyReport(@RequestParam(value = "clasCode", required = false) String clasCode, Model model, HttpServletRequest request, VwStdntStdnprntVO vwStdntStdnprntVO) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String stdnprntId = memberVO.getMberId();
		ClasStdntVO clasStdntVO = (ClasStdntVO)request.getSession().getAttribute("CLASS_STD_INFO");
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		
		vwStdntStdnprntVO.setStdnprntId(stdnprntId);
		vwStdntStdnprntVO.setClasStdntCode(clasStdntCode);
		
		// 교외체험학습 관련 학부모와 학생의 정보
		vwStdntStdnprntVO = this.approvalService.studentInfo(vwStdntStdnprntVO);
		
		model.addAttribute("vwStdntStdnprntVO", vwStdntStdnprntVO);
		
		log.debug("fieldStudyReport->clasCode : " + clasCode);
		log.debug("fieldStudyApply->stdnprntId : " + stdnprntId);
		log.debug("fieldStudyReport->clasStdntCode : " + clasStdntCode);
		log.debug("fieldStudyReport->vwStdntStdnprntVO : " + vwStdntStdnprntVO);
		
		return "approval/fieldStudyReport";
	}
	
	//학부모-제출문서 등록
	@ResponseBody
	@PostMapping("/insertDoc")
	public int insertDoc(SanctnDocVO sanctnDocVO) {
		int result = this.approvalService.insertDoc(sanctnDocVO);
		
		log.debug("insertDoc->sanctnDocVO : " + sanctnDocVO);
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
		int result = approvalService.approvalSign(request, sanctnDocVO, uploadFile);
		
		log.debug("approvalSign->sanctnDocVO : " + sanctnDocVO);
		log.debug("approvalSign->result : " + result);
		
		return result;
	}
}
