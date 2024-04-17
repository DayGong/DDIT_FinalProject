package kr.or.ddit.dclz.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.DclzVO;

public interface DclzMapper {

	// 학생 등교 하교 기록
	public void insertDclz(Map<String, Object> map);
	
	// sysdate get
	public String getSysdate();

	// 출결 정보 get
	public List<DclzVO> getAllDclz(Map<String, Object> map);

	// 반학생 정보 get
	public List<ClasStdntVO> getAllClasStd(String string);

	// 출결 처리 상태 목록 get
	public List<CmmnDetailCodeVO> getDclzCmmn();

	// 반학생 정보 get with 반학생코드
	public ClasStdntVO getClasStdntVOWithClasStdntCode(String clasStdntCode);

	// 출결 처리 상태 변경
	public int updateDclzCmmn(Map<String, Object> map);
	
	// 최근 출결 정보
	public List<DclzVO> getRecentAtend(Map<String,Object> map);
}
