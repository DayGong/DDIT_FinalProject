package kr.or.ddit.student.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.TaskResultVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/student")
@Controller
public class StudentContoller {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	StudentService studentService;
	
	//학생 마이페이지
	@GetMapping("/mypage")
	public String mypage(Model model, HttpServletRequest request, String mberId) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("loginAccount -> " + loginAccount);
		String loginId = loginAccount.getMberId();
		MemberVO memVO = new MemberVO();
		
		// 내 정보 가져오기
		memVO = studentService.myInfo(loginId);
		log.info("mypage -> memVO: " + memVO);
		
		// 내 학교 정보 가져오기
		List<SchulPsitnMberVO> mySchulList = studentService.mySchulList(loginId);
		log.info("mypage -> mySchulList: " + mySchulList);
		
		// 내 클래스 정보 가져오기
		List<ClasStdntVO> myClassList = studentService.myClassList(loginId);
		log.info("mypage -> myClassList: " + myClassList);
		
		model.addAttribute("memVO", memVO);
		model.addAttribute("mySchulList", mySchulList);
		model.addAttribute("myClassList", myClassList);
		
		request.setAttribute("memVO", memVO);
		
		return "student/mypage";
	}
	
	// 프로필 수정
	@ResponseBody
	@PostMapping("/updateProfile")
	public MemberVO updateProfile(MemberVO memVO
			, MultipartFile uploadFile
			, MultipartHttpServletRequest request) {
		log.info("updateProfile -> memVO: " + memVO);
		log.info("updateProfile -> uploadFile: " + uploadFile);
		
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
		
		int result = this.studentService.updateProfile(memVO);
		log.info("updateProfile -> result: " + result);
		
		//프로필 이미지가 바뀌든 안바뀌든 회원의 정보를 다시 가져옴
		memVO = this.studentService.myInfo(memVO.getMberId());
		
		return memVO;
	}
	
	// 칭찬 스티커 페이지로 이동
	@GetMapping("/complimentSticker")
	public String complimentSticker(HttpServletRequest request, Model model) {
		MemberVO loginAccount = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = loginAccount.getMberId();
		log.info("loginAccount: " + loginAccount);
		
		// 칭찬 스티커 수
		int complimentStickerCount = studentService.getComplimentStickerCount(mberId);
		
		// 칭찬 스티커 내역
		List<TaskResultVO> taskResultVOList = studentService.getComplimentStickerStatus(mberId);
		
		model.addAttribute("complimentStickerCount", complimentStickerCount);
		model.addAttribute("taskResultVOList", taskResultVOList);
		
		return "student/complimentSticker";
	}
	
	//학부모 인증(학생이)
	@GetMapping("/parentCertification")
	public String parentCertification() {
		return "student/parentCertification";
	}
	
	// 연월일 폴더 생성
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat();
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
}
