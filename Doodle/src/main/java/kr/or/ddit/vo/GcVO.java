package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class GcVO {
	private String gcCode;//성적표 코드
	private String clasStdntCode;//반 학생 코드
	private int scre;//성적
	private String unitEvlCode;//단원 평가 코드
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm")
	private Date gcDate; // 응시 일시
	
	private double avgClasScore; // 반평균(get)
	List<ClasStdntVO> clasStdntVOList;
}
