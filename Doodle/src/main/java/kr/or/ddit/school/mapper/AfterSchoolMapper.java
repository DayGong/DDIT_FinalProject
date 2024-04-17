package kr.or.ddit.school.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AschaDclzVO;
import kr.or.ddit.vo.AschaVO;
import kr.or.ddit.vo.AschaWeekPlanVO;
import kr.or.ddit.vo.AtnlcReqstVO;

public interface AfterSchoolMapper {

	// 방과후학교 전체 리스트
	public List<AschaVO> afterSchoolList(Map<String, Object> map);

	// 전체 방과후학교 수
	public int getTotalAfterSchool(Map<String, Object> map);

	// 과목당 수강중인 학생수 출력
	public int getTotalLectureStudent(String aschaCode);
	
	// 방과후학교 상세
	public List<AschaVO> afterSchoolDetail(AschaVO aschaVO);

	// 방과후학교 생성
	public int afterSchoolCreate(AschaVO aschaVO);

	// 방과후학교 코드 최대값 가져오기
	public int getMaxAschaSeq(String schulCode);

	// 방과후학교 수정
	public int afterSchoolUpdate(AschaVO aschaVO);

	// 방과후학교 삭제
	public int afterSchoolDelete(AschaVO aschaVO);

	// 교사의 방과후화면 개설 목록
	public List<AschaVO> afterSchoolTeacherList(String mberId);

	// 과목당 수강중인 학생들
	public List<AschaVO> lectureStudentList(AschaVO aschaVO);

	// 수강신청 상태 변경
	public int lectureStateUpdate(AtnlcReqstVO atnlcReqstVO);

	// 주간계획 insert
	public int createWeekPlan(List<AschaWeekPlanVO> aschaWeekPlanVOList2);
	
	// 주간계획 select
	public AschaVO selectWeekPlan(AschaVO aschaVO);

	// 학생이 수강신청한 방과후학교 목록
	public List<AschaVO> afterSchoolLectureList(String mberId);

	// 주간계획 삭제
	public int deleteWeekPlan(AschaVO aschaVO);

	// 학교 정보 가져오기
	public AschaVO getSchoolInfo(String schulCode);

	// 결제내역 insert
	public int afterSchoolPayment(AtnlcReqstVO atnlcReqstVO);

	// 수강코드 최대값 가져오기
	public int getMaxatnlcReqst(String aschaCode);
	
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
