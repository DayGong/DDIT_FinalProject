package kr.or.ddit.employee.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.employee.service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	//직원 마이페이지
	@Override
	public String mypage() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
