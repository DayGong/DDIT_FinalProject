package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EdcInfoNttVO {
	private String edcInfoNttCode; //게시물 코드
	private String edcInfoNttNm;	//게시물 명
	private String edcInfoNttWritngDt;	//게시물 작성 일시
	private String edcInfoNttWrter;	//게시물 작성자
	private String edcInfoNttUrl;	//게시물 경로
	private int rnum;				//순번
}
