package kr.or.ddit.util.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.util.service.SessionService;

/*
 * 세션을 관리하는 컨트롤러/서비스
 * 반/학교 관련 페이지에 접근 및 퇴장했을 때 반/학교 관련 세션을 관리한다.
 * 
 * 컨트롤러 함수 목록 :
 * enterClassPageAjax  : 반 관련 페이지에 접속했을 때 반/반학생or담임교사or자녀정보 정보를 세션에 저장한다.
 * enterSchoolPageAjax : 학교 관련 페이지에 접속했을 때 학교/학교소속회원 정보를 세션에 저장한다.
 * quitClassPageAjax   : 반 관련 페이지에서 벗어났을 때  반/반학생or담임교사or자녀정보 정보를 세션에서 삭제한다.
 * quitSchoolPageAjax  : 학교 관련 페이지에서 벗어났을 때  학교/학교소속회원 정보를 세션에서 삭제한다.
 * 
 * 서비스 함수 목록 :
 * setClassSession     : 반 관련 페이지에 접속했을 때 반/반학생or담임교사or자녀정보 정보를 세션에 저장한다.
 * deleteClassSession  : 학교 관련 페이지에 접속했을 때 학교/학교소속회원 정보를 세션에 저장한다.
 * setSchoolSession    : 반 관련 페이지에서 벗어났을 때  반/반학생or담임교사or자녀정보 정보를 세션에서 삭제한다.
 * deleteSchoolSession : 학교 관련 페이지에서 벗어났을 때  학교/학교소속회원 정보를 세션에서 삭제한다.
 * 
 * 사용 방법 :
 * 1. jsp에서 세션 처리할 때
 * 1-1. 반 페이지 입장
 *      let insertData = 'CL10000001';                            // 입장할 반의 반코드 필요
 *      $.ajax({
 *         url:"/session/enterClassPageAjax",                     // 세션컨트롤러의 url로 설정  
 *         data:insertData,                                       // 컨트롤러에게 반코드 전달
 *         ...                          
 *      })
 * 1-2. 반 페이지 퇴장
 *      $.ajax({
 *         url:"/session/quitClassPageAjax",                      // 세션컨트롤러의 url로 설정
 *         ...                                                      
 *      })
 * 1-3. 학교 페이지 입장
 *      let insertData = '7581092';                               // 입장할 학교의 학교코드 필요
 *      $.ajax({
 *         url:"/session/enterSchoolPageAjax",                    // 세션컨트롤러의 url로 설정
 *         data:insertData,                                       // 컨트롤러에게 학교코드 전달  
 *         ...                
 *      })
 * 1-4. 학교 페이지 퇴장
 *      $.ajax({
 *         url:"/session/quitSchoolPageAjax",                    // 세션컨트롤러의 url로 설정
 *         ...                                                    
 *      })
 * 
 * 
 * 2. 컨트롤러에서 세션 처리할 때
 * 2-1. 반 페이지 입장
 *    @Autowired
 *    SessionService sessionService;                             // 세션서비스 추가
 *    
 *    public void 진행중인메소드(HttpServletRequest request, ...){   // 매개변수에 http서블릿리퀘스트 추가
 *       sessionService.setClassSession(request, clasCode);      // 매개변수에 request와 클래스코드를 넘겨준다.
 *       ...
 *    }
 * 2-2. 반 페이지 퇴장
 *    @Autowired
 *    SessionService sessionService;                             // 세션서비스 추가
 *    
 *    public void 진행중인메소드(HttpServletRequest request, ...){   // 매개변수에 http서블릿리퀘스트 추가
 *       sessionService.deleteClassSession(request);             // 매개변수에 request를 넘겨준다.
 *       ...
 *    }
 * 2-3. 학교 페이지 입장
 *    @Autowired
 *    SessionService sessionService;                             // 세션서비스 추가
 *    
 *    public void 진행중인메소드(HttpServletRequest request, ...){   // 매개변수에 http서블릿리퀘스트 추가
 *       sessionService.setSchoolSession(request, schulCode);    // 매개변수에 request와 학교코드를 넘겨준다.
 *       ...
 *    }
 * 2-4. 학교 페이지 퇴장
 *    @Autowired
 *    SessionService sessionService;                             // 세션서비스 추가
 *    
 *    public void 진행중인메소드(HttpServletRequest request, ...){   // 매개변수에 http서블릿리퀘스트 추가
 *       sessionService.deleteSchoolSession(request, clasCode);  // 매개변수에 request를 넘겨준다.
 *       ...
 *    }
 */

/*
 * 세션명                      	설명					타입
 * USER_INFO        회원(로그인중인)			MemberVO
 * CLASS_STD_INFO   반학생/자녀(접속중인 반의)	ClasStdntVO
 * CLASS_TCH_INFO   담임교사(접속중인 반의)		HrtchrVO
 * CLASS_INFO       반(접속중인)			ClasVO
 * SCHOOL_INFO      학교(접속중인)			SchulVO
 * SCHOOL_USER_INFO 학교소속회원(접속중인)		SchulPsitnMber
 */

@Controller
@RequestMapping("/session")
public class SessionController {

	@Autowired
	SessionService sessionService; 
	
	//반 페이지 입장 ajax 
	@PostMapping("/enterClassPageAjax")
	public int enterClassPageAjax(HttpServletRequest request, @RequestBody String clasCode) {
		return sessionService.setClassSession(request,clasCode);
	}

	// 반 페이지 퇴장 ajax 
	@PostMapping("/quitClassPageAjax")
	public int quitClassPageAjax(HttpServletRequest request) {
		return sessionService.deleteClassSession(request);
	}
	
	// 학교 페이지 입장 ajax 
	@PostMapping("/enterSchoolPageAjax")
	public int enterSchoolPageAjax(HttpServletRequest request, @RequestBody String schulCode) {
		return sessionService.setSchoolSession(request,schulCode);
	}
	
	// 학교 페이지 퇴장 ajax 
	@PostMapping("/quitSchoolPageAjax")
	public int quitSchoolPageAjax(HttpServletRequest request) {
		return sessionService.deleteSchoolSession(request);
	}
	
	// 1차 권한 학생인지 확인
	@ResponseBody
	@PostMapping("/isStudent")
	public Boolean isStudent(HttpServletRequest request) {
		return sessionService.isStudent(request);
	}
	
	// 1차 권한 교직원인지 확인
	@ResponseBody
	@PostMapping("/isEmployee")
	public Boolean isEmployee(HttpServletRequest request) {
		return sessionService.isEmployee(request);
	}

	// 1차 권한 학부모인지 확인
	@ResponseBody
	@PostMapping("/isParent")
	public Boolean isParent(HttpServletRequest request) {
		return sessionService.isParent(request);
	}

	// 교직원 권한 교장인지 확인
	@ResponseBody
	@PostMapping("/isPrincipal")
	public Boolean isPrincipal(HttpServletRequest request) {
		return sessionService.isPrincipal(request);
	}
	
	// 교직원 권한 교사인지 확인
	@ResponseBody
	@PostMapping("/isTeacher")
	public Boolean isTeacher(HttpServletRequest request) {
		return sessionService.isTeacher(request);
	}
	
	// 교직원 권한 행정인지 확인
	@ResponseBody
	@PostMapping("/isAdministration")
	public Boolean isAdministration(HttpServletRequest request) {
		return sessionService.isAdministration(request);
	}
	
	// 교직원 권한 영양사인지 확인
	@ResponseBody
	@PostMapping("/isDietitian")
	public Boolean isDietitian(HttpServletRequest request) {
		return sessionService.isDietitian(request);
	}
}
