package kr.or.ddit.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.HeaderMapper;
import kr.or.ddit.common.service.HeaderService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.NoticeVO;

@Service
public class HeaderServiceImpl implements HeaderService {

	@Autowired
	HeaderMapper headerMapper;
	
	// (학생) 현재 소속된 클래스 코드와 반 소속 상태  찾기
	@Override
	public ClasStdntVO getStudentClasStatus(String mberId) {
		return this.headerMapper.getStudentClasStatus(mberId);
	}

	// (교사) 현재 운영 중인 클래스 코드 찾기
	@Override
	public String getTeacherClasCode(String mberId) {
		return this.headerMapper.getTeacherClasCode(mberId);
	}

	// 모든 알림 불러오기
	@Override
	public List<NoticeVO> getAllNotice(String mberId) {
		return this.headerMapper.getAllNotice(mberId);
	}
	
	// 알림 열람 여부 변경
	@Override
	public int updateNoticeReadngAt(String noticeCode) {
		return this.headerMapper.updateNoticeReadngAt(noticeCode);
	}
	
	// 현재 소속된 학교 코드 찾기
	@Override
	public List<String> getSchulCode(String mberId) {
		return this.headerMapper.getSchulCode(mberId);
	}

	// (학부모) 자녀 리스트
	@Override
	public List<FamilyRelateVO> childList(String mberId) {
		return this.headerMapper.childList(mberId);
	}

	// 알림 삭제
	@Override
	public int noticeDelete(List<String> noticeCodeList) {
		return this.headerMapper.noticeDelete(noticeCodeList);
	}
	
	// 프로필 이미지 구하기
	@Override
	public String getMberImage(String mberId) {
		return this.headerMapper.getMberImage(mberId);
}

}
