package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AschaWeekPlanVO {
	private String aschaWeekPlanCode; // 방과후학교 주간 계획 코드
	private String aschaWeek;            // 방과후학교 주
	private String aschaWeekPlanCn;   // 방과후학교 주간 계획 내용
	private String aschaCode;         // 방과후학교 코드
}
