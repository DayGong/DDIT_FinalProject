package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.NtcnVO;

public interface NtcnService {
	
	// 알림장 목록 가져오기
	public List<NtcnVO> getNoticeList(Map<String, Object> map);

	// 알림장 게시판 등록
	public int ntcnInsert(NtcnVO ntcnVO);

	// 첨부파일코드 구하기
	public String getAtchFileCode(String clasCode);

	// 첨부파일 테이블 insert
	public int atchFileInsert(List<AtchFileVO> atchFileVOList);

	// 첨부파일 리스트
	public List<AtchFileVO> atchFileList(String atchFileCode);

	// 알림장 총 목록
	public int getTotalNtcn(String clasCode);

	// 알림장 수정 폼 출력
	public NtcnVO goToUpdateForm(String ntcnCode);

	// 첨부파일 개별삭제
	public int atchFileDeleteOne(String atchFileCours);

	// 알림장 수정
	public int ntcnUpdate(NtcnVO ntcnVO);

	// 알림장 수정 -> 글 제목이 수정된 경우 알림 제목 수정
	public int noticeSjUpdate(NtcnVO ntcnVO);

	// 첨부파일 순번 구하기
	public int getAtchFileSn(String atchFileCode);

	// 중요 알림 설정 -> 상단 고정
	public int updateImprtcAt(NtcnVO ntcnVO);

	// 알림장 삭제
	public int ntcnDelete(String ntcnCode);

	// 첨부파일 삭제
	public int atchFileDelete(String atchFileCode);

	// 알림장 양식 불러오기
	public String getNtcnForm(String nttNm);

	// 학급 내 모든 학생/학부모 리스트
	public List<String> getAllClassMber(String clasCode);

	// 알림장 등록 -> 알림 테이블 insert
	public int noticeInsertAll(Map<String, Object> map);

	// 알림장 삭제 -> 알림 테이블 delete
	public int noticeDeleteAll(String ntcnCode);

}
