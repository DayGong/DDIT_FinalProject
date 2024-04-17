package kr.or.ddit.dclz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dclz.mapper.DclzMapper;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.DclzVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DclzServiceImpl implements DclzService {

	@Autowired
	DclzMapper dclzMapper;
	
	
	
	// (학생) 등교 하교 기록
	@Override
	public int insertStdDclz(HttpServletRequest request) {
		String sysdate = dclzMapper.getSysdate();
		ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO");
		String clasStdntCode = clasStdntVO.getClasStdntCode();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clasStdntCode",clasStdntCode);
		map.put("sysdate",sysdate);
		map.put("insert_cnt",-1);
		dclzMapper.insertDclz(map);
		return (int) map.get("insert_cnt");
	}

	// (교사) 학생 등교 하교 기록
	@Override
	public int insertDclz(String clasStdntCode) {
		String sysdate = dclzMapper.getSysdate();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clasStdntCode",clasStdntCode);
		map.put("sysdate",sysdate);
		map.put("insert_cnt",-1);
		dclzMapper.insertDclz(map);
		return (int) map.get("insert_cnt");
	}

	// 출결 정보 get
	@Override
	public List<DclzVO> getAllDclz(HttpServletRequest request) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// after page session
		map.put("clasCode", clasVO.getClasCode());
		if (request.isUserInRole("ROLE_A01001") || request.isUserInRole("ROLE_A01003")) {
			ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO");
			map.put("clasStdntCode", clasStdntVO.getClasStdntCode());
		}
		
		return dclzMapper.getAllDclz(map);
	}

	// 반학생 정보 get
	@Override
	public List<ClasStdntVO> getAllClasStd(HttpServletRequest request) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		return dclzMapper.getAllClasStd(clasVO.getClasCode());
	}

	// 출결 처리 상태 목록 get
	@Override
	public List<CmmnDetailCodeVO> getDclzCmmn() {
		return dclzMapper.getDclzCmmn();
	}

	// 반학생 정보 get with 반학생코드
	@Override
	public ClasStdntVO getClasStdntVOWithClasStdntCode(String clasStdntCode) {
		return dclzMapper.getClasStdntVOWithClasStdntCode(clasStdntCode);
	}

	// 출결 처리 상태 변경
	@Override
	public int updateDclzCmmn(Map<String, Object> map) {
		return dclzMapper.updateDclzCmmn(map);
	}

	// 최근 출결 정보
	@Override
	public List<DclzVO> getRecentAtend(Map<String, Object> map) {
		return dclzMapper.getRecentAtend(map);
	}
}
