package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ClasAlbumVO {
	private String clasAlbumCode;	//반 앨범 코드
	private String albumNm;			//앨범 명 
	private String atchFileCode;	//첨부파일 코드
	private String clasCode;		//반 코드
	private String clasStdntCode;	//회원 아이디
	private String mberNm;			// 회원 이름
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date albumDe;			// 앨범 등록 일자
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date albumUpdtDe;		// 앨범 수정 일자
	private int nttSttemntAccmlt;	// 게시물 신고 누적
	private String nttSttemntSttus;	// 게시물 신고 상태

	// 신고 JOIN
	private String mberId;			// 회원 아이디(MEMBER 테이블)
	
	/* ATCH_FILE */
	private String atchFileCours;	// 파일 경로(ATCH_FILE)
	
	//CLAS_ALBUM : ATCH_FILE = 1 : N
	private List<AtchFileVO> atchFileVOList;
	
	//CLAS_ALBUM : ALBUM_TAG = 1 : N
	private List<AlbumTagVO> albumTagVOList;	
	
	private MultipartFile[] uploadFile; // 여러파일 업로드
}
