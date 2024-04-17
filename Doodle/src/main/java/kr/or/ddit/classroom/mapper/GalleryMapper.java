package kr.or.ddit.classroom.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AlbumTagVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasAlbumVO;

public interface GalleryMapper {
	
	// 학급 앨범 목록
	public List<ClasAlbumVO> clasAlbumList(String clasCode);

	// 학급 앨범 목록(map사용)
	public List<ClasAlbumVO> clasAlbumList2(Map<String, Object> map);

	// 앨범 코드 최대값 가져오기
	public int getMaxAlbumSeq(String clasCode);

	// 사진 경로 insert
	public int insertAtchFile(AtchFileVO atchFileVO);

	// 앨범 추가
	public int createAlbum(ClasAlbumVO clasAlbumVO);

	// 앨범 태그 insert
	public int insertAlbumTags(List<AlbumTagVO> albumTagVOList2);

	// 학급 갤러리 상세
	public List<ClasAlbumVO> galleryDetail(String atchFileCode);

	// 갤러리 사진 삭제
	public int deleteImage(AtchFileVO atchFileVO);

	// 갤러리 사진 수정
	public int updateImage(AtchFileVO atchFileVO);	
	
	// 앨범 삭제
	public int deleteAlbum(String atchFileCode);
	
	// 앨범 사진 삭제
	public int deleteImages(String atchFileCode);

	// 앨범 수정
	public int updateAlbum(ClasAlbumVO clasAlbumVO);

	//앨범에 들어있는 이미지 파일들을 한큐에 삭제함
	public int deleteImagesAll(String atchFileCode);

	// 학급 앨범 수 조회 
	public int getTotalGallery(Map<String, Object> map);

	// 앨범 태그 리스트
	public List<String> albumTagList(String clasCode);

	// 앨범 태그 삭제
	public int deleteAlbumTag(String atchFileCode);

	// 신고 후 신고 누적과 게시물 신고 상태 update하는 메서드
	public int modNttSttemnt(String atchFileCode);
		
	// 반 앨범 내 이미지 get
	public List<AtchFileVO> getClasImg(Map<String, Object> map);
}
