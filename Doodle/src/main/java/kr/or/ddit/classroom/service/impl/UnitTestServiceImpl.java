package kr.or.ddit.classroom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.classroom.mapper.UnitTestMapper;
import kr.or.ddit.classroom.service.UnitTestService;
import kr.or.ddit.vo.AswperVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.GcVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.QuesVO;
import kr.or.ddit.vo.UnitEvlScoreVO;
import kr.or.ddit.vo.UnitEvlVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UnitTestServiceImpl implements UnitTestService {
	@Autowired
	UnitTestMapper unitTestMapper;
	
	// 단원평가 생성
	@Transactional
	@Override
	public int createUnitTest(HttpServletRequest request, UnitEvlVO ue) {
		int res = 0;
		
		String unitEvlCode = unitTestMapper.getMaxUECode();
		ue.setUnitEvlCode(unitEvlCode);
		
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String clasCode = clasVO.getClasCode();
		ue.setClasCode(clasCode);
		
		// 단원평가 생성
		res += unitTestMapper.createUnitTest(ue);
		
		// 문항 생성
		List<QuesVO> quesVOList = ue.getQuesVOList();
		for(QuesVO quesVO : quesVOList) {
			quesVO.setUnitEvlCode(ue.getUnitEvlCode());
			res += unitTestMapper.createQues(quesVO);
		}
		
		return res;
	}
	
	// 단원 평가 목록 조회
	@Override
	public List<UnitEvlScoreVO> getUnitTestList(String clasCode) {
		return unitTestMapper.getUnitTestList(clasCode);
	}
	
	// 단원평가 상세 조회
	@Override
	public UnitEvlVO detail(String unitEvlCode) {
		return unitTestMapper.detail(unitEvlCode);
	}

	// 문항 목록
	@Override
	public List<QuesVO> getQuesList(String unitEvlCode) {
		return unitTestMapper.getQuesList(unitEvlCode);
	}

	// 단원평가 학생 결과 목록
	@Override
	public List<GcVO> getGcList(String unitEvlCode) {
		return unitTestMapper.getGcList(unitEvlCode);
	}

	// 한명의 학생이 하나의 단원평가에 대한 본인의 결과 ajax
	@Override
	public List<GcVO> getStdGc(String unitEvlCode, String mberId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("unitEvlCode",unitEvlCode);
		map.put("mberId",mberId);
		return unitTestMapper.getStdGc(map);
	}

	// 성적표 insert ajax
	@Override
	public int makeGc(HttpServletRequest request, String unitEvlCode) {
		ClasStdntVO clasStdntVO = getClasStdntWithUnitEvlCodeAndMberId(request, unitEvlCode);
		GcVO gcVO = new GcVO();
		gcVO.setClasStdntCode(clasStdntVO.getClasStdntCode());
		gcVO.setUnitEvlCode(unitEvlCode);
		return unitTestMapper.makeGc(gcVO);
	}


	// 시험 종료 후 성적표 점수 update 및 학생 답안 insert
	@Override
	public int finishGc(HttpServletRequest request, Map<String, Object> map) {
		// map unitEvlCode, aswperArr["x", "o" ...]
		int res = 0;
		String unitEvlCode = (String) map.get("unitEvlCode");
		ClasStdntVO clasStdntVO = getClasStdntWithUnitEvlCodeAndMberId(request, unitEvlCode);
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		
		@SuppressWarnings("unchecked")
		List<String> aswperArr = (List<String>) map.get("aswperArr");
		
		int score = 0;
		// 답지 가져옴
		List<QuesVO> quesList = unitTestMapper.getQuesList(unitEvlCode);
		
		for(int i = 0; i <aswperArr.size(); ++i) {
			AswperVO aswperVO = new AswperVO();
			aswperVO.setUnitEvlCode(unitEvlCode);
			aswperVO.setClasStdntCode(clasStdntCode);
			aswperVO.setQuesNo(i+1);
			aswperVO.setAswperCn(aswperArr.get(i));

			QuesVO ques = quesList.get(i);
			// 점수 합산
			if(aswperVO.getAswperCn().equals(ques.getQuesCnsr())) {
				score += ques.getQuesAllot();
			}
			
			// 학생 답안 생성
			res += unitTestMapper.insertAswper(aswperVO);
		}
		// 점수 update
		GcVO gcVO = new GcVO();
		gcVO.setScre(score);
		gcVO.setClasStdntCode(clasStdntCode);
		gcVO.setUnitEvlCode(unitEvlCode);
		unitTestMapper.scoreUpdate(gcVO);
		
		return res;
	}

	// 학생 답안 select 
	@Override
	public List<AswperVO> getAswper(AswperVO sendVO) {
		return unitTestMapper.getAswper(sendVO);
	}

	// 학생 답안 삭제
	@Transactional
	@Override
	public int deleteStdRes(Map<String, Object> map) {
		int res = 0;
		String unitEvlCode = (String)map.get("unitEvlCode");
		String clasStdntCode = (String)map.get("clasStdntCode");
		
		// 답안 삭제
		AswperVO aswperVO = new AswperVO();
		aswperVO.setUnitEvlCode(unitEvlCode);
		aswperVO.setClasStdntCode(clasStdntCode);
		res += unitTestMapper.delAswper(aswperVO);

		// 성적표 삭제
		GcVO gcVO = new GcVO();
		gcVO.setUnitEvlCode(unitEvlCode);
		gcVO.setClasStdntCode(clasStdntCode);
		res += unitTestMapper.delGc(aswperVO);
		
		return res;
	}

	// 단원평가 수정
	@Transactional
	@Override
	public int updateUnitTest(UnitEvlVO ue) {
		int res = 0;
		
		// 단원평가 기본 정보
		unitTestMapper.updateUnitTest(ue);
		// 답안 정보
		// 항목 수가 바뀌면 일부 답안 정보를 삭제 해야 한다.
		unitTestMapper.deleteQues(ue.getUnitEvlCode());
		// 답안 새로 추가
		List<QuesVO> quesVOList = ue.getQuesVOList();
		for(QuesVO quesVO : quesVOList) {
			quesVO.setUnitEvlCode(ue.getUnitEvlCode());
			res += unitTestMapper.createQues(quesVO);
		}
		
		return res;
	}

	// 단원평가 삭제
	@Override
	public int deleteUnitTest(String unitEvlCode) {
		// oracle에서 종속 삭제 처리(문제, 학생 답안, 학생 성적표)
		return unitTestMapper.deleteUnitTest(unitEvlCode);
	}

	// 한명의 학생이 반에 대한 본인의 모든 시험 결과 모두 가져오기
	@Override
	public List<UnitEvlScoreVO> getStdGcList(Map<String, Object> map) {
		log.info("getStdGcList map => " + map);

		List<UnitEvlScoreVO> unitEvlScoreVOList = this.unitTestMapper.getStdGcList(map);
		log.info("getStdGcList unitEvlScoreVOList => ", unitEvlScoreVOList);
		return unitEvlScoreVOList;
	}
	
	// 시험코드와 아이디를 통해 반학생코드 get
	public ClasStdntVO getClasStdntWithUnitEvlCodeAndMberId(HttpServletRequest request, String unitEvlCode) {
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId", memberVO.getMberId());
		map.put("unitEvlCode", unitEvlCode);
		ClasStdntVO clasStdntVO = unitTestMapper.getClasStdntWithUnitEvlCodeAndMberId(map);
		return clasStdntVO;
	}
	
	// 반코드와 아이디를 통해 반학생 정보 get
	public ClasStdntVO getClasStdntWithClasCodeAndMberId(HttpServletRequest request, String clasCode) {
		MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId", memberVO.getMberId());
		map.put("clasCode", clasCode);
		ClasStdntVO clasStdntVO = unitTestMapper.getClasStdntWithClasCodeAndMberId(map);
		return clasStdntVO;
	}

	// 하나의 단원평가에 대한 모든 반학생 성적 get
	@Override
	public UnitEvlScoreVO getAllStdScoreInOneUnitEvl(String unitEvlCode) {
		return unitTestMapper.getAllStdScoreInOneUnitEvl(unitEvlCode);
	}

	// 하나의 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	@Override
	public List<UnitEvlScoreVO> getOneUnitEvlAndAllGc(HttpServletRequest request, String unitEvlCode) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("unitEvlCode",unitEvlCode);
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String clasCode = clasVO.getClasCode();
		map.put("clasCode",clasCode);
		if (request.isUserInRole("ROLE_A01001")) {
			MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
			map.put("mberId", memberVO.getMberId());
		}
		else if (request.isUserInRole("ROLE_A01003")) {
			ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO") ;
			map.put("mberId", clasStdntVO.getMberId());
		}
		return unitTestMapper.getUnitEvlAndAllGc(map);
	}
	
	// 모든 단원평가 정보 + 모든 학생의 답안 정보 + 응시 인원 정보 + 평균 점수
	@Override
	public List<UnitEvlScoreVO> getAllUnitEvlAndAllGc(HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String, Object>();
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String clasCode = clasVO.getClasCode();
		map.put("clasCode",clasCode);
		if (request.isUserInRole("ROLE_A01001")) {
			MemberVO memberVO = (MemberVO)request.getSession().getAttribute("USER_INFO");
			map.put("mberId", memberVO.getMberId());
		}
		else if (request.isUserInRole("ROLE_A01003")) {
			ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO") ;
			map.put("mberId", clasStdntVO.getMberId());
		}
		return unitTestMapper.getUnitEvlAndAllGc(map);
	}

	// 학생의 학부모 정보 구하기
	@Override
	public List<FamilyRelateVO> getParents(String mberId) {
		return unitTestMapper.getParents(mberId);
	}

	// 진행중인 반 단원평가
	@Override
	public List<UnitEvlVO> getDoingExam(HttpServletRequest request) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("clasCode", clasVO.getClasCode());
		map.put("size", 20);
		return unitTestMapper.getDoingExam(map);
	}
}
