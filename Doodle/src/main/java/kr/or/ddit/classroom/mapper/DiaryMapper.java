package kr.or.ddit.classroom.mapper;

import java.util.List;

import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DiarySearchVO;
import kr.or.ddit.vo.NttVO;

public interface DiaryMapper {

	// 일기장  쓰기에서 날씨를 불러오기위해 학교가 소속된 지역을 가져오는 메서드
	public String getSchulArea(String schulCode);

	// 일기장 등록
	public int addDiaryAct(NttVO nttVO);

	// 일기장 목록 불러오기
	public List<NttVO> getDiaryList(DiarySearchVO diarySearchVO);

	// 일기장 개수 불러오기
	public int getDiaryTotal(DiarySearchVO diarySearchVO);

	// 선생님 아이디 가져오기
	public String getTeacherId(ClasVO clasVO);

	// 일기장 상세보기 정보 가져오기
	public NttVO getDiaryDetail(String nttCode);

	// 댓글 리스트 가져옴
	public List<AnswerVO> getDiaryReplyList(String nttCode);
	
	// 댓글 상세 정보 가져옴
	public AnswerVO getDiaryReplyDetail(String answerCode);

	// 댓글 등록하기
	public int addReply(AnswerVO answerVO);
	
	// 댓글 수정하기
	public int modDiaryReply(AnswerVO answerVO);

	// 댓글 삭제하기
	public int delDiaryReply(String answerCode);

	// 선생님이 일기장 목록을 가져오는 메서드
	public List<NttVO> getAllDiaryList(DiarySearchVO diarySearchVO);

	// 일기 삭제하기
	public int delDiary(String nttCode);

	// 저장될 게시물 코드 불러오기
	public String getNttCode();

	// 대용량 내용만 따로 저장
	public int addNttCn(NttVO nttVO);

}
