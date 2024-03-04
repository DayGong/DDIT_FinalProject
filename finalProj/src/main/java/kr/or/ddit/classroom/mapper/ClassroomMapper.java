package kr.or.ddit.classroom.mapper;

public interface ClassroomMapper {
	
	//학급클래스 목록
		public String classList();
		
		//학급클래스 소속회원 목록
		public String classMemberList();
		
		// 결석 사유 신청(체험학습도)
		public String absentReason();
		
		//자유 게시판 목록 
		public String freeBoard();
		
		//투표/설문조사 게시판 목록
		public String votingSurvey();
		
		//알림장 목록
		public String notice();
		
		//과제 게시판 목록
		public String task();
		
		//단원마무리 게시판 목록
		public String unitTest();
		
		//학급 갤러리 목록
		public String gallery();
		
		//학급 시간표 조회
		public String schedule();
		
		//온라인 수업
		public String onlineClass();
		
		//생활 기록부 조회
		public String lifeRecord();
}
