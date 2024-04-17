package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AnswerVO {
	private String answerCode;		// 댓글 코드
	private String answerCn;		// 댓글 내용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date answerWritngDt;	// 댓글 작성 일자
	private String nttCode;			// 대상 게시물 코드
	private String schulCode;		// 학교 코드
	private String mberId;			// 작성자 아이디
	private String mberNm;			// 작성자 이름
	
	// 일기장
	private String strAnswerWritngDt;	// 댓글 작성 일자(문자)
	private String answerId;			// 댓글 작성자(게시물과 join시 이름 겹침 문제 해결용)
}
