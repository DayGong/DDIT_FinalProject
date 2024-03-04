package kr.or.ddit.school.mapper;

public interface SchoolMapper {

	//학교 공지사항 게시판 목록
		public String notice();
		
		//학교 교육정보 게시판 
		public String eduInfo();
		
		//교직원 관리
		public String employeeManage();
		
		//자료실 
		public String dataRoom();
		
		//급식
		public String meal();
		
		//학사일정
		public String academicCalendar();
		
		//시간표
		public String schedule();
		
		//학생(전교생) 관리 
		public String studentsManage();
		
		//방과후학교
		public String afterSchool();
		
		//학급 클래스 목록
		public String classList();
}
