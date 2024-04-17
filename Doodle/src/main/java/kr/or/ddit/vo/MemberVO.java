package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private String mberId; //회원 아이디
	private String password; //비밀번호
	private String mberNm; //회원 명
	private String ihidnum; //주민등록번호
	private String moblphonNo; //핸드폰 번호
	private String mberEmail; //회원 이메일
	private int zip; //우편 번호
	private String mberAdres; //회원 주소
	private String mberImage; //회원 이미지
	private String mberSecsnAt; //회원 탈퇴 여부
	private String cmmnDetailCode; //공통 회원 분류(A01)
	private String birthDate; //회원 생일
	
	private String mberSortNm; //공통 회원 분류 명(A01)
	private MultipartFile multipartFile; //프로필 사진(1개)
	
	List<SchulPsitnMberVO> schulPsitnMberVOList;

	//MEMBER : VW_MEMBER_AUTH = 1 : N
	private List<VwMemberAuthVO> vwMemberAuthVOList;
}
