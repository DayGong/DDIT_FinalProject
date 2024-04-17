package kr.or.ddit.util.service;

import javax.servlet.http.HttpServletRequest;

public interface SessionService {

	int setClassSession(HttpServletRequest request, String clasCode, String childId);
	int setClassSession(HttpServletRequest request, String clasCode);
	int setClassSession(HttpServletRequest request);

	int deleteClassSession(HttpServletRequest request);

	int setSchoolSession(HttpServletRequest request, String schulCode);
	int setSchoolSession(HttpServletRequest request);
	
	int deleteSchoolSession(HttpServletRequest request);
	
	int setMemberSession(HttpServletRequest request);

	Boolean isStudent(HttpServletRequest request);

	Boolean isEmployee(HttpServletRequest request);
	
	Boolean isParent(HttpServletRequest request);

	Boolean isPrincipal(HttpServletRequest request);

	Boolean isTeacher(HttpServletRequest request);

	Boolean isAdministration(HttpServletRequest request);

	Boolean isDietitian(HttpServletRequest request);
}
