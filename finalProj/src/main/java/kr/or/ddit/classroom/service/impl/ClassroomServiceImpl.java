package kr.or.ddit.classroom.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.classroom.mapper.ClassroomMapper;
import kr.or.ddit.classroom.service.ClassroomService;

@Service
public class ClassroomServiceImpl implements ClassroomService{
	
	@Autowired
	ClassroomMapper classroomMapper;
	
	//학급클래스 목록
	@Override
	public String classList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//학급클래스 소속회원 목록
	@Override
	public String classMemberList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 결석 사유 신청(체험학습도)
	@Override
	public String absentReason() {
		// TODO Auto-generated method stub
		return null;
	}

	//자유 게시판 목록 
	@Override
	public String freeBoard() {
		// TODO Auto-generated method stub
		return null;
	}

	//투표/설문조사 게시판 목록
	@Override
	public String votingSurvey() {
		// TODO Auto-generated method stub
		return null;
	}

	//알림장 목록
	@Override
	public String notice() {
		// TODO Auto-generated method stub
		return null;
	}

	//과제 게시판 목록
	@Override
	public String task() {
		// TODO Auto-generated method stub
		return null;
	}

	//단원마무리 게시판 목록
	@Override
	public String unitTest() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급 갤러리 목록
	@Override
	public String gallery() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급 시간표 조회
	@Override
	public String schedule() {
		// TODO Auto-generated method stub
		return null;
	}

	//온라인 수업
	@Override
	public String onlineClass() {
		// TODO Auto-generated method stub
		return null;
	}

	//생활 기록부 조회
	@Override
	public String lifeRecord() {
		// TODO Auto-generated method stub
		return null;
	}

}
