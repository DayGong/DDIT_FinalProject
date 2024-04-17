package kr.or.ddit.school.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.EdcInfoNttVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;

public interface SchoolMapper {
	
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

    //첨부파일 테이블에 insert
  	public int insertNttAttach(AtchFileVO atchFileVO);

	// 학교 목록 조회
	public List<SchulVO> schoolList(Map<String, Object> map);

	// 학교 목록 전체 글 수
	public int schoolGetTotal(Map<String, Object> map);
	
	//자료실 시작-----------------------------
	
	//자료실 게시판 조회
	public List<NttVO> dataRoom(Map<String, Object> map);

	// 자료실 총 게시물 수
	public int dataRoomGetTotal(Map<String, Object> map);

	//자료실 게시판 등록
	public int dataRoomCreate(NttVO nttVO);

	//자료실 첨부파일코드 Max값 가져오기
	public String getDataMaxCode(NttVO nttVO);

	//파일업로드
	public int uploadFile(AtchFileVO atchfileVO);
	
	//자료실 상세조회
	public NttVO dataRoomDetail(NttVO nttVO);
	
	// 자료실 게시판 조회수 증가
	public int totalViews(NttVO nttVO);
	
	//첨부파일 다운로드
	//자료실 상세조회 해당 게시글 개별 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public AtchFileVO getFileName(AtchFileVO atchFileCode);

	//자료실 해당 게시글 첨부파일 가져오기
	//자유게시판 상세조회 해당 게시글 전체 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode);

	//자료실 게시물 셀렉트 메서드(수정)
	public NttVO selectNttVO(NttVO nttVO);
	
	//자료실 게시글 수정시 기존 첨부파일 개별 삭제시 실행되는 메소드
	public void deleteAtchFile2(AtchFileVO atchFileVO2);
	
	//자료실 게시글 수정시 기존 첨부파일 개별 삭제 후 파일 순번 정렬 메소드
	public void updateFileSn(Map<String, Object> updateAtchFileSnMap);
	
	//자료실 게시판 수정
	public int dataRoomUpdateAjax(NttVO nttVO);
	
	//자료실 게시판 내용 삭제
	public int dataRoomDeleteAjax(NttVO nttVO);
	
	//자료실 첨부파일 삭제
	public int deleteAtchFile(String nttCode);
	
	//자료실 끝 -----------------------------
	//교육 정보 인서트(크롤링)
	public int eduInfoInsertAjax(Map<String, String> edcInfoNttVO);

	//교육 정보 게시판 게시물 개수
	public int edcInfoListGetTotal(Map<String, Object> map);

	//교육 정보 게시판 조회
	public List<EdcInfoNttVO> edcInfoListAjax(Map<String, Object> map);

	//인서트 전 기존 데이터  전체 삭제
	public int deleteEduInfoAjax();

}
