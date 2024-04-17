package kr.or.ddit.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VwStdntStdnprntVO {
	private String mberNm;			// 학생 이름
	private String clasCode;        // 반 코드
	private String clasNm;          // 반 이름
	private String cmmnGrade;       // 공통 학년(A22)
	private String clasStdntCode;   // 반 학생 코드
	private int clasInNo;           // 학생 번호
	private String stdnprntId;      // 학부모 아이디
	private String stdnprntNm;      // 학부모 이름
	private String moblphonNo;      // 학부모 연락처
	private String cmmnDetailCode;  // 가족 관계
	private String schulCode;       // 학교 코드
	private String stdntId;         // 학생 아이디
	private String schulNm;         // 학교 이름
}
