package kr.or.ddit.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.MemberVO;

public interface CommonService {

	//메인페이지
	public String main();

	//FAQ 게시판 목록
	public String faq();

	//학원 조회
	public String academy();

	//아이디 중복체크
	public int idDupChk(MemberVO memberVO);

	//회원가입 실행
	public int signUp(MemberVO memberVO, MultipartFile uploadFile, List<String> mberChildIdList, String familyChoice);

	//학부모 회원가입시 자녀아이디 체크
	public int childChk(MemberVO memberVO);

	//로그인
	@GetMapping("/login")
	public String loginForm();

	//가족 관계 종류 불러오는 리스트 (회원가입에서 띄워야함)
	public List<CmmnDetailCodeVO> familyCategory();

	// 방문자 수와 브라우저를 등록하는 메서드
	public void addVisitrCo(HttpServletRequest request);

	// 로그인 수를 등록하는 메서드
	public void addLoginCo();
	
	//최초 1회 비밀번호 변경
	public int updatePassword(MemberVO memberVO);
}
