package kr.or.ddit.consultation.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.consultation.mapper.ConsultationMapper;
import kr.or.ddit.consultation.service.ConsultationService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.CnsltDiarySearchVO;
import kr.or.ddit.vo.CnsltDiaryVO;
import kr.or.ddit.vo.CnsltVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ConsultationServiceImpl implements ConsultationService {

	@Autowired
	ConsultationMapper consultationMapper;
	
	// yyyy-MM-dd로 간단한 날짜 형식 변환
	public Date getDatePattern(Date date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sdate = sdf.format(date);
		Date patternDate = sdf.parse(sdate);

		return patternDate;
	}

	// 선생님의 상담 예약 목록을 불러오는 메서드
	@Override
	public List<Map<String, Object>> loadCnsltResveList(Map<String, Object> map, HttpServletRequest request) {
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		Map<String, Object> cnsltSchedulHash = new HashMap<String, Object>();
		
		String clasCode = (String) map.get("clasCode");
		log.info("loadCnsltResveList clasCode => " + clasCode);
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		log.info("memberVO => " + memberVO);
		
		CnsltVO cnsltVO = new CnsltVO();
		cnsltVO.setClasCode(clasCode);
		cnsltVO.setCnsltTrgetId(memberVO.getMberId());
		cnsltVO.setCnsltTrgetIdNm(memberVO.getMberNm());
		
		List<CnsltVO> cnsltVOList = this.consultationMapper.loadCnsltResveList(cnsltVO);
		log.info("cnsltVOList => " + cnsltVOList);
		
		for (CnsltVO cnslt : cnsltVOList) {
			String trgetIdNm = cnslt.getCnsltTrgetIdNm();	// 상담자 이름 저장
			String pwNm = trgetIdNm;						// 최종으로 출력될 이름 결과값
			
			String sttus = cnslt.getCmmnCnsltSttus();
			String sttusNm = cnslt.getCmmnCnsltSttusNm();
			String time = cnslt.getCmmnCnsltTime();
			
			// 상담 대상 아이디와 세션 아이디가 같지 않은 경우
			if ( !cnsltVO.getCnsltTrgetId().equals(cnslt.getCnsltTrgetId()) ) {
				pwNm = "";	// 값 초기화
				
				String[] nmArry = trgetIdNm.split("");
			
				for (int i = 0; i < nmArry.length; i++) {	// 중간 이름 *로 대체
					if ( 1 <= i && i < (nmArry.length - 1)) { nmArry[i] = "*"; }
					pwNm += nmArry[i];
				}
			}
			
			String color = "";
			String textColor = "black";
			if (sttus == "A09001" || "A09001".equals(sttus)) { color = "#FF7F27"; }	// 예약 대기
			if (sttus == "A09002" || "A09002".equals(sttus)) { color = "#0003FF"; }	// 예약 확인
			if (sttus == "A09003" || "A09003".equals(sttus)) { color = "#FF0000"; }	// 예약 거부
			if (sttus == "A09004" || "A09004".equals(sttus)) { color = "#808080"; }	// 상담 완료
			
			Map<String, Object> content = new HashMap<String, Object>();
			content.put("cnsltDiary", cnslt.getCnsltDiary());		// 상담 일지
			content.put("cnsltRequstCn", cnslt.getCnsltRequstCn());	// 상담 요청 내용
			content.put("cmmnCnsltTime", time); 					// 상담 시간
			content.put("cnsltTrgetId", cnslt.getCnsltTrgetId());	// 상담 대상 아이디
			content.put("sttus", sttus);							// 예약 상태 코드
			content.put("cnsltCn", cnslt.getCnsltCn());				// 상담 완료 시 상담 내역
			
			cnsltSchedulHash.put("id", cnslt.getCnsltCode());											// 상담 예약 코드
			cnsltSchedulHash.put("title", "[" + sttusNm + "] " + pwNm + " (예약 시간 : " + time +")");	// [예약상태] 상담자 명 (예약 시간 : )
			cnsltSchedulHash.put("start", cnslt.getCnsltDe());											// 상담일
			cnsltSchedulHash.put("extendedProps", content);
			cnsltSchedulHash.put("color", color);
			cnsltSchedulHash.put("textColor", textColor);
			
			jsonObj = new JSONObject(cnsltSchedulHash);
			jsonArr.add(jsonObj);
		}
		
		log.info("jsonArr => " + jsonArr);
		return jsonArr;
	}

	// 상담 예약 시간을 불러오는 메서드
	@Override
	public List<CnsltVO> loadCnsltTime(CnsltVO cnsltVO) {
		return this.consultationMapper.loadCnsltTime(cnsltVO);
	}
	
	// 상담VO로 학교 코드를 불러오는 메서드
	public String getSchulCode(CnsltVO cnsltVO) {
		return this.consultationMapper.getSchulCode(cnsltVO);
	}

	// 상담VO로 담임선생님을 불러오는 메서드
	@Override
	public String getTcherId(CnsltVO cnsltVO) {
		return this.consultationMapper.getTcherId(cnsltVO);
	}

	// 상담 예약 시간을 불러오는 메서드
	@Override
	public List<String> loadTime() {
		return this.consultationMapper.loadTime();
	}
	
	// 상담 예약 내역을 불러오는 메서드
	@Override
	public List<CnsltVO> loadCnsltResve(CnsltVO cnsltVO, HttpServletRequest request) {
		Date date;
		List<CnsltVO> cnsltVOList = null;
//		String clasCode = (String) request.getSession().getAttribute("CLASS_INFO");
//		log.info("clasCode test ==> " + clasCode);
		try {
			date = getDatePattern(cnsltVO.getCnsltDe());
			cnsltVO.setCnsltDe(date);
//			cnsltVO.setClasCode();
			log.info("loadCnsltTime cnsltVO => " + cnsltVO);
			log.info("loadCnsltTime date => " + date);
			
			cnsltVOList = this.consultationMapper.loadCnsltResve(cnsltVO);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		log.info("loadCnsltTime cnsltVOList => ", cnsltVOList);
		
		return cnsltVOList;
	}
	
	// 상담 예약을 저장하는 메서드
	@Override
	public String setCnsltRequest(CnsltVO cnsltVO) {
		String returnStr = "";
		
		// 학교 코드를 불러오는 메서드
		String schulCode = this.consultationMapper.getSchulCode(cnsltVO);
		cnsltVO.setSchulCode(schulCode);
		log.info("학교 코드 확인 => " + schulCode);

		// 담임선생님 아이디를 불러오는 메서드
		String cnsltTcherId = this.consultationMapper.getTcherId(cnsltVO);
		cnsltVO.setCnsltTcherId(cnsltTcherId);
		log.info("담임선생님 확인 => " + cnsltTcherId);

		// 초기 상담 상태를 대기로 설정
		cnsltVO.setCmmnCnsltSttus("A09001");
		log.info("setCnsltRequest cnsltVO => " + cnsltVO);

		int result = this.consultationMapper.setCnsltRequest(cnsltVO);
		
		if (result == 1) { returnStr = "/cnslt/goToCnsltList"; }
		
		return returnStr;
	}

	// 예약 개수를 가져오는 메서드
	@Override
	public String loadResveCnt(CnsltVO cnsltVO) {
		Date date;
		String result = "";
		
		try {
			date = getDatePattern(cnsltVO.getCnsltDe());
			cnsltVO.setCnsltDe(date);
			
			result = this.consultationMapper.loadResveCnt(cnsltVO);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	// 상담 예약 내역을 삭제하는 메서드
	@Override
	public int deleteCnsltResve(CnsltVO cnsltVO) {
		return this.consultationMapper.deleteCnsltResve(cnsltVO);
	}

	// 상담 예약 내역을 수정하는 페이지로 이동하는 메서드
	public CnsltVO modifyCnsltResve(String cnsltCode) {
		CnsltVO modCnsltVO = this.consultationMapper.getOneCnsltResve(cnsltCode);
		log.info("modifyCnsltResve resultCnsltVO => " + modCnsltVO);
		
		try {
			modCnsltVO.setCnsltDe(getDatePattern(modCnsltVO.getCnsltDe()));
			log.info("modifyCnsltResve cnsltDe => " + modCnsltVO.getCnsltDe());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return modCnsltVO;
	}
	
	// 상담 예약 수정을 실행하는 메서드
	@Override
	public String modifyCnsltResveAct(CnsltVO cnsltVO) {
		String returnStr = "";
		
		int result = this.consultationMapper.modifyCnsltResveAct(cnsltVO);
		log.info("modifyCnsltResveAct result => " + result);

		if (result == 1) { returnStr = "/cnslt/goToCnsltList"; }
		
		return returnStr;
	}

	// 선생님이 상담 내역을 불러오는 메서드
	@Override
	public List<Map<String, Object>> loadTeacherCnsltResveList(Map<String, Object> map) {
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		Map<String, Object> cnsltSchedulHash = new HashMap<String, Object>();
		
		String clasCode = (String) map.get("clasCode");
		log.info("loadTeacherCnsltResveList clasCode => " + clasCode);
		
		List<CnsltVO> cnsltVOList = this.consultationMapper.loadTeacherCnsltResveList(clasCode);
		log.info("loadTeacherCnsltResveList cnsltVOList => " + cnsltVOList);
		
		for (CnsltVO cnslt : cnsltVOList) {
			String sttus = cnslt.getCmmnCnsltSttus();
			String sttusNm = cnslt.getCmmnCnsltSttusNm();
			String trgetNm = cnslt.getCnsltTrgetIdNm();
			String time = cnslt.getCmmnCnsltTime();
			
			String color = "";
			String textColor = "black";
			if (sttus == "A09001" || "A09001".equals(sttus)) { color = "#FF7F27"; }	// 예약 대기
			if (sttus == "A09002" || "A09002".equals(sttus)) { color = "#0003FF"; }	// 예약 확인
			if (sttus == "A09003" || "A09003".equals(sttus)) { color = "#FF0000"; }	// 예약 거부
			if (sttus == "A09004" || "A09004".equals(sttus)) { color = "#808080"; }	// 상담 완료
			
			Map<String, Object> content = new HashMap<String, Object>();
			content.put("cnsltDiary", cnslt.getCnsltDiary());			// 상담 일지
			content.put("cnsltRequstCn", cnslt.getCnsltRequstCn());		// 상담 요청 내용
			content.put("cmmnCnsltTime", cnslt.getCmmnCnsltTime()); 	// 상담 시간
			content.put("cnsltTrgetId", cnslt.getCnsltTrgetId());		// 상담 대상 아이디
			content.put("cnsltTrgetIdNm", trgetNm);						// 상담 대상 아이디
			content.put("sttus", sttus);								// 예약 상태 코드
			content.put("cnsltCn", cnslt.getCnsltCn());				// 상담 완료 시 상담 내역
			
			cnsltSchedulHash.put("id", cnslt.getCnsltCode());												// 상담 예약 코드
			cnsltSchedulHash.put("title", "[" + sttusNm + "] " + trgetNm + " (예약 시간 : " + time +")");		// [예약상태] 상담자 명 (예약 시간 : )
			cnsltSchedulHash.put("start", cnslt.getCnsltDe());												// 상담일
			cnsltSchedulHash.put("extendedProps", content);
			cnsltSchedulHash.put("color", color);
			cnsltSchedulHash.put("textColor", textColor);
			
			jsonObj = new JSONObject(cnsltSchedulHash);
			jsonArr.add(jsonObj);
		}
		
		return jsonArr;
	}

	// 상담 상태를 변경하는 메서드
	@Override
	public int changeSttus(Map<String, Object> map) {
		String cnsltCode = (String) map.get("cnsltCode");
		String cmmnCnsltSttus = (String) map.get("sttus");
		String cnsltDiary = (String) map.get("cnsltDiary");
		
		CnsltVO cnsltVO = new CnsltVO();
		cnsltVO.setCnsltCode(cnsltCode);
		cnsltVO.setCmmnCnsltSttus(cmmnCnsltSttus);
		
		if (cnsltDiary != null) { cnsltVO.setCnsltDiary(cnsltDiary); }
		log.info("changeSttus cnsltVO => " + cnsltVO);
		
		int result = this.consultationMapper.changeSttus(cnsltVO);
		
		return result;
	}

	@Override
	public ArticlePage<CnsltVO> loadCnsltDiaryList(CnsltDiarySearchVO cnsltDiarySearchVO) {
		log.info("loadCnsltDiaryList cnsltDiarySearchVO => " + cnsltDiarySearchVO);
		String keyword = cnsltDiarySearchVO.getKeyword();
		int currentPage = cnsltDiarySearchVO.getCurrentPage();
		int size = cnsltDiarySearchVO.getSize();
		
		log.info("searchCnsltDiaryList cnsltDiarySearchVO => " + cnsltDiarySearchVO);
		
		int total = this.consultationMapper.getCnsltDiaryTotal(cnsltDiarySearchVO);
		log.info("loadCnsltDiaryList total => " + total);
		
		List<CnsltVO> cnsltDiaryVOList = this.consultationMapper.loadCnsltDiaryList(cnsltDiarySearchVO);
		log.info("loadCnsltDiaryList cnsltDiaryVOList => " + cnsltDiaryVOList);
		
		ArticlePage<CnsltVO> cnsltPage = new ArticlePage<CnsltVO>(currentPage, size, cnsltDiaryVOList, keyword, total);

		return cnsltPage;
	}
	
	// 상담 정보를 불러오는 메서드
	@Override
	public CnsltVO viewCnsltCnDetail(String cnsltCode) {
		CnsltVO cnsltVO = this.consultationMapper.getOneCnsltDiary(cnsltCode);
		
		FamilyRelateVO familyRelateVO = this.consultationMapper.getFamilyRelate(cnsltVO);
		log.info("viewCnsltCnDetail familyRelateVO => " + familyRelateVO);
		
		cnsltVO.setStdntId(familyRelateVO.getStdntId());
		cnsltVO.setStdntIdNm(familyRelateVO.getStdntIdNm());
		cnsltVO.setClasInNo(familyRelateVO.getClasInNo());
		log.info("viewCnsltCnDetail cnsltVO => " + cnsltVO);
		
		return cnsltVO;
	}

	// 상담 내용을 등록/수정하는 메서드
	@Override
	public int insertCnsltCnAct(CnsltDiaryVO cnsltDiaryVO) {
		return this.consultationMapper.insertCnsltCnAct(cnsltDiaryVO);
	}

	// 상담 내용을 삭제하는 메서드
	@Override
	public int delCnsltCn(String cnsltCode) {
		return this.consultationMapper.delCnsltCn(cnsltCode);
	}

	// 상담에서 학생 정보를 불러오는 윈도우 창
	@Override
	public ClasStdntVO viewChildInfo(String mberId, HttpServletRequest request) {
		// 세션에 저장된 클래스 정보 가져오기
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		log.info("viewChildInfo CLAS_INFO => " + clasVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberId", mberId);
		map.put("clasCode", clasVO.getClasCode());
		
		// 학생 정보를 불러오는 메서드
		ClasStdntVO clasStdntVO = this.consultationMapper.viewChildInfo(map);
		log.info("viewChildInfo clasStdntVO => " + clasStdntVO);
		
		return clasStdntVO;
	}

}
