package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class SchulPsitnMberVO {
	private int rnum;
	private String schulCode;           	//학교 코드
	private String mberId;              	//회원 아이디
	private String cmmnSchulPsitnSttus; 	//공통 학교 소속 상태(A02)
	private String cmmnGrade;           	//공통 학년(A22)
	private String cmmnEmpClsf;         	//공통 직원 직급(A14)
	private String sign;         			//서명
	
	//조인 시 사용하는 컬럼들
	private String grade; 					//학년
	private String schulPsitnSttusNm;		//학교 소속 상태 명(A02)
	private String cmmnEmpClsfNm;			//공통 직원 직급 명(A14)
	
	private List<SchulVO> schulVOList;		//학교 정보
	private List<MemberVO> memberVOList;	//학생 정보
//	private List<ChttRoomVO> chttRoomVoList;//채팅방 목록
	private MemberVO memberVO;				//유저 정보
	
	private String schulNm;      //학교 명
}
