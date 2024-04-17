package kr.or.ddit.school.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AschaDclzVO;
import kr.or.ddit.vo.AschaVO;
import kr.or.ddit.vo.AtnlcReqstVO;

public interface AfterSchoolService {

	// 방과후학교 리스트
	public List<AschaVO> afterSchoolList(Map<String, Object> map);
	
	// 방과후학교 전체 수 
	public int getTotalAfterSchool(Map<String, Object> map);

	// 방과후학교 상세
	public List<AschaVO> afterSchoolDetail(AschaVO aschaVO);

	// 방과후학교 생성
	public int afterSchoolCreate(AschaVO aschaVO);

	// 방과후학교 수정
	public int afterSchoolUpdate(AschaVO aschaVO);

	// 방과후학교 삭제
	public int afterSchoolDelete(AschaVO aschaVO);

	// 교사 방과후화면 개설 목록
	public List<AschaVO> afterSchoolTeacherList(String mberId);

	// 과목당 수강중인 학생들
	public List<AschaVO> lectureStudentList(AschaVO aschaVO);

	// 수강신청 상태 변경
	public int lectureStateUpdate(AtnlcReqstVO atnlcReqstVO);

	// 학생이 수강신청한 방과후학교 목록
	public List<AschaVO> afterSchoolLectureList(String mberId);

	// 결제내역 insert
	public int afterSchoolPayment(AtnlcReqstVO atnlcReqstVO);

	// 출석부 목록
	public List<AschaVO> attendanceList(AschaVO aschaVO);

	// 출결정보 등록
	public int attendanceInsert(AschaDclzVO aschaDclzVO);

	// 출결정보 수정
	public int attendanceUpdate(AschaDclzVO aschaDclzVO);

	// 출결정보 삭제
	public int attendanceDelete(AschaDclzVO aschaDclzVO);

	// 학생, 학부모 방과후학교 )출석부 목록
	public List<AtnlcReqstVO> studAttendanceList(AtnlcReqstVO atnlcReqstVO);

}
