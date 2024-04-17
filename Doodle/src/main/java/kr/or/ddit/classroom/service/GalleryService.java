package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasAlbumVO;


public interface GalleryService {
	
	// 학급 앨범 목록
	public List<ClasAlbumVO> clasAlbumList(String clasCode);
	
	// 학급 앨범 목록(map사용)
	public List<ClasAlbumVO> clasAlbumList2(Map<String, Object> map);

	// 앨범 추가
	public int createAlbum(ClasAlbumVO clasAlbumVO);

	// 학급 앨범 삭제
	public int deleteAlbum(String atchFileCode);
	
	// 학급 앨범 수정
	public int updateAlbum(ClasAlbumVO clasAlbumVO);
	
	// 학급 갤러리 상세
	public List<ClasAlbumVO> galleryDetail(String atchFileCode);

	// 학급앨범 수 조회
	public int getTotalGallery(Map<String, Object> map);
	
	// 태그 리스트
	public List<String> albumTagList(String clasCode);

	// 갤러리 사진 삭제
	public int deleteImage(AtchFileVO atchFileVO);

	// 갤러리 사진 수정
	public int updateImage(AtchFileVO atchFileVO);

	// 신고 후 신고 누적과 게시물 신고 상태 update하는 메서드
	public int modNttSttemnt(String atchFileCode);	
}
