package kr.or.ddit.school.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.school.mapper.SchafsSchedulMapper;
import kr.or.ddit.school.service.SchafsSchedulService;
import kr.or.ddit.vo.SchafsSchdulVO;

@Service
public class SchafsSchedulServiceImpl implements SchafsSchedulService {
	
	@Autowired
	SchafsSchedulMapper schafsSchedulMapper;
	
	// 학사 일정 리스트
	@Override
	public List<SchafsSchdulVO> scheduleList(String schulCode) {
		return this.schafsSchedulMapper.scheduleList(schulCode);
	}

	// 학사 일정 등록
	@Override
	public int scheduleInsert(SchafsSchdulVO schafsSchdulVO) {
		return this.schafsSchedulMapper.scheduleInsert(schafsSchdulVO);
	}

	// 학사 일정 수정
	@Override
	public int scheduleUpdate(SchafsSchdulVO schafsSchdulVO) {
		return this.schafsSchedulMapper.scheduleUpdate(schafsSchdulVO);
	}

	// 학사 일정 삭제
	@Override
	public int scheduleDelete(String schdulCode) {
		return this.schafsSchedulMapper.scheduleDelete(schdulCode);
	}

	// 학교 메인용 학사 일정 리스트
	@Override
	public List<SchafsSchdulVO> scheduleListMain(String schulCode) {
		return this.schafsSchedulMapper.scheduleListMain(schulCode);
	}

}
