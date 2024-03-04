package kr.or.ddit.parents.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.parents.mapper.ParentsMapper;
import kr.or.ddit.parents.service.ParentsService;

@Service
public class ParentsServiceImpl implements ParentsService {
	
	@Autowired
	ParentsMapper parentsMapper;

	//학부모 마이페이지
	@Override
	public String mypage() {
		// TODO Auto-generated method stub
		return null;
	}

	//학부모 인증 신청(학생에게)
	@Override
	public String parentCertification() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급클래스 신청
	@Override
	public String classRequest() {
		// TODO Auto-generated method stub
		return null;
	}

	//상담 신청
	@Override
	public String consultRequest() {
		// TODO Auto-generated method stub
		return null;
	}

	//방과후학교 신청
	@Override
	public String afterSchoolRequest() {
		// TODO Auto-generated method stub
		return null;
	}

	//방과후학교 결제
	@Override
	public String afterSchoolPay() {
		// TODO Auto-generated method stub
		return null;
	}
	

}
