package kr.or.ddit.common.mapper;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface CommonMapper {

	//메인페이지
	public String main();

	//회원가입
	public int signUp(MemberVO memberVO);

	//회원가입시 아이디 중복체크
	public int idDupChk(MemberVO memberVO);

	//(학부모 회원가입시) 자녀아이디 체크
	public int childChk(MemberVO memberVO);

	//(학부모 회원가입시) 가족 관계 종류 불러오는 메소드 (회원가입.jsp에서 조건을 보여줘야함함)
	public List<CmmnDetailCodeVO> familyCategory();

	//(학부모 회원가입시) 자녀아이디로 학교코드 알아오는 메소드(가족관계에 인서트해야하는 내용)
	public String getSchulCode(String mberChildId);
	
	//(학부모 회원가입시) 학교소속회원 insert
	public int insertSchulPsitnMber(SchulPsitnMberVO spmVO);

	//(학부모 회원가입시) 가족 관계 정보 insert하는 메소드
	public int insertFamilyRelate(FamilyRelateVO frlVO);

	//로그인
	@GetMapping("/login")
	public String loginForm();

	//로그인시 아이디 유무체크
	public MemberVO loginChk(String username);

	//아이디 찾기
	public String searchId();

	//비밀번호 찾기
	public String searchPwd();

	//FAQ 게시판 목록
	public String faq();

	//학원 조회
	public String academy();
	
	// 방문자 수와 브라우저를 등록하는 메서드
	public int addVisitrCo(String browserName);

	// 로그인 수를 등록하는 메서드
	public int addLoginCo();
	
	//최초 1회 비밀번호 변경
	public int updatePassword(MemberVO memberVO);
}
