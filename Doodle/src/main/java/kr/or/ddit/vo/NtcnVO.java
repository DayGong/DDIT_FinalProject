package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NtcnVO {
	private String ntcnCode;     		//알림장 코드
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date ntcnWritngDt;   		//알림장 작성 일시
	private String ntcnSj;       		//알림장 제목
	private String ntcnCn;       		//알림장 내용
	private String clasCode;     		//반 코드
	private String atchFileCode; 		//첨부 파일 코드
	private int ntcnCnt; 		 		//조회수
	private int imprtcNtcnAt; 			//중요(고정) 상태
	
	private MultipartFile[] uploadFiles;//업로드한 파일
	
	// 조인 시 사용
	private HrtchrVO hrtchrVO;	 		//담임 교사 정보
	private List<AtchFileVO> atchFileVO;		//첨부파일 정보
}
