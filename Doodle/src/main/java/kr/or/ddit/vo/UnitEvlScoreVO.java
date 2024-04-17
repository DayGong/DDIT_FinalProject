package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

/*
 * 성적 통계를 위한 VO
 */
@Data
public class UnitEvlScoreVO {
	// UNIT_EVL
	private String unitEvlCode;
	private String unitEvlNm;
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm")
	private Date unitEvlBeginDt;
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm")
	private Date unitEvlEndDt;
	private String clasCode;
	
	// etc..
	private int yetCnt; 		 // 미응시 인원
	private int doneCnt; 	     // 응시 완료 인원
	private int allCnt; 	     // 전체 인원
	private double avgClasScore; // 반평균
	private double maxScore; // 반 최고 점수
	private double minScore; // 반 최저 점수
	
	// QUES
	private int quesNo;
	private String quesQues;
	private String quesCnsr;
	private String quesExplna;
	private int quesAllot;
	
	// GC
	private String gcCode;
	private String clasStdntCode;
	private int scre;
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm")
	private Date gcDate;
	
	// CLAS_STDNT
	private int clasInNo;
	private String cmmnStdntClsf;
	private String cmmnClasPsitnSttus;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntJoinDate;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntExitDate;
	
	// MEMBER
	private String mberId;
	private String mberNm;
	
	// ASWPER
	private String aswperCn;
	
	// 학생 결과
	private List<UnitEvlScoreVO> UnitEvlScoreVOList;
	// 단원평가 정답
	private List<UnitEvlScoreVO> quesList;
	// 학생 답안
	private List<UnitEvlScoreVO> aswperList;
}
