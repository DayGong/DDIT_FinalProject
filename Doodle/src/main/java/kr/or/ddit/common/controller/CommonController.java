package kr.or.ddit.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.util.etc.AuthManager;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {

	/*
	 * 세션명
	 * USER_INFO        회원(로그인중인)
	 * CLASS_STD_INFO   반학생(접속중인 반의)
	 * CLASS_TCH_INFO   담임교사(접속중인 반의)
	 * CLASS_INFO       반(접속중인)
	 * SCHOOL_INFO      학교(접속중인)
	 * SCHOOL_USER_INFO 학교소속회원(접속중인)
	 */

	@Autowired
	CommonService commonService;
	@Autowired
	SessionService sessionService;
	@Autowired
	PasswordEncoder passwordEncode;
	@Autowired
	AuthManager authManager;

	// 로그인 전 메인페이지(초기화면)
	@GetMapping("/")
	public String loginMain(HttpServletRequest request) {
		
		// 방문자 수와 브라우저를 등록하는 메서드
		this.commonService.addVisitrCo(request);
		
		return "/common/loginMain";
		
	}

	// 로그인 후 페이지
	@GetMapping("/main")
	public String main() {
		return "redirect:/school/main";
	}

	// 회원가입 폼 화면 출력
	@GetMapping("/signUp")
	public String signUp(Model model, String auth) {
		List<CmmnDetailCodeVO> familyChoiceList = commonService.familyCategory();
		model.addAttribute("familyChoiceList", familyChoiceList);
		model.addAttribute("auth", auth);
		log.info("auth: " + auth);
		return "common/signUp";
	}

	// 회원가입 아이디 중복체크
	@ResponseBody
	@PostMapping("/idDupChk")
	public int idDupChk(@RequestBody MemberVO memberVO){
		log.info("중복체크 memberVO-> " + memberVO.getMberId());
		int res = commonService.idDupChk(memberVO);
		log.info("DB다녀와서 vo -> " + memberVO);

		return res;
	}

	// 회원가입 학부모 자녀아이디 체크
	@ResponseBody
	@PostMapping("/childChk")
	public List<Integer> childChk(@RequestParam String idList){
		log.info("중복체크 idList-> " + idList);
		String[] array = idList.split(",");
		List<Integer> resultList = new ArrayList<Integer>();
		for(String id : array) {
			MemberVO memberVO = new MemberVO();
			memberVO.setMberId(id);
			resultList.add(commonService.childChk(memberVO));
		}
		log.info("DB다녀와서res -> " + resultList);
		return resultList;
	}

	// 회원가입 실행
	@ResponseBody
	@PostMapping("/signUpMember")
	public int signUpMember(MemberVO memberVO, @RequestParam("upload") MultipartFile uploadFile,
			@RequestParam("mberChild") List<String> mberChildIdList, @RequestParam("familyChoice") String familyChoice) {
		log.info("MemberVO의 값 -> " + memberVO);
		log.info("uploadFile.getSize()의 값 -> " + uploadFile.getSize());
		log.info("mberChildId의 값 -> " + mberChildIdList.toString());
		//자녀 수 만큼 아이디 값을 받아와야하기때문에 List로 받아옴
		log.info("mberChildId의 값 -> " + mberChildIdList.size());
		log.info("familyChoice의 값 -> " + familyChoice);
		return commonService.signUp(memberVO, uploadFile, mberChildIdList, familyChoice);
	}

	// 로그인폼 화면
	@GetMapping("/login")
	public String loginForm(String ec, Model model, @RequestParam(required = true, defaultValue = "0") String auth) {
							//ec는 에러알럿을 띄울때 구분하는 코드
							//@RequestParam(required = true, defaultValue = "0")을 사용하는 이유는 어차피 auth의 값은 1~3밖에 없기때문에
							//숫자만 받을 것이기 때문에 문자열이 못오게 기본값을 "0"으로 지정
							//권한의 정보(1 또는 2 또는 3)이 담긴 String auth로 권한 받기
		String returnUrl = "";//리턴할 jsp를 담을 변수 선언
		if("1".equals(auth) || "2".equals(auth) || "3".equals(auth)) {
			returnUrl = "/common/loginForm";//auth=1 학생 로그인 폼 페이지, auth=2 학부모 로그인 폼 페이지(회원가입이있음),auth=3 선생님 로그인 폼 페이지,
		}else {
			returnUrl = "/common/loginMain";//그외의 잘못된 값은 loginMain로 던짐
		}
		model.addAttribute("ec", ec);//jsp에 에러코드 정보 알려줌
		model.addAttribute("auth", auth);//jsp에 auth정보알려줌
		return returnUrl;

	}
	
	// 최초 로그인 비밀번호 변경
	@ResponseBody
	@PostMapping("/updatePassword")
	public int updatePassword(@RequestBody MemberVO memberVO, HttpServletRequest request) {
		log.info("updatePassword -> memVO: " + memberVO);
		
		String password = memberVO.getPassword();
		log.info("mypage -> password: " + password);
		
		// 비밀번호 암호화 작업
		String encodedPassword = this.passwordEncode.encode(password);
		log.info("encodedPw: " + encodedPassword);
		
		// 암호화된 비밀번호를 VO에 넣어줌
		memberVO.setPassword(encodedPassword);
		log.info("updateEncodedPassword -> memberVO: " + memberVO);
		
		// 비밀번호 변경
		int result = this.commonService.updatePassword(memberVO);
		log.info("updatePassword -> result: " + result);
		
		// 변경된 정보를 세션에 다시 넣어줌
		sessionService.setMemberSession(request);
		
		return result;
	}
	
	// 비밀번호 변경 대상자(최초 로그인) 선별 작업
	@ResponseBody
	@GetMapping("/firstLoginAt")
	public boolean passwordDecode(HttpServletRequest request, String password) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        // 회원 비밀번호를 해싱하여 기본 비밀번호(java)와 비교
        boolean passwordChk =  encoder.matches("java", password);
        log.info("passwordDecode -> passwordChk: " + passwordChk);
        
        return passwordChk;
	}

	// FAQ 게시판 목록
	@GetMapping("/faq")
	public String faq() {
		return "common/faq";
	}

	// 학원 조회
	@GetMapping("/academy")
	public String academy() {
		return "common/academy";
	}

	// 시큐리티 권한 에러 났을때
	@GetMapping("/accessError")
	public String accessError() {
		return "common/accessError";
	}
	
	// 현재 URL을 알아내는 메소드
	@ResponseBody
	@GetMapping("/getCurrentUrl")
	public String getCurrentUrl(HttpServletRequest request, String currentUrl) {
		log.info("currentUrl -> " + currentUrl);
		
		return currentUrl;
	}
}
