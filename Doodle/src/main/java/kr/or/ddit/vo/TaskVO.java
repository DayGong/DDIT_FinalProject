package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class TaskVO {
//	private int rnum;			 //글 번호
	private String taskCode;     //과제 코드
	private String taskSj;       //과제 제목
	private String taskCn;       //과제 내용
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date taskBeginDt;    //과제 시작 일시
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm")
	private Date taskEndDt;      //과제 종료 일시
	private String atchFileCode; //첨부 파일 코드(첨부 파일)
	private String clasCode;     //반 코드
	private int taskCnt;		 //과제 조회수
	
	public MultipartFile[] uploadFiles; //업로드한 파일들
	
	HrtchrVO hrtchrVO;
	private List<AtchFileVO> atchFileVOList;
	
	TaskResultVO taskResultVO;
}                                
