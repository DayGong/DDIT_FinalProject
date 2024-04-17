package kr.or.ddit.school.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.school.service.SchafsSchedulService;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/school")
@Controller
public class SchafsSchdulController {
	
	@Autowired
	SchafsSchedulService schafsSchedulService;
	
	// 학사 일정
	@RequestMapping("/schafsSchedul")
	public String schafsSchedul() {
		return "school/schafsSchedul";
	}
	
	// 학사 일정 리스트
	@ResponseBody
	@GetMapping("/scheduleList")
	public List<Map<String, Object>> scheduleList(String schulCode) {
		log.info("scheduleList -> schulCode: " + schulCode);

		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		HashMap<String, Object> map = new HashMap<>();
		
		List<SchafsSchdulVO> schafsSchdul = schafsSchedulService.scheduleList(schulCode);
		log.info("scheduleList -> schafsSchdul: " + schafsSchdul);
		
		for (SchafsSchdulVO ssVO : schafsSchdul) {
			map.put("scheduleCd", ssVO.getSchafsSchdulCode());
			map.put("scheduleNm", ssVO.getSchafsSchdulNm());
			map.put("scheduleCn", ssVO.getSchafsSchdulCn());
			map.put("scheduleBgnde", ssVO.getSchafsSchdulBgnde());
			map.put("scheduleEndde", ssVO.getSchafsSchdulEndde());
			map.put("scheduleSe", ssVO.getSchafsSchdulSe());
			jsonObj = new JSONObject(map);
			jsonArr.add(jsonObj);
		}
		
		log.info("jsonArrCheck:{}", jsonArr);
		
		return jsonArr;
	}
	
	// 학사 일정 등록
	@ResponseBody
	@PostMapping("/scheduleInsert")
	public int scheduleInsert(@RequestBody SchafsSchdulVO schafsSchdulVO) {
		log.info("scheduleInsert -> schafsSchdulVO: " + schafsSchdulVO);
		
		int result = schafsSchedulService.scheduleInsert(schafsSchdulVO);
		log.info("scheduleInsert -> result: " + result);
		
		return result;
	}
	
	// 학사 일정 수정
	@ResponseBody
	@PostMapping("/scheduleUpdate")
	public int scheduleUpdate(@RequestBody SchafsSchdulVO schafsSchdulVO) {
		log.info("scheduleUpdate -> schafsSchdulVO: " + schafsSchdulVO);
		
		int result = schafsSchedulService.scheduleUpdate(schafsSchdulVO);
		log.info("scheduleUpdate -> result: " + result);
		
		return result;
	}
	
	// 학사 일정 삭제
	@ResponseBody
	@PostMapping("/scheduleDelete")
	public int scheduleDelete(String schdulCode) {
		log.info("scheduleDelete -> schdulCode: " + schdulCode);
		
		int result = schafsSchedulService.scheduleDelete(schdulCode);
		log.info("scheduleDelete -> result: " + result);
		
		return result;
	}
}