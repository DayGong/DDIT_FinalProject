package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AschaVO {
	private String aschaCode;		// 방과후학교 코드
	private String aschaNm;			// 방과후학교 명
	private String aschaDetailCn;	// 방과후학교 상세 내용
	private int aschaAtnlcCt;		// 방과후학교 수강 비용
	private int aschaAceptncPsncpa;// 방과후학교 수용 정원
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date aschaAtnlcBgnde;	// 방과후학교 수강 시작 일자
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date aschaAtnlcEndde;	// 방과후학교 수강 종료 일자
	private String schulCode;		// 학교 코드
	private String mberId;			// 회원 아이디
	private String cmmnDetailCode;	// 공통 수강 코드(A10)
	private String cmmnAtnlcNm;		// 공통 수강 상태 명
	private int totalStdnt;		// 과목당 수강중인 학생 수
	private String stdntState;		// 학생 수강 상태
	
	/* MEMBER */
	private String mberNm;			// 회원 이름
	private String moblphonNo; 		//핸드폰 번호
	
	/* SCHUL */
    private String schulNm;
    private String schulAdres;
    private String schulTlphonNo;
    
    /* CLAS */
    private String cmmnGrade;
    private String clasNm;
	
    /* CLAS_STDNT */
    private String clasInNo;
    
	// ASCHA : ASCHA_WEEK_PLAN = 1 : N
	private List<AschaWeekPlanVO> aschaWeekPlanVOList;
	
	// ASCHA : ATNLC_REQST = 1:N
	private List<AtnlcReqstVO> atnlcReqstVOList;
	
}
