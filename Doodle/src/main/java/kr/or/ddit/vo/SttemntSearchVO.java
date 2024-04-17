package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SttemntSearchVO {
	private String rceptDtRd;					// 접수 일자
	private String rceptStDt;					// 접수 일자 시작일
	private String rceptEdDt;					// 접수 일자 종료일
	private String processDtRd;					// 처리 일자
	private String processStDt;					// 처리 일자 시작일
	private String processEdDt;					// 처리 일자 종료일
	private String[] sttemntSttusCB;			// 상태
	private String searchCondition;				// 검색 조건
	private String keyword;						// 검색어
	private int currentPage;					// 현재 페이지
	private int size;							// 한 화면에 보일 목록 수
}
