package kr.or.ddit.util.etc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.VwMemberAuthVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AuthManager {
	/*
	 * 개요 :
	 * controller나 service에서 로그인한 회원의 권한을 알고 싶을 때 사용
	 * 1차 권한 : 학생, 교직원, 학부모
	 * 2차 교직원 권한 : 교장, 교사, 행정, 영양사
	 */
	
	/*  return 권한 목록 : 
		ROLE_A01001	학생
		ROLE_A01002	교직원
		ROLE_A01003	학부모
		
		ROLE_A14001	교장
		ROLE_A14002	교사
		ROLE_A14003	행정
		ROLE_A14004	영양사
		
		2024-03-15 기준.
		
		정확한 정보는 공통코드 파일 참조.
		https://docs.google.com/spreadsheets/d/1-NFbT1zIcRe6g8GBELxxgVYxPckKsChP6udD3KTGgXA/edit?pli=1#gid=1408838145
	 */
	
	/*
	 * 사용 방법 :
	 * controller나 service에
	 * @AutoWired
	 * GetAuth getAuth; 
	 * 추가
	 * 
	 * 체크하고 싶은 위치에서
	 * String auth = getAuth.get1Auth();
	 * if(auth.equals("ROLE_A01001"){
	 *       // 학생일 때 처리할 코드 ...
	 * }
	 * else if(auth.equals("ROLE_A01002"){
	 *       // 교직원일 때 처리할 코드 ...
	 * }
	 * else if(auth.equals("ROLE_A01003"){
	 *       // 학부모일 때 처리할 코드 ...
	 * }
	 * 
	 * 2차 교직원 권한도 메소드명이랑 비교할 문자열값만 바꿔서 똑같이 사용하면 됨.
	 */
	
	
	/*
	 * 1차 권한(학생,학부모,교직원) 얻는 메소드
	 * 
	 * return           : ROLE_A01001, ROLE_A01002, ROLE_A01003
	 * param(memberVO)  : Session에서 꺼낸 르그인한 회원 정보 
	 */
	public String get1Auth(MemberVO memberVO) {
		String auth ="";
		List<VwMemberAuthVO> viewMemberAuthVOList = memberVO.getVwMemberAuthVOList();
		for(VwMemberAuthVO authVO : viewMemberAuthVOList) {
			String temp = authVO.getCmmnDetailCode().substring(5, 8);
			log.info("temp : "+temp);
			if(temp.equals("A01")) {
				auth = authVO.getCmmnDetailCode();
				break;
			}
		}
		return auth; // "ROLE_A01001"
	}
	
	public String get1Auth(HttpServletRequest request) {
		if(request.isUserInRole("A01001")) {
			return "A01001";
		}else if(request.isUserInRole("A01002")) {
			return "A01002";
		}else if(request.isUserInRole("A01003")) {
			return "A01003";
		}else if(request.isUserInRole("A01000")) {
			return "A01000";
		}
		return null;
	}
	/*
	 * 교직원 권한(교장,교원,영양사 등) 얻는 메소드
	 * 
	 * return           : ROLE_A14001, ROLE_A14002 ...
	 * param(memberVO)  : Session에서 꺼낸 르그인한 회원 정보 
	 */
	public String getEmployeeAuth(MemberVO memberVO) {
		String auth ="";
		List<VwMemberAuthVO> viewMemberAuthVOList = memberVO.getVwMemberAuthVOList();
		for(VwMemberAuthVO authVO : viewMemberAuthVOList) {
			String temp = authVO.getCmmnDetailCode().substring(5, 8);
			log.info("temp : "+temp);
			if(temp.equals("A14")) {
				auth = authVO.getCmmnDetailCode();
				break;
			}
		}
		return auth;
	}
	
	// 로그인 했는지 확인
	public boolean isAuthenticated() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
	        return false;
	    }
	    return authentication.isAuthenticated();
	}
	
	public void consoleLogAllAuth(HttpServletRequest request) {
		
		ClasVO clasVOSession = (ClasVO)request.getSession().getAttribute("CLASS_INFO");
		SchulVO schulVOSession = (SchulVO)request.getSession().getAttribute("SCHOOL_INFO");
		ClasStdntVO clasStdntVOSession = (ClasStdntVO)request.getSession().getAttribute("CLASS_STD_INFO");
		HrtchrVO hrtchrVOSession = (HrtchrVO)request.getSession().getAttribute("CLASS_TCH_INFO");
		
		log.info("clasVOSession:"+clasVOSession);
		log.info("schulVOSession:"+schulVOSession);
		log.info("clasStdntVOSession:"+clasStdntVOSession);
		log.info("hrtchrVOSession:"+hrtchrVOSession);
	}
}
