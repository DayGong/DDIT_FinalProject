package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ChttVO {
	  
  private String chttCode;     // 채팅 코드
  @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
  private Date chttDt;        	// 채팅 일시
  private String writer;		// 발신자	
  private String dsptchId;		// 발신 아이디
  private String chttCn;		// 채팅 내용
  private String chttRoomCode;	// 채팅방 코드
  private String chttSn;		// 채팅 순번
  private String dsptchNm;		// 발신자 명
  
}
