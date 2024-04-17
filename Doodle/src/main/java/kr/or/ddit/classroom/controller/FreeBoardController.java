package kr.or.ddit.classroom.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.classroom.service.FreeBoardService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.VoteNdQustnrVO;
import kr.or.ddit.vo.VoteQustnrDetailIemVO;
import kr.or.ddit.vo.VoteQustnrIemVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/freeBoard")
@Slf4j
public class FreeBoardController {

	@Autowired
	String uploadFolder;

	// 자유게시판 서비스 호출
	@Autowired
	FreeBoardService service;

	// 자유게시판 글 등록 폼 출력 메서드
	@GetMapping("/create")
	public String FreeBoardInsert() {
		return "class/freeBoardCreate";
	}

	//자유게시판 반페이지 입장 세션처리
	@Autowired
	SessionService sessionService;


	// 자유게시판 글 등록 실행 메서드
	@ResponseBody
	@PostMapping("/freeBoarRegistration")
	public int FreeBoarRegistration(HttpServletRequest request, Model model, NttVO nttVO, @RequestParam("upload") List<MultipartFile> uploadList) {
		// 로그인한 회원의 세션 정보 가져옴
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 게시물 코드 최대값 가져오는 메소드
		String getNttCode = service.getNttMaxCode();
		int maxNttCode = Integer.valueOf(getNttCode) + 1;

		// 게시물 코드 vo 세팅
		nttVO.setNttCode(String.valueOf(maxNttCode));

		int res = service.freeBoarRegistration(memberVO, nttVO, uploadList,clasVO);

		return res;
	}

	// 자유게시판 게시글 목록 출력
	@GetMapping("/freeBoardList")
	// String searchCondition = 검색 조건 파라미터 , @RequestParam(defaultValue = "1")
	// String currentPage = 페이징 파라미터,
	// RequestParam(defaultValue = "") String keyword = 검색어파라미터
	public String FreeBoardList(Model model, String searchCondition,
			@RequestParam(defaultValue = "1") String currentPage, @RequestParam(defaultValue = "") String keyword,HttpServletRequest request)
			throws ParseException {

		Map<String, Object> map = new HashMap<String, Object>();// 여러가지 파라미터값을 담을 Map 변수 선언
		map.put("cmmnNttSe", "A08002");// 게시판 분류코드
		map.put("currentPage", currentPage);// 페이징 처리
		map.put("keyword", keyword);// 검색어
		map.put("searchCondition", searchCondition);// 검색조건

		// jsp단에서 처리해야할 것
		model.addAttribute("currentPage", currentPage);// 글 번호 설정을 위한 현재페이지
		model.addAttribute("keyword", keyword);// 검색어 검색 후 검색어가 남아있게하기 위해
		model.addAttribute("searchCondition", searchCondition);// 검색후 검색조건이 남아있게 하기위해

		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");

		log.info("clasVO->" + clasVO);
		// 리스트 목록을 가져오기 위해 서비스 호출

		List<NttVO> nttVOList = service.selectNttList(map);


		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");

		// 위의 결과 값을 jsp단에서 출력
		model.addAttribute("nttVOList", nttVOList);
		// 페이징 처리를 위해서 전체 게시글 수를 가져올 서비스 호출
		int total = service.selectNttCount(map);

		// 글 번호 설정을 위해 jsp에도 처리
		model.addAttribute("total", total);

		// 페이징 처리를 위해 ArticlePage 호출해서 필수 매개변수 값을 넣어준다.
		ArticlePage<NttVO> articlePage = new ArticlePage<NttVO>(total, Integer.parseInt(currentPage), 10, nttVOList,keyword);

		// 페이징 처리의 html을 가져옴
		model.addAttribute("pagingArea", articlePage.getPagingArea());

		return "class/freeBoardList";
	}

	// 자유게시판 게시글 상세보기 메소드
	@PostMapping("/freeBoardDetailView")
	public String freeBoardDetailView(NttVO nttVO, HttpServletRequest request ,Model model) {
		// 첫번째 게시글 코드로 디비 조회하고 model에 넣어서 jsp에 넘겨주기
		nttVO = service.freeBoardDetail(nttVO);

		// 두번째 jsp한테 넘기기 전에 조회수 증가 시키고 넘겨주기
		int rdcnt = nttVO.getNttRdcnt();
		nttVO.setNttRdcnt(++rdcnt);
		service.rdCntadd(nttVO);

		// 세번째 첨부파일 코드로 첨부파일 테이블에서 첨부파일 리스트 가져오기
		List<AtchFileVO> atchFileVOList = service.selectAtchList(nttVO.getNttAtchFileCode());

//		log.info("atchFileVOList의 값->" + atchFileVOList);
		model.addAttribute("nttVO", nttVO);
		model.addAttribute("atchFileVOList", atchFileVOList);
//		log.info("atchFileVOList의 사이즈 -> " + atchFileVOList.size());
		//세션으로 게시글 작성자와 동일한지 정보확인
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		model.addAttribute("memberVO", memberVO);
		//댓글 리스트 출력
		List<AnswerVO>replyList = service.selectReply(nttVO);
//		log.info("replyList->" + replyList);
		model.addAttribute("replyList", replyList);
		return "class/freeBoardDetailView";
	}

	// 자유게시판 첨부파일 다운로드 기능 구현
	@PostMapping("/download")
	public void downloadFile(AtchFileVO atchFileVO, HttpServletResponse response) throws Exception {
		try {
			atchFileVO = service.getFileName(atchFileVO);
			//파일이 실제로 업로드 되어있는 파일 경로 지정하기
			//uploadFolder=>D:\\upload 디비에 저장된 파일 이름(\\freeBoard\\가 저장되어있음)
			String filePath = uploadFolder;
			uploadFolder.replace("\\", "/");
			//경로와 파일 명으로 파일 객체 생성
			File dFile = new File(filePath,atchFileVO.getAtchFileCours());
//			log.info("dFile->" + dFile.toString());
			//파일 길이 가져오기
			int size = (int)dFile.length();
//			log.info("파일길이 size=>" + size);
			if(size > 0) {
				String encodedFilename = "attachment; filename*=" + "UTF-8" + "''" + URLEncoder.encode(atchFileVO.getAtchFileNm(), "UTF-8");
				response.setContentType("application/octet-stream; charset=utf-8");
				// Header 설정
				response.setHeader("Content-Disposition", encodedFilename);
				// ContentLength 설정
				response.setContentLength(size);
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				/* BufferedInputStream
				 *
				java.io의 가장 기본 파일 입출력 클래스
				입력 스트림(통로)을 생성해줌
				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
				*/
				in = new BufferedInputStream(new FileInputStream(dFile));
					/* BufferedOutputStream
				 *
				java.io의 가장 기본이 되는 파일 입출력 클래스
				출력 스트림(통로)을 생성해줌
				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
				*/
				out = new BufferedOutputStream(response.getOutputStream());

				try {
						byte[] buffer = new byte[4096];
						int bytesRead = 0;
						/*
						모두 현재 파일 포인터 위치를 기준으로 함 (파일 포인터 앞의 내용은 없는 것처럼 작동)
						int read() : 1byte씩 내용을 읽어 정수로 반환
						int read(byte[] b) : 파일 내용을 한번에 모두 읽어서 배열에 저장
						int read(byte[] b. int off, int len) : 'len'길이만큼만 읽어서 배열의 'off'번째 위치부터 저장
						*/
						while ((bytesRead = in .read(buffer)) != -1) {
							out.write(buffer, 0, bytesRead);
						}
						// 버퍼에 남은 내용이 있다면, 모두 파일에 출력
						out.flush();
				} finally {
				 /*
				 현재 열려 in,out 스트림을 닫음
				 메모리 누수를 방지하고 다른 곳에서 리소스 사용이 가능하게 만듬
				 */
				 in.close();
				 out.close();
				}
			} else {
				throw new FileNotFoundException("파일이 없습니다.");
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
	}
	//게시글 삭제
	@ResponseBody
	@PostMapping("/deleteFreeBoardAjax")
	public int deleteFreeBoard(@RequestBody(required = false) NttVO nttVO) {
//		log.info("nttVO 첨부파일 삭제게시물코드: " + nttVO.getNttAtchFileCode());
//		log.info("nttVO 삭제게시물코드: " + nttVO.getNttCode());

		int res = service.deleteFreeBoard(nttVO);
		return res;
	}

	//게시글 수정 폼 출력
	@PostMapping("/updateFreeBoard")
	public String updateFreeBoard(NttVO nttVO, AtchFileVO atchFileVO,Model model) {
//		log.info("nttVO 첨부파일 수정할 게시물 코드 : " + atchFileVO.getAtchFileCode());
//		log.info("nttVO 수정할 게시물코드: " + nttVO.getNttCode());
//		log.info("nttVO 수정할 게시물 기존 제목 : " + nttVO.getNttCode());
//		log.info("nttVO 수정할 게시물 기존 내용 " + nttVO.getNttCode());
		List<AtchFileVO> atchFileVOList = service.selectAtchList(atchFileVO.getAtchFileCode());
		nttVO = service.selectNttVO(nttVO);
//		log.info("수정할 게시물 첨부파일 atchFileVOList->" + atchFileVOList);
		model.addAttribute("atchFileVOList", atchFileVOList);
		model.addAttribute("nttVO", nttVO);
		model.addAttribute("atchFileVO", atchFileVO);

		return "class/freeBoardUpdate";
	}

	@ResponseBody
	@PostMapping("/updateFreeBoardAjax")
	public int updateFreeBoardAjax(NttVO nttVO, AtchFileVO atchFileVO, String snArr,@RequestParam("upload") List<MultipartFile> uploadList, HttpServletRequest request) {
		int res = 0;//수정작업 성공한 개수
//		log.info("atchFileVO 첨부파일 수정할 게시물 코드 가져오기 : " + atchFileVO.getAtchFileCode());
//		log.info("nttVO 수정할 게시물코드 가져오기: " + nttVO.getNttCode());
//		log.info("nttVO 수정할 게시물 수정된 제목 가져오기: " + nttVO.getNttNm());
//		log.info("nttVO 수정할 게시물 수정된 내용 가져오기" + nttVO.getNttCn());
//		log.info("uploadList 이미지 개수 ->" + uploadList.size());
		String[] snArray = null;
		if(snArr != null && !"".equals(snArr)) {
			snArray = snArr.split(","); // ['4','2']
//			log.info("snArray : " + snArray.toString());

		}
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		res = service.updateFreeBoardAjax(nttVO, atchFileVO, snArray,uploadList,memberVO);

		return res;
	}

	@ResponseBody
	@PostMapping("/createReply")
	public Map<String, Object> createReply(@RequestBody(required = false)AnswerVO answerVO, HttpServletRequest request){
		int result = 0;//댓글 등록 작업 성공한 개수
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		answerVO.setMberId(memberVO.getMberId());
//		log.info("answerVO->" + answerVO);
//		log.info("answerVO내용들어왔는지 확인 ->"+ answerVO.getAnswerCn());
		result = service.createReply(answerVO,memberVO);
//		log.info("answerVO->" + answerVO);
		Map<String, Object> createReplyMap = new HashMap<String, Object>();

		createReplyMap.put("result", result);
		createReplyMap.put("answerVO", answerVO);

		return createReplyMap;
	}

	@ResponseBody
	@PostMapping("/updateReply")
	public int updateReply(@RequestBody(required = false)AnswerVO answerVO,Model model,HttpServletRequest request) {
		log.info("answerVO.getAnswerCn->" + answerVO.getAnswerCn());
		log.info("answerVO.getAnswerCode()->" + answerVO.getAnswerCode());

		int result = service.updateReply(answerVO);//댓글 수정 작업 성공한 개수

		return result;
	}


	@ResponseBody
	@PostMapping("/deleteReply")
	public int deleteReply(@RequestBody(required = false)AnswerVO answerVO) {

		log.info("answerVO.getAnswerCode()->" + answerVO.getAnswerCode());
		int result = service.deleteReply(answerVO);//댓글 삭제 작업 성공한 개수
		return result;
	}

	//////////////////////////////////////////설문 투표 컨트롤러 시작//////////////////////////////////////////

	//설문 등록 폼
	@GetMapping("/surveyCreate")
	public String surveyCreate() {
		return "class/surveyCreate";
	}
	//설문 등록 폼 등록
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/surveyCreateAjax")
	public int surveyCreateAjax(String data, HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
		//758109210076
		int res = 0;
		//반코드, 학교코드 세션에서 불러오기 위해 clasVO 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		//log.info("clasVO->" + clasVO);

		//작성자 아이디 불러오기 위해 memberVO 가져오기
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		//log.info("memberVO->" + memberVO);

		Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);
		//세션에서 clasVO불러와서 반 코드 데이터 세팅
		map.put("clasCode", clasVO.getClasCode());
		//세션에서 clasVO불러와서 학교 코드 데이터 세팅
		map.put("schulCode", clasVO.getSchulCode());
		//세션에서 memberVO불러와서 작성자 아이디 세팅
		map.put("mberId", memberVO.getMberId());
		//세팅한 VO 서비스 호출해서 데이터 전달
		res = service.surveyCreateAjax(map);

		return res;
	}

	//설문게시판 출력
	@GetMapping("/surveyList")
	public String surveyList(HttpServletRequest request, Model model) {
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		model.addAttribute("cmmnDetailCode", "A08003");
		return "class/surveyList";
	}

	//설문게시판 목록 ajax 출력
	@ResponseBody
	@RequestMapping(value = "/surveyListAjax", method = RequestMethod.POST)
	public ArticlePage<VoteNdQustnrVO> surveyListAjax(@RequestBody Map<String, Object> surveyMap) {
		//map{"currentPage":"1","keyword":""}
		List<VoteNdQustnrVO> voteNdQustnrVOList = service.surveyList(surveyMap);
		//log.info("voteNdQustnrVOList->"+ voteNdQustnrVOList);
		int total = service.getTotalSurvey(surveyMap);
		//log.info("total->"+ total);
		int size = 10;
		String currentPage = surveyMap.get("currentPage").toString();
		String keyword = surveyMap.get("keyword").toString();
		String url = "/freeBoard/surveyListAjax";
		ArticlePage<VoteNdQustnrVO> data = new ArticlePage<VoteNdQustnrVO>(total, Integer.parseInt(currentPage), size, keyword, url, voteNdQustnrVOList);
		return data;
	}

	//설문게시판 상세
	@PostMapping("/surveyDetailView")
	public String surveyDetailView(Model model,VoteNdQustnrVO voteNdQustnrVO, HttpServletRequest request) {
		//log.info("설문게시판 상세 코드 -> " + voteNdQustnrVO.getVoteQustnrCode());
		//사용자가 클릭한 설문 게시글 정보 가져오기
		voteNdQustnrVO = service.surveyDetailView(voteNdQustnrVO.getVoteQustnrCode());
		//사용자가 클릭한 설문 상세조회의 질문 리스트 가져오기
		List<VoteQustnrIemVO> iemVOList = service.iemVOList(voteNdQustnrVO.getVoteQustnrCode());
//		log.info("설문게시판 상세정보의 질문리스트->" + iemVOList);
		voteNdQustnrVO.setVoteQustnrIemVOList(iemVOList);
		List<VoteQustnrDetailIemVO> detailVOList = service.detailVOList(voteNdQustnrVO.getVoteQustnrCode());
		voteNdQustnrVO.setVoteQustnrDetailIemVOList(detailVOList);
		log.info("설문게시판 상세정보의 질문리스트,보기를 넣은 상태의 VO내용->" + voteNdQustnrVO);
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String voteQustnrBeginDt2 = format.format(voteNdQustnrVO.getVoteQustnrBeginDt());
		String voteQustnrEndDt2 = format.format(voteNdQustnrVO.getVoteQustnrEndDt());

		model.addAttribute("voteQustnrBeginDt", voteQustnrBeginDt2);
		model.addAttribute("voteQustnrEndDt", voteQustnrEndDt2);
		model.addAttribute("voteNdQustnrVO", voteNdQustnrVO);
		model.addAttribute("clasVO", clasVO);


		return "class/surveyDetailView";
	}


	//사용자의 설문 답변 등록
	@ResponseBody
	@PostMapping("/surbeyRegistrationAjax")
	public int surbeyRegistrationAjax(@RequestBody Map<String, Object> data,  HttpServletRequest request){
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.info("dataMap값~->"+ data);
		data.put("mberId", memberVO.getMberId());
		data.put("clasCode",clasVO.getClasCode());
		int res = service.surbeyRegistrationAjax(data);
		return res;
	}

	@ResponseBody
	@PostMapping("/survayChk")
	public int survayChk(@RequestBody String voteQustnrCode, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();
		voteNdQustnrVO.setVoteQustnrCode(voteQustnrCode);
		voteNdQustnrVO.setMberId(memberVO.getMberId());
		int res = service.survayChk(voteNdQustnrVO);

		return res;
	}

	//설문게시판 수정
	@PostMapping("/surveyUpdate")
	public String surveyUpdate(String voteQustnrCode, HttpServletRequest request,Model model) {
		//log.info("어덯게 값이 받아지니 -> " + voteQustnrCode);
		VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();
		voteNdQustnrVO = service.surveyDetailView(voteQustnrCode);
		//사용자가 클릭한 설문 상세조회의 질문 리스트 가져오기
		List<VoteQustnrIemVO> iemVOList = service.iemVOList(voteQustnrCode);
//		log.info("설문게시판 상세정보의 질문리스트->" + iemVOList);
		voteNdQustnrVO.setVoteQustnrIemVOList(iemVOList);
		List<VoteQustnrDetailIemVO> detailVOList = service.detailVOList(voteQustnrCode);
		voteNdQustnrVO.setVoteQustnrDetailIemVOList(detailVOList);
		log.info("설문게시판 상세정보의 질문리스트,보기를 넣은 상태의 VO내용->" + voteNdQustnrVO);
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");

		int answerCnt = service.answerChk(voteQustnrCode);

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String voteQustnrBeginDt2 = format.format(voteNdQustnrVO.getVoteQustnrBeginDt());
		String voteQustnrEndDt2 = format.format(voteNdQustnrVO.getVoteQustnrEndDt());

		model.addAttribute("voteNdQustnrVO", voteNdQustnrVO);
		model.addAttribute("clasVO", clasVO);
		model.addAttribute("answerCnt", answerCnt);

		return "class/surveyUpdate";
	}
	//설문 수정 폼 등록
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/surveyUpdateAjax")
	public int surveyUpdateAjax(String data, HttpServletRequest request) throws JsonMappingException, JsonProcessingException, ParseException {
		//758109210076
		int res = 0;
		//반코드, 학교코드 세션에서 불러오기 위해 clasVO 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		//log.info("clasVO->" + clasVO);

		//작성자 아이디 불러오기 위해 memberVO 가져오기
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		//log.info("memberVO->" + memberVO);

		Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);
		//세션에서 clasVO불러와서 반 코드 데이터 세팅
		map.put("clasCode", clasVO.getClasCode());
		//세션에서 clasVO불러와서 학교 코드 데이터 세팅
		map.put("schulCode", clasVO.getSchulCode());
		//세션에서 memberVO불러와서 작성자 아이디 세팅
		map.put("mberId", memberVO.getMberId());
		//세팅한 VO 서비스 호출해서 데이터 전달
		res = service.surveyUpdateAjax(map);

		return res;
	}

	//설문게시판 설문조사 게시글 삭제
	@ResponseBody
	@PostMapping("/surveyDeleteAjax")
	public int surveyDeleteAjax(String data) throws JsonMappingException, JsonProcessingException {
		//사용자 값 삭제
		Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);

		log.info("삭제버튼 게시글 코드 값->"+ map.get("voteQustnrCode"));

		int res = service.surveyDeleteAjax(map.get("voteQustnrCode").toString());

		return res;
	}

	//투표 등록
	@GetMapping("/voteCreate")
	public String voteCreate() {
		return "class/voteCreate";
	}
	//투표 폼 등록
		@ResponseBody
		@PostMapping("/voteCreateAjax")
		public int voteCreateAjax(String data, HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
			//758109210076
			int res = 0;

			//반코드, 학교코드 세션에서 불러오기 위해 clasVO 가져오기
			ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
			//log.info("clasVO->" + clasVO);

			//작성자 아이디 불러오기 위해 memberVO 가져오기
			MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
			//log.info("memberVO->" + memberVO);

			Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);


			//세션에서 clasVO불러와서 반 코드 데이터 세팅
			map.put("clasCode", clasVO.getClasCode());

			//세션에서 clasVO불러와서 학교 코드 데이터 세팅
			map.put("schulCode", clasVO.getSchulCode());
			//세션에서 memberVO불러와서 작성자 아이디 세팅
			map.put("mberId", memberVO.getMberId());
			//세팅한 VO 서비스 호출해서 데이터 전달
			res = service.voteCreateAjax(map);
			//log.info("세팅 후 투표 등록 폼 map-> " + map);

			return res;
		}

	//투표게시판 출력
	@GetMapping("/voteList")
	public String voteList(HttpServletRequest request, Model model) {
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");
		model.addAttribute("clasCode", clasVO.getClasCode());
		model.addAttribute("schulCode", clasVO.getSchulCode());
		model.addAttribute("cmmnDetailCode", "A08004");
		return "class/voteList";
	}
	//투표게시판 목록 ajax 출력
	@ResponseBody
	@RequestMapping(value = "/voteListAjax", method = RequestMethod.POST)
	public ArticlePage<VoteNdQustnrVO> voteListAjax(@RequestBody Map<String, Object> surveyMap) {
		//map{"currentPage":"1","keyword":""}
		List<VoteNdQustnrVO> voteNdQustnrVOList = service.surveyList(surveyMap);
		log.info("voteNdQustnrVOList->"+ voteNdQustnrVOList);
		int total = service.getTotalSurvey(surveyMap);
		//log.info("total->"+ total);
		int size = 10;
		String currentPage = surveyMap.get("currentPage").toString();
		String keyword = surveyMap.get("keyword").toString();
		String url = "/freeBoard/surveyListAjax";
		ArticlePage<VoteNdQustnrVO> data = new ArticlePage<VoteNdQustnrVO>(total, Integer.parseInt(currentPage), size, keyword, url, voteNdQustnrVOList);
		return data;
	}

	//투표 상세
	@PostMapping("/voteDetailView")
	public String voteDetailView(Model model,VoteNdQustnrVO voteNdQustnrVO, HttpServletRequest request) {
		log.info("투표게시판 상세 코드 -> " + voteNdQustnrVO.getVoteQustnrCode());
		//사용자가 클릭한 설문 게시글 정보 가져오기
		voteNdQustnrVO = service.surveyDetailView(voteNdQustnrVO.getVoteQustnrCode());
		//사용자가 클릭한 설문 상세조회의 질문 리스트 가져오기
		List<VoteQustnrIemVO> iemVOList = service.iemVOList(voteNdQustnrVO.getVoteQustnrCode());
//		log.info("설문게시판 상세정보의 질문리스트->" + iemVOList);
		voteNdQustnrVO.setVoteQustnrIemVOList(iemVOList);
		List<VoteQustnrDetailIemVO> detailVOList = service.detailVOList(voteNdQustnrVO.getVoteQustnrCode());
		voteNdQustnrVO.setVoteQustnrDetailIemVOList(detailVOList);
		log.info("설문게시판 상세정보의 질문리스트,보기를 넣은 상태의 VO내용->" + voteNdQustnrVO);
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String voteQustnrBeginDt2 = format.format(voteNdQustnrVO.getVoteQustnrBeginDt());
		String voteQustnrEndDt2 = format.format(voteNdQustnrVO.getVoteQustnrEndDt());

		model.addAttribute("voteQustnrBeginDt", voteQustnrBeginDt2);
		model.addAttribute("voteQustnrEndDt", voteQustnrEndDt2);
		model.addAttribute("voteNdQustnrVO", voteNdQustnrVO);
		model.addAttribute("clasVO", clasVO);
		return "class/voteDetailView";
	}
	//투표게시판 수정
	@PostMapping("/voteUpdate")
	public String voteUpdate(String voteQustnrCode, HttpServletRequest request,Model model) {
		//log.info("어덯게 값이 받아지니 -> " + voteQustnrCode);
		VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();
		voteNdQustnrVO = service.surveyDetailView(voteQustnrCode);
		//사용자가 클릭한 설문 상세조회의 질문 리스트 가져오기
		List<VoteQustnrIemVO> iemVOList = service.iemVOList(voteQustnrCode);
//				log.info("설문게시판 상세정보의 질문리스트->" + iemVOList);
		voteNdQustnrVO.setVoteQustnrIemVOList(iemVOList);
		List<VoteQustnrDetailIemVO> detailVOList = service.detailVOList(voteQustnrCode);
		voteNdQustnrVO.setVoteQustnrDetailIemVOList(detailVOList);
		log.info("설문게시판 상세정보의 질문리스트,보기를 넣은 상태의 VO내용->" + voteNdQustnrVO);
		ClasVO clasVO =(ClasVO) request.getSession().getAttribute("CLASS_INFO");

		int answerCnt = service.answerChk(voteQustnrCode);

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String voteQustnrBeginDt2 = format.format(voteNdQustnrVO.getVoteQustnrBeginDt());
		String voteQustnrEndDt2 = format.format(voteNdQustnrVO.getVoteQustnrEndDt());

		model.addAttribute("voteNdQustnrVO", voteNdQustnrVO);
		model.addAttribute("clasVO", clasVO);
		model.addAttribute("answerCnt", answerCnt);
		return "class/voteUpdate";
	}
	//투표 수정 폼 등록
		@SuppressWarnings("unchecked")
		@ResponseBody
		@PostMapping("/voteUpdateAjax")
		public int voteUpdateAjax(String data, HttpServletRequest request) throws JsonMappingException, JsonProcessingException, ParseException {
			//758109210076
			int res = 0;
			//반코드, 학교코드 세션에서 불러오기 위해 clasVO 가져오기
			ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
			//log.info("clasVO->" + clasVO);

			//작성자 아이디 불러오기 위해 memberVO 가져오기
			MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
			//log.info("memberVO->" + memberVO);

			Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);
			//세션에서 clasVO불러와서 반 코드 데이터 세팅
			map.put("clasCode", clasVO.getClasCode());
			//세션에서 clasVO불러와서 학교 코드 데이터 세팅
			map.put("schulCode", clasVO.getSchulCode());
			//세션에서 memberVO불러와서 작성자 아이디 세팅
			map.put("mberId", memberVO.getMberId());
			//세팅한 VO 서비스 호출해서 데이터 전달
			res = service.voteUpdateAjax(map);

			return res;
		}

	//투표게시판 투표 게시글 삭제
	@ResponseBody
	@PostMapping("/voteDeleteAjax")
	public int voteDeleteAjax(String data) throws JsonMappingException, JsonProcessingException {
		//사용자 값 삭제
		Map<String, Object> map = new ObjectMapper().readValue(data, Map.class);
		//log.info("삭제버튼 게시글 코드 값->"+ map.get("voteQustnrCode"));
		int res = service.surveyDeleteAjax(map.get("voteQustnrCode").toString());
		return res;
	}

	//최근에 마감된 투표 3개 가져오기
	@GetMapping("/surveyVoteChart")
	public String surveyVoteChart(Model model, HttpServletRequest request){
		//차트 데이터를 불러오기위해 공통으로 사용될 List
		List<Map<String, Object>> voteNdQustnrVOMapList = service.recentVotes();
		//log.info("최근 투표 여러개 voteNdQustnrVOMapList->" + voteNdQustnrVOMapList);

		//막대 차트
		List<List<Map<String, Object>>> voteQustnrIemVOMapList = new ArrayList<List<Map<String, Object>>>();
		for (int i = 0; i < voteNdQustnrVOMapList.size(); i++) {
			//
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("voteQustnrCode", voteNdQustnrVOMapList.get(i).get("VOTE_QUSTNR_CODE"));
			parameterMap.put("voteIemSn", voteNdQustnrVOMapList.get(i).get("VOTE_IEM_SN"));
			List<Map<String, Object>> list = service.getVoteInfo(parameterMap);
			voteQustnrIemVOMapList.add(list);
		}


		//도넛 및 파이 차트
		//반코드, 학교코드 세션에서 불러오기 위해 clasVO 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		List<List<Map<String, Object>>> responseMemberList = new ArrayList<List<Map<String,Object>>>();
		for (int i = 0; i < voteNdQustnrVOMapList.size(); i++) {
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("schulCode", clasVO.getSchulCode());
			parameterMap.put("clasCode", clasVO.getClasCode());
			parameterMap.put("voteQustnrCode", voteNdQustnrVOMapList.get(i).get("VOTE_QUSTNR_CODE"));
			parameterMap.put("voteIemSn", voteNdQustnrVOMapList.get(i).get("VOTE_IEM_SN"));
			List<Map<String, Object>> list = service.getResponseMember(parameterMap);
			responseMemberList.add(list);
		}
		log.info("가져온 투표의 정보 responseMemberList->" + responseMemberList);

		model.addAttribute("voteNdQustnrVOMapList", voteNdQustnrVOMapList);
		model.addAttribute("voteQustnrIemVOMapList", voteQustnrIemVOMapList);
		model.addAttribute("responseMemberList", responseMemberList);

		return "class/surveyVoteChart";
	}

	@GetMapping("/surveyFormDownload")
	public void surveyFormDownload(HttpServletResponse response) throws Exception {
		try {
			//파일이 실제로 업로드 되어있는 파일 경로 지정하기
			//uploadFolder=>D:\\upload 디비에 저장된 파일 이름(\\freeBoard\\가 저장되어있음)
			String filePath = uploadFolder + "\\freeBoard\\설문조사문서.xlsx";
			uploadFolder.replace("\\", "/");
			//경로와 파일 명으로 파일 객체 생성
			File dFile = new File(filePath);
//			log.info("dFile->" + dFile.toString());
			//파일 길이 가져오기
			int size = (int)dFile.length();
//			log.info("파일길이 size=>" + size);
			if(size > 0) {
				String encodedFilename = "attachment; filename*=" + "UTF-8" + "''" + URLEncoder.encode("설문조사문서.xlsx", "UTF-8");
				response.setContentType("application/octet-stream; charset=utf-8");
				// Header 설정
				response.setHeader("Content-Disposition", encodedFilename);
				// ContentLength 설정
				response.setContentLength(size);
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				/* BufferedInputStream
				 *
				java.io의 가장 기본 파일 입출력 클래스
				입력 스트림(통로)을 생성해줌
				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
				*/
				in = new BufferedInputStream(new FileInputStream(dFile));
					/* BufferedOutputStream
				 *
				java.io의 가장 기본이 되는 파일 입출력 클래스
				출력 스트림(통로)을 생성해줌
				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
				*/
				out = new BufferedOutputStream(response.getOutputStream());

				try {
						byte[] buffer = new byte[4096];
						int bytesRead = 0;
						/*
						모두 현재 파일 포인터 위치를 기준으로 함 (파일 포인터 앞의 내용은 없는 것처럼 작동)
						int read() : 1byte씩 내용을 읽어 정수로 반환
						int read(byte[] b) : 파일 내용을 한번에 모두 읽어서 배열에 저장
						int read(byte[] b. int off, int len) : 'len'길이만큼만 읽어서 배열의 'off'번째 위치부터 저장
						*/
						while ((bytesRead = in .read(buffer)) != -1) {
							out.write(buffer, 0, bytesRead);
						}
						// 버퍼에 남은 내용이 있다면, 모두 파일에 출력
						out.flush();
				} finally {
				 /*
				 현재 열려 in,out 스트림을 닫음
				 메모리 누수를 방지하고 다른 곳에서 리소스 사용이 가능하게 만듬
				 */
				 in.close();
				 out.close();
				}
			} else {
				throw new FileNotFoundException("파일이 없습니다.");
			}
		} catch (Exception e) {
			log.info(e.getMessage());
		}
	}

	// 설문게시판 엑셀 파일 업로드 시 타게 되는 컨트롤러
		@ResponseBody
		@PostMapping("/surveyExcelRegistration")
		public List<HashMap<Integer, String>> surveyExcelRegistration(HttpServletRequest request, Model model, @RequestParam("upload") MultipartFile upload) {

			List<HashMap<Integer, String>>  excelList = service.surveyExcelRegistration(upload);

			return excelList;
		}

}
