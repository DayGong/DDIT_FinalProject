package kr.or.ddit.teacher.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.teacher.mapper.TeacherMapper;
import kr.or.ddit.teacher.service.TeacherService;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TeacherServiceImpl implements TeacherService {
	
	@Autowired
	TeacherMapper teacherMapper;

	//교사 마이페이지
	@Override
	public MemberVO myInfo(String mberId) {
		return this.teacherMapper.myInfo(mberId);
	}

	//교사 소속 학교 리스트
	@Override
	public List<SchulPsitnMberVO> mySchulList(String loginId) {
		return this.teacherMapper.mySchulList(loginId);
	}

	//교사 소속 클래스 리스트
	@Override
	public List<HrtchrVO> myClassList(String loginId) {
		return this.teacherMapper.myClassList(loginId);
	}
	
	// 마이 페이지 프로필 수정
	@Override
	public int updateProfile(MemberVO memVO) {
		return this.teacherMapper.updateProfile(memVO);
	}

}
