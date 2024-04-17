package kr.or.ddit.vo;

import lombok.Data;

@Data
public class IemRspnsVO {
	private int voteIemSn;	//투표 항목 순번
	private String voteQustnrCode;	//투표 코드
	private String mberId;	//투표자 아이디
	private String quesRspnsCn;	//지문 응답 내용
	private String clasCode;	//반 코드
}
