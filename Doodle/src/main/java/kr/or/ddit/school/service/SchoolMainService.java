package kr.or.ddit.school.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DietVO;
import kr.or.ddit.vo.SchulVO;

public interface SchoolMainService {
	
	// 학부모 : 자녀와 자녀의 학교 정보 get
	public List<SchulVO> getSchoolAndChildren(HttpServletRequest request);

	// 가입된 클래스 목록 출력
	public List<ClasVO> myClassList(HttpServletRequest request, String mberId, String cmCode);

	// 메인화면 급식 목록
	public List<DietVO> mainPageMeals(HttpServletRequest request);
	
}
