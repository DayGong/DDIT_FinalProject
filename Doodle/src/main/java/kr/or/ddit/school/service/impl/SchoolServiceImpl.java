package kr.or.ddit.school.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.school.mapper.SchoolMapper;
import kr.or.ddit.school.service.SchoolService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.EdcInfoNttVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchoolServiceImpl implements SchoolService {
	@Autowired
	SchoolMapper schoolMapper;
	
	@Autowired
	String uploadFolder;

	// 학사 일정 등록
	@Override
	public int scheduleInsert(SchafsSchdulVO schedule) {
		return 0;
	}

	// 학사 일정 조회
	@Override
	public List<SchafsSchdulVO> scheduleSelect() {
		return this.schoolMapper.scheduleSelect();
	}

	// 학사 일정 삭제
	@Override
	public int scheduleDelete(String start) {
		return 0;
	}

	// 학사 일정 수정
	@Override
	public int scheduleUpdate(SchafsSchdulVO schedule) {
		return 0;
	}

	// 학교 목록 불러오기
	@Override
	public ArticlePage<SchulVO> schoolListAjax(Map<String, Object> map) {
		// 키값 설정
		String keyword = "";
		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		int size = Integer.parseInt(map.get("size").toString());
		
		// 총 데이터 갯수 가져오기
		int SchoolTotal = this.schoolMapper.schoolGetTotal(map);
		
		// 학교 목록 가져오기
		List<SchulVO> schulVOList = this.schoolMapper.schoolList(map);

		// 페이지네이션
		ArticlePage<SchulVO> data = new ArticlePage<SchulVO>(SchoolTotal, currentPage, size, schulVOList, keyword);
		
		log.debug("schoolListAjax -> total : " + SchoolTotal);
		log.debug("String.valueOf(total) : "  + String.valueOf(SchoolTotal));
				
		return data;
	}
	
	// 자료실 게시판 조회
	@Override
	public List<NttVO> dataRoom(Map<String, Object> map) {
		return this.schoolMapper.dataRoom(map);
	}
	
	// 자료실 총 게시물 수
	@Override
	public int dataRoomGetTotal(Map<String, Object> map) {
		return this.schoolMapper.dataRoomGetTotal(map);
	}
	
	// 자료실 글 생성
	@Override
	public int dataRoomCreateAjax(MemberVO memberVO, NttVO nttVO, List<MultipartFile> uploadList, SchulVO schulVO) {
		nttVO.setSchulCode(schulVO.getSchulCode());
		nttVO.setMberId(memberVO.getMberId());// 작성자 아이디 vo 세팅

		int res = schoolMapper.dataRoomCreate(nttVO);// 게시글 텍스트 전송
		String alal = nttVO.getNttAtchFileCode();
		log.debug("alal" + alal);

		int res2 = 0;
		int result = 0;
		// 폴더생성
		if (uploadList != null && !uploadList.isEmpty() && uploadList.get(0).getSize() > 0) {
			File fileFolder = new File(uploadFolder + "\\freeBoard\\");
			// 개수만큼 폴더생성
			fileFolder.mkdirs();

			String atchFileCode = schoolMapper.getDataMaxCode(nttVO);
			AtchFileVO atchfileVO = new AtchFileVO();
			atchfileVO.setAtchFileCode(atchFileCode);// 첨부파일 작성자 첨부파일코드

			// ↓시퀀스컬럼의 값을 위한 변수 ↓
			int fileCnt = 0;
			// 사용자가 올린 파일 복사
			for (MultipartFile multipartFile : uploadList) {
				String uuid = UUID.randomUUID().toString();

				String uploadFileName = uuid + "_" + multipartFile.getOriginalFilename();
				// 복사할 파일을 어디에 저장할 지 경로 정하기 ↓↓↓↓↓
				String Filepath = uploadFolder + "\\dataRoom\\" + uploadFileName;
				File saveFile = new File(Filepath);

				// 복사한 경로에 이미지 파일 업로드 ↓↓↓↓↓
				try {
					// 파일 복사 실행
					multipartFile.transferTo(saveFile);

				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// (디비에 파일 저장하는 것임)ATACHFILE테이블에 파일 경로 및 컬럼 값 데이터 입력 ↓↓↓↓↓
				fileCnt++;
				atchfileVO.setAtchFileSn(fileCnt);								// 첨부파일 순번
				atchfileVO.setAtchFileCours("/dataRoom/" + uploadFileName);		// 첨부파일경로
				atchfileVO.setAtchFileNm(multipartFile.getOriginalFilename());	// 첨부파일 이름
				atchfileVO.setAtchFileTy(multipartFile.getContentType());		// 첨부파일 유형
				atchfileVO.setRegistId(nttVO.getMberId());						// 첨부파일 등록자 아이디
				res2 = schoolMapper.uploadFile(atchfileVO);
			}

			if ((res + res2) == 2) {
				result = 1;
			}
		} else {
			result = res;
		}
		// 1이면 성공 0이면 실패
		return result;

	}

	// 자료실 게시판 상세조회
	@Override
	public NttVO dataRoomDetail(NttVO nttVO) {
		nttVO = this.schoolMapper.dataRoomDetail(nttVO);
		// 조회수 증가
		this.schoolMapper.totalViews(nttVO);
		return nttVO;
	}
	
	//첨부파일 다운로드
	@Override
	public AtchFileVO getFileName(AtchFileVO atchFileCode) {
		return this.schoolMapper.getFileName(atchFileCode);
	}
	
	// 자료실 상세조회 -> 첨부파일 가져오기
	@Override
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode) {
		return schoolMapper.selectAtchList(nttAtchFileCode);
	}
	
	//게시물 셀렉트 메서드(자료실 수정)
	@Override
	public NttVO selectNttVO(NttVO nttVO) {
		return schoolMapper.selectNttVO(nttVO);
	}
	
	// 자료실 게시판 수정
	@Override
	public int dataRoomUpdateAjax(NttVO nttVO, AtchFileVO atchFileVO, String[] snArray, List<MultipartFile> uploadList, MemberVO memberVO) {
		if(snArray != null) {
			AtchFileVO atchFileVO2 = new AtchFileVO();
			for (int i = 0; i < snArray.length; i++) {
				atchFileVO2.setAtchFileCode(atchFileVO.getAtchFileCode());
				atchFileVO2.setAtchFileSn(Integer.parseInt(snArray[i]) );
				//첨부파일 개별삭제
				schoolMapper.deleteAtchFile2(atchFileVO2);
			}

			List<AtchFileVO>fileVOList =  schoolMapper.selectAtchList(atchFileVO.getAtchFileCode());
			for (int i = 0; i < fileVOList.size(); i++) {
				Map<String, Object> updateAtchFileSnMap = new HashMap<String, Object>();
				updateAtchFileSnMap.put("atchFileCode", atchFileVO.getAtchFileCode());
				updateAtchFileSnMap.put("orignAtchFileSn", fileVOList.get(i).getAtchFileSn());
				updateAtchFileSnMap.put("atchFileSn", i+1);
				schoolMapper.updateFileSn(updateAtchFileSnMap);
				
				log.debug("atchFileCode~!" + atchFileVO.getAtchFileCode());
				log.debug("orignAtchFileSn~!" + fileVOList.get(i).getAtchFileSn());
				log.debug("atchFileSn~!" + i+1);
			}
		}

		if (uploadList != null && uploadList.size() != 0 && uploadList.get(0).getSize() > 0) {
			List<AtchFileVO> fileVOList =  schoolMapper.selectAtchList(atchFileVO.getAtchFileCode());
			File fileFolder = new File(uploadFolder + "\\dataRoom\\");
			// 개수만큼 폴더생성
			fileFolder.mkdirs();

			String atchFileCode = "";
			if(fileVOList != null && fileVOList.size() > 0) {
				atchFileCode = atchFileVO.getAtchFileCode();
			}else {
				// 등록할때는 파일 안올리고 수정할 때 처음 올리는 상황
				atchFileCode = schoolMapper.getDataMaxCode(nttVO);
			}
			AtchFileVO atchfileVO = new AtchFileVO();
			atchfileVO.setAtchFileCode(atchFileCode);//첨부파일 작성자 첨부파일코드

			// ↓시퀀스컬럼의 값을 위한 변수 ↓
			int fileCnt = fileVOList.size();
			// 사용자가 올린 파일 복사
			for (MultipartFile multipartFile : uploadList) {
				String uuid = UUID.randomUUID().toString();
				String uploadFileName = uuid +"_"+ multipartFile.getOriginalFilename();
				// 복사할 파일을 어디에 저장할 지 경로 정하기 ↓↓↓↓↓
				String Filepath = uploadFolder  +"\\dataRoom\\"+ uploadFileName;
				File saveFile = new File(Filepath);

				// 복사한 경로에 이미지 파일 업로드 ↓↓↓↓↓
				try {
					multipartFile.transferTo(saveFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// (디비에 파일 저장)ATACHFILE테이블에 파일 경로 및 컬럼 값 데이터 입력 ↓↓↓↓↓
				multipartFile.getOriginalFilename();

				++fileCnt;
				atchfileVO.setAtchFileSn(fileCnt);								//첨부파일 순번
				atchfileVO.setAtchFileCours("/dataRoom/"+ uploadFileName);		//첨부파일경로
				atchfileVO.setAtchFileNm(multipartFile.getOriginalFilename());	//첨부파일 이름
				atchfileVO.setAtchFileTy(multipartFile.getContentType());		//첨부파일 유형
				atchfileVO.setRegistId(memberVO.getMberId());					//첨부파일 등록자 아이디
				schoolMapper.uploadFile(atchfileVO);
			}
		}
		int result = schoolMapper.dataRoomUpdateAjax(nttVO);

		return result;
	}

	// 자료실 게시판 삭제
	@Override
	public int dataRoomDeleteAjax(NttVO nttVO) {
		//게시글 삭제
		int cnt = this.schoolMapper.dataRoomDeleteAjax(nttVO);
		//첨부파일 삭제
		int cnt2 = this.schoolMapper.deleteAtchFile(nttVO.getNttAtchFileCode());
		int result = cnt + cnt2;
		
		log.debug("삭제삭제삭제" + nttVO.getNttAtchFileCode());
		
		if(result==2) {
			return result;
		}else {
			return 0;
		}
	}
	
	//교육 정보 인서트(크롤링)
	@Override
	public int eduInfoInsertAjax(List<Map<String, String>> edcInfoNttVOList) {
		//인서트 전 기존 데이터 전체  삭제
		int cnt = schoolMapper.deleteEduInfoAjax();
		int result = 0;
		for (Map<String, String> edcInfoNttVO : edcInfoNttVOList) {
			schoolMapper.eduInfoInsertAjax(edcInfoNttVO);
			result++;
		}
		log.debug("삭제 된 교육 정보 게시물 수 -> "+cnt);
		 
		return result;
	}

	//교육 정보 게시판 조회
	@Override
	public ArticlePage<EdcInfoNttVO> edcInfoListAjax(Map<String, Object> map) {
		String keyword = map.get("keyword").toString();
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String url = "/school/eduInfo";
		
		List<EdcInfoNttVO> edcInfoNttVOList = schoolMapper.edcInfoListAjax(map);

		//교육 정보 게시판 게시물 개수
		int total = schoolMapper.edcInfoListGetTotal(map);

		//페이징
		ArticlePage<EdcInfoNttVO> data = new ArticlePage<EdcInfoNttVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), edcInfoNttVOList, keyword);
	    data.setUrl(url);
	    
	    log.debug("keyword~" + keyword);
	    log.debug("currentPage~" + currentPage);
	    log.debug("size~" + size);
	    
		return data;
	}

}
