package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ChldrnClasVO;
import kr.or.ddit.vo.ClasAlbumVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.GcVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.QuesVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SkedVO;
import kr.or.ddit.vo.TaskVO;
import kr.or.ddit.vo.UnitEvlVO;

public interface ClassroomService {
	
	// 학급 클래스 메인: 해당 클래스의 담임 교사 정보
	public HrtchrVO clasInfoSelect(String clasCode);
	
	//학급클래스 소속회원 목록
	public String classMemberList();
	
	// 결석 사유 신청(체험학습도)
	public String absentReason();
	
	//자유 게시판 목록 
	public String freeBoard();
	
	//투표/설문조사 게시판 목록
	public String votingSurvey();
	
	//알림장 목록
	public String notice();
	
	//과제 게시판 목록
	public List<TaskVO> taskList(Map<String, Object> map);
	
	//과제 게시판 목록 수
	public int getTotalTask(String clasCd);
	
	//단원마무리 게시판 목록
	public String unitTest();
	
	//학급 시간표 조회
	public String schedule();
	
	//온라인 수업
	public String onlineClass();
	
	//생활 기록부 조회
	public String lifeRecord();
	
	// 학급클래스(반) 목록 불러오기
	public ArticlePage<ClasVO> classroomListAjax(Map<String, Object> map);
	
	// 학급클래스(반) 목록 개수 조회
//	public int classroomGetTotal(Map<String, Object> map);

	// 학급클래스(반) 목록
//	public List<ClasVO> classroomList(Map<String, Object> map);
	
	// 교사 학교명 가져오기 
	public SchulPsitnMberVO getSchoolNm(SchulPsitnMberVO schulPsitnMberVO);

	//클래스 생성
	public int classCreateAjax(ClasVO clasVO);
	
	//학교 -> 학급클래스 목록
	public ArticlePage<ClasVO> classListAjax(Map<String, Object> map);

	//클래스 생성 전 중복체크
	public int classDupCheck(ClasVO clasVO);

	//클래스 담당 교사 등록
	public int hrtchrCreate(ClasVO clasVO);

	//클래스 가입시 학교 코드 가져오기
	public String selectSchulCode(String clasCode);

	//클래스 가입신청
	public int classJoinReqAjax(ClasStdntVO clasStdntVO);
	
	//클래스 가입신청 목록
	public ArticlePage<ClasStdntVO> classJoinReqListAjax(Map<String, Object> map);

	//클래스 가입신청 처리
	public int classJoinAjax(ClasStdntVO clasStdntVO);

	//클래스 가입신청 취소
	public int classJoinReqCancelAajx(ClasStdntVO clasStdntVO);

	//선생님화면)학생 구성원 목록
	public ArticlePage<ClasStdntVO> classTStudListAjax(Map<String, Object> map);
	
	//클래스 구성원  상세정보
	public MemberVO classMberDetailAjax(String mberId);

	//이메일 값 가져오기
	public List<String> getEmailByMemberId(List<String> mberIds, String clasCode);

	//학교 소속 회원 테이블 INSERT
	public int classInvCodeJoin(ChldrnClasVO chldrnClasVO);
	
	//학교 소속 중복체크
	public int schulPsitnDupCheck(ChldrnClasVO chldrnClasVO);

	//자녀 반 테이블 INSERT
	public int chldrnClasInsert(ChldrnClasVO chldrnClasVO);
	
	//학부모 클래스 소속 중복체크
	public int classDupCnt(ChldrnClasVO chldrnClasVO);

	//학부모 구성원 목록
	public ArticlePage<ClasStdntVO> classTParentListAjax(Map<String, Object> map);

	//학생 구성원 수정
	public int classStudUpdateAjax(List<ClasStdntVO> clasStdntVOList);
	
	//학생, 학부모화면) 학생조회
	public ArticlePage<ClasStdntVO> classStdntListAjax(Map<String, Object> map);
	
	//학생, 학부모화면) 학생조회 총 개수
	public int StdntListGetTotal(Map<String, Object> map);

	//클래스 수정
	public int classUpdateAjax(ClasVO clasVO);

	//클래스 삭제
	public int classDeleteAjax(ClasVO clasVO);
	
	// 학급 시간표 목록
	public List<SkedVO> scheduleList(SkedVO skedVO);

	// 학급시간표 등록
	public int scheduleCreate(List<SkedVO> skedVOList);
	
	// 오늘의 시간표 목록
	public List<SkedVO> todaySchedule(String clasCode);

	// 학기 중복 확인
	public int checkScheduleSemstr(SkedVO skedVO);

	//클래스 가입 거절 목록
	public ArticlePage<ClasStdntVO> classJoinRJListAjax(Map<String, Object> map);

	//내가 속해있는 클래스 가져오기
	public List<ClasStdntVO> getMberClasCode(String mberId);


}
