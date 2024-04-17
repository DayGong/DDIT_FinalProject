package kr.or.ddit.util.mapper;

import java.util.Map;

import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

public interface CheckMapper {

	ClasStdntVO checkBelongClStd(Map<String, Object> map);

	HrtchrVO checkBelongClTch(Map<String, Object> map);

	SchulPsitnMberVO checkBelongSch(Map<String, Object> map);

	ClasStdntVO checkBelongClPrnt(Map<String, Object> map);

}
