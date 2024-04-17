package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ChldrnClasVO {
	private String chldrnClasCode;  //자녀 반 코드
	private String clasCode;		//반코드
	private String mberId;			//회원아이디(학부모)
	private String stdntId;			//학생아이디
	private String stdntNm;			//학생명
	private String stdnprntNm;		//학부모명
	private String cmmnDetailNm;	//가족관계
	private String rnum;
	
	private String schulCode; 		//학교 코드
}
