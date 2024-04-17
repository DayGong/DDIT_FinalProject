package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AtchFileVO {
	private String atchFileCode;	// 첨부 파일 코드
	private int atchFileSn;		// 순번
	private String atchFileCours;	// 파일 경로
	private String atchFileNm;		// 파일 명
	private String atchFileTy;		// 파일 유형
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date atchFileDe;		// 파일 등록 일자
	private String registId;		// 등록자 아이디
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updtDe;			// 수정 일자
	private String updtId;			// 수정자 아이디


	/* NttVO */
	private String clasCode;		//반코드
	/* ClasAlbumVO */
	private String albumNm;			// 앨범 이름

	/*FreeBoard*/
	private List<AtchFileVO> atchFileVOSnList;//파일 순서를 담을 리스트
}