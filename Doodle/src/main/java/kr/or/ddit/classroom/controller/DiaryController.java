package kr.or.ddit.classroom.controller;

import java.util.List;
import java.util.Map;

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

import kr.or.ddit.classroom.service.DiaryService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DiarySearchVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/diary")
@Controller
public class DiaryController {
	
	@Autowired
	DiaryService diaryService;
	
	/** 일기장 목록으로 이동하는 메서드 */
	@GetMapping("/goToDiaryList")
	public String goToDiaryList(HttpServletRequest request, Model model) {
		MemberVO mberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.debug("goToDiaryList mberVO => " + mberVO);
		
		model.addAttribute("mberVO", mberVO);
		
		return "class/diaryList";
	}
	
	/** 일기장 쓰기 */
	@GetMapping("/addDiary")
	public String addDiary(HttpServletRequest request, Model model, @RequestParam(value = "nttCode", required = false, defaultValue = "") String nttCode) {
		MemberVO mberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		model.addAttribute("mberVO", mberVO);
		
		log.debug("addDiary mberVO => " + mberVO);
		
		
		return "class/diaryAdd";
	}
	
	/** 일기장  쓰기에서 날씨를 불러오기위해 학교가 소속된 지역을 가져오는 메서드 */
	@ResponseBody
	@GetMapping("/getSchulArea")
	public String getSchulArea(HttpServletRequest request) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.debug("getSchulArea clasVO => " + clasVO);
		
		String area = this.diaryService.getSchulArea(clasVO.getSchulCode());
		return area;
	}
	
	/** 일기장 등록 */
	@ResponseBody
	@PostMapping("/addDiaryAct")
	public int addDiaryAct(HttpServletRequest request, NttVO nttVO) {
		int result = this.diaryService.addDiaryAct(request, nttVO);
		
		log.debug("addDiaryAct nttVO => " + nttVO);
		log.debug("addDiaryAct result => " + result);
		
		return result;
	}
	
	/** 일기장 목록 불러오기 */
	@ResponseBody
	@PostMapping("/getDiaryList")
	public ArticlePage<NttVO> getDiaryList(HttpServletRequest request, DiarySearchVO diarySearchVO) {
		ArticlePage<NttVO> nttVOPage = this.diaryService.getDiaryList(request, diarySearchVO);
		
		log.debug("getDiaryList diarySearchVO => " + diarySearchVO);
		log.debug("getDiaryList nttVOPage => " + nttVOPage);
		
		return nttVOPage;
	}
	
	/** 일기 상세보기로 이동 */
	@GetMapping("/diaryViewDetail")
	public String diaryViewDetail(HttpServletRequest request, Model model, @RequestParam(value = "nttCode") String nttCode) {
		Map<String, Object> map = this.diaryService.diaryViewDetail(request, model, nttCode);
		model.addAttribute("mberVO", map.get("mberVO"));
		model.addAttribute("teacherId", map.get("teacherId"));
		model.addAttribute("writerId", map.get("writerId"));
		
		log.debug("diaryViewDetail map => " + map);
		
		return "class/diaryViewDetail";
	}
	
	/** 일기 상세보기 정보 가져오기 */
	@ResponseBody
	@GetMapping("/getDiaryDetail")
	public NttVO getDiaryDetail(@RequestParam(value = "nttCode") String nttCode) {
		NttVO nttVO = this.diaryService.getDiaryDetail(nttCode);
		
		log.debug("getDiaryDetail nttCode => " + nttCode);
		log.debug("getDiaryDetail nttVO => " + nttVO);
		
		return nttVO;
	}
	
	/** 일기 삭제하기 */
	@ResponseBody
	@PostMapping("/delDiary")
	public int delDiary(@RequestBody NttVO nttVO) {
		int result = this.diaryService.delDiary(nttVO.getNttCode());
		
		log.debug("delDiary result => " + result);
		
		return result;
	}
	
	/** 댓글 목록 가져오기 */
	@ResponseBody
	@GetMapping("/getDiaryReplyList")
	public List<AnswerVO> getDiaryReplyList(@RequestParam(value = "nttCode") String nttCode) {
		List<AnswerVO> answerVOList = this.diaryService.getDiaryReplyList(nttCode);
		
		log.debug("getDiaryReplyDetail answerCode => " + nttCode);
		log.debug("getDiaryReplyDetail answerVO => " + answerVOList);
		
		return answerVOList;
	}
	
	/** 댓글 상세 정보 가져오기 */
	@ResponseBody
	@GetMapping("/getDiaryReplyDetail")
	public AnswerVO getDiaryReplyDetail(@RequestParam(value = "answerCode") String answerCode) {
		AnswerVO answerVO = this.diaryService.getDiaryReplyDetail(answerCode);
		
		log.debug("getDiaryReplyDetail answerCode => " + answerCode);
		log.debug("getDiaryReplyDetail answerVO => " + answerVO);
		
		return answerVO;
	}
	
	/** 댓글 등록하기 */
	@ResponseBody
	@PostMapping("/addReply")
	public int addReply(HttpServletRequest request, @RequestBody AnswerVO answerVO) {
		int result = this.diaryService.addReply(request, answerVO);
		
		log.debug("addReply result => " + result);
		
		return result;
	}
	
	/** 댓글 수정하기 */
	@ResponseBody
	@PostMapping("/modDiaryReply")
	public AnswerVO modDiaryReply(@RequestBody AnswerVO answerVO) {
		AnswerVO resAnswerVO = this.diaryService.modDiaryReply(answerVO);
		
		log.debug("modDiaryReply answerCn => " + resAnswerVO);
		
		return resAnswerVO;
	}
	
	/** 댓글 삭제하기 */
	@ResponseBody
	@PostMapping("/delDiaryReply")
	public int delDiaryReply(@RequestBody AnswerVO answerVO) {
		int result = this.diaryService.delDiaryReply(answerVO.getAnswerCode());
		
		log.debug("delDiaryReply result => " + result);
		
		return result;
	}
	
	/** 일기장 이미지 파일업로드 */
	@ResponseBody
	@PostMapping("/diaryImgUpload")
	public String diaryImgUpload(String imgData) {
		String filePath = this.diaryService.diaryImgUpload(imgData);
		
		log.debug("imgData : " + imgData);
		log.debug("filePath : " + filePath);
		
		return filePath;
//		return "/resources/upload/2024/03/09/32a3a147-667c-4af1-b4dc-fe0edf289253_루돌푸꿈돌.png";
	}
	
}
