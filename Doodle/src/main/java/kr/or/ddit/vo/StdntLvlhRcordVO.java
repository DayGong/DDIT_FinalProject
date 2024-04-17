package kr.or.ddit.vo;

import lombok.Data;

@Data
public class StdntLvlhRcordVO {
	private String stdntLvlhRcordCode; //학생 생활 기록 코드
	private String stdntLvlhEvl;       //학생 생활 평가
	private String cmmnGrade;          //공통 학년(A22)
	private String cmmnSemstr;         //공통 학기(A23)
	private String schulCode;          //학교 코드
	private String mberId;             //회원 아이디
}
