package kr.or.ddit.school.service;

import java.util.List;

import kr.or.ddit.vo.SchafsSchdulVO;

public interface SchafsSchedulService {

	// 학사 일정 리스트
	public List<SchafsSchdulVO> scheduleList(String schulCode);
	
	// 학사 일정 등록
	public int scheduleInsert(SchafsSchdulVO schafsSchdulVO);
	
	// 학사 일정 수정
	public int scheduleUpdate(SchafsSchdulVO schafsSchdulVO);
	
	// 학사 일정 삭제
	public int scheduleDelete(String schdulCode);
	
	// 학교 메인용 학사 일정 리스트
	public List<SchafsSchdulVO> scheduleListMain(String schulCode);
}
