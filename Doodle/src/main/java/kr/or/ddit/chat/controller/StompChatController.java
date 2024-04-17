package kr.or.ddit.chat.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import kr.or.ddit.chat.service.ChatRoomService;
import kr.or.ddit.vo.ChttVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class StompChatController {
	private final SimpMessagingTemplate template; // 특정 Broker로 메세지를 전달

	@Autowired
	ChatRoomService chatRoomService;

	@MessageMapping(value = "/chat/enter")
	public void enter(ChttVO message) {
		log.debug("채팅전송체크{}");
		message.setChttCn(message.getWriter() + "님이 채팅방에 참여하였습니다.");
		template.convertAndSend("/sub/chat/room/" + message.getChttRoomCode(), message);
	}

	@MessageMapping(value = "/chat/message")
	public void message(ChttVO message) {

		template.convertAndSend("/sub/chat/room/" + message.getChttRoomCode(), message);
		template.convertAndSend("/sub/chat/main/", message);

		int result = this.chatRoomService.insert(message);

		if (result > 0) {
			System.out.println("메세지 전송 성공");
		} else {
			System.out.println("실패");
			return;
		}
	}
	
//	@MessageMapping(value = "/chat/alam")
//	public void alam(ChttVO message) {
//
//		template.convertAndSend("/sub/chat/main/" + message.getChttRoomCode(), message);
//
//	}
	
}
