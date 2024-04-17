package kr.or.ddit.classroom.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.IemRspnsVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.VoteNdQustnrVO;
import kr.or.ddit.vo.VoteQustnrDetailIemVO;
import kr.or.ddit.vo.VoteQustnrIemVO;

public interface FreeBoardMapper {

	//자유게시판 코드 nttCode Max값 가져오기
	public String getNttMaxCode();

	//자유게시판 게시물 등록시 첨부파일 등록
	public int uploadFile(AtchFileVO atchfileVO);

	//자유게시판 게시물 등록시 게시글 텍스트 등록
	public int freeBoarRegistration(NttVO nttVO);

	//자유게시판 테이블 데이터 리스트 가져오기
	public List<NttVO> selectNttList(Map<String, Object> map);

	//자유게시판 전체 게시물 수 가져오기
	public int selectNttCount(Map<String, Object> map);

	//자유게시판 상세조회 데이터 가져오기
	public NttVO freeBoardDetail(NttVO nttVO);

	//자유게시판 자유게시판 첨부파일코드  Max값 가져오기
	public String getFreeMaxCode(NttVO nttVO);

	//자유게시판 조회수 증가 하기
	public int rdCntadd(NttVO nttVO);

	//자유게시판 상세조회 해당 게시글 첨부파일 가져오기, //자유게시판 상세조회 해당 게시글 전체 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode);

	//자유게시판 상세조회 해당 게시글 개별 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public AtchFileVO getFileName(AtchFileVO atchFileCode);

	//자유게시판 상세조회 삭제
	public int deleteFreeBoard(NttVO nttVO);

	//자유게시판 상세조회 파일 삭제
	public int deleteAtchFile(String atchFileCode);

	//자유게시판 상세조회 업데이트
	public int updateFreeBoardAjax(NttVO nttVO);

	//자유게시판 게시글 수정시 기존 첨부파일 개별 삭제시 실행되는 메소드
	public void deleteAtchFile2(AtchFileVO atchFileVO2);

	//자유게시판 게시글 수정시 기존 첨부파일 개별 삭제 후 파일 순번 정렬 메소드
	public void updateFileSn(Map<String, Object> updateAtchFileSnMap);

	//자유게시판 게시글 전체 가져오기
	public NttVO selectNttVO(NttVO nttVO);

	//자유게시판 댓글작성
	public int createReply(AnswerVO answerVO);

	//자유게시판 댓글 맥스값 가져오기
	public int getMaxAnswerCode();

	//자유게시판 댓글 리스트 가져오기
	public List<AnswerVO> selectReply(NttVO nttVO);

	//자유게시판 댓글 삭제
	public int deleteReply(AnswerVO answerVO);

	//설문게시판 설문 등록
	public int insertQust(VoteNdQustnrVO voteNdQustnrVO);

	//설문게시글 맥스 게시물 코드 가져오기
	public int getMaxSurveyVoteCode();

	//설문항목 등록
	public int insertQustIem(VoteQustnrIemVO voteQustnrIemVO);

	//설문 세부항목 등록
	public int insertQustDetail(VoteQustnrDetailIemVO voteQustnrDetailIemVO);

	//설문 게시판 리스트 조회
	public List<VoteNdQustnrVO> surveyList(Map<String, Object> map);

	//설문 게시판 게시물 최대값
	public int getTotalSurvey(Map<String, Object> surveyMap);

	//설문 게시판 상세조회
	public VoteNdQustnrVO surveyDetailView(String voteQustnrCode);

	//설문 질문 조회
	public List<VoteQustnrIemVO> iemVOList(String voteQustnrCode);

	//설문 질문 보기 조회
	public List<VoteQustnrDetailIemVO> detailVOList(String voteQustnrCode);

	//설문 학교 조회
	public SchulVO getSchulNm(String clasCode);

	//설문 사용자 답변 등록
	public int surbeyRegistrationAjax(IemRspnsVO iemRspnsVO);

	//설문 참여 여부 확인
	public int survayChk(VoteNdQustnrVO voteNdQustnrVO);

	//설문 수정 등록
	public int updateQust(VoteNdQustnrVO voteNdQustnrVO);

	//설문 응답 유무 확인
	public int answerChk(String voteQustnrCode);

	//설문 수정 시 보기 삭제
	public int surveyDelDetail(String voteQustnrCode);

	//설문 수정 시 보기 문제 삭제
	public int surveyDelQustustion(String voteQustnrCode);

	//설문 수정 시 설문 설정 수정
	public int surveyUpdateAjax(VoteNdQustnrVO voteNdQustnrVO);

	//설문 삭제 시 사용자 응답 데이터 삭제
	public int deleteIemRspns(String data);

	//설문 삭제 시 보기 데이터 삭제
	public int deleteQustnDetail(String data);

	//설문 삭제 시 질문 데이터 삭제
	public int deleteQustnIem(String data);

	//설문 삭제 시 설문 설정 데이터 삭제
	public int deleteVoteNdQustnr(String data);

	//최근 마감된 투표 3개 가져오기
	public List<Map<String, Object>> recentVotes();

	//최근에 마감된 투표 정보 가져오기
	public List<Map<String, Object>> getVoteInfo(Map<String, Object> voteNdQustnrVOMap);

	//응시/미응시 인원 수 정보 가져오기
	public List<Map<String, Object>> getResponseMember(Map<String, Object> parameterMap);

	//댓글 수정 mapper
	public int updateReply(AnswerVO answerVO);










}
