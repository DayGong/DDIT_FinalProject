package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HmpgManageVO {
	private Date hmpgManageDe;	// 홈페이지 관리 일자
	private int loginCo;		// 로그인 수
	private int mberSbscrbCo;	// 회원 가입 수
	private int visitrCo;		// 방문자 수
	private int brwsrChromeCo;	// 브라우저 크롬 수
	private int brwsrEdgeCo;	// 브라우저 엣지 수
	private int brwsrWhaleCo;	// 브라우저 웨일 수
	private int brwsrEtcCo;	// 브라우저 기타 수
	
	private int brwsrSum;		// 브라우저 개수 합계
}
