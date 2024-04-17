package kr.or.ddit.common.mapper;

import java.util.List;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.NoticeVO;

public interface HeaderMapper {
	// (학생) 현재 소속된 클래스 코드와 반 소속 상태  찾기
	public ClasStdntVO getStudentClasStatus(String mberId);
	
	// (교사) 현재 운영 중인 클래스 코드 찾기
	public String getTeacherClasCode(String mberId);
	
	// 모든 알림 불러오기
	public List<NoticeVO> getAllNotice(String mberId);
	
	// 알림 열람 여부 변경
	public int updateNoticeReadngAt(String noticeCode);
	
	// 현재 소속된 학교 코드 찾기
	public List<String> getSchulCode(String mberId);
	
	// (학부모) 자녀 리스트
	public List<FamilyRelateVO> childList(String mberId);
	
	// 알림 삭제
	public int noticeDelete(List<String> noticeCodeList);
	
	// 프로필 이미지 구하기
	public String getMberImage(String mberId);
}
