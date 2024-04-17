package kr.or.ddit.classroom.service;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.VoteNdQustnrVO;
import kr.or.ddit.vo.VoteQustnrDetailIemVO;
import kr.or.ddit.vo.VoteQustnrIemVO;

public interface FreeBoardService {
	//자유 게시판 게시글만 등록
	public int freeBoarRegistration(MemberVO memberVO, NttVO nttVO, List<MultipartFile> uploadList,ClasVO clasVO);

	//게시판 최근 값 가져오기
	public String getNttMaxCode();

	//자유 게시판 목록 전체 데이터 가져오기
	public List<NttVO> selectNttList(Map<String, Object> map);

	//페이징 처리를 위해 자유 게시판 게시글 수 가져오기
	public int selectNttCount(Map<String, Object> map);

	//자유 게시판 상세 조회 출력을 위해 상세 조회 목록 가져오기
	public NttVO freeBoardDetail(NttVO nttVO);

	//자유게시판 조회수 증가
	public int rdCntadd(NttVO nttVO);

	//자유게시판 상세조회 해당 게시글 첨부파일 가져오기, //자유게시판 상세조회 해당 게시글 전체 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode);

	//자유게시판 상세조회 해당 게시글 개별 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public AtchFileVO getFileName(AtchFileVO atchFileVO);

	//자유게시판 상세조회 삭제 메소드
	public int deleteFreeBoard(NttVO nttVO);

	//자유게시판 수정 메소드
	public int updateFreeBoardAjax(NttVO nttVO, AtchFileVO atchFileVO, String[] snArray, List<MultipartFile> uploadList,MemberVO memberVO);

	//자유게시판 게시글 전체 값 가져오는 메소드
	public NttVO selectNttVO(NttVO nttVO);

	//자유게시판 댓글 작성 메소드
	public int createReply(AnswerVO answerVO, MemberVO memberVO);

	//자유게시판 댓글 리스트 출력 메소드
	public List<AnswerVO> selectReply(NttVO nttVO);

	//자유게시판 댓글 수정
	public int updateReply(AnswerVO answerVO);

	//자유게시판 댓글 삭제 메소드
	public int deleteReply(AnswerVO answerVO);

	//설문 등록 메소드
	public int surveyCreateAjax(Map<String, Object> map);

	//설문 리스트 메소드
	public List<VoteNdQustnrVO> surveyList(Map<String, Object> map);

	//설문 리스트 최대값 가져오기
	public int getTotalSurvey(Map<String, Object> surveyMap);

	//설문 상세조회
	public VoteNdQustnrVO surveyDetailView(String voteQustnrCode);

	//설문 질문 조회
	public List<VoteQustnrIemVO> iemVOList(String voteQustnrCode);

	//설문 질문 보기 조회
	public List<VoteQustnrDetailIemVO> detailVOList(String voteQustnrCode);

	//설문 학교 조회
	public SchulVO getSchulNm(String clasCode);

	//설문 등록
	public int surbeyRegistrationAjax(Map<String, Object> data);

	//설문 참여 여부 확인
	public int survayChk(VoteNdQustnrVO voteNdQustnrVO);

	//설문 수정 폼 등록
	public int surveyUpdateAjax(Map<String, Object> map) throws ParseException;

	//설문 응답자 유무 확인
	public int answerChk(String voteQustnrCode);

	//설문 삭제
	public int surveyDeleteAjax(String voteQustnrCode);

	//투표 생성
	public int voteCreateAjax(Map<String, Object> map);

	//투표 수정 폼 등록
	public int voteUpdateAjax(Map<String, Object> map) throws ParseException;

	//최근에 마감된 투표 3개 가져오기
	public List<Map<String, Object>> recentVotes();

	//최근에 마감된 투표 3개 정보 가져오기
	public List<Map<String, Object>> getVoteInfo(Map<String, Object> parameterMap);

	//응시/미응시 인원 수 정보 가져오기
	public List<Map<String, Object>> getResponseMember(Map<String, Object> parameterMap);

	//설문조사 등록 시 엑셀 파일 업로드하면 타게되는 서비스
	public List<HashMap<Integer, String>> surveyExcelRegistration(MultipartFile upload);




}
