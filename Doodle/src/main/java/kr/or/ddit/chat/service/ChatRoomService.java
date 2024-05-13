package kr.or.ddit.chat.service;

import java.util.List;
import java.util.Map;


import kr.or.ddit.vo.ChttRoomVO;
import kr.or.ddit.vo.ChttVO;
import kr.or.ddit.vo.ClasFamVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface ChatRoomService {

	// 친구 목록 조회
	public List<SchulPsitnMberVO> friendList(SchulPsitnMberVO schulPsitnMberVO);
	
	// 나의 채팅방 목록
	public List<ChttRoomVO> roomsList(ChttRoomVO chttRoomVO);

	// 채팅방 개설
	public int createRooms(ChttRoomVO chttRoomVO);

	// 채팅방 상세
	public ChttRoomVO chtt(String chttRoomCode);

	// 채팅 등록
	public int insert(ChttVO message);

	// 채팅내역
	public List<ChttVO> chtts(String chttRoomCode);
	
	// 채팅방 코드 구하기
	public String roomCode(ChttRoomVO chttRoomVO);
	
	// 채팅 갯수 구하기
	public int chttTotal(Map<String, Object> map);
	
	//반 소속 학부모 목록
	public List<ClasFamVO> clasFamList(ClasFamVO clasFamVO);
	
	//반 채팅방 목록
	public List<ChttRoomVO> clasFamRoomsList(ChttRoomVO chttRoomVO);

}
