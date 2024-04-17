package kr.or.ddit.vo;

import lombok.Data;

@Data
public class QuesVO {
	private int quesNo;         //문제 번호
	private String unitEvlCode; //단원 평가 코드
	private String quesQues;    //문제 지문
	private String quesCnsr;    //문제 정답
	private String quesExplna;  //문제 해설
	private int quesAllot;      //문제 배점
}
