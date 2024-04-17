package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SkedVO {
	private String skedCode;   //시간표 코드
	private int semstr;        //학기
	private int period;        //교시
	private String cmmnSbject; //공통 과목(A07)
	private String cmmnDayNm;  //공통 요일(A18)명
	private String cmmnDay;    //공통 요일(A18)
	private String clasCode;   //반 코드
}                                
