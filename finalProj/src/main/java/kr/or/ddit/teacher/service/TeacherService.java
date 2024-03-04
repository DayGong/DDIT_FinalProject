package kr.or.ddit.teacher.service;


public interface TeacherService {

	//교사 마이페이지
	public String mypage();
	
	//담당 학급 목록
	public String classList();
	
	//학급 소속 회원 관리페이지
	public String classMemberAdmin();
	
	// 결석 사유 신청 목록(체험학습 포함)
	public String absentReasonList();
	
	//상담 신청 목록 게시판
	public String consultRequestList();
	
	
	//투표/설문조사 등록
	public String createVotingSurvey();
	
	//알림장 등록
	public String createNotice();
	
	//과제 등록
	public String createTask();
	
	//단원마무리 등록
	public String createUnitTest();
	
	//성적 목록
	public String gradeList();
	
	
	//생활기록 학생 목록
	public String lifeRecordList();
	 
	//반 통계?? 뭐에대한 통계인지 모르겠어
	
	//학생 출결 목록
	public String attendanceList();
	
	//시간표 등록
	public String createSchedule();
}
