package kr.or.ddit.school.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DietVO;
import kr.or.ddit.vo.SchulVO;

public interface SchoolMainMapper {
	
	// 학부모 : 자녀와 자녀의 학교 정보 get
	public List<SchulVO> getSchoolAndChildren(String mberId);
	
	// 가입된 학급클래스 목록(학생)
	public List<ClasVO> myClassListStd(Map<String, Object> map);
	// 가입된 학급클래스 목록(교직원)
	public List<ClasVO> myClassListTch(Map<String, Object> map);
	// 가입된 학급클래스 목록(학부모)
	public List<ClasVO> myClassListPrn(Map<String, Object> map);

	// 메인 화면 급식 목록
	public List<DietVO> mainPageMeals(String schulCode);

}
