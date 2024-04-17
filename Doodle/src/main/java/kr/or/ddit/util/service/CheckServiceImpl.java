package kr.or.ddit.util.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.util.etc.AuthManager;
import kr.or.ddit.util.mapper.CheckMapper;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CheckServiceImpl implements CheckService{

	@Autowired
	CheckMapper checkMapper;
	@Autowired
	SessionService sessionService;
	@Autowired
	AuthManager authManager;
	
	@Override
	public boolean checkBelongCl(HttpServletRequest request, String clasCode) {
		Map<String, Object> map = new HashMap<String, Object>(); // 쿼리 파라미터
		MemberVO memberVO = null;
		ClasStdntVO clasStdntVOTemp = null;
		HrtchrVO hrtchrVOTemp = null;

		/** 저장된 세션 정보 읽어서 쿼리 파라미터 set */
		memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		map.put("mberId", memberVO.getMberId());
		map.put("clasCode",clasCode);
		
		// log
		log.info("service memberVO:"+memberVO);
		
		// 학생
		if(request.isUserInRole("A01001")) {
			clasStdntVOTemp = checkMapper.checkBelongClStd(map);
		}
		// 교사
		else if(request.isUserInRole("A14002")) {
			hrtchrVOTemp = checkMapper.checkBelongClTch(map);
		}
		// 학부모 
		else if(request.isUserInRole("A01003")) {
			clasStdntVOTemp = checkMapper.checkBelongClPrnt(map);
		}
		// 교장, 행정, 교감은 열람 가능
		else if(request.isUserInRole("A14001") || request.isUserInRole("A14003") || request.isUserInRole("A14005")){
			return true;
		}
		// 권한 없는 교직원
		else {
			return false;
		}

		// 해당 url의 반에 속하지 않으면 return false
		if(clasStdntVOTemp == null && hrtchrVOTemp == null) {
			return false;
		}
		
		/*
		반 페이지를 버튼이 아니라 url에 직접 입력해서 페이지에 접속할 시 session 정보가 없을 수도 있음.
		없을 경우를 대비해 세션을 자동으로 추가해줌.
		*/
		sessionService.setClassSession(request, clasCode);
		
		return true;
	}

	@Override
	public boolean checkBelongSch(HttpServletRequest request, String schulCode) {
		Map<String, Object> map = new HashMap<String, Object>(); // 쿼리 파라미터
		MemberVO memberVO = null;
		SchulPsitnMberVO schulPsitnMberVO = null;

		/** 저장된 세션 정보 읽어서 쿼리 파라미터 set */
		memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		map.put("mberId", memberVO.getMberId());
		map.put("schulCode",schulCode);
		
		// log
		log.info("service memberVO:"+memberVO);
		
		schulPsitnMberVO = checkMapper.checkBelongSch(map);

		// 해당 url의 학교에 속하지 않으면 return false
		if(schulPsitnMberVO == null) {
			return false;
		}
		
		/*
		반 페이지를 버튼이 아니라 url에 직접 입력해서 페이지에 접속할 시 session 정보가 없을 수도 있음.
		없을 경우를 대비해 세션을 자동으로 추가해줌.
		*/
		sessionService.setSchoolSession(request, schulCode);
		
		return true;
	}
	
	
}
