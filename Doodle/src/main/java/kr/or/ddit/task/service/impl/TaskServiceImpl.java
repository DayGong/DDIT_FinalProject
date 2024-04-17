package kr.or.ddit.task.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.task.mapper.TaskMapper;
import kr.or.ddit.task.service.TaskService;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.TaskResultVO;
import kr.or.ddit.vo.TaskVO;

@Service
public class TaskServiceImpl implements TaskService {
	
	@Autowired
	TaskMapper taskMapper;
	
	//과제 게시판 목록
	@Override
	public List<TaskVO> taskList(Map<String, Object> map) {
		return this.taskMapper.taskList(map);
	}
	
	//과제 게시판 총 목록
	@Override
	public int getTotalTask(Map<String, Object> map) {
		return this.taskMapper.getTotalTask(map);
	}
	
	//과제 게시글 상세 보기
	@Override
	public TaskVO taskDetail(String taskCode) {
		return this.taskMapper.taskDetail(taskCode);
	}
	
	// 과제 게시글 조회수 증가
	@Override
	public int updateTaskCnt(String taskCode) {
		return this.taskMapper.updateTaskCnt(taskCode);
	}

	// 과제 게시글 등록
	@Override
	public int taskInsert(TaskVO taskVO) {
		return this.taskMapper.taskInsert(taskVO);
	}
	
	//과제 게시글 등록 -> 학생/학부모에게 알림
	@Override
	public int noticeInsertAll(Map<String, Object> map) {
		return this.taskMapper.noticeInsertAll(map);
	}

	//1) 파일 업로드 후 파일테이블에 insert
	@Override
	public int atchFileInsert(List<AtchFileVO> atchFileVOList) {
		return this.taskMapper.atchFileInsert(atchFileVOList);
	}

	//ATCH_FILE 테이블의 ATCH_FILE_CODE 가져오기
	@Override
	public String getAtchFileCode(String clasCode) {
		return this.taskMapper.getAtchFileCode(clasCode);
	}

	// 첨부 파일 이름 리스트
	@Override
	public List<AtchFileVO> atchFileList(Map<String,Object> map) {
		return this.taskMapper.atchFileList(map);
	}

	// 첨부 파일 삭제(초기화)
	@Override
	public int atchFileDelete(String atchFileCode) {
		return this.taskMapper.atchFileDelete(atchFileCode);
	}
	
	// 교사가 현재 운영 중인 클래스의 코드 찾기
	@Override
	public HrtchrVO getClasCode(String mberId) {
		return this.taskMapper.getClasCode(mberId);
	}

	// 과제 게시글 수정
	@Override
	public int taskUpdate(TaskVO taskVO) {
		return this.taskMapper.taskUpdate(taskVO);
	}
	
	// 과제 게시글 수정 -> 글 제목 수정 시 알림 제목도 수정
	@Override
	public int noticeSjUpdate(TaskVO taskVO) {
		return this.taskMapper.noticeSjUpdate(taskVO);
	}

	// 파일 새로 업로드한 경우 업로드 진행
	@Override
	public int atchFileUpdate(List<AtchFileVO> atchFileVOList) {
		return this.taskMapper.atchFileUpdate(atchFileVOList);
	}

	// 과제 게시글 삭제
	@Override
	public int taskDelete(String taskCode) {
		return this.taskMapper.taskDelete(taskCode);
	}
	
	// 과제 게시글 삭제 -> 학생/학부모 알림 삭제
	@Override
	public int noticeDeleteAll(String taskCode) {
		return this.taskMapper.noticeDeleteAll(taskCode);
	}
	
	// 과제 게시글 삭제 -> 제출된 과제 삭제
	@Override
	public int inputTaskDelete(String taskCode) {
		return this.taskMapper.inputTaskDelete(taskCode);
	}
	
	// 과제 게시글 삭제 -> 제출된 과제 첨부 파일 삭제
	@Override
	public int inputTaskAtchFileDelete(String taskCode) {
		return this.taskMapper.inputTaskAtchFileDelete(taskCode);
	}
	
	// 과제 제출
	@Override
	public int inputTask(TaskResultVO taskResultVO) {
		return this.taskMapper.inputTask(taskResultVO);
	}

	// (과제 제출용)로그인 한 학생의 반 학생 코드 가져오기
	@Override
	public String getClasStdntCode(String mberId) {
		return this.taskMapper.getClasStdntCode(mberId);
	}

	// 과제 제출 현황 리스트
	@Override
	public List<ClasStdntVO> inputTaskList(Map<String, Object> map) {
		return this.taskMapper.inputTaskList(map);
	}

	// 제출한 과제 삭제
	@Override
	public int myTaskDelete(String taskResultCode) {
		return this.taskMapper.myTaskDelete(taskResultCode);
	}

	// 피드백 등록
	@Override
	public int feedbackInsert(Map<String, Object> map) {
		return this.taskMapper.feedbackInsert(map);
	}
	
	// 피드백 등록 -> 알림 테이블 insert
	@Override
	public int fdbckNoticeInsert(Map<String, Object> map) {
		return this.taskMapper.fdbckNoticeInsert(map);
	}

	// 피드백 삭제 -> 알림 테이블 delete
	@Override
	public int noticeDelete(Map<String, Object> map) {
		return this.taskMapper.noticeDelete(map);
	}
	
	// 헤더로 알림 내용을 보냄
	@Override
	public NoticeVO feedbackToHeader(Map<String, Object> map) {
		return this.taskMapper.feedbackToHeader(map);
	}

	// 알림 수정
	@Override
	public int updateNotice(String taskCode) {
		return this.taskMapper.updateNotice(taskCode);
	}

	// 한 클래스 내 전체 학생 + 학부모 목록
	@Override
	public List<String> getAllClassMber(String clasCode) {
		return this.taskMapper.getAllClassMber(clasCode);
	}

	// 자녀 리스트
	@Override
	public List<String> getChildList(String mberId) {
		return this.taskMapper.getChildList(mberId);
	}

	// 과제 제출 수
	@Override
	public int getInputTaskCount(String taskCode) {
		return this.taskMapper.getInputTaskCount(taskCode);
	}

	// 칭찬 스티커 주기
	@Override
	public int complimentStickerUpdate(String taskResultCode) {
		return this.taskMapper.complimentStickerUpdate(taskResultCode);
	}

}
