package kr.or.ddit.classroom.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.classroom.mapper.GalleryMapper;
import kr.or.ddit.classroom.service.GalleryService;
import kr.or.ddit.vo.AlbumTagVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasAlbumVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Service
public class GalleryServiceImpl implements GalleryService{
	
	@Autowired
	GalleryMapper galleryMapper;
	
	@Autowired
	String uploadFolder;
	
	// 학급 앨범 목록
	@Override
	public List<ClasAlbumVO> clasAlbumList(String clasCode) {
		return this.galleryMapper.clasAlbumList(clasCode);
	}

	// 학급 앨범 목록(map사용)
	@Override
	public List<ClasAlbumVO> clasAlbumList2(Map<String, Object> map) {
		return this.galleryMapper.clasAlbumList2(map);
	}
	
	// 앨범 추가
	@Override
	public int createAlbum(ClasAlbumVO clasAlbumVO) {
		// 앨범 코드 설정
		// db에서 가장 큰 일련번호 가지고 옴
		/*
		 * clasAlbumVO : ClasAlbumVO(clasAlbumCode=null, albumNm=111, atchFileCode=null,
		 * clasCode=OJ20240101 , clasStdntCode=null, mberNm=, albumDe=Mon Mar 11
		 * 00:00:00 KST 2024, albumUpdtDe=null , uploadFile=[파일객체들])
		 */
		log.debug("createAlbum service->" + clasAlbumVO);
		int maxAlbumSeq = galleryMapper.getMaxAlbumSeq(clasAlbumVO.getClasCode());
		log.debug("maxAlbumSeq -> " + maxAlbumSeq);
		// 일련번호 생성
		int nextAlbumSeq = maxAlbumSeq + 1;
		// 일련번호를 포함한 앨범코드 생성(CLAS_CODE+ALB+일련번호)
		String nextAlbumCode = clasAlbumVO.getClasCode() + "ALB" + String.format("%05d", nextAlbumSeq);

		// 앨범에 생성된 코드 설정
		clasAlbumVO.setClasAlbumCode(nextAlbumCode);
		clasAlbumVO.setAtchFileCode(nextAlbumCode);
		clasAlbumVO.setClasStdntCode(clasAlbumVO.getClasStdntCode());

		// 앨범 추가
		int result = this.galleryMapper.createAlbum(clasAlbumVO);

		// 파일 업로드 경로
		File uploadPath = new File(uploadFolder, getFolder());

		if (!uploadPath.exists()) {
			uploadPath.mkdirs(); // 파일 디렉토리 생성 역할
		}

		// 원본 파일명
		String atchFileNm = "";
		// MIME타입
		String mime = "";
		// ATCH_FILE 테이블의 순번 컬럼을 위한 카운터 변수
		int atchFileSn = 1;

		MultipartFile[] uploadFile = clasAlbumVO.getUploadFile();

		// 첫 번째 파일 썸네일로 만들기
		MultipartFile firstFile = uploadFile[0];
		atchFileNm = firstFile.getOriginalFilename();
		mime = firstFile.getContentType();

		UUID uuid = UUID.randomUUID();
		atchFileNm = uuid.toString() + "_" + atchFileNm;

		File saveFile = new File(uploadFolder + "\\" + getFolder(), atchFileNm);

		try {
			firstFile.transferTo(saveFile);
			// 썸네일 생성 및 사진크기 지정
			File thumbnailFile = new File(uploadPath, "s_" + atchFileNm);
			Thumbnails.of(saveFile).size(220, 270).toFile(thumbnailFile);
			// ATCH_FILE 테이블 insert
			AtchFileVO firstAtchFileVO = new AtchFileVO();

			firstAtchFileVO.setAtchFileCode(nextAlbumCode); // 첨부파일 경로 = 반 앨범폴더 경로
			firstAtchFileVO.setAtchFileSn(0); // 순번
			firstAtchFileVO.setAtchFileCours("/" + getFolder().replace("\\", "/") + "/" + atchFileNm); // 파일 경로
			firstAtchFileVO.setAtchFileNm(firstFile.getOriginalFilename()); // 파일 이름
			firstAtchFileVO.setAtchFileDe(firstAtchFileVO.getAtchFileDe());
			firstAtchFileVO.setAtchFileTy(mime); // 파일 타입
			// 수정 필요 (아이디 강제로 넣어버림~)
			firstAtchFileVO.setRegistId(clasAlbumVO.getMberId());

			log.debug("atchFileVO : " + firstAtchFileVO);

			result += this.galleryMapper.insertAtchFile(firstAtchFileVO);

		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}

		// 나머지 파일은 원본으로 저장하기
		for (MultipartFile multipartFile : uploadFile) {
			log.debug("-------------------------------------------------");
			log.debug("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.debug("MIME타입  : " + multipartFile.getContentType());

			atchFileNm = multipartFile.getOriginalFilename();
			mime = multipartFile.getContentType();

			uuid = UUID.randomUUID();
			atchFileNm = uuid.toString() + "_" + atchFileNm;

			// File객체 설계(저장 경로 설정)
			saveFile = new File(uploadFolder + "\\" + getFolder(), atchFileNm);

			try {
				// 파일 복사 실행
				multipartFile.transferTo(saveFile);

				// ATCH_FILE 테이블 insert
				AtchFileVO atchFileVO = new AtchFileVO();

				atchFileVO.setAtchFileCode(nextAlbumCode); // 첨부파일 경로 = 반 앨범폴더 경로
				atchFileVO.setAtchFileSn(atchFileSn++); // 순번
				atchFileVO.setAtchFileCours("/" + getFolder().replace("\\", "/") + "/" + atchFileNm); // 파일 경로
				atchFileVO.setAtchFileNm(multipartFile.getOriginalFilename()); // 파일 이름
				atchFileVO.setAtchFileDe(atchFileVO.getAtchFileDe());
				atchFileVO.setAtchFileTy(mime); // 파일 타입
				atchFileVO.setRegistId(clasAlbumVO.getMberId());

				log.debug("atchFileVO : " + atchFileVO);

				result += this.galleryMapper.insertAtchFile(atchFileVO);

			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		} // 파일 올리기 끝

		// ALBUM_TAG 테이블에 insert
		List<AlbumTagVO> albumTagVOList = clasAlbumVO.getAlbumTagVOList();
		List<AlbumTagVO> albumTagVOList2 = new ArrayList<AlbumTagVO>();

		for (AlbumTagVO albumTagVO : albumTagVOList) {
			albumTagVO.setClasAlbumCode(clasAlbumVO.getClasAlbumCode());
			log.debug("AlbumTagVO ->albumTagVO : " + albumTagVO);

			albumTagVOList2.add(albumTagVO);
		}
		log.debug("AlbumTagVO ->albumTagVOList2 : " + albumTagVOList2);
		// ALBUM_TAG 테이블에 insert all
		result += this.galleryMapper.insertAlbumTags(albumTagVOList2);

		return result;
	}

	// 연/월/일 폴더 생성
	public String getFolder() {
		// 간단한 날짜 형식 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// 날짜 객체 생성
		Date date = new Date();
		// ex) 2024-03-07
		String str = sdf.format(date);
		// ex) 2024-03-07 -> 2024\\03\\07
		return str.replace("-", File.separator);
	}

	// 이미지인지 판단. (썸네일)
	public boolean checkImageType(File file) {
		// MIME(Multipurpose Internet Mail Extensions) : 문서, 파일 또는 바이트 집합의 성격과 형식. 표준화
		// MIME 타입 알아냄. .jpeg / .jpg의 MIME(ContentType)타입 : image/jpeg
		String contentType;
		try {
			// 파일을 검사해서 MIME 타입 확인
			contentType = Files.probeContentType(file.toPath());
			log.debug("contentType : " + contentType);

			// image/jpeg image로 시작함 -> true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 이 파일이 이미지가 아닐 경우
		return false;
	}	

	// 학급 앨범 삭제
	@Override
	public int deleteAlbum(String atchFileCode) {
		// 앨범 태그 삭제 (CLAS_ALBUM의 앨범명과 같기때문에 변수명 똑같이 씀)
		int result = this.galleryMapper.deleteAlbumTag(atchFileCode);

		// 학급 앨범 삭제
		result += this.galleryMapper.deleteAlbum(atchFileCode);

		// 사진 삭제
		File file = new File(uploadFolder, getFolder());

		if (file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
		}

		result += this.galleryMapper.deleteImages(atchFileCode);

		return result;
	}

	// 학급 앨범 수정
	@Override
	public int updateAlbum(ClasAlbumVO clasAlbumVO) {

		// 앨범 코드 설정
		// db에서 가장 큰 일련번호 가지고 옴

		// DELETE FROM ATCH_FILE
		// WHERE ATCH_FILE_CODE LIKE 'OJ20240101ALB00007%'
		// 앨범에 들어있는 이미지 파일들을 한큐에 삭제함
		int result = this.galleryMapper.deleteImagesAll(clasAlbumVO.getAtchFileCode());

		/*
		 * clasAlbumVO : ClasAlbumVO(clasAlbumCode=null, albumNm=111, atchFileCode=null,
		 * clasCode=OJ20240101 , clasStdntCode=null, mberNm=, albumDe=Mon Mar 11
		 * 00:00:00 KST 2024, albumUpdtDe=null , uploadFile=[파일객체들])
		 */
		// 변경 대상 앨범코드
		String nextAlbumCode = clasAlbumVO.getAtchFileCode();

		// 앨범에 생성된 코드 설정
		clasAlbumVO.setClasAlbumCode(nextAlbumCode);
		clasAlbumVO.setAtchFileCode(nextAlbumCode);
		clasAlbumVO.setAlbumNm(clasAlbumVO.getAlbumNm());
		clasAlbumVO.setClasStdntCode(clasAlbumVO.getClasStdntCode());

		// 앨범 변경
		result += this.galleryMapper.createAlbum(clasAlbumVO);

		// 파일 업로드 경로
		File uploadPath = new File(uploadFolder, getFolder());

		if (!uploadPath.exists()) {
			uploadPath.mkdirs(); // 파일 디렉토리 생성 역할
		}

		// 원본 파일명
		String atchFileNm = "";
		// MIME타입
		String mime = "";
		// ATCH_FILE 테이블의 순번 컬럼을 위한 카운터 변수
		int atchFileSn = 1;

		MultipartFile[] uploadFile = clasAlbumVO.getUploadFile();

		// 첫 번째 파일 썸네일로 만들기
		MultipartFile firstFile = uploadFile[0];
		atchFileNm = firstFile.getOriginalFilename();
		mime = firstFile.getContentType();

		UUID uuid = UUID.randomUUID();
		atchFileNm = uuid.toString() + "_" + atchFileNm;

		File saveFile = new File(uploadFolder + "\\" + getFolder(), atchFileNm);

		try {
			firstFile.transferTo(saveFile);
			// 썸네일 생성 및 사진크기 지정
			File thumbnailFile = new File(uploadPath, "s_" + atchFileNm);
			Thumbnails.of(saveFile).size(220, 270).toFile(thumbnailFile);
			// ATCH_FILE 테이블 insert
			AtchFileVO firstAtchFileVO = new AtchFileVO();

			firstAtchFileVO.setAtchFileCode(nextAlbumCode); // 첨부파일 경로 = 반 앨범폴더 경로
			firstAtchFileVO.setAtchFileSn(0); // 순번
			firstAtchFileVO.setAtchFileCours("/" + getFolder().replace("\\", "/") + "/" + atchFileNm); // 파일 경로
			firstAtchFileVO.setAtchFileNm(firstFile.getOriginalFilename()); // 파일 이름
			firstAtchFileVO.setAtchFileDe(firstAtchFileVO.getAtchFileDe());
			firstAtchFileVO.setAtchFileTy(mime); // 파일 타입
			// 수정 필요 (아이디 강제로 넣어버림~)
			firstAtchFileVO.setRegistId(clasAlbumVO.getMberId());

			log.debug("atchFileVO : " + firstAtchFileVO);

			result += this.galleryMapper.insertAtchFile(firstAtchFileVO);

		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}
		
		// 나머지 파일은 원본으로 저장하기
		for (MultipartFile multipartFile : uploadFile) {
			log.debug("-------------------------------------------------");
			log.debug("원본 파일명 : " + multipartFile.getOriginalFilename());
			log.debug("MIME타입  : " + multipartFile.getContentType());

			atchFileNm = multipartFile.getOriginalFilename();
			mime = multipartFile.getContentType();

			uuid = UUID.randomUUID();
			atchFileNm = uuid.toString() + "_" + atchFileNm;

			// File객체 설계(저장 경로 설정)
			saveFile = new File(uploadFolder + "\\" + getFolder(), atchFileNm);

			try {
				// 파일 복사 실행
				multipartFile.transferTo(saveFile);

				// ATCH_FILE 테이블 insert
				AtchFileVO atchFileVO = new AtchFileVO();

				atchFileVO.setAtchFileCode(nextAlbumCode); // 첨부파일 경로 = 반 앨범폴더 경로
				atchFileVO.setAtchFileSn(atchFileSn++); // 순번
				atchFileVO.setAtchFileCours("/" + getFolder().replace("\\", "/") + "/" + atchFileNm); // 파일 경로
				atchFileVO.setAtchFileNm(multipartFile.getOriginalFilename()); // 파일 이름
				atchFileVO.setAtchFileDe(atchFileVO.getAtchFileDe());
				atchFileVO.setAtchFileTy(mime); // 파일 타입
				atchFileVO.setRegistId(clasAlbumVO.getMberId());

				log.debug("atchFileVO : " + atchFileVO);

				result += this.galleryMapper.insertAtchFile(atchFileVO);

			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		return result;
	}
	
	// 학급 갤러리 상세
	@Override
	public List<ClasAlbumVO> galleryDetail(String atchFileCode) {
		return this.galleryMapper.galleryDetail(atchFileCode);
	}
	
	// 학급앨범 수 조회
	@Override
	public int getTotalGallery(Map<String, Object> map) {
		return this.galleryMapper.getTotalGallery(map);
	}

	// 태그 리스트
	@Override
	public List<String> albumTagList(String clasCode) {
		// albumTagList ->clasCode : OJ20240101
		return this.galleryMapper.albumTagList(clasCode);
	}

	// 갤러리 사진 삭제
	@Override
	public int deleteImage(AtchFileVO atchFileVO) {
		return this.galleryMapper.deleteImage(atchFileVO);
	}
	
	// 갤러리 사진 수정
	@Override
	public int updateImage(AtchFileVO atchFileVO) {
		return this.galleryMapper.updateImage(atchFileVO);
	}

	// 신고 후 신고 누적과 게시물 신고 상태 update하는 메서드
	@Override
	public int modNttSttemnt(String atchFileCode) {
		return this.galleryMapper.modNttSttemnt(atchFileCode);
	}
	
}
