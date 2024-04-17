package kr.or.ddit.classroom.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.classroom.mapper.ClassroomMainMapper;
import kr.or.ddit.classroom.mapper.ClassroomMapper;
import kr.or.ddit.classroom.mapper.GalleryMapper;
import kr.or.ddit.classroom.mapper.NtcnMapper;
import kr.or.ddit.classroom.service.ClassroomMainService;
import kr.or.ddit.task.mapper.TaskMapper;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NtcnVO;
import kr.or.ddit.vo.TaskVO;

@Service
public class ClassroomMainServiceImpl implements ClassroomMainService {

	@Autowired
	ClassroomMapper classroomMapper;
	@Autowired
	ClassroomMainMapper classroomMainMapper;
	@Autowired
	TaskMapper taskMapper;
	@Autowired
	NtcnMapper ntcnMapper;
	@Autowired
	GalleryMapper galleryMapper;
	
	// 학생 목록
	@Override
	public List<ClasStdntVO> getStdList(Map<String, Object> map) {
		return classroomMapper.getStdList(map);
	}

	// 과제
	@Override
	public List<TaskVO> getTaskList(Map<String, Object> map) {
		return taskMapper.getTaskList(map);
	}

	// 알림장
	@Override
	public List<NtcnVO> getNtcnList(Map<String, Object> map) {
		return ntcnMapper.getNtcnList(map);
	}

	// 반 앨범 이미지 get
	@Override
	public List<AtchFileVO> getClasImg(HttpServletRequest request, Map<String, Object> map) {
		
		// size는 최대 9
		int size = Integer.parseInt((String)map.get("size"));
		if(size > 9) {
			map.put("size",9);
		}
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		map.put("clasCode",clasVO.getClasCode());
		
		return galleryMapper.getClasImg(map);
	}

	// 반삭제
	@Override
	public int deleteClassroom(HttpServletRequest request) {
		int res = 0;

		MemberVO memberVO 	= (MemberVO) request.getSession().getAttribute("USER_INFO");
		ClasVO clasVO 		= (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String mberId 		= memberVO.getMberId();
		String clasCode 	= clasVO.getClasCode();
		
		// 해당 반의 담임인지 확인
		try {
			HrtchrVO hrtchrVO = (HrtchrVO) classroomMapper.clasInfoSelect(clasCode);
			if(hrtchrVO.getMberId().equals(mberId) ) {
				res = classroomMapper.deleteClassroom(clasCode);
			}
			
		} catch (NullPointerException e) {
			res = 0;
		}
		
		return res;
	}
	
	
}
