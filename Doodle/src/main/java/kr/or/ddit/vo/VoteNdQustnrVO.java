package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
//공통상세코드 A08003 설문, 공통코드 A08
//공통상세코드 A08004 투표, 공통코드 A08
@Data
public class VoteNdQustnrVO {

	private String voteQustnrCode;					//투표 설문 코드
	private String voteQustnrNm;					//투표 설문 명
	private String voteQustnrCn;					//투표 설문 내용
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date voteQustnrBeginDt;					//투표 설문 시작 일시
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date voteQustnrEndDt;					//투표 설문 종료 일시
	private String cmmnDetailCode;					//공통 투표/설문 구분(A12)
	private String clasCode;						//반 코드
	private String schulCode;						//학교 코드
	private String mberId;							//작성자 아이디
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date writngDt;							//투표 설문 게시글 작성날짜
	private List<VoteQustnrIemVO> voteQustnrIemVOList; //투표 설문 질문 리스트
	private List<VoteQustnrDetailIemVO>voteQustnrDetailIemVOList;//해당 질문의 보기내용과 순를 담을 변수

}
