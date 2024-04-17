package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.DiarySearchVO;
import kr.or.ddit.vo.NttVO;

public interface DiaryService {

	// 일기장  쓰기에서 날씨를 불러오기위해 학교가 소속된 지역을 가져오는 메서드
	public String getSchulArea(String schulCode);

	// 일기장 등록
	public int addDiaryAct(HttpServletRequest request, NttVO nttVO);

	// 일기장 목록 불러오기
	public ArticlePage<NttVO> getDiaryList(HttpServletRequest request, DiarySearchVO diarySearchVO);

	// 일기 상세보기로 이동
	public Map<String, Object> diaryViewDetail(HttpServletRequest request, Model model, String nttCode);

	// 일기 상세보기 정보 가져옴
	public NttVO getDiaryDetail(String nttCode);

	// 댓글 상세 정보 가져옴
	public AnswerVO getDiaryReplyDetail(String answerCode);
	
	// 댓글 리스트 가져옴
	public List<AnswerVO> getDiaryReplyList(String nttCode);

	// 댓글 등록하기
	public int addReply(HttpServletRequest request, AnswerVO answerVO);

	// 댓글 수정하기
	public AnswerVO modDiaryReply(AnswerVO answerVO);

	// 댓글 삭제하기
	public int delDiaryReply(String answerCode);

	// 일기 삭제하기
	public int delDiary(String nttCode);

	// 일기장 이미지 파일업로드
	public String diaryImgUpload(String imgData);


}
