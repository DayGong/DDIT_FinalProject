package kr.or.ddit.classroom.vo;

import java.util.Date;

import lombok.Data;

// 알림장
@Data
public class NtcnVO {
	private String ntcnCode;
	private Date ntcnWritngDt;
	private String ntcnCn;
	private String clasCode;
}
