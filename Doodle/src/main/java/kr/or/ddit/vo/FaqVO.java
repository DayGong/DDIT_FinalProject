package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class FaqVO {
	private String faqCode;//FAQ 코드
	@DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
	private Date faqRegistDt;//FAQ 등록 일시
	private String faqSj;//FAQ 제목
	private String faqCn;//FAQ 내용
}
