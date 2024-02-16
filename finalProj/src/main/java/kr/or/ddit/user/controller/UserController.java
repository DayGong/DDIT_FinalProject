package kr.or.ddit.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.user.service.UserService;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/user")
@Slf4j
@Controller
public class UserController {
	
	@Autowired
	UserService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String userList() {
		log.info("/user/list start");
		return "user/list";
	}

}
