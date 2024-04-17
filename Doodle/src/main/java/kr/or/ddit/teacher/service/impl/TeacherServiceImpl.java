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

	//담당 학급 목록
	@Override
	public String classList() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급 소속 회원 관리페이지
	@Override
	public String classMemberAdmin() {
		// TODO Auto-generated method stub
		return null;
	}

	// 결석 사유 신청 목록(체험학습 포함)
	@Override
	public String absentReasonList() {
		// TODO Auto-generated method stub
		return null;
	}

	//투표/설문조사 등록
	@Override
	public String createVotingSurvey() {
		// TODO Auto-generated method stub
		return null;
	}

	//알림장 등록
	@Override
	public String createNotice() {
		// TODO Auto-generated method stub
		return null;
	}

	//과제 등록
	@Override
	public String createTask() {
		// TODO Auto-generated method stub
		return null;
	}

	//성적 목록
	@Override
	public String gradeList() {
		// TODO Auto-generated method stub
		return null;
	}

	//생활기록 학생 목록
	@Override
	public String lifeRecordList() {
		// TODO Auto-generated method stub
		return null;
	}
	//반 통계?? 뭐에대한 통계인지 모르겠어
	
	//학생 출결 목록
	@Override
	public String attendanceList() {
		// TODO Auto-generated method stub
		return null;
	}

	//시간표 등록
	@Override
	public String createSchedule() {
		// TODO Auto-generated method stub
		return null;
	}

}
