package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class HrtchrVO {
	private String clasCode;				//반코드
	private String schulCode;				//학교코드
	private String mberId;					//회원 아이디
	private String cmmnDetailCode;			//공통 반 소속 상태(A03)
	
	private String mberSortNm;				//공통 회원 분류 명(A01)
	
	// 알림장에서 사용
	private String mberNm;					// 회원 이름 
	
	// 학급 클래스 메인에서 사용
	private ClasVO clasVO;				 	// 클래스 정보
	private MemberVO memberVO;				// 담임 교사 정보
//	private SchulVO schulVO;				// 학교 정보
	private List<ClasVO> clasVOList;		// 담임 교사가 속한 클래스 정보
}
