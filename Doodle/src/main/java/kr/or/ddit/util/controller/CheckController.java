package kr.or.ddit.util.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.util.service.CheckService;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/check")
@Controller
public class CheckController {
	
	@Autowired
	CheckService checkService;
	
	/*
	 * ajax(post)
	 */
	@ResponseBody
	@PostMapping("/checkBelongCl")
	public int checkBelongCl(HttpServletRequest request, @RequestParam("clasCode") String clasCode) {
		boolean res = checkService.checkBelongCl(request, clasCode);
		if(res==true) {
			return 1;
		}else {
			return 0;
		}
	}

	@ResponseBody
	@PostMapping("/checkBelongClwithRb")
	public int checkBelongClwithRb(HttpServletRequest request, @RequestBody String clasCode) {
		boolean res = checkService.checkBelongCl(request, clasCode);
		if(res==true) {
			return 1;
		}else {
			return 0;
		}
	}
}
