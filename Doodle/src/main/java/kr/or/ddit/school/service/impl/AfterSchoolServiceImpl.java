package kr.or.ddit.school.service.impl;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.school.mapper.AfterSchoolMapper;
import kr.or.ddit.school.service.AfterSchoolService;
import kr.or.ddit.vo.AschaDclzVO;
import kr.or.ddit.vo.AschaVO;
import kr.or.ddit.vo.AschaWeekPlanVO;
import kr.or.ddit.vo.AtnlcReqstVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AfterSchoolServiceImpl implements AfterSchoolService {
	
	@Autowired
	AfterSchoolMapper afterSchoolMapper;

	// 방과후학교 전체 리스트
	@Override
	public List<AschaVO> afterSchoolList(Map<String, Object> map) {
		// 전체 리스트 출력
		List<AschaVO> aschaVOList = this.afterSchoolMapper.afterSchoolList(map);
		
		// 과목당 수강중인 학생수 출력
		for (AschaVO aschaVO : aschaVOList) {
			int stdntCount= this.afterSchoolMapper.getTotalLectureStudent(aschaVO.getAschaCode());
			aschaVO.setTotalStdnt(stdntCount);
			
			// 학교 정보 가져오기
			AschaVO schoolInfo = this.afterSchoolMapper.getSchoolInfo(aschaVO.getSchulCode());
			aschaVO.setSchulNm(schoolInfo.getSchulNm());
			aschaVO.setSchulAdres(schoolInfo.getSchulAdres());
			aschaVO.setSchulTlphonNo(schoolInfo.getSchulTlphonNo());
		}
		
		return aschaVOList;
	}
	
	// 전체 방과후학교 수
	@Override
	public int getTotalAfterSchool(Map<String, Object> map) {
		return this.afterSchoolMapper.getTotalAfterSchool(map);
	}

	// 방과후학교 상세
	@Override
	public List<AschaVO> afterSchoolDetail(AschaVO aschaVO) {
		List<AschaVO> aschaVOList = this.afterSchoolMapper.afterSchoolDetail(aschaVO);
		
		// 과목당 수강중인 학생수 출력
		for (AschaVO aschaVO2 : aschaVOList) {
			int stdntCount= this.afterSchoolMapper.getTotalLectureStudent(aschaVO2.getAschaCode());
			aschaVO2.setTotalStdnt(stdntCount);
			
			log.debug("aschaVO.getAschaCode() :" +aschaVO2.getAschaCode());
			log.debug("stdntCount : " + stdntCount);
		}
		return aschaVOList;
	}

	// 방과후학교 생성
	@Override
	public int afterSchoolCreate(AschaVO aschaVO) {
		// 방과후학교 코드 설정
		int maxAschaSeq = afterSchoolMapper.getMaxAschaSeq(aschaVO.getSchulCode());
		// 일련번호 생성
		int nextAschaSeq = maxAschaSeq +1;
		// 현재연도 추출
		LocalDate now = LocalDate.now();
		// 일련번호를 포함한 방과후학교 코드 설정(SCHUL_CODE+생성연도+일련번호)
	 	String nextAschaCode = aschaVO.getSchulCode() + now.getYear() +String.format("%04d", nextAschaSeq);
		
		// 생성된 방과후학교 코드 설정
		aschaVO.setAschaCode(nextAschaCode);
		aschaVO.setMberId(aschaVO.getMberId());
		aschaVO.setCmmnDetailCode("A10001");	// 신청진행중 코드로 고정함.
		
		int result = this.afterSchoolMapper.afterSchoolCreate(aschaVO);
		
		// ASCHA_WEEK_PLAN 테이블에 insert
		List<AschaWeekPlanVO> aschaWeekPlanVOList = aschaVO.getAschaWeekPlanVOList();
		List<AschaWeekPlanVO> aschaWeekPlanVOList2 = new ArrayList<AschaWeekPlanVO>();

		// 일련번호 생성(방과후학교코드 + 01)
		int code = 0;
		
		for(AschaWeekPlanVO aschaWeekPlanVO : aschaWeekPlanVOList) {
			aschaWeekPlanVO.setAschaCode(aschaVO.getAschaCode());
			// 방과후코드 1씩 증가
			code++;
			String codeNum = aschaVO.getAschaCode() + String.format("%02d", code);
			
			// 생성한 일련번호 등록
			aschaWeekPlanVO.setAschaWeekPlanCode(codeNum);
			
			log.debug("codeNum : "+codeNum);
			log.debug("aschaWeekPlanVO ->aschaWeekPlanVO :" + aschaWeekPlanVO);
			
			aschaWeekPlanVOList2.add(aschaWeekPlanVO);
		}
		
		result += this.afterSchoolMapper.createWeekPlan(aschaWeekPlanVOList2);
		
		log.debug("afterSchoolCreate(serviceImpl) -> aschaVO : " + aschaVO);
		log.debug("maxSeq ->" +maxAschaSeq);
		log.debug("nowTime : "+now.getYear());
		log.debug("afterSchoolCreate->result : " + result);
		log.debug("aschaWeekPlanVO -> aschaWeekPlanVOList2 : "+aschaWeekPlanVOList2);
		
		return result;
	}

	// 방과후학교 수정
	@Override
	public int afterSchoolUpdate(AschaVO aschaVO) {
		// 주간계획 제외한 방과후학교 수정
		int result = this.afterSchoolMapper.afterSchoolUpdate(aschaVO);
		
		// 주간계획 일괄 삭제
		result += this.afterSchoolMapper.deleteWeekPlan(aschaVO);
		
		// 삭제후 ASCHA_WEEK_PLAN 테이블에 insert
		List<AschaWeekPlanVO> aschaWeekPlanVOList = aschaVO.getAschaWeekPlanVOList();
		List<AschaWeekPlanVO> aschaWeekPlanVOList2 = new ArrayList<AschaWeekPlanVO>();
		
		// 일련번호 생성(방과후학교코드 + 01)
		int code = 0;
				
		for(AschaWeekPlanVO aschaWeekPlanVO : aschaWeekPlanVOList) {
			aschaWeekPlanVO.setAschaCode(aschaVO.getAschaCode());
			// 방과후코드 1씩 증가
			code++;
			String codeNum = aschaVO.getAschaCode() + String.format("%02d", code);

			// 생성한 일련번호 등록
			aschaWeekPlanVO.setAschaWeekPlanCode(codeNum);
			aschaWeekPlanVOList2.add(aschaWeekPlanVO);
		}
		
		result += this.afterSchoolMapper.createWeekPlan(aschaWeekPlanVOList2);
		
		log.debug("aschaWeekPlanVO -> aschaWeekPlanVOList2 : "+aschaWeekPlanVOList2);
		
		return result;
	}

	// 방과후학교 삭제
	@Override
	public int afterSchoolDelete(AschaVO aschaVO) {
		// 주간계획 삭제
		int result = this.afterSchoolMapper.deleteWeekPlan(aschaVO);
		
		// 방과후학교 삭제
		result += this.afterSchoolMapper.afterSchoolDelete(aschaVO);
		return result;
	}

	// 교사의 방과후화면 개설 목록
	@Override
	public List<AschaVO> afterSchoolTeacherList(String mberId) {
		return this.afterSchoolMapper.afterSchoolTeacherList(mberId);
	}

	// 과목당 수강중인 학생들
	@Override
	public List<AschaVO> lectureStudentList(AschaVO aschaVO) {
		return this.afterSchoolMapper.lectureStudentList(aschaVO);
	}

	// 수강신청 상태 변경
	@Override
	public int lectureStateUpdate(AtnlcReqstVO atnlcReqstVO) {
		return this.afterSchoolMapper.lectureStateUpdate(atnlcReqstVO);
	}

	// 학생이 수강신청한 방과후학교 목록
	@Override
	public List<AschaVO> afterSchoolLectureList(String mberId) {
		return this.afterSchoolMapper.afterSchoolLectureList(mberId);
	}

	// 결제내역 insert
	@Override
	public int afterSchoolPayment(AtnlcReqstVO atnlcReqstVO) {
		// 미결제시 수강신청 코드 생성하기
		if(atnlcReqstVO.getAtnlcReqstCode() == null) {
			// 방과후학교의 수강코드 최대값 가져오기
			int maxatnlcReqstSeq = afterSchoolMapper.getMaxatnlcReqst(atnlcReqstVO.getAschaCode());
			// 일련번호 생성
			int nextAtnlcReqstSeq = maxatnlcReqstSeq +1;
			// 현재날짜(월/일) 추출
			LocalDate now = LocalDate.now();
			// 일련번호를 포함한 수강신청 코드 설정(ASCHA_CODE+월/일+일련번호)
			String nextAtnlcReqstCode = atnlcReqstVO.getAschaCode() + String.format("%02d",now.getMonthValue())
						+ String.format("%02d", now.getDayOfMonth()) + String.format("%03d", nextAtnlcReqstSeq); 
			
			// 생성한 방과후학교 코드 등록
			atnlcReqstVO.setAtnlcReqstCode(nextAtnlcReqstCode);
			
			log.debug("maxatnlcReqstSeq :" +maxatnlcReqstSeq);
			log.debug("nowdate : "+now.getMonthValue()+now.getDayOfMonth());
			log.debug("nextAtnlcReqstCode :"+nextAtnlcReqstCode);
		}
		
		return this.afterSchoolMapper.afterSchoolPayment(atnlcReqstVO);
	}

	// 출석부 목록
	@Override
	public List<AschaVO> attendanceList(AschaVO aschaVO) {
		return this.afterSchoolMapper.attendanceList(aschaVO);
	}

	// 출결정보 등록
	@Override
	public int attendanceInsert(AschaDclzVO aschaDclzVO) {
		return this.afterSchoolMapper.attendanceInsert(aschaDclzVO);
	}

	// 출결정보 수정
	@Override
	public int attendanceUpdate(AschaDclzVO aschaDclzVO) {
		return this.afterSchoolMapper.attendanceUpdate(aschaDclzVO);
	}

	// 출결정보 삭제
	@Override
	public int attendanceDelete(AschaDclzVO aschaDclzVO) {
		return this.afterSchoolMapper.attendanceDelete(aschaDclzVO);
	}

	// 학생, 학부모 방과후학교 )출석부 목록
	@Override
	public List<AtnlcReqstVO> studAttendanceList(AtnlcReqstVO atnlcReqstVO) {
		return this.afterSchoolMapper.studAttendanceList(atnlcReqstVO);
	}

}
