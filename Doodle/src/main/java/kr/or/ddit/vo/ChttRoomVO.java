package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
public class ChttRoomVO {
	private String chttRoomCode; // 채팅방 코드
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date chttRoomDt; // 채팅방 일시
	private String cmmnDetailCode; // 공통 완료 여부(A20)
	private String schulCode; // 학교 코드
	private String clasCode; // 반 코드
	private String crtrId; // 생성자 아이디
	private String prtcpntId; // 참여자 아이디

	// 채팅방 : 채팅 = 1 : N
	private List<ChttVO> chttVOList;

	private MemberVO crtrVO;	//생성자 정보
	private MemberVO prtcpntVO;	//참여자 정보
	
	private List<WebSocketSession> sessions = new ArrayList<>();

}
