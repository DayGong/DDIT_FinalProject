package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CnsltDiarySearchVO {
	private String cnsltDeRB;			// 1. 기간
	private String[] cnsltTimeCB;		// 2. 상담 시간
	private String[] cnsltSttusCB;		// 3. 상태
	private String startDate; 			// 4. 기간 선택 시작일
	private String endDate;				// 5. 기간 선택 종료일
	private String searchCondition;		// 6. 검색 조건
	private String keyword;				// 7. 검색어
	private int currentPage;			// 현재 페이지
	private int size;					// 목록 개수
}
