package kr.or.ddit.vo;

import lombok.Data;

@Data
public class VoteQustnrDetailIemVO {
	private int voteDetailIemSn;   //투표 세부 항목 순번
	private int voteIemSn;         //투표 항목 순번
	private String voteQustnrCode; //투표 코드
	private String voteDetailIemCn;//투표 세부 항목 내용
	private IemRspnsVO iemRspnsVO;
}
