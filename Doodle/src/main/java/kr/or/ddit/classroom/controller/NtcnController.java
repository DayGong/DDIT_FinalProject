package kr.or.ddit.classroom.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.classroom.service.NtcnService;
import kr.or.ddit.common.service.HeaderService;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NtcnVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/ntcn")
@Controller
public class NtcnController {

	@Autowired
	NtcnService ntcnService;
	
	@Autowired
	HeaderService headerService;
	
	@Autowired
	SessionService sessionService;
	
	@Autowired
	String uploadFolder;
	
	// 알림장 메인 출력
	@GetMapping("/ntcnList")
	public String ntcnList(HttpServletRequest request, Model model
			,@RequestParam(value="clasCode", required=false) String clasCode
			,@RequestParam(value="currentPage", required=false) String currentPage
			,@RequestParam(value="keyword", required=false, defaultValue="") String keyword) {
		// 클래스 세션 처리
		sessionService.setClassSession(request, clasCode);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clasCode", clasCode);
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		
		List<NtcnVO> ntcnVOList = ntcnService.getNoticeList(map);
		List<AtchFileVO> atchFileList = ntcnService.atchFileList(clasCode);
		int total = ntcnService.getTotalNtcn(clasCode);
		
		model.addAttribute("clasCode", clasCode);
		model.addAttribute("keyword", keyword);
		model.addAttribute("total", total);
		model.addAttribute("ntcnVOList", ntcnVOList);
		model.addAttribute("atchFileVOList", atchFileList);
		
		log.debug("ntcnList -> clasCode: " + clasCode);
		log.debug("ntcnList -> map: " + map);
		log.debug("ntcnList -> ntcnVOList: " + ntcnVOList);
		log.debug("ntcnList -> atchFileList: " + atchFileList);
		
		return "class/ntcn";
	}
	
	// 알림장 메인 출력
	@ResponseBody
	@PostMapping("/ntcnListAjax")
	public List<NtcnVO> ntcnListAjax(HttpServletRequest request, Model model
			,@RequestBody(required=false) Map<String,Object> map) {
		String clasCode = (String) map.get("clasCode");
		map.put("clasCode", clasCode);
		map.put("currentPage", map.get("currentPage") == null ? "1" : map.get("currentPage"));
		map.put("keyword", map.get("keyword") == null ? "" : map.get("keyword"));
		List<NtcnVO> ntcnVOList = ntcnService.getNoticeList(map);
		List<AtchFileVO> atchFileList = ntcnService.atchFileList(clasCode);
		
		log.debug("ntcnListAjax -> map: " + map);
		log.debug("ntcnListAjax -> ntcnVOList: " + ntcnVOList);
		log.debug("ntcnListAjax -> atchFileList: " + atchFileList);
		
		return ntcnVOList;
	}
	
	// 알림장 첨부파일 목록
	@ResponseBody
	@PostMapping("/atchFileList")
	public List<AtchFileVO> atchFileList(HttpServletRequest request,
			@RequestParam("atchFileCode") String atchFileCode){
		List<AtchFileVO> atchFileList = ntcnService.atchFileList(atchFileCode);
				
		log.debug("ntcnList -> atchFileCode: " + atchFileCode);
		log.debug("ntcnList -> atchFileList: " + atchFileList);
		
		return atchFileList;
	}
	
	// 중요한 알림 설정
	@ResponseBody
	@PostMapping("/updateImprtcAt")
	public int updateImprtcAt(NtcnVO ntcnVO) {
		int result = ntcnService.updateImprtcAt(ntcnVO);
		
		log.debug("updateImprtcAt -> ntcnVO: " + ntcnVO);
		log.debug("updateImprtcAt -> result: " + result);
		
		return result;
	}
	
	// 알림 등록 폼 출력
	@GetMapping("/ntcnInsertForm")
	public String ntcnInsertForm(@RequestParam("clasCode") String clasCode, Model model) {
		log.debug("ntcnInsertForm -> clasCode: " + clasCode);
		
		return "class/ntcnInsertForm";
	}
	
	// 알림장 게시판 등록
	@ResponseBody
	@PostMapping("/ntcnInsert")
	public String ntcnInsert(HttpServletRequest request, NtcnVO ntcnVO) {
		// insert 결과 담을 변수 선언
		int result1 = 0;
		int result2 = 0; 
		
		// 교사 세션 가져오기
		MemberVO loginAccount =  (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = loginAccount.getMberId();
		
		// 업로드한 파일 가져오기
		MultipartFile[] multiPartFile = ntcnVO.getUploadFiles();
		
		log.debug("ntcnInsert -> ntcnVO: " + ntcnVO);
		log.debug("ntcnInsert -> multiPartFile: " + multiPartFile);
		
		// 업로드한 파일이 있는 경우에만 업로드 진행
		if(multiPartFile != null && multiPartFile.length > 0) {
			File uploadPath = new File(uploadFolder + "\\ntcn\\");
			
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			
			// 첨부 파일 코드 구해서 VO에 추가
			String atchFileCode = ntcnService.getAtchFileCode(ntcnVO.getClasCode());
			
			List<AtchFileVO> atchFileVOList = new ArrayList<AtchFileVO>();
			int sn = 1; // 순번
			
			for (MultipartFile mf : multiPartFile) {
				// 파일 복사
				try {
					UUID uuid = UUID.randomUUID();
					File fileName = new File(uploadPath, uuid.toString() + "_" + mf.getOriginalFilename());
					
					AtchFileVO atchFileVO = new AtchFileVO();

					mf.transferTo(fileName);
					atchFileVO.setAtchFileCode(atchFileCode);
					atchFileVO.setAtchFileSn(sn++);
					atchFileVO.setAtchFileCours(uuid.toString() + "_" + mf.getOriginalFilename());
					atchFileVO.setAtchFileNm(mf.getOriginalFilename());
					atchFileVO.setAtchFileTy(mf.getContentType());
					atchFileVO.setRegistId(mberId);
					
					atchFileVOList.add(atchFileVO);
					
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			
			
			// 1. 첨부파일 테이블 insert
			result1 = ntcnService.atchFileInsert(atchFileVOList);
			
			// 2. 알림장 테이블 insert
			ntcnVO.setAtchFileCode(atchFileCode);
			result2 = ntcnService.ntcnInsert(ntcnVO);
			
			log.debug("ntcnInsert -> 최종 atchFileVOList: " + atchFileVOList);
			log.debug("파일 있 ntcnInsert -> result1: " + result1);
			log.debug("ntcnInsert -> result2: " + result2);
			log.debug("ntcnInsert 후 -> ntcnVO: " + ntcnVO);
			
		}else { // 첨부파일 없는 경우, 알림장 테이블 insert만 진행
			result1 = ntcnService.ntcnInsert(ntcnVO);
			log.debug("파일 없 ntcnInsert -> result1: " + result1);
		}
		
		return ntcnVO.getNtcnCode();
	}
	
	// 알림장 수정 폼 출력
	@GetMapping("/ntcnUpdateForm")
	public String ntcnUpdateForm(String ntcnCode, Model model) {
		NtcnVO ntcnVO = ntcnService.goToUpdateForm(ntcnCode);
		String atchFileCode = ntcnVO.getAtchFileCode();
		
		log.debug("ntcnUpdateForm -> ntcnCode: " + ntcnCode);
		log.debug("ntcnUpdateForm -> ntcnVO: " + ntcnVO);
		
		model.addAttribute("ntcnVO", ntcnVO);

		// 첨부 파일 목록 있으면 같이 model에 담음
		if(atchFileCode != "" || atchFileCode != null) {
			List<AtchFileVO> atchFileList = ntcnService.atchFileList(ntcnVO.getAtchFileCode());
			model.addAttribute("atchFileList", atchFileList);
			log.debug("ntcnList -> atchFileList: " + atchFileList);
		}
		
		return "class/ntcnUpdateForm";
	}
	
	// 첨부 파일 개별 삭제
	@ResponseBody
	@PostMapping("/atchFileDeleteOne")
	public int atchFileDeleteOne(@RequestParam("atchFileCours") String atchFileCours) {
		int result = ntcnService.atchFileDeleteOne(atchFileCours);
		
		log.debug("atchFileDeleteOne -> atchFileCours: " + atchFileCours);
		log.debug("atchFileDeleteOne -> result: " + result);
		
		return result;
	}
	
	// 알림장 수정
	@ResponseBody
	@PostMapping("/ntcnUpdate")
	public String ntcnUpdate(HttpServletRequest request, NtcnVO ntcnVO) {
		// 결과 담을 변수 선언
		int result1 = 0;
		int result2 = 0; 
		
		// 교사 세션 가져오기
		MemberVO loginAccount =  (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = loginAccount.getMberId();
		
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String clasCode = clasVO.getClasCode();
		
		// 업로드한 파일 가져오기
		MultipartFile[] multiPartFile = ntcnVO.getUploadFiles();
		
		log.debug("ntcnUpdate -> ntcnVO: " + ntcnVO);
		log.debug("ntcnInsert -> multiPartFile: " + multiPartFile);
		
		// 업로드한 파일이 있는 경우에만 업로드 진행
		if(multiPartFile != null && multiPartFile.length > 0) {
			File uploadPath = new File(uploadFolder + "\\ntcn\\");
			
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			
			String atchFileCode = ntcnVO.getAtchFileCode();
			
			// 기존 글에 첨부파일이 없는 경우
			if(ntcnVO.getAtchFileCode() == "" || ntcnVO.getAtchFileCode() == null || ntcnVO.getAtchFileCode().equals("")) {
				atchFileCode = ntcnService.getAtchFileCode(clasCode);
			}
			
			List<AtchFileVO> atchFileVOList = new ArrayList<AtchFileVO>();
			int sn = ntcnService.getAtchFileSn(atchFileCode); // 순번 max값 구하기
			
			for (MultipartFile mf : multiPartFile) {
				try {
					UUID uuid = UUID.randomUUID();
					File fileName = new File(uploadPath, uuid.toString() + "_" + mf.getOriginalFilename());
					
					AtchFileVO atchFileVO = new AtchFileVO();

					mf.transferTo(fileName);
					atchFileVO.setAtchFileCode(atchFileCode);
					atchFileVO.setAtchFileSn(sn++);
					atchFileVO.setAtchFileCours(uuid.toString() + "_" + mf.getOriginalFilename());
					atchFileVO.setAtchFileNm(mf.getOriginalFilename());
					atchFileVO.setAtchFileTy(mf.getContentType());
					atchFileVO.setUpdtId(mberId);
					
					atchFileVOList.add(atchFileVO);
					
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			
			// 1. 첨부파일 테이블 처리
			result1 = ntcnService.atchFileInsert(atchFileVOList);				
			// 2. 알림장 테이블 처리
			ntcnVO.setAtchFileCode(atchFileCode);
			result2 = ntcnService.ntcnUpdate(ntcnVO);
			
			log.debug("ntcnInsert -> 최종 atchFileVOList: " + atchFileVOList);
			log.debug("파일 있 ntcnUpdate -> result1: " + result1);
			log.debug("ntcnUpdate -> result2: " + result2);
			log.debug("ntcnUpdate 후 -> ntcnVO: " + ntcnVO);
			
		}else { // 첨부파일 없는 경우, 알림장 테이블 update만 진행
			result1 = ntcnService.ntcnUpdate(ntcnVO);
			log.debug("파일 없 ntcnInsert -> result1: " + result1);
		}
		
		// 알림장 게시글 제목이 수정된 경우, 알림 제목도 같이 수정
		if(ntcnVO.getNtcnSj() != null) {
			int result3 = this.ntcnService.noticeSjUpdate(ntcnVO);
			log.debug("ntcnUpdate -> result3: " + result3);
		}
		
		return ntcnVO.getClasCode();
	}
	
	// 알림장 삭제
	@ResponseBody
	@PostMapping("/ntcnDelete")
	public int ntcnDelete(NtcnVO ntcnVO) {
		// 알림장 삭제
		int result1 = ntcnService.ntcnDelete(ntcnVO.getNtcnCode());
		
		// 첨부파일 삭제
		int result2 = this.ntcnService.atchFileDelete(ntcnVO.getAtchFileCode());
		
		// 학생/학부모 알림도 같이 삭제
		int result3 = this.ntcnService.noticeDeleteAll(ntcnVO.getNtcnCode());
		
		log.debug("ntcnDelete -> ntcnVO: " + ntcnVO);
		log.debug("taskDelete -> result1: " + result1);
		log.debug("taskDelete -> result2: " + result2);
		log.debug("taskDelete -> deleteNoticeRes: " + result3);
		
		return result1 + result2 + result3;
	}
	
	// 알림장 글 양식 불러오기
	@ResponseBody
	@RequestMapping(value="/getNtcnForm", method=RequestMethod.POST, produces="application/text;charset=utf-8")
	public String getNtcnForm(String nttNm, Model model) {
		String ntcnForm = ntcnService.getNtcnForm(nttNm);
		
		model.addAttribute("ntcnForm", ntcnForm);
		
		log.debug("getNtcnForm -> nttNm: " + nttNm);
		log.debug("getNtcnForm -> ntcnForm: " + ntcnForm);
		
		return ntcnForm;
	}
	
	// 알림 게시글 등록 -> 알림 테이블 insert
	@ResponseBody
	@PostMapping("/noticeInsertAll")
	public int noticeInsertAll(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		String clasCode = (String) map.get("clasCode");
		
		// 클래스 내 학생/학부모 리스트
		List<String> noticeRcvIdList = ntcnService.getAllClassMber(clasCode);
		
		map.put("noticeRcvIdList", noticeRcvIdList);		
		int result = ntcnService.noticeInsertAll(map);
		
		log.debug("noticeInsertAll -> map: " + map);
		log.debug("noticeInsertAll -> noticeRcvIdList: " + noticeRcvIdList);
		log.debug("noticeInsertAll -> result: " + result);
		
		return result;
	}
}
