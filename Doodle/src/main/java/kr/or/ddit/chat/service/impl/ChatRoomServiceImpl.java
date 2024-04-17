package kr.or.ddit.chat.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.chat.mapper.ChatRoomMapper;
import kr.or.ddit.chat.service.ChatRoomService;
import kr.or.ddit.vo.ChttRoomVO;
import kr.or.ddit.vo.ChttVO;
import kr.or.ddit.vo.ClasFamVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	ChatRoomMapper chatRoomMapper;

	// 친구 목록 조회
	@Override
	public List<SchulPsitnMberVO> friendList(SchulPsitnMberVO schulPsitnMberVO) {
		return this.chatRoomMapper.friendList(schulPsitnMberVO);
	}
	
	// 나의 채팅방 목록
	@Override
	public List<ChttRoomVO> roomsList(ChttRoomVO chttRoomVO) {
		return this.chatRoomMapper.roomsList(chttRoomVO);
	}

	// 채팅방 개설
	@Override
	public int createRooms(ChttRoomVO chttRoomVO) {
		chttRoomVO.setChttRoomCode(UUID.randomUUID().toString());
		return this.chatRoomMapper.createRooms(chttRoomVO);
	}

	// 채팅방 상세
	@Override
	public ChttRoomVO chtt(String chttRoomCode) {
		return this.chatRoomMapper.chtt(chttRoomCode);
	}

	// 채팅 등록
	@Override
	public int insert(ChttVO message) {
		message.setChttCode(UUID.randomUUID().toString());
		log.debug("insert->message" + message);
		return this.chatRoomMapper.insert(message);
	}

	// 채팅내역
	@Override
	public List<ChttVO> chtts(String chttRoomCode) {
		return this.chatRoomMapper.chtts(chttRoomCode);
	}
	
	// 채팅내역 - 무한스크롤 역순으로 어떻게 해야되나요? ㅠㅠ
//	@Override
//	public List<ChttVO> chtts(Map<String, Object> map) {
//		return this.chatRoomMapper.chtts(map);
//	}

	// 이미 생성된 채팅방이 있는지 체크
//	@Override
//	public int roomChk(ChttRoomVO chttRoomVO) {
//		return this.chatRoomMapper.roomChk(chttRoomVO);
//	}
	
	// 채팅방 코드 구하기
	@Override
	public String roomCode(ChttRoomVO chttRoomVO) {
		return this.chatRoomMapper.roomCode(chttRoomVO);
	}
	
	// 채팅 갯수 구하기
	@Override
	public int chttTotal(Map<String, Object> map) {
		return this.chatRoomMapper.chttTotal(map);
	}
	
	//반 소속 학부모 목록
	@Override
	public List<ClasFamVO> clasFamList(ClasFamVO clasFamVO) {
		return this.chatRoomMapper.clasFamList(clasFamVO);
	}
	
	//반 채팅방 목록
	@Override
	public List<ChttRoomVO> clasFamRoomsList(ChttRoomVO chttRoomVO) {
		return this.chatRoomMapper.clasFamRoomsList(chttRoomVO);
	}
	
}
