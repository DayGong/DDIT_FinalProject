package kr.or.ddit.school.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.EdcInfoNttVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulVO;


public interface SchoolService {
	
	// 학사일정 등록
	public int scheduleInsert(SchafsSchdulVO schedule);

	// 학사일정 조회
	public List<SchafsSchdulVO> scheduleSelect();

	// 학사일정 삭제
	public int scheduleDelete(String start);

	// 학사일정 수정
	public int scheduleUpdate(SchafsSchdulVO schedule);
	
	//시간표
	public String schedule();
	
	//학생(전교생) 관리 
	public String studentsManage();
	
	//방과후학교
	public String afterSchool();
	
	//학급 클래스 목록
	public String classList();
	
	// 학교 목록 불러오기
	public ArticlePage<SchulVO> schoolListAjax(Map<String, Object> map);

	//자료실 시작 ----------------------
	
	//자료실 게시판 조회
	public List<NttVO> dataRoom(Map<String, Object> map);
	
	// 자료실 총 게시물 수
	public int dataRoomGetTotal(Map<String, Object> map);
	
	// 자료실 글 등록 실행 메서드
	public int dataRoomCreateAjax(MemberVO memberVO, NttVO nttVO, List<MultipartFile> uploadList, SchulVO schulVO);
	
	//자료실 상세조회
	public NttVO dataRoomDetail(NttVO nttVO);
	
	//자료실 상세조회 해당 게시글 개별 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public AtchFileVO getFileName(AtchFileVO atchFileCode);
	
	//자료실  상세조회 첨부파일 가져오기
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode);

	//자료실 게시물 셀렉트 메서드
	public NttVO selectNttVO(NttVO nttVO);

	//자료실 게시판 수정
	public int dataRoomUpdateAjax(NttVO nttVO, AtchFileVO atchFileVO, String[] snArray, List<MultipartFile> uploadList, MemberVO memberVO);
	
	//자료실 게시판 삭제
	public int dataRoomDeleteAjax(NttVO nttVO);
	
	//자료실 끝-----------------------
	//교육 정보 인서트(크롤링)
	public int eduInfoInsertAjax(List<Map<String, String>> edcInfoNttVO);

	//교육 정보 게시판 조회
	public ArticlePage<EdcInfoNttVO> edcInfoListAjax(Map<String, Object> map);

}
