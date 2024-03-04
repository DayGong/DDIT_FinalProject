package kr.or.ddit.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.admin.service.AdminService;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Slf4j
@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	// 신고게시판
	@GetMapping("/complaint")
	public String complaint() {
		return "admin/complaint";
	}
}
