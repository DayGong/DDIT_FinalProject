package kr.or.ddit.dclz.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.DclzVO;

public interface DclzService {

	public int insertDclz(String clasStdntCode);

	public List<DclzVO> getAllDclz(HttpServletRequest request);

	public int insertStdDclz(HttpServletRequest request);

	public List<ClasStdntVO> getAllClasStd(HttpServletRequest request);

	public List<CmmnDetailCodeVO> getDclzCmmn();

	public ClasStdntVO getClasStdntVOWithClasStdntCode(String clasStdntCode);

	public int updateDclzCmmn(Map<String, Object> map);
	
	// 최근 출결 정보
	public List<DclzVO> getRecentAtend(Map<String,Object> map);
}
