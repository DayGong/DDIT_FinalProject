package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SttemntVO {
	private String sttemntCode;    				// 신고 코드
	private String schulCode;      				// 학교 코드
	private String cmmnSttemntCn;  				// 공통 신고 내용(A24)
	private String nttCode;        				// 게시물 코드
	private String cmmnSttemntProcessSttus; 	// 공통 신고 처리 상태(A21)
	private String wrterId;						// 작성자 아이디
	private String sttemntId;         			// 신고자 아이디
	private String mngrId;         				// 관리자 아이디
	private String clasCode;					// 반 코드
	private String rceptDt;						// 접수 일자
	private String processDt;					// 처리 일자
	private int nttSttemntAccmlt;				// 게시물 신고 누적
	// JOIN
	private String cmmnSttemntCnNm;  			// 공통 신고 내용(A24) 이름
	private String cmmnSttemntProcessSttusNm; 	// 공통 신고 처리 상태(A21) 이름
	private String sttemntNm;         			// 신고자 이름
	private String wrterNm;						// 작성자 이름
	private String clasStdntCode;				// 반 학급 코드(갤러리 테이블)
}
