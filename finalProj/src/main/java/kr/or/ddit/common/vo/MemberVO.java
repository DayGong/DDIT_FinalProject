package kr.or.ddit.common.vo;

import lombok.Data;

@Data
public class MemberVO {
	private String mberId; //회원 아이디
	private String password; //회원 비밀번호
	private String mberNm;//회원 이름
	private String ihidnum;//회원 주민번호
	private String moblphonNo;//회원 휴대폰번호
	private String mberEmail;//회원 이메일
	private int zip;//회원 우편번호
	private String mberAdres;//회원 집주소
	private String mberImage;//회원 프로필 이미지
	private String mberSecsnAt;//회원 탈퇴 여부
	private String cmmnDetailCode;//공통회원 분류(A01)
}
