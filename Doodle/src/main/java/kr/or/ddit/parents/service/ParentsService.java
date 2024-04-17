package kr.or.ddit.parents.service;

import java.util.List;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface ParentsService {

	//학부모 마이 페이지
	public MemberVO myInfo(String loginId);
	
	//프로필 수정
	public int updateProfile(MemberVO memVO);
	
	//자녀 리스트
	public List<FamilyRelateVO> childList(String loginId);

	//자녀 학교 리스트
	public List<SchulPsitnMberVO> childSchulList(String loginId);
	
	//자녀 클래스 리스트
	public List<ClasStdntVO> childClassList(String loginId);

	//학부모 인증 신청(학생에게)
	public String parentCertification();
	
	//학급클래스 신청
	public String classRequest();
	
	//상담 신청
	public String consultRequest();
	
	//방과후학교 신청
	public String afterSchoolRequest();
	
	//방과후학교 결제
	public String afterSchoolPay();

}
