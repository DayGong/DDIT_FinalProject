package kr.or.ddit.parents.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.parents.service.ParentsService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/parents")
@Controller
public class ParentsController {
	@Autowired
	String uploadFolder;
	
	@Autowired
	ParentsService parentsService;
	
	//학부모 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model, HttpServletRequest request, String mberId) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");

		String loginId = loginAccount.getMberId();
		MemberVO memVO = new MemberVO();
		// 내 정보 가져오기
		memVO = parentsService.myInfo(loginId);
		
		// 자녀 리스트 가져오기
		List<FamilyRelateVO> childList = parentsService.childList(loginId);
		List<SchulPsitnMberVO> childSchulList = new ArrayList<SchulPsitnMberVO>();
		List<ClasStdntVO> childClassList = new ArrayList<ClasStdntVO>();
		
		model.addAttribute("memVO", memVO);
		model.addAttribute("childList", childList);
		model.addAttribute("childSchulList", childSchulList);
		model.addAttribute("childClassList", childClassList);
		
		log.debug("loginAccount -> " + loginAccount);
		log.debug("mypage -> memVO: " + memVO);
		log.debug("mypage -> childList: " + childList);
		
		return "parents/mypage";
	}
	
	@ResponseBody
	@PostMapping("/getChildList")
	public List<FamilyRelateVO> getChildList(Principal principal) {
		//로그인 한 아이디를 가져옴
		String loginId = principal.getName();
		// 자녀 리스트 가져오기
		List<FamilyRelateVO> childList = parentsService.childList(loginId);
		
		log.debug("getChildList -> childList: " + childList);
		
		return childList;
	}
	
	// 프로필 수정
	@ResponseBody
	@PostMapping("/updateProfile")
	public MemberVO updateProfile(MemberVO memVO
			, MultipartFile uploadFile
			, MultipartHttpServletRequest request) {
		memVO.setMultipartFile(uploadFile);
		MultipartFile multipartFile = memVO.getMultipartFile();
		
		if(multipartFile!=null && multipartFile.getOriginalFilename().length()>0) {	
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + multipartFile.getOriginalFilename();
			
			memVO.setMberImage(uploadFileName);
			
			String savePath = uploadFolder + "\\profile\\" + uploadFileName;
			
			File file = new File(savePath);
			
			try {
				multipartFile.transferTo(file);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int result = this.parentsService.updateProfile(memVO);
		
		//프로필 이미지가 바뀌든 안바뀌든 회원의 정보를 다시 가져옴
		memVO = this.parentsService.myInfo(memVO.getMberId());
		
		log.debug("updateProfile -> memVO: " + memVO);
		log.debug("updateProfile -> uploadFile: " + uploadFile);
		log.debug("updateProfile -> result: " + result);
		
		return memVO;
	}
	
	//학부모 인증 신청(학생에게)
	@GetMapping("/parentCertification")
	public String parentCertification() {
		return "parents/parentCertification";
	}
	
	//학급클래스 신청
	@GetMapping("/classRequest")
	public String classRequest() {
		return "parents/classRequest";
	}
	
	//방과후학교 신청
	@GetMapping("/afterSchoolRequest")
	public String afterSchoolRequest() {
		return "parents/afterSchoolRequest";
	}
	
	//방과후학교 결제
	@GetMapping("/afterSchoolPay")
	public String afterSchoolPay() {
		return "parents/afterSchoolPay";
	}
}
