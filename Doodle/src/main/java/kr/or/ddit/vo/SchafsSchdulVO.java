package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SchafsSchdulVO {
	private String schafsSchdulCode;    //학사 일정 코드
	private String schafsSchdulNm;      //학사 일정 명
	private String schafsSchdulCn;      //학사 일정 내용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date schafsSchdulBgnde;     //학사 일정 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date schafsSchdulEndde;     //학사 일정 종료일
	private String schafsSchdulSe;		//학사 일정 구분
	private String schulCode;           //학교 코드
}
