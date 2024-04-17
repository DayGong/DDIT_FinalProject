package kr.or.ddit.util.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Slf4j
@Controller
public class RefundMessageController {
	@ResponseBody
	@PostMapping("/sms/sendMsg")
	public JSONObject sendSms(@RequestBody Map<String, String> map) throws Exception {

		String api_key = "NCSLIUVALN15NV86";
		String api_secret = "YCBUEUDBEZA5DMIDC6OAFBY08MRGMZZE";
		Message coolsms = new Message(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", map.get("moblphonNo")); // 수신번호
		set.put("text", map.get("msg")); // 메세지 내용

		set.put("from", "01083354487"); // 발신번호
		set.put("type", "lms"); // 문자 타입 : 일반 : SMS, 장문 : LMS, 포토 : MMS
		set.put("app_version", "test app 1.2");

		log.info("set:"+set);
		try {
			JSONObject result = coolsms.send(set); // 보내기 & 전송 결과 받기

			log.info("result.toString():"+result.toString());
			log.info("result type :"+ result.getClass().getName());

			return result;
			
		} catch (CoolsmsException e) {
			log.info("e.getMessage():"+e.getMessage());
			log.info("e.getCode():"+e.getCode());
		}
		
		return null;
	}
	
	// 주희
	// api_key    : NCSQK3MC61OVY17E
	// api_secret : FNZKIGZ0D3HAVEK6CZSS020BY9ASFLUH
	// from       : 01067604151
	
	// 재훈이 형이 빌려준 거(팀원들끼리 돈모아서 충전한거라 쉬쉬 하고 쓰시랍니다.)
	// api_key    : NCSLIUVALN15NV86
	// api_secret : YCBUEUDBEZA5DMIDC6OAFBY08MRGMZZE
    // from       : 01083354487
}