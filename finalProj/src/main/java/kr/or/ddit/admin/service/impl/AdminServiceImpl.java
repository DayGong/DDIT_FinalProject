package kr.or.ddit.admin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mapper.AdminMapper;
import kr.or.ddit.admin.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper adminMapper;
	
	// 신고게시판
	@Override
	public String complaint() {
		// TODO Auto-generated method stub
		return null;
	}

}
