package kr.or.ddit.teacher.mapper;

import java.util.List;

import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface TeacherMapper {

	//교사 마이페이지
	public MemberVO myInfo(String mberId);
	
	//교사 소속 학교 리스트
	public List<SchulPsitnMberVO> mySchulList(String loginId);
	
	//교사 소속 클래스 리스트
	public List<HrtchrVO> myClassList(String loginId);
	
	// 마이 페이지 프로필 변경
	public int updateProfile(MemberVO memVO);
	
	// 담당 학급 목록
	public String classList();
	
	// 학급 소속 회원 관리페이지
	public String classMemberAdmin();
	
	// 결석 사유 신청 목록(체험학습 포함)
	public String absentReasonList();
		
	// 투표/설문조사 등록
	public String createVotingSurvey();
	
	// 알림장 등록
	public String createNotice();
	
	// 과제 등록
	public String createTask();
	
	// 성적 목록
	public String gradeList();
	
	// 생활기록 학생 목록
	public String lifeRecordList();
	 
	// 반 통계?? 뭐에대한 통계인지 모르겠어
	
	// 학생 출결 목록
	public String attendanceList();
	
	// 시간표 등록
	public String createSchedule();
}
