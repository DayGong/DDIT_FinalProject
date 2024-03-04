package kr.or.ddit.school.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.school.mapper.SchoolMapper;
import kr.or.ddit.school.service.SchoolService;

@Service
public class SchoolServiceImpl implements SchoolService {
	
	@Autowired
	SchoolMapper schoolMapper;
	
	//학교 공지사항 게시판 목록
	@Override
	public String notice() {
		// TODO Auto-generated method stub
		return null;
	}
	//학교 교육정보 게시판 
	@Override
	public String eduInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	//교직원 관리
	@Override
	public String employeeManage() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//자료실 
	@Override
	public String dataRoom() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//급식
	@Override
	public String meal() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//학사일정
	@Override
	public String academicCalendar() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//시간표
	@Override
	public String schedule() {
		// TODO Auto-generated method stub
		return null;
	}

	//학생(전교생) 관리
	@Override
	public String studentsManage() {
		// TODO Auto-generated method stub
		return null;
	}
	//방과후학교
	@Override
	public String afterSchool() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급 클래스 목록
	@Override
	public String classList() {
		// TODO Auto-generated method stub
		return null;
	}

}
