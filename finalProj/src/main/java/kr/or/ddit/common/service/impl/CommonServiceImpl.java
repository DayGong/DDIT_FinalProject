package kr.or.ddit.common.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.CommonMapper;
import kr.or.ddit.common.service.CommonService;
@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	CommonMapper commonMapper;
	
	//메인페이지
	@Override
	public String main() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//회원가입
	@Override
	public String signUp() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//로그인
	@Override
	public String loginForm() {
		// TODO Auto-generated method stub
		return null;
	}

	//아이디 찾기
	@Override
	public String searchId() {
		// TODO Auto-generated method stub
		return null;
	}

	//비밀번호 찾기
	@Override
	public String searchPwd() {
		// TODO Auto-generated method stub
		return null;
	}

	//FAQ 게시판 목록
	@Override
	public String faq() {
		// TODO Auto-generated method stub
		return null;
	}

	//학원 조회
	@Override
	public String academy() {
		// TODO Auto-generated method stub
		return null;
	}

}
