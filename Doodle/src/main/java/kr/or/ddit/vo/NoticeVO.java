package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVO {
	private String noticeCode;               // 알림 코드
	private String noticeSj;                 // 알림 제목
	private String noticeCn;                 // 알림 내용
	private String cmmnNoticeReadngAt;       // 공통 알림 열람 여부(A13)
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date noticeTrnsmitDt;            // 알림 송신 일시
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date noticeReadngDt;             // 알림 수신 일시
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss") 
	private Date noticeTrnsmitResveDt;       // 알림 송신 예약 일시
	private String schulCode;                // 학교 코드
	private String noticeSndId;              // 알림 송신자 아이디
	private String noticeRcvId;              // 알림 수신자 아이디
	private String cmmnBoardSe;				 // 공통 게시판 구분(A08)
	
	// 헤더에서 사용
	private TaskVO taskVO;					 // 과제 정보
}                                        
