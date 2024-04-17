package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AschaDclzVO {
	
	private String aschaAtendDe;	 // 방과후 출석 일자
	private String atnlcReqstCode;  // 수강 신청 코드
	private String cmmnDetailCode;  // 공통 출결 처리(A06)
	private String mberId;          // 회원 아이디
	private String stdntState;  // 공통 출결 처리명(A06)
	
	private String mberNm;			// 회원 이름
	private String aschaNm;			// 방과후 이름
}                                      
