package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ClasVO {
	private String clasCode;       		// 반 코드
	private String clasNm;         		// 반 명
	private int clasYear;          		// 반 연도
	private String cmmnGrade;      		// 공통 학년(A22)
	private String cmmnGradeNm;			// (공통코드)학년 명 가져오는 컬럼
	private String cmmnClasSttus;  		// 공통 반 상태(A16)
	private String cmmnClasSttusNm;		// (공통코드)반 상태 가져오는 컬럼
	private String schulCode;			// 학교 코드
	private String beginTm;			// 등교 시간
	private String endTm;			// 하교 시간
	private int rnum; 				// 순번
	private String mberNm;				// 회원이름
	
	// 학교/학급클래스 검색할 때 사용하는 JOIN
	private SchulVO schulVO;			// 학교VO
	// 반 학년 join
	private CmmnDetailCodeVO cmmnDetailCodeVO;
	// 자녀 정보 join
	private List<MemberVO> memberVO;

	//학교명 join
	private String schulNm;
	//CmmnDetailCodeVO테이블 -> 공통 상세 코드 명
	private String cmmnDetailCodeNm;
	
	//클래스 담당 교사
	private HrtchrVO hrtchrVO;
	
	//학부모 마이 페이지에서 사용
	private int cmmnGradeNo;			// 공통 학년 숫자(A22)
	
}
