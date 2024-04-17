package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UnitEvlVO {
	private String unitEvlCode;  //단원 평가 코드
	private String unitEvlNm;    //단원 평가 명
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm")
	private Date unitEvlBeginDt; //단원 평가 시작 일시
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm")
	private Date unitEvlEndDt;   //단원 평가 종료 일시
	private String clasCode;     //반 코드
	
	private List<QuesVO> quesVOList; // 문항 리스트
	private List<ClasStdntVO> clasStdntVOList; // 학생 목록 
}
