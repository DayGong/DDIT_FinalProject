package kr.or.ddit.consultation.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.CnsltDiarySearchVO;
import kr.or.ddit.vo.CnsltDiaryVO;
import kr.or.ddit.vo.CnsltVO;
import kr.or.ddit.vo.MemberVO;

public interface ConsultationService {

	// 선생님의 상담 예약 목록을 불러오는 메서드
	public List<Map<String, Object>> loadCnsltResveList(Map<String, Object> map, HttpServletRequest request);

	// 상담 예약 시간을 불러오는 메서드
	public List<CnsltVO> loadCnsltTime(CnsltVO cnsltVO);

	// 상담VO로 학교 코드를 불러오는 메서드
	public String getSchulCode(CnsltVO cnsltVO);
		
	// 상담VO로 담임선생님을 불러오는 메서드
	public String getTcherId(CnsltVO cnsltVO);
	
	// 상담 예약 시간을 불러오는 메서드
	public List<String> loadTime();
	
	// 상담 예약 내역을 불러오는 메서드
	public List<CnsltVO> loadCnsltResve(CnsltVO cnsltVO, HttpServletRequest request);
	
	// 상담 예약을 저장하는 메서드
	public String setCnsltRequest(CnsltVO cnsltVO);

	// 예약 개수를 가져오는 메서드
	public String loadResveCnt(CnsltVO cnsltVO);

	// 상담 예약 내역을 삭제하는 메서드
	public int deleteCnsltResve(CnsltVO cnsltVO);

	// 상담 예약 내역을 수정하는 페이지로 이동하는 메서드
	public CnsltVO modifyCnsltResve(String cnsltCode);
	
	// 상담 예약 수정을 실행하는 메서드
	public String modifyCnsltResveAct(CnsltVO cnsltVO);

	// 선생님이 상담 내역을 불러오는 메서드
	public List<Map<String, Object>> loadTeacherCnsltResveList(Map<String, Object> map);

	// 상담 상태를 변경하는 메서드
	public int changeSttus(Map<String, Object> map);

	// 상담 일지 게시판을 불러오는 메서드
	public ArticlePage<CnsltVO> loadCnsltDiaryList(CnsltDiarySearchVO cnsltDiarySearchVO);

	// 상담 일지 자세히보기 페이지로 이동하기 전 상담 정보를 불러오는 메서드
	public CnsltVO viewCnsltCnDetail(String cnsltCode);

	// 상담 내용을 등록/수정하는 메서드
	public int insertCnsltCnAct(CnsltDiaryVO cnsltDiaryVO);

	// 상담 내용을 삭제하는 메서드
	public int delCnsltCn(String cnsltCode);

	// 상담에서 학생 정보를 불러오는 윈도우 창
	public ClasStdntVO viewChildInfo(String mberId, HttpServletRequest request);

}
