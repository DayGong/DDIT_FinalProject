package kr.or.ddit.classroom.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.classroom.service.ClassroomMainService;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.NtcnVO;
import kr.or.ddit.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/class")
@Controller
public class ClassroomMainController {

	@Autowired
	ClassroomMainService classroomMainService;
	
	// 학생 리스트 get
	@ResponseBody
	@PostMapping("/getStdList")
	public List<ClasStdntVO> getStdList(@RequestBody Map<String,Object> map){
		/*
		 *  파라미터맵 : clasCode(선택사항)
		 *			  schulCode(선택사항)
		 */
		
		return classroomMainService.getStdList(map);
	}
	
	// 과제 게시판 목록. 사이즈, 클래스코드 선택적.
	@ResponseBody
	@PostMapping("/getTaskList")
	public List<TaskVO> getTaskList(HttpServletRequest request, @RequestBody Map<String,Object> map){
		String sendClasCode = (String)map.get("clasCode");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션 클래스 코드와 입력 클래스코드가 같지 않음.
		if(sendClasCode != null && !sendClasCode.equals(clasVO.getClasCode())) {
			return null;
		};
		// 전체 검색 시 교장과 행정직만 가능.
		if(sendClasCode == null && !(request.isUserInRole("A14001") || request.isUserInRole("A14003"))){
			return null;
		}
		
		return classroomMainService.getTaskList(map);
	}
	
	// 알림장 게시판 목록. 사이즈, 클래스코드 선택적.
	@ResponseBody
	@PostMapping("/getNtcnList")
	public List<NtcnVO> getNtcnList(HttpServletRequest request, @RequestBody Map<String,Object> map){
		String sendClasCode = (String)map.get("clasCode");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		// 세션 클래스 코드와 입력 클래스코드가 같지 않음.
		if(sendClasCode != null && !sendClasCode.equals(clasVO.getClasCode())) {
			return null;
		};
		// 전체 검색 시 교장과 행정직만 가능.
		if(sendClasCode == null && !(request.isUserInRole("A14001") || request.isUserInRole("A14003"))){
			return null;
		}
		
		return classroomMainService.getNtcnList(map);
	}
	
	// 밤 앨범 내 사진 get.
	@ResponseBody
	@PostMapping("/getClasImg")
	public List<AtchFileVO> getClasImg(HttpServletRequest request, @RequestBody Map<String,Object> map){
		/*
		 * 파라미터
		 * size : 출력 사진 갯수
		 */
		return classroomMainService.getClasImg(request, map);
	}
	
	// 반 수정.
	@ResponseBody
	@PostMapping("/modifyClassroom")
	public int modifyClassroom(HttpServletRequest request){
		return 0;
	}
	
	// 반 삭제.
	@ResponseBody
	@PostMapping("/deleteClassroom")
	public int deleteClassroom(HttpServletRequest request){
		return classroomMainService.deleteClassroom(request);
	}
}
