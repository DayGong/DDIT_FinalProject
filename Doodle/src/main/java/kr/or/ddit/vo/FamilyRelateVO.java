package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class FamilyRelateVO {
	private String schulCode;			//학교 코드
	private String stdntId;				//학생 아이디
	private String stdnprntId;			//학부모 아이디
	private String cmmnDetailCode;		//공통 가족 관계(A04)
	
	//조인 시 사용하는 컬럼
	private String familyRelateNm;			//공통 가족 관계 명(A04)
	
	private List<SchulVO> schulVOList;	//자녀 학교 정보
	private SchulPsitnMberVO schulPsitnMberVO; //학부모 자녀의 소속 학교 정보
	
	// NEY - 조인용 컬럼
	private String stdntIdNm;
	private int clasInNo;
	// 학부모 정보
	private MemberVO parentMemberVO;
	//조인 시 사용하는 컬럼
	private String mberSortNm;			//공통 가족 관계 명(A04)
	
	//조인 시 사용하는 컬럼
	private MemberVO stdntVO;

}

