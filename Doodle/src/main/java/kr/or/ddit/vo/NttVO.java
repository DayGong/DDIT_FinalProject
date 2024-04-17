package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NttVO {
	private String nttCode;				// 게시물코드
	private String nttNm;				// 게시물 제목
	private String nttCn;				// 게시물 내용
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date nttWritngDt;			// 게시물 등록일시
	private int nttSttemntAccmlt;		// 게시물 신고누적
	private String nttAtchFileCode;		// 게시물 첨부파일코드
	private String cmmnNttSe;			// 공통 게시물 구분 (어느 게시판의 게시물인지 구분하는 역할)
	private String cmmnNttSttemnt;		// 공통 게시물 신고상태
	private String clasCode;			// 반 코드
	private String schulCode;			// 학교코드
	private String mberId;				// 게시물 작성자
	private int rnum;					// 게시물번호
	private int nttRdcnt; 				// 조회수
	private String wethr;				// 날씨
	
	private MultipartFile[] uploadFile;
	
	//NTT : ATCH_FILE = 1 : N
	private List<AtchFileVO> atchFileVOList;
	
	//Member테이블
	private MemberVO memberVO;	
	private String mberNm;           // 게시물 작성자명
	
	// NEY_일기장
	private List<AnswerVO> answerVOList;
	
//	private String answerCode;
//	private String answerCn;
	private String strNttWritngDt;			// 게시물 등록일시
}
