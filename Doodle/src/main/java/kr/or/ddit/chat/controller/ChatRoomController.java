package kr.or.ddit.chat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.chat.service.ChatRoomService;
import kr.or.ddit.vo.ChttRoomVO;
import kr.or.ddit.vo.ChttVO;
import kr.or.ddit.vo.ClasFamVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatRoomController {

	@Autowired
	ChatRoomService chatRoomService;

	// 교직원 목록 조회
	@GetMapping("/friends")
	public String friend(@RequestParam(value = "schulCode", required = false) String schulCode) {

		return "/chat/friend";
	}

	@ResponseBody
	@PostMapping("/friends")
	public List<SchulPsitnMberVO> friendList(@RequestBody(required = false) SchulPsitnMberVO schulPsitnMberVO, HttpServletRequest request) {
		// 로그인한 회원 ID
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = memberVO.getMberId();
		
		schulPsitnMberVO.setMberId(mberId);
		log.debug("friendList->schulPsitnMberVO : " + schulPsitnMberVO);


		List<SchulPsitnMberVO> schulPsitnMberVOList = this.chatRoomService.friendList(schulPsitnMberVO);

		log.debug("friendList->schulPsitnMberVOList : " + schulPsitnMberVOList);

		return schulPsitnMberVOList;
	}

	// 교직원 채팅방 목록 조회
	@GetMapping("/rooms")
	public String rooms(HttpServletRequest request,
			@RequestParam(value = "schulCode", required = false) String schulCode) {
		return "/chat/rooms";
	}

	//교직원 채팅방 목록
	@ResponseBody
	@PostMapping("/rooms")
	public List<ChttRoomVO> roomsList(HttpServletRequest request,
			@RequestBody(required = false) ChttRoomVO chttRoomVO) {

		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String crtrId = memberVO.getMberId();
		String prtcpntId = memberVO.getMberId();
		chttRoomVO.setCrtrId(crtrId);
		chttRoomVO.setPrtcpntId(prtcpntId);

		String schulCode = chttRoomVO.getSchulCode();

		log.debug("roomsList->crtrId : " + crtrId);
		log.debug("roomsList->prtcpntId : " + prtcpntId);
		log.debug("roomsList->schulCode : " + schulCode);

		log.debug("roomsList->chttRoomVO : " + chttRoomVO);

		List<ChttRoomVO> chttRoomVOList = this.chatRoomService.roomsList(chttRoomVO);
		log.debug("roomsList->chttRoomVOList : " + chttRoomVOList);

		return chttRoomVOList;
	}
	

	//채팅방 개설
	@ResponseBody
	@PostMapping("/room")
	public int createRooms(@RequestBody ChttRoomVO chttRoomVO) {
		log.debug("createRooms->chttRoomVO전 : " + chttRoomVO);

		int result = this.chatRoomService.createRooms(chttRoomVO);
		log.debug("createRooms->result : " + result);
		log.debug("createRooms->chttRoomVO후 : " + chttRoomVO);

		return result;
	}
	
	// 채팅방 코드 구하기
	@ResponseBody
	@PostMapping("/roomCode")
	public String roomCode(@RequestBody ChttRoomVO chttRoomVO) {
		log.debug("roomCode->crtrId : " + chttRoomVO.getCrtrId());
		log.debug("roomCode->prtcpntId : " + chttRoomVO.getPrtcpntId());
		
		String chttRoomCode = this.chatRoomService.roomCode(chttRoomVO);
		log.debug("roomCode->chttRoomCode : " + chttRoomCode);
		
		return chttRoomCode;
	}
	

	//채팅방 상세
	@GetMapping("/chtt")
	public String chtt(@RequestParam(value = "chttRoomCode") String chttRoomCode, Model model, HttpServletRequest request) {
		log.debug("chtt->chttRoomCode : " + chttRoomCode);
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.debug("chtt->memberVO : " + memberVO);

		ChttRoomVO chttRoomVO = this.chatRoomService.chtt(chttRoomCode);
		log.debug("chtt->chttRoomVO : " + chttRoomVO);
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("chttRoomVO", chttRoomVO);
		return "/chat/chtt";
	}

	//채팅내역
	@ResponseBody
	@PostMapping("/chtt")
	public List<ChttVO> chtts(@RequestBody String chttRoomCode) {
		log.debug("chtts->chttRoomCode :" + chttRoomCode);
		chttRoomCode = chttRoomCode.substring(0, chttRoomCode.length() - 1);
		List<ChttVO> chttVOList = this.chatRoomService.chtts(chttRoomCode);
		log.debug("chtts->chttVOList :" + chttVOList);

		return chttVOList;
	}
	
	
	//반 소속 학부모 목록
	@GetMapping("/clasFam")
	public String clasFam(@RequestParam(value = "schulCode", required = false) String clasCode) {
		return "/chat/clasFam";
	}
	
	@ResponseBody
	@PostMapping("/clasFam")
	public List<ClasFamVO> clasFamList(@RequestBody(required = false) ClasFamVO clasFamVO, HttpServletRequest request){
		// 로그인한 회원 ID
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String mberId = memberVO.getMberId();
		
		clasFamVO.setStdnprntId(mberId);
		log.debug("clasFamList->clasFamVO : " + clasFamVO);
		
		List<ClasFamVO> clasFamVOList = this.chatRoomService.clasFamList(clasFamVO);

		log.debug("clasFamList->clasFamVOList : " + clasFamVOList);

		return clasFamVOList;
	}
	
	//반 채팅방 목록 조회
	@GetMapping("/clasFamRooms")
	public String clasFamRooms(HttpServletRequest request,
			@RequestParam(value = "clasCode", required = false) String clasCode) {
		return "/chat/clasFamRooms";
	}
	
	//반 채팅방 목록
	@ResponseBody
	@PostMapping("/clasFamRooms")
	public List<ChttRoomVO> clasFamRoomsList(HttpServletRequest request,
			@RequestBody(required = false) ChttRoomVO chttRoomVO) {

		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String crtrId = memberVO.getMberId();
		String prtcpntId = memberVO.getMberId();
		chttRoomVO.setCrtrId(crtrId);
		chttRoomVO.setPrtcpntId(prtcpntId);

		String clasCode = chttRoomVO.getClasCode();

		log.debug("clasFamRoomsList->crtrId : " + crtrId);
		log.debug("clasFamRoomsList->prtcpntId : " + prtcpntId);
		log.debug("clasFamRoomsList->clasCode : " + clasCode);

		log.debug("clasFamRoomsList->chttRoomVO : " + chttRoomVO);

		List<ChttRoomVO> clasFamRoomsList = this.chatRoomService.clasFamRoomsList(chttRoomVO);
		log.debug("clasFamRoomsList->clasFamRoomsList : " + clasFamRoomsList);

		return clasFamRoomsList;
	}

}