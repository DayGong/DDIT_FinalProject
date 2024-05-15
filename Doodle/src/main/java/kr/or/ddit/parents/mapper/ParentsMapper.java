package kr.or.ddit.parents.mapper;

import java.util.List;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface ParentsMapper {
	//학부모 마이페이지
	public MemberVO myInfo(String loginId);
	
	//프로필 수정
	public int updateProfile(MemberVO memVO);
	
	//자녀 리스트
	public List<FamilyRelateVO> childList(String loginId);

	//자녀 학교 리스트
	public List<SchulPsitnMberVO> childSchulList(String loginId);
	
	//자녀 클래스 리스트
	public List<ClasStdntVO> childClassList(String loginId);
	
	//상담 신청
	public String consultRequest();
	
}
