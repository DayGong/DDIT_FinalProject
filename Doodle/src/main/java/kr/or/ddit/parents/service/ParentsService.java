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

}
