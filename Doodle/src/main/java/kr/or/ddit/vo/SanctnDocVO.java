package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SanctnDocVO {
	private int rnum; 				  		//게시물번호
	private String docCode;					//문서 코드
	private String cmmnDocKnd;   			//공통 문서 종류(A25)
	private String cmmnDocKndNm;   			//공통 문서 종류(A25) 한글명
	private String cmmnProcessSttus;   		//공통 문서 처리상태(A11)
	private String cmmnProcessSttusNm;   	//공통 문서 처리상태(A11) 한글명
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date exprnLrnBgnde; 			//체험학습시작날짜
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date exprnLrnEndde; 			//체험학습종료날짜
	private String lrnStle;					//학습 형태
	private String purps;					//목적
	private String dstn;					//목적지
	private String docCn;					//문서 내용
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date rqstDe;					//신청일
	private String tcherSanctn;         	//담임 결재		
	private String deputyPrncpalSanctn;   	//교감 결재
	private String docReject;   			//문서 거절 내용
	
	private String clasStdntCode;   		//반 학생 코드
	private String schulCode;				//학교 코드		
	private String stdntId;					//학생 아이디 		
	private String stdnprntId;				//학부모 아이디 	
//	private String cmmnGrade;           	//공통 학년(A22)	
	private String clasCode;       			//반 코드			
//	private int clasInNo;					//학급 내 번호	
	
	private String tcherId;   				//담임 아이디
	private String deputyPrncpalId;   		//교감 아이디
	
	private String atchFileCode;   			//첨부 파일 코드
	private String atchFileSn;   			//순번
	
	//조인 테이블
	//SanctnDoc : ATCH_FILE = 1 : N
	private List<AtchFileVO> atchFileVOList;
	
	private ClasStdntVO clasStdntVO;		//반 학생 
	private ClasVO clasVO;					//반
	private FamilyRelateVO familyRelateVO;	//가족 관계
	private SchulPsitnMberVO teacherVO;		//담임 선생
	private SchulPsitnMberVO deputyVO;		//교감
	private SchulVO schulVO;				//학교
	
	
}	

//필요 테이블 멤버 2번 (학생, 학부모), 가족관계, 반학생, 학교, 반, 학교소속회원, 첨부파일
