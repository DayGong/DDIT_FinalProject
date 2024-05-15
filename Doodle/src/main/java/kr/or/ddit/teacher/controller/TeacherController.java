package kr.or.ddit.teacher.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.teacher.service.TeacherService;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/teacher")
@Controller
public class TeacherController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	PasswordEncoder passwordEncode;
	
	@Autowired
	TeacherService teacherService;
	
	//교사 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model, HttpServletRequest request, String mberId) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String loginId = loginAccount.getMberId();
		MemberVO memVO = new MemberVO();
		// 내 정보 가져오기
		memVO = teacherService.myInfo(loginAccount.getMberId());
		// 내 학교 정보 가져오기
		List<SchulPsitnMberVO> mySchulList = teacherService.mySchulList(loginId);
		// 내 클래스 정보 가져오기
		List<HrtchrVO> myClassList = teacherService.myClassList(loginId);
		
		model.addAttribute("memVO", memVO);
		model.addAttribute("mySchulList", mySchulList);
		model.addAttribute("myClassList", myClassList);
		
		request.setAttribute("memVO", memVO);
		
		log.debug("loginAccount -> " + loginAccount);
		log.debug("stdVO: " + memVO);
		log.debug("mypage -> mySchulList: " + mySchulList);
		log.debug("mypage -> myClassList: " + myClassList);
		
		return "teacher/mypage";
	}
	
	// 프로필 수정
	@ResponseBody
	@PostMapping("/updateInfo")
	public MemberVO updateProfile(MemberVO memVO
			, MultipartFile uploadFile
			, MultipartHttpServletRequest request) {
		
		memVO.setMultipartFile(uploadFile);
		
		MultipartFile multipartFile = memVO.getMultipartFile();
		
		//파일이 없어도 uploadFile은 null이 아님
		/*
		 1. 파일객체가 있음
		  - 파일복사(transferTo)
		  - memVO.setMberImage(파일명)
		 */
		if(multipartFile!=null && multipartFile.getOriginalFilename().length()>0) {	
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + multipartFile.getOriginalFilename();

			memVO.setMberImage(uploadFileName);
			
			String savePath = uploadFolder + "\\profile\\" + uploadFileName;
			File file = new File(savePath);
			
			try {
				//파일업로드
				multipartFile.transferTo(file);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*
		 2. 파일객체가 없음
		  - 파일복사는 통과함
		  - memVO의 mberImage는 null
		 */
		int result = this.teacherService.updateProfile(memVO);
		
		//프로필 이미지가 바뀌든 안바뀌든 회원의 정보를 다시 가져옴
		memVO = this.teacherService.myInfo(memVO.getMberId());
		
		log.debug("updateProfile -> memVO: " + memVO);
		log.debug("updateProfile -> uploadFile: " + uploadFile);
		log.debug("updateProfile -> result: " + result);
		
		return memVO;
	}
	
}
