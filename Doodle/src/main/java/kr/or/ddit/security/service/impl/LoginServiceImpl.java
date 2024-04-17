package kr.or.ddit.security.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.security.mapper.LoginMapper;
import kr.or.ddit.security.service.LoginService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginMapper loginMapper;

	// 로그인 수를 등록하는 메서드
	@Override
	public void addLoginCo() {
		int result = this.loginMapper.addLoginCo();
		log.info("addLoginCo result => " + result);
	}
}
