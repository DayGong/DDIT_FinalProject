package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DietVO {
	private String dietCode;//식단 코드
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dietDe;//식단 일자
	private String dietMenu;//식단 메뉴
	private String schulCode;//학교 코드
	
	// join schul
	private SchulVO schulVO;
}
