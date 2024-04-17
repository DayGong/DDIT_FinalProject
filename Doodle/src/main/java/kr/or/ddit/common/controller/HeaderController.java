package kr.or.ddit.common.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.service.HeaderService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/header")
@Controller
public class HeaderController {
	
	@Autowired
	HeaderService headerService;
	
	// 회원 이미지 가져오기
	@ResponseBody
	@RequestMapping(value="/getMberImage", method=RequestMethod.GET, produces="application/text;charset=utf-8")
	public String getMberImage(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("getMberImage -> memberVO: " + memberVO);
		
		String mberId = memberVO.getMberId();
		String mberImage = headerService.getMberImage(mberId);
		log.info("getMberImage -> mberImage: " + mberImage);
		
		return mberImage;
	}
	
	// 선생님의 클래스 코드 가져오기
	@ResponseBody
	@PostMapping("/getClasCode")
	public String getClasCode(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("getClasCode -> memberVO: " + memberVO);
		
		String mberId = memberVO.getMberId();
		String auth = memberVO.getVwMemberAuthVOList().get(0).getCmmnDetailCode();
		log.info("getClasCode -> auth: " + auth);
		
		String clasCode = headerService.getTeacherClasCode(mberId);
		
		log.info("getClasCode -> clasCode: " + clasCode);
		
		return clasCode;
	}
	
	// 학생의 클래스 코드와 반 소속 상태 가져오기
	@ResponseBody
	@PostMapping("/getStudentClasStatus")
	public ClasStdntVO getStudentClasStatus(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("getStudentClasStatus -> memberVO: " + memberVO);
		
		String mberId = memberVO.getMberId();

		ClasStdntVO clasStdntVO = headerService.getStudentClasStatus(mberId);
		log.info("getStudentClasStatus -> clasStdntVO: " + clasStdntVO);
		
		return clasStdntVO;
	}
	
	// 모든 알림 불러오기
	@ResponseBody
	@PostMapping("/getAllNotice")
	public List<NoticeVO> getAllNotice(HttpServletRequest request, Model model) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("getAllNotice -> loginAccount: " + loginAccount);
		
		String mberId = loginAccount.getMberId();
		
		List<NoticeVO> noticeVOList = headerService.getAllNotice(mberId);
		log.info("getAllNotice -> noticeVOList: " + noticeVOList);
		
		model.addAttribute("noticeVOList", noticeVOList);
		
		return noticeVOList;
	}
	
	// 알림을 읽었을 때 알림 열람 여부 변경
	@ResponseBody
	@PostMapping("/updateNoticeReadngAt")
	public int updateNoticeReadngAt(@RequestParam("noticeCode") String noticeCode) {
		log.info("updateNoticeReadngAt -> noticeCode: " + noticeCode);
		
		int result = headerService.updateNoticeReadngAt(noticeCode);
		log.info("updateNoticeReadngAt -> result: " + result);
		
		return result;
	}
	
	// 학부모 자녀 리스트
	@ResponseBody
	@GetMapping("/childList")
	public List<FamilyRelateVO> childList(HttpServletRequest request, Model model){
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("childList -> loginAccount: " + loginAccount);
		
		String mberId = loginAccount.getMberId();
		
		List<FamilyRelateVO> childList = headerService.childList(mberId);
		log.info("childList -> childList: " + childList);
		
		model.addAttribute("childList", childList);
		
		return childList;
	}
	
	// 알림 삭제
	@ResponseBody
	@PostMapping("/noticeDelete")
	public int noticeDelete(String[] noticeCodeArr, HttpServletRequest request) {
//		log.info("noticeDelete -> noticeCodeArr" + Arrays.toString(noticeCodeArr));
		
		// 세션에 저장된 아이디 가져오기
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = loginAccount.getMberId();
		
		List<NoticeVO> noticeVOList = headerService.getAllNotice(mberId);
		log.info("getAllNotice -> noticeVOList: " + noticeVOList);
		
		// 받아온 배열을 리스트로 변환
		List<String> noticeCodeList = Arrays.asList(noticeCodeArr);
		log.info("getAllNotice -> noticeCodeList: " + noticeCodeList);
		
		int result = headerService.noticeDelete(noticeCodeList);
		log.info("삭제 후 getAllNotice -> noticeVOList: " + noticeVOList);
		
		return result;
	}
	
	// DB에 저장된 비밀번호 해독하는 메소드
	@ResponseBody
	@GetMapping("/passwordDecode")
	public boolean passwordDecode(HttpServletRequest request, String inputPassword) {
		// 세션에 저장된 아이디 가져오기
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String password = loginAccount.getPassword();
		log.info("passwordDecode -> password: " + password);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        // 입력된 비밀번호를 해싱하여 저장된 비밀번호와 비교
        boolean passwordChk =  encoder.matches(inputPassword, password);
        
        return passwordChk;
	}
}