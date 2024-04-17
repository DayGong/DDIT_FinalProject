package kr.or.ddit.employee.mapper;

import java.util.List;
import java.util.Map;


import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;

public interface EmployeeMapper {

	// 직원 마이페이지
	public String mypage();

	// 교직원 리스트
	public List<SchulVO> employeeList(Map<String, Object> map);
	
	// 교직원 리스트 총 게시물 수
    public int getEmployeeTotal(Map<String, Object> map);

	// 교직원 상세
	public SchulVO employeeDetail(Map<String,Object> map);

	// 멤버 등록
	public int insertMember(MemberVO memberVO);

	// 교직원 등록
	public int insertSchoolMember(SchulPsitnMberVO schulPsitnMberVO);

	// 교직원 등록시 아이디 중복체크
	public int idDupChk(MemberVO memberVO);
	
	// 멤버 수정
	public int updateMember(MemberVO memberVO);
	
	// 교직원 수정
	public int updateEmployeeSchulPsitnMber(SchulPsitnMberVO schulPsitnMberVO);

	// 교직원 삭제
	public int employeeDeleteAjax(SchulPsitnMberVO schulPsitnMberVO);
	
	// 학생 리스트
	public List<SchulVO> studentList(Map<String, Object> map);
	
	// 학생 리스트 총 갯수
	public int getStudentTotal(Map<String, Object> map);
	
	// 학생 상세
	public SchulVO studentDetail(Map<String, Object> map);
	
	//학생 등록
	public int insertSchoolStudent(SchulPsitnMberVO schulPsitnMberVO);

	// 학생 수정
	public int updateStudentSchulPsitnMber(SchulPsitnMberVO schulPsitnMberVO);
	
	// 학생 삭제
	public int studentDeleteAjax(SchulPsitnMberVO schulPsitnMberVO);
	
	//회원 이미지 가져오기
	public String employeeMemberImage(MemberVO memberVO);
	
	//서명 등록/수정
	public int insertSign(SchulPsitnMberVO schulPsitnMberVO);
	
	//아이디 최대값
	public String selectMaxId(String cmmnDetailCode);
	
	//멤버 삭제
	public int deleteMember(String mberId);
}
