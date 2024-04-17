package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DclzVO {
	
	// 1depth
	// dclz
	private String atendDe;			//출석 일자
	private String cmmnDetailCode;	//공통 출결 처리(A06)
	private String dclzCmmnNm;		//공통 출결 처리 명
	// dt(subquery table)
	private String dtDt;
	
	// 2depth
	// clas_stdnt
	private String clasStdntCode;
	private int clasInNo;
	private String cmmnStdntClsf;
	private String cmmnClasPsitnSttus;
	private String clasCode;
	private String schulCode;
	private String mberId;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntJoinDate;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date clasStdntExitDate;
	// member
	private String mberNm;
	// sanctn_doc
	List<SanctnDocVO> sanctnList;

	// 3depth
	// dclz
	private int dclzSn;				//출결 순번
	private String dclzProcessTime;	//출결 처리 시간
	
	// self list
	List<DclzVO> stdList;
//	List<DclzVO> dayList;
	List<DclzVO> timeList;
}
