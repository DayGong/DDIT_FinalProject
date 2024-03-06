package kr.or.ddit.classroom.vo;

import lombok.Data;

// 시간표
@Data
public class SkedVO {
	private String skedCode;
	private int semstr;
	private int period;
	private String cmmnSbject;
	private String cmmnDay;
	private String clasCode;
}
