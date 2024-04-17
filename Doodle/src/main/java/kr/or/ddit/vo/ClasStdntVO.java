package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ClasStdntVO {
	private String clasStdntCode;			//반 학생 코드
	private int clasInNo;					//학급 내 번호
	private String cmmnStdntClsf;			//공통 학생 직급(A19)
	private String cmmnClasPsitnSttus;		//공통 반 소속 상태(A03)
	private String clasCode;				//반 코드
	private String schulCode;				//학교 코드
	private String mberId;					//회원 아이디
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntJoinDate;		// 가입일
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntExitDate;		// 가입일
	
	private int rnum; 						//순번
	private String mberNm;					//회원 이름
	private String grade;					//학년 명
	private String cmmnClasPsitnSttusNm; 	//공통 반 소속 상태 명
	private String cmmnStdntClsfNm; 		//공통 학생 직급 명
	private String schulNm;					//학교명
	private String birthDate;				//생일
	private String moblphonNo;				//전화번호


	List<MemberVO> memberVOList;			//회원 정보
	List<ClasVO> clasVOList;				//소속 클래스 정보
	
	// 반 정보 join
	ClasVO clasVO;
	
	// 상담 JOIN
	MemberVO memberVO;
	
	// 과제 게시판 join
	TaskVO taskVO;
}

