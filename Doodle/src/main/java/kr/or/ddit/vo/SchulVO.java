package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SchulVO {
	private String schulCode;    //학교 코드
	private String schulNm;      //학교 명
	private String schulAdres;   //학교 주소
	private String schulTlphonNo;//학교 전화 번호
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date schulAnnvrsry;  //개교기념일
	
	// 학교테이블 : 학교 소속 회원 = 1 : N
	private List<SchulPsitnMberVO> schulPsitnMberVOList;
	
	// 마이 페이지에서 사용
	private SchulPsitnMberVO schulPsitnMberVO; //자녀 학교 소속 정보 
	private ClasVO clasVO;
	private ClasStdntVO clasStdntVO;
	
	// 학부모용 자녀
	private List<ClasStdntVO> stdList;
}
