package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class HolidVO {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hoildDe;		// 휴일 일자
	private String schulCode;	// 학교 코드
}
