package kr.or.ddit.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SanctnDocSearchVO {
	private String cmmnDocKnd;				// 01. 문서 종류
	private String exprnLrnBgndeRb;			// 02. 체험학습시작일
	private String exprnLrnEnddeRb;			// 03. 체험학습종료일
	private String rqstDeRb;				// 04. 신청일
	private String[] cmmnProcessSttusCB;	// 05. 상태
	private String bgndeStartDate; 			// 06. 체험학습시작일 선택 시작일
	private String bgndeEndDate;			// 07. 체험학습시작일 선택 종료일
	private String enddeStartDate; 			// 08. 체험학습종료일 선택 시작일
	private String enddeEndDate;			// 09. 체험학습종료일 선택 종료일
	private String rqstDeStartDate; 		// 10. 신청일 선택 시작일
	private String rqstDeEndDate;			// 11. 신청일 선택 종료일
	private String searchCondition;			// 12. 검색 조건
	private String keyword;					// 13. 검색어
	private int currentPage;				// 14. 현재 페이지
	private int size;						// 15. 목록 개수
	private String clasStdntCode;			// 16. 반학생코드
	private String clasCode;				// 17. 반코드
	private String schulCode;				// 18. 학교코드
}
