package kr.or.ddit.vo;

import lombok.Data;

@Data
public class PresentnPapersVO {
	private String presentnPapersCode;       //제출 서류 코드
	private String cmmnDetailCode;           //공통 서류 처리 상태(A11)
	private String papersProcessRejectCn;    //서류 처리 거절 내용
	private String clasStdntCode;            //반 학생 코드
}
