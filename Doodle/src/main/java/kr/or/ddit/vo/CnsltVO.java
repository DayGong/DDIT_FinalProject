package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CnsltVO {
	private String cnsltCode;			// 상담 코드
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date cnsltDe;				// 상담 일자
	private String cnsltDiary;			// 상담 일지(거절 시 학부모 안내 문구)
	private String cnsltRequstCn;		// 상담 요청 내용
	private String cmmnCnsltSttus;		// 공통 상담 상태(A09)
	private String cmmnCnsltSttusNm;	// 공통 상담 상태(A09) 명
	private String schulCode;			// 학교 코드
	private String cnsltTrgetId;		// 상담 대상 아이디
	private String cnsltTrgetIdNm;		// 상담 대상 이름
	private String clasCode;			// 반 코드
	private String cnsltTcherId;		// 담임 교사 아이디
	private String cnsltTcherIdNm;		// 담임 교사 이름
	private String cmmnCnsltTime; 		// 공통 상담 시간(A17)
	
	private String stdntId;				// 자녀 아이디
	private String stdntIdNm;			// 자녀 이름
	private int clasInNo;				// 자녀 학급 내 번호
	
	private String cnsltCn;				// 상담 일지(거절, 완료 시)  
	private List<CmmnDetailCodeVO> cmmnDetailCodeCnsltTimeList;		// 상담 시간 목록
}
