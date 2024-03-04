package kr.or.ddit.student.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.student.mapper.StudentMapper;
import kr.or.ddit.student.service.StudentService;

@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	StudentMapper studentMapper;
	
	//학생 마이페이지
	@Override
	public String mypage() {
		// TODO Auto-generated method stub
		return null;
	}

	//학부모 인증(학생이)
	@Override
	public String parentCertification() {
		// TODO Auto-generated method stub
		return null;
	}

}
