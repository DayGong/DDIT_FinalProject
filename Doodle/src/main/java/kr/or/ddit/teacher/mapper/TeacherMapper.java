package kr.or.ddit.teacher.mapper;

import java.util.List;

import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface TeacherMapper {

	//교사 마이페이지
	public MemberVO myInfo(String mberId);
	
	//교사 소속 학교 리스트
	public List<SchulPsitnMberVO> mySchulList(String loginId);
	
	//교사 소속 클래스 리스트
	public List<HrtchrVO> myClassList(String loginId);
	
	// 마이 페이지 프로필 변경
	public int updateProfile(MemberVO memVO);
	
}
