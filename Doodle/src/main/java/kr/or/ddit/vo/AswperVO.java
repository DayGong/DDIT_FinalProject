package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AswperVO {
	private int quesNo;			// 문제 번호
	private String unitEvlCode;		// 단원 평가 코드
	private String clasStdntCode;	// 반 학생 코드
	private String aswperCn;		// 답안 내용
}
