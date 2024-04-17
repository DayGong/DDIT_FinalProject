package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AlbumTagVO {
	private int tagCode;			// 태그 코드
	private String clasAlbumCode;	// 반 앨범 코드
	private String tagNm;			// 태그 명
}
