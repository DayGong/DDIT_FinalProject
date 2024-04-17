package kr.or.ddit.classroom.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AswperVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.GcVO;
import kr.or.ddit.vo.QuesVO;
import kr.or.ddit.vo.UnitEvlScoreVO;
import kr.or.ddit.vo.UnitEvlVO;

public interface UnitTestMapper {

	// 단원 평가 맥시멈 넘버 코드
	public String getMaxUECode();

	// 단원평가 생성
	public int createUnitTest(UnitEvlVO ue);
	
	// 문항 생성
	public int createQues(QuesVO quesVO);
	
	// 단원 평가 목록 조회
	public List<UnitEvlScoreVO> getUnitTestList(String clasCode);

	// 단원평가 상세 조회
	public UnitEvlVO detail(String unitEvlCode);

	// 문항 목록
	public List<QuesVO> getQuesList(String unitEvlCode);

	// 단원평가 학생 결과 목록
	public List<GcVO> getGcList(String unitEvlCode);
	
	// 한명의 학생이 하나의 단원평가에 대한 본인의 결과 ajax
	public List<GcVO> getStdGc(Map<String, Object> map);

	// 성적표 insert ajax
	public int makeGc(GcVO gcVO);

	// 학생 답안 생성
	public int insertAswper(AswperVO aswperVO);
	
	// 성적표 점수 update
	public int scoreUpdate(GcVO gcVO);

	// 학생 답안 select 
	public List<AswperVO> getAswper(AswperVO sendVO);

	// 학생 답안 삭제
	public int delAswper(AswperVO aswperVO);

	// 학생 성적표 삭제
	public int delGc(AswperVO aswperVO);

	// 단원평가 내용 수정 완료
	public int updateUnitTest(UnitEvlVO ue);

	// 단원평가 답안 삭제
	public void deleteQues(String unitEvlCode);

	// 단원평가 삭제
	public int deleteUnitTest(String unitEvlCode);

	// 한명의 학생이 반에 대한 본인의 모든 시험 결과 모두 가져오기
	public List<UnitEvlScoreVO> getStdGcList(Map<String, Object> map);

	// 하나의 단원평가에 대한 모든 반학생 성적 get
	public UnitEvlScoreVO getAllStdScoreInOneUnitEvl(String unitEvlCode);

	// 단원평가코드, 회원아이디로 반학생 데이터 get
	public ClasStdntVO getClasStdntWithUnitEvlCodeAndMberId(Map<String,Object> map);
	
	// 반코드와 아이디를 통해 반학생 정보 get
	public ClasStdntVO getClasStdntWithClasCodeAndMberId(Map<String, Object> map);

	// 하나/모든 단원평가 정보 + 모든/자신 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	public List<UnitEvlScoreVO> getUnitEvlAndAllGc(Map<String, Object> map);

	// 학생의 학부모 정보 구하기
	public List<FamilyRelateVO> getParents(String mberId);
	
	// 진행중인 반 단원평가
	public List<UnitEvlVO>getDoingExam(Map<String, Object> map);
}
