package kr.or.ddit.util.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.CommonMapper;
import kr.or.ddit.util.etc.AuthManager;
import kr.or.ddit.util.mapper.SessionMapper;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SessionServiceImpl implements SessionService {

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
	 * 세션명                      설명					타입
	 * USER_INFO        회원(로그인중인)		MemberVO
	 * CLASS_STD_INFO   반학생/자녀(접속중인 반의)	ClasStdntVO
	 * CLASS_TCH_INFO   담임교사(접속중인 반의)	HrtchrVO
	 * CLASS_INFO       반(접속중인)			ClasVO
	 * SCHOOL_INFO      학교(접속중인)			SchulVO
	 * SCHOOL_USER_INFO 학교소속회원(접속중인)	SchulPsitnMber
	 */
	
	@Autowired
	SessionMapper sessionMapper;
	@Autowired
	AuthManager authManager;
	@Autowired
	CommonMapper commonMapper;
	
	// 반/담임교사or반학생or자녀 정보 session에 저장 
	@Override
	public int setClassSession(HttpServletRequest request, String clasCode, String childId) {
		// 로그인한 회원 정보 get
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		String auth = authManager.get1Auth(memberVO);
		
		// 입장한 반 정보 session에 저장
		ClasVO clasVO = sessionMapper.getEnterClasVO(clasCode);
		request.getSession().setAttribute("CLASS_INFO", clasVO);    // ClasVO

		// 입장한 반의 학교 정보 session에 저장
		setSchoolSession(request, clasVO.getSchulCode());
		
		// 반학생or담임교사or자녀 정보 session 저장에 필요한 쿼리문에 필요한 값 세팅
		Map<String, Object> map = new HashMap<String, Object>();
		// 학부모라서 학생의 Id를 전달받았을 땐 학생 id로.
		if(childId != null && !childId.equals("")) {
			map.put("mberId", childId);
		}else {
			map.put("mberId", memberVO.getMberId());
		}
		map.put("clasCode",clasVO.getClasCode());

		log.info("childId:"+childId);
		log.info("map mberId :"+map.get("mberId"));
		
		// 반학생 정보 session에 저장
		if(auth.equals("ROLE_A01001") || auth.equals("ROLE_A01003")) {
			log.info("setClassSession 학생 or 학부모");
			ClasStdntVO ClasStdntVO = sessionMapper.getEnterClasStdntVO(map);
			if(ClasStdntVO!=null) {
				request.getSession().setAttribute("CLASS_STD_INFO", ClasStdntVO); // ClasStdntVO
			}
		}
		// 담임교사 정보 session에 저장
		else if(auth.equals("ROLE_A01002")) {
			log.info("교직원");
			HrtchrVO hrtchrVO = sessionMapper.getEnterHrtchrVO(map);
			if(hrtchrVO!=null) {
				request.getSession().setAttribute("CLASS_TCH_INFO", hrtchrVO);    // HrtchrVO
			}
		}
		
		return 0;
	}
	
	@Override
	public int setClassSession(HttpServletRequest request, String clasCode) {
		return setClassSession(request,clasCode, null);
	}

	@Override
	public int setClassSession(HttpServletRequest request) {
		return 0;
	}
	
	// 반/담임교사or반학생or자녀 정보 세션 삭제
	@Override
	public int deleteClassSession(HttpServletRequest request) {
		request.getSession().removeAttribute("CLASS_INFO");      // ClasVO
		request.getSession().removeAttribute("CLASS_STD_INFO");  // ClasStdntVO
		request.getSession().removeAttribute("CLASS_TCH_INFO");  // HrtchrVO

		return 0;
	}

	// 학교/학교소속회원 정보 세션 저장
	@Override
	public int setSchoolSession(HttpServletRequest request, String schulCode) {
		// 로그인한 회원 정보 get
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
				
		// 학교 정보 session에 저장
		SchulVO schulVO = sessionMapper.getEnterSchoolVO(schulCode);
		request.getSession().setAttribute("SCHOOL_INFO", schulVO);
		
		// 학교소속회원 정보 session에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId", memberVO.getMberId());
		map.put("schulCode",schulVO.getSchulCode());
		SchulPsitnMberVO schulPsitnMberVO = sessionMapper.getEnterSchulPsitnMberVO(map);
		request.getSession().setAttribute("SCHOOL_USER_INFO", schulPsitnMberVO);
			
		return 0;
	}
	
	@Override
	public int setSchoolSession(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		String schulCode = "";
		
		if (request.isUserInRole("ROLE_A01001")) {
			schulCode = sessionMapper.getSchulCodeWithStdId(memberVO.getMberId());
		} else if (request.isUserInRole("ROLE_A01002")) {
			schulCode = sessionMapper.getSchulCodeWithTchId(memberVO.getMberId());
		}else {
			
		}
		
		return setSchoolSession(request, schulCode);
	}

	// 학교/학교소속회원 정보 세션 삭제
	@Override
	public int deleteSchoolSession(HttpServletRequest request) {
		// 학교, 학교소속회원 session 삭제
		request.getSession().removeAttribute("SCHOOL_INFO");        // SchulVO
		request.getSession().removeAttribute("SCHOOL_USER_INFO");   // SchulPsitnMberVO
		// 반 세션 또한 삭제
		request.getSession().removeAttribute("CLASS_INFO");         // ClasStdntVO
				
		return 0;
	}
	
	@Override
	public int setMemberSession(HttpServletRequest request) {
		MemberVO oldMemberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		MemberVO newMemberVO = commonMapper.loginChk(oldMemberVO.getMberId());
		request.getSession().setAttribute("USER_INFO", newMemberVO);
		return 0;
	}

	// 1차 권한 학생인지 
	@Override
	public Boolean isStudent(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.get1Auth(memberVO);
		if (auth.equals("ROLE_A01001")) {
			return true;
		} else {
			return false;
		}
	}

	// 1차 권한 교직원인지 
	@Override
	public Boolean isEmployee(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.get1Auth(memberVO);
		if (auth.equals("ROLE_A01002")) {
			return true;
		} else {
			return false;
		}
	}

	// 1차 권한 학부모인지 
	@Override
	public Boolean isParent(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.get1Auth(memberVO);
		if (auth.equals("ROLE_A01003")) {
			return true;
		} else {
			return false;
		}
	}

	// 교직원 권한 교장인지
	@Override
	public Boolean isPrincipal(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.getEmployeeAuth(memberVO);
		if (auth.equals("ROLE_A14001")) {
			return true;
		} else {
			return false;
		}
	}

	// 교직원 권한 교사인지
	@Override
	public Boolean isTeacher(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.getEmployeeAuth(memberVO);
		if (auth.equals("ROLE_A14002")) {
			return true;
		} else {
			return false;
		}
	}

	// 교직원 권한 행정인지
	@Override
	public Boolean isAdministration(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.getEmployeeAuth(memberVO);
		if (auth.equals("ROLE_A14003")) {
			return true;
		} else {
			return false;
		}
	}

	// 교직원 권한 영양사인지
	@Override
	public Boolean isDietitian(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String auth = authManager.getEmployeeAuth(memberVO);
		if (auth.equals("ROLE_A14004")) {
			return true;
		} else {
			return false;
		}
	}

}
