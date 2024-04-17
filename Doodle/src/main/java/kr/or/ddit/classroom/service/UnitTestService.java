package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.AswperVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.GcVO;
import kr.or.ddit.vo.QuesVO;
import kr.or.ddit.vo.UnitEvlScoreVO;
import kr.or.ddit.vo.UnitEvlVO;

public interface UnitTestService {

	// 단원평가 생성
	public int createUnitTest(HttpServletRequest request, UnitEvlVO ue);
	
	// 단원 평가 목록 조회
	public List<UnitEvlScoreVO> getUnitTestList(String clasCode);

	// 단원평가 상세 조회
	public UnitEvlVO detail(String unitEvlCode);

	// 문항 목록
	public List<QuesVO> getQuesList(String unitEvlCode);

	// 단원평가 학생 결과 목록
	public List<GcVO> getGcList(String unitEvlCode);
	
	//한명의 학생이 하나의 단원평가에 대한 본인의 결과 ajax
	public List<GcVO> getStdGc(String unitEvlCode, String mberId);

	// 성적표 insert ajax
	public int makeGc(HttpServletRequest request, String unitEvlCode);

	// 시험 종료 후 학생 답안 생성
	public int finishGc(HttpServletRequest request, Map<String, Object> map);

	// 학생 답안 select 
	public List<AswperVO> getAswper(AswperVO sendVO);

	// 학생 답안 삭제
	public int deleteStdRes(Map<String, Object> map);

	// 단원평가 수정 완료
	public int updateUnitTest(UnitEvlVO ue);

	// 단원평가 삭제 
	public int deleteUnitTest(String unitEvlCode);

	// 한명의 학생 모든 단원평가에 대한 결과 목록 
	public List<UnitEvlScoreVO> getStdGcList(Map<String, Object> map);

	// 하나의 단원평가에 대한 모든 반학생 성적 get 
	public UnitEvlScoreVO getAllStdScoreInOneUnitEvl(String unitEvlCode);

	// 하나의 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	public List<UnitEvlScoreVO> getOneUnitEvlAndAllGc(HttpServletRequest request, String unitEvlCode);

	// 학생의 학부모 정보 구하기
	public List<FamilyRelateVO> getParents(String mberId);

	// 모든 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	public List<UnitEvlScoreVO> getAllUnitEvlAndAllGc(HttpServletRequest request);

	// 진행중인 반 단원평가
	List<UnitEvlVO> getDoingExam(HttpServletRequest request);
}
