package kr.or.ddit.task.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.TaskResultVO;
import kr.or.ddit.vo.TaskVO;

public interface TaskMapper {
	//과제 게시판 목록
	public List<TaskVO> taskList(Map<String, Object> map);
	
	// 과제 게시판 목록. 로우넘 없음. 클래스코드 선택적.
	public List<TaskVO> getTaskList(Map<String, Object> map);
	
	//과제 게시판 목록 수
	public int getTotalTask(Map<String, Object> map);
	
	//과제 게시글 상세 보기
	public TaskVO taskDetail(String taskCode);
	
	//과제 게시글 조회수 증가
	public int updateTaskCnt(String taskCode);

	//과제 게시글 등록
	public int taskInsert(TaskVO taskVO);
	
	//과제 게시글 등록 -> 학생/학부모에게 알림
	public int noticeInsertAll(Map<String, Object> map);
	
	//1) 파일 업로드 후 파일테이블에 insert
	public int atchFileInsert(List<AtchFileVO> atchFileVOList);

	//ATCH_FILE 테이블의 ATCH_FILE_CODE 가져오기
	public String getAtchFileCode(String clasCode);
	
	// 첨부 파일 이름 리스트
	public List<AtchFileVO> atchFileList(Map<String, Object> map);
	
	// 첨부 파일 삭제(초기화)
	public int atchFileDelete(String atchFileCode);

	// 교사가 현재 운영 중인 클래스의 코드 찾기
	public HrtchrVO getClasCode(String mberId);
	
	// 과제 게시글 수정
	public int taskUpdate(TaskVO taskVO);
	
	// 과제 게시글 수정 -> 글 제목 수정 시 알림 제목도 수정
	public int noticeSjUpdate(TaskVO taskVO);
	
	// 과제 게시글 삭제
	public int taskDelete(String taskCode);
	
	// 과제 게시글 삭제 -> 학생/학부모 알림 삭제
	public int noticeDeleteAll(String taskCode);
	
	// 과제 게시글 삭제 -> 제출된 과제 삭제
	public int inputTaskDelete(String taskCode);
	
	// 과제 게시글 삭제 -> 제출된 과제 첨부 파일 삭제
	public int inputTaskAtchFileDelete(String taskCode);

	// 파일 새로 업로드한 경우 업로드 진행
	public int atchFileUpdate(List<AtchFileVO> atchFileVOList);
	
	// 과제 제출
	public int inputTask(TaskResultVO taskResultVO);
	
	// (과제 제출용)로그인 한 학생의 반 학생 코드 가져오기
	public String getClasStdntCode(String mberId);
	
	// 제출한 과제 삭제
	public int myTaskDelete(String taskResultCode);
	
	// 과제 제출 현황 리스트
	public List<ClasStdntVO> inputTaskList(Map<String, Object> map);
	
	// 피드백 등록
	public int feedbackInsert(Map<String, Object> map);
	
	// 피드백 등록 -> 알림 테이블 insert
	public int fdbckNoticeInsert(Map<String, Object> map);
	
	// 피드백 삭제 -> 알림 테이블 delete
	public int noticeDelete(Map<String, Object> map);
	
	// 알림 수정
	public int updateNotice(String taskCode);
	
	// 헤더로 알림 내용을 보냄
	public NoticeVO feedbackToHeader(Map<String, Object> map);
	
	// 한 클래스 내 전체 학생 + 학부모 목록
	public List<String> getAllClassMber(String clasCode);
	
	// 자녀 리스트
	public List<String> getChildList(String mberId);
	
	// 과제 제출 수
	public int getInputTaskCount(String taskCode);
	
	// 칭찬 스티커 주기
	public int complimentStickerUpdate(String taskResultCode);
	
}
