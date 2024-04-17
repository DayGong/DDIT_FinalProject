package kr.or.ddit.echo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
//	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	// 로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 로그인중인 개별유저
	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();

	// 클라이언트가 서버로 연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		String senderId = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		log.info("afterConnectionEstablished->senderId : " + senderId);
		if (senderId != null) { // 로그인 값이 있는 경우만
			log.info(senderId + " 연결 됨");
			users.put(senderId, session); // 로그인중 개별유저 저장
		}

		log.info("{}연결됨", session.getId());
	}

	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//모든 유저에게 보낸다 - 브로드 캐스팅
//		for (WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderNickname + ": " +  message.getPayload()));
//		}
		
		String senderId = getMemberId(session);
		log.info("handleTextMessage->senderId : " + senderId);
		//protocol: cmd,방 만든사람,초대받는 사람,방코드  (ex: create,user2,user1,234)
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		
		if (msg != null) {
			String[] strs = msg.split(",");
			log(strs.toString());
			if (strs != null && strs.length == 4) {
				String type = strs[0];	// 채팅방
				String crtrId = strs[1]; // 생성자 아이디
				String prtcpntId = strs[2];	// 참여자 아이디
				String chttRoomCode = strs[3];	//채팅방 코드
				WebSocketSession targetSession = users.get(crtrId); // 메시지를 받을 세션 조회

				// 실시간 접속시
				if ("room".equals(type) && targetSession != null) {
					// ex: [&분의일] 신청이 들어왔습니다.
					TextMessage tmpMsg = new TextMessage(
//							"<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + crtrId + "가 채팅방을 생성했습니다!!</a>");
							"<a href='javascript:void(0);' onclick='openChatPop(\"/chat/chtt?chttRoomCode=" + chttRoomCode + "\")'>[<b>채팅</b>] " + prtcpntId + "님이 채팅방을 생성했습니다!!</a>");
					log.info("tmpMsg : " + tmpMsg);
					targetSession.sendMessage(tmpMsg);
				}
			}
			if(strs!=null && strs.length == 7) {
				WebSocketSession targetSession;
				String type = strs[0];	// 채팅
				String chttRoomCode = strs[1];	//채팅방 코드
				String dsptchId = strs[2];	//채팅 친 아이디  
				// 상대방 아이디가 와야되는데??
				String dsptchNm = strs[3];	//채팅 친 이름
				String chttCn = strs[4];	//채팅 내용
				String crtrId = strs[5];	//상대방 아이디
				String prtcpntId = strs[6];	//상대방 아이디
				log.info("handleTextMessage->dsptchId : " + dsptchId);
				if(senderId.equals(crtrId)) {
					targetSession = users.get(prtcpntId); // 메시지를 받을 세션 조회(상대방)
					log.info("handleTextMessage->prtcpntId : " + prtcpntId);
				}else {
					targetSession = users.get(crtrId); // 메시지를 받을 세션 조회(상대방)
					log.info("handleTextMessage->crtrId : " + crtrId);
				}
				
				// 실시간 접속시
				if ("chtt".equals(type) && targetSession != null) {
					TextMessage tmpMsg = new TextMessage(
						    "<a href='javascript:void(0);' onclick='openChatPop(\"/chat/chtt?chttRoomCode=" + chttRoomCode + "\")'>[<b>채팅</b>] " + dsptchNm + "님이 메세지를 보냈습니다!!</a>");
					log.info("!!!!!!!!!!!!!!!!!!!!!!!!tmpMsg : " + tmpMsg);
					targetSession.sendMessage(tmpMsg);
				}
				
				if(targetSession == null) {
					log.info("targetSession null인디요??!!!ㅜㅜ");
				}
			}
		}
	}

	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);
		if (senderId != null) { // 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
			sessions.remove(session);
		}
	}

	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}

	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
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
