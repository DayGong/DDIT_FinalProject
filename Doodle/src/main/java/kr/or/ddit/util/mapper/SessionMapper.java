package kr.or.ddit.util.mapper;

import java.util.Map;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;

public interface SessionMapper {

	public ClasVO getEnterClasVO(String clasCode);

	public SchulVO getEnterSchoolVO(String schulCode);

	public ClasStdntVO getEnterClasStdntVO(Map<String, Object> map);

	public SchulPsitnMberVO getEnterSchulPsitnMberVO(Map<String, Object> map);

	public HrtchrVO getEnterHrtchrVO(Map<String, Object> map);

	public String getSchulCodeWithStdId(String mberId);

	public String getSchulCodeWithTchId(String mberId);
	
}
