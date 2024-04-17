package kr.or.ddit.classroom.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.NtcnVO;
import kr.or.ddit.vo.TaskVO;

public interface ClassroomMainService {

	List<ClasStdntVO> getStdList(Map<String, Object> map);

	List<TaskVO> getTaskList(Map<String, Object> map);

	List<NtcnVO> getNtcnList(Map<String, Object> map);

	List<AtchFileVO> getClasImg(HttpServletRequest request, Map<String, Object> map);

	int deleteClassroom(HttpServletRequest request);

}
