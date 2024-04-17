package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TaskResultVO {
	private String taskResultCode;		//과제 결과물 코드
	private String taskCode;      		//과제 코드
	private String cn;            		//내용
	private String fdbck;         		//피드백
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm:ss")
	private Date taskPresentnDate;		//과제 제출일
	private String atchFileCode;  		//첨부 파일 코드(첨부 파일)
	private String clasStdntCode; 		//반 학생 코드
	private String complimentSticker;	//칭찬 스티커
	@DateTimeFormat(pattern ="yyyy-MM-dd hh:mm:ss")
	private Date complimentStickerDate;	//칭찬 스티커 받은 날짜
	
	MultipartFile uploadFile;	  		//제출 과제
	
	ClasStdntVO clasStdntVO;	  		//학생 정보
	AtchFileVO atchFileVO;		  		//첨부파일 정보
	
	TaskVO taskVO;						//과제 정보
}
