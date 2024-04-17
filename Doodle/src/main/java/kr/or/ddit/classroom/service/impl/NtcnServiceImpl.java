package kr.or.ddit.classroom.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.classroom.mapper.NtcnMapper;
import kr.or.ddit.classroom.service.NtcnService;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.NtcnVO;

@Service
public class NtcnServiceImpl implements NtcnService {

	@Autowired
	NtcnMapper ntcnMapper;
	
	// 알림장 리스트
	@Override
	public List<NtcnVO> getNoticeList(Map<String, Object> map) {
		return this.ntcnMapper.getNoticeList(map);
	}

	// 알림장 게시판 등록
	@Override
	public int ntcnInsert(NtcnVO ntcnVO) {
		return this.ntcnMapper.ntcnInsert(ntcnVO);
	}

	// 첨부파일코드 구하기
	@Override
	public String getAtchFileCode(String clasCode) {
		return this.ntcnMapper.getAtchFileCode(clasCode);
	}

	// 첨부파일 테이블 insert
	@Override
	public int atchFileInsert(List<AtchFileVO> atchFileVOList) {
		return this.ntcnMapper.atchFileInsert(atchFileVOList);
	}

	// 첨부파일 리스트
	@Override
	public List<AtchFileVO> atchFileList(String atchFileCode) {
		return this.ntcnMapper.atchFileList(atchFileCode);
	}

	// 알림장 총 목록
	@Override
	public int getTotalNtcn(String clasCode) {
		return this.ntcnMapper.getTotalNtcn(clasCode);
	}

	// 알림장 수정 폼 출력
	@Override
	public NtcnVO goToUpdateForm(String ntcnCode) {
		return this.ntcnMapper.goToUpdateForm(ntcnCode);
	}

	// 첨부파일 개별삭제
	@Override
	public int atchFileDeleteOne(String atchFileCours) {
		return this.ntcnMapper.atchFileDeleteOne(atchFileCours);
	}

	// 알림장 수정
	@Override
	public int ntcnUpdate(NtcnVO ntcnVO) {
		return this.ntcnMapper.ntcnUpdate(ntcnVO);
	}
	
	// 알림장 수정 -> 글 제목이 수정된 경우 알림 제목 수정
	@Override
	public int noticeSjUpdate(NtcnVO ntcnVO) {
		return this.ntcnMapper.noticeSjUpdate(ntcnVO);
	}

	// 첨부파일 순번 구하기
	@Override
	public int getAtchFileSn(String atchFileCode) {
		return this.ntcnMapper.getAtchFileSn(atchFileCode);
	}

	// 중요 알림 설정 -> 상단 고정
	@Override
	public int updateImprtcAt(NtcnVO ntcnVO) {
		return this.ntcnMapper.updateImprtcAt(ntcnVO);
	}

	// 알림장 삭제
	@Override
	public int ntcnDelete(String ntcnCode) {
		return this.ntcnMapper.ntcnDelete(ntcnCode);
	}
	
	// 첨부파일 삭제
	@Override
	public int atchFileDelete(String atchFileCode) {
		return  this.ntcnMapper.atchFileDelete(atchFileCode);
	}

	// 알림장 글 양식 불러오기
	@Override
	public String getNtcnForm(String nttNm) {
		return this.ntcnMapper.getNtcnForm(nttNm);
	}

	// 학급 내 모든 학생/학부모 리스트
	@Override
	public List<String> getAllClassMber(String clasCode) {
		return this.ntcnMapper.getAllClassMber(clasCode);
	}

	// 알림장 등록 -> 알림 테이블 insert
	@Override
	public int noticeInsertAll(Map<String, Object> map) {
		return this.ntcnMapper.noticeInsertAll(map);
	}

	// 알림장 삭제 -> 알림 테이블 delete
	@Override
	public int noticeDeleteAll(String ntcnCode) {
		return this.ntcnMapper.noticeDeleteAll(ntcnCode);
	}

}
