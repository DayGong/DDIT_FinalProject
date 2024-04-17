package kr.or.ddit.student.service;

import java.util.List;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.TaskResultVO;

public interface StudentService {

	//학생 마이페이지
	public MemberVO myInfo(String loginId);
	
	//학생 소속 학교 리스트
	public List<SchulPsitnMberVO> mySchulList(String loginId);
	
	//학생 소속 클래스 리스트
	public List<ClasStdntVO> myClassList(String loginId);
	
	//프로필 수정
	public int updateProfile(MemberVO memVO);
	
	//학부모 인증(학생이)
	public String parentCertification();

	//칭찬 스티커 수
	public int getComplimentStickerCount(String mberId);

	//칭찬 스티커 내역
	public List<TaskResultVO> getComplimentStickerStatus(String mberId);

}
