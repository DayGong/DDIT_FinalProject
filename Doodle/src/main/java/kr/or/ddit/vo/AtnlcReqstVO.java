package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AtnlcReqstVO {
	private String atnlcReqstCode;  // 수강 신청 코드
	private int atnlcSetleAmount;   // 수강 결제 금액
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date atnlcSetleDt;      // 수강 결제 일시
	private String atnlcRefndAcnut; // 수강 환불 계좌
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date atnlcRefndDt;      // 수강 환불 일시
	private String cmmnDetailCode;  // 공동 수강 상태(A10)
	private String aschaCode;       // 방과후학교 코드
	private String schulCode;       // 학교 코드
	private String stdntId;         // 학생 아이디
	private String stdnprntId;      // 학부모 아이디
	
	/* ATNLC_REQST : ASCHA_DCLZ = 1:N */
	private List<AschaDclzVO> aschaDclzVOList;
}
