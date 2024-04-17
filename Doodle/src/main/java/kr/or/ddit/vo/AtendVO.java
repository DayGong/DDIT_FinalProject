package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AtendVO {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date atendDe;		// 출석 일자
	private String schulCode;	// 학교 코드
}
