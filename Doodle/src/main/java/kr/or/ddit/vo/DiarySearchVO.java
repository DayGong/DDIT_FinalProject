package kr.or.ddit.vo;

import lombok.Data;

@Data
public class DiarySearchVO {
	private String mberId;				// 작성자
	private String startDate; 			// 시작일
	private String endDate;				// 종료일
	private String searchCondition;		// 검색 조건
	private String keyword;				// 검색어
	private int currentPage;			// 현재 페이지
	private int size;					// 목록 개수
	private String schulCode;			// 학교 코드
	private String clasCode;			// 반 코드		
}
