package kr.or.ddit.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.user.mapper.UserMapper;
import kr.or.ddit.user.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	String uploadFolder;

	@Autowired
	UserMapper mapper;

}
