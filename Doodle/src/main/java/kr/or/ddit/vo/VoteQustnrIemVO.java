package kr.or.ddit.vo;

import lombok.Data;

@Data
public class VoteQustnrIemVO {
	private int voteIemSn;				//투표 항목 순번
	private String voteQustnrCode; 		//투표 코드
	private String voteIemCn;			//투표 항목 내용
	private String voteQustnrType;		//투표 설문 타입 구분(주관식 설문질문인지, 객관식 설문질문인지)
}
