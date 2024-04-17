package kr.or.ddit.util.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class socket extends TextWebSocketHandler {
	//소켓에 연결한 클라이언트 목록
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	//특정 사용자를 찾기 위한 map
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	//소켓연결
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓이 연결되면 전체 세션 리스트에 세션을 추가시킨다
		sessions.add(session);
		
		//연결하려는 클라이언트의 세션에서 id값을 불러와 map에 id값으로 세션을 담는다
//		Map<String, Object> sessionGet = session.getAttributes();
		String sessionId = getMemberId(session);
		userSessionsMap.put(sessionId, session);
		
		//소켓 연결 시 저장된 세션 확인
		log.info("session -> " + sessions);
		log.info("userSessionsMap -> " + userSessionsMap);
	}
	
	//소켓연결 해제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//전체 세션리스트에서 연결을 해제하려는 세션을 지운다
		sessions.remove(session);
		
		//연결을 해제하려는 세션을 id값으로 찾아 map에서 지운다
		String sessionId = getMemberId(session);
		userSessionsMap.put(sessionId, session);
		userSessionsMap.remove(sessionId,session);
		
		//소켓 연결 해제 시 저장된 세션 확인
		log.info("session -> " + sessions);
		log.info("userSessionsMap -> " + userSessionsMap);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//받은 메시지를 String 값으로 받는다
		String msg = message.getPayload();
		log.info("msg 잘 들어 왔니? -> " + msg);
		
		//메시지를 ','로 나눠준다
		String[] msgs = msg.split(",");
		
		// 한 클래스 내 학생/학부모에게 알림 전송
		if(msgs!=null && msgs.length == 2) {
			if(msgs[1].equals("toAll")) {
				log.info("들어왔니?????????????????????????????");
				String notice = msgs[0];	// 알림 내용
				String sendmsg = notice;
				log.info("sendmsg -> " + sendmsg);
				
				for(int i=0; i<sessions.size(); i++) {
					TextMessage tmsg = new TextMessage(sendmsg);
					sessions.get(i).sendMessage(tmsg);
				}
			}
		}

		// 학생에게 알림 전송
		if(msgs!=null && msgs.length == 3) {
			if(msgs[2].equals("toStdnt")) {
				String notice = msgs[0];	// 알림 내용
				String stdntId = msgs[1];	// 알림 대상
				log.info(msgs[0] + " <- notice 좀 확인하자");
				log.info(msgs[1] + " <- stdntId 좀 확인하자");
				
				WebSocketSession targetSession = userSessionsMap.get(stdntId);
				
				String sendmsg = notice;
				
				TextMessage tmsg = new TextMessage(sendmsg);
				targetSession.sendMessage(tmsg);
			}
		}
	}
	
	// 웹소켓에 id 가져오기
	// 접속한 유저의 http세션을 조회하여 id를 얻는 함수
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVO loginUser = (MemberVO) httpSession.get("USER_INFO");
		String meberId = loginUser.getMberId();
		return meberId == null ? null : meberId;
	}
}
