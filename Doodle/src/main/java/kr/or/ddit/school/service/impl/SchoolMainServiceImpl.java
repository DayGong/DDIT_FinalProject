package kr.or.ddit.school.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.school.mapper.SchoolMainMapper;
import kr.or.ddit.school.service.SchoolMainService;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DietVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchoolMainServiceImpl implements SchoolMainService{
	
	@Autowired
	SchoolMainMapper schoolMainMapper;

	// 학부모 : 자녀와 자녀의 학교 정보 get
	@Override
	public List<SchulVO> getSchoolAndChildren(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		List<SchulVO> schulVOList = schoolMainMapper.getSchoolAndChildren(memberVO.getMberId());
		log.info("schulVOList : "+schulVOList.toString());
		return schulVOList;
	}
	
	// 가입된 클래스 목록
	@Override
	public List<ClasVO> myClassList(HttpServletRequest request, String mberId, String cmCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		map.put("mberId", mberId);
		map.put("schulCode", schulVO.getSchulCode());
		
		if (cmCode.equals("ROLE_A01001")) { // 학생
			return schoolMainMapper.myClassListStd(map);
		}
		if (cmCode.equals("ROLE_A01002")) { // 교직원
			return schoolMainMapper.myClassListTch(map);
		}
		if (cmCode.equals("ROLE_A01003")) { // 학부모
			return schoolMainMapper.myClassListPrn(map);
		}
		return null;
	}

	// 메인 화면 급식 목록
	@Override
	public List<DietVO> mainPageMeals(HttpServletRequest request) {
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		return schoolMainMapper.mainPageMeals(schulVO.getSchulCode());
	}

}
