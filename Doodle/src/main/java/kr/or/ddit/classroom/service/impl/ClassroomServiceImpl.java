package kr.or.ddit.classroom.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.classroom.mapper.ClassroomMapper;
import kr.or.ddit.classroom.service.ClassroomService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.MailUtil;
import kr.or.ddit.vo.ChldrnClasVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.HrtchrVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SkedVO;
import kr.or.ddit.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ClassroomServiceImpl implements ClassroomService{

	@Autowired
	ClassroomMapper classroomMapper;

	@Autowired
	String uploadFolder;

	// 학급 클래스 메인: 해당 클래스의 담임 교사 정보
	@Override
	public HrtchrVO clasInfoSelect(String clasCode) {
		return this.classroomMapper.clasInfoSelect(clasCode);
	}

	//학급클래스 소속회원 목록
	@Override
	public String classMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	// 결석 사유 신청(체험학습도)
	@Override
	public String absentReason() {
		// TODO Auto-generated method stub
		return null;
	}

	//자유 게시판 목록
	@Override
	public String freeBoard() {
		// TODO Auto-generated method stub
		return null;
	}

	//투표/설문조사 게시판 목록
	@Override
	public String votingSurvey() {
		// TODO Auto-generated method stub
		return null;
	}

	//알림장 목록
	@Override
	public String notice() {
		// TODO Auto-generated method stub
		return null;
	}

	//과제 게시판 목록
	@Override
	public List<TaskVO> taskList(Map<String, Object> map) {
		return this.classroomMapper.taskList(map);
	}

	//과제 게시판 총 목록
	@Override
	public int getTotalTask(String clasCd) {
		return this.classroomMapper.getTotalTask(clasCd);
	}

	//단원마무리 게시판 목록
	@Override
	public String unitTest() {
		// TODO Auto-generated method stub
		return null;
	}

	//학급 시간표 조회
	@Override
	public String schedule() {
		// TODO Auto-generated method stub
		return null;
	}

	//온라인 수업
	@Override
	public String onlineClass() {
		// TODO Auto-generated method stub
		return null;
	}

	//생활 기록부 조회
	@Override
	public String lifeRecord() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 학급클래스(반) 목록 불러오기
	@Override
	public ArticlePage<ClasVO> classroomListAjax(Map<String, Object> map) {
		// 키값 설정
		String keyword = "";
		if (map.get("keyword") == null) {
			keyword = "";
		} else {
			keyword = map.get("keyword").toString();
		}
		int currentPage = Integer.parseInt(map.get("currentPage").toString());
		int size = Integer.parseInt(map.get("size").toString());
		
		// 총 데이터 갯수 가져오기
		int classroomTotal = this.classroomMapper.classroomGetTotal(map);
		log.info("classroomListAjax -> total : " + classroomTotal);
		log.info("String.valueOf(total) : "  + String.valueOf(classroomTotal));
		
		// 학급클래스(반) 목록 가져오기
		List<ClasVO> clasVOList = this.classroomMapper.classroomList(map);
		log.info("clasVOList => "+ clasVOList);
		
		// 페이지네이션
		ArticlePage<ClasVO> data = new ArticlePage<ClasVO>(classroomTotal, currentPage, size, clasVOList, keyword);
				
		return data;
	}

	// 교사 학교명 가져오기
	@Override
	public SchulPsitnMberVO getSchoolNm(SchulPsitnMberVO schulPsitnMberVO) {
		return this.classroomMapper.getSchoolNm(schulPsitnMberVO);
	}

	// 클래스 생성
	@Override
	public int classCreateAjax(ClasVO clasVO) {
		return this.classroomMapper.classCreateAjax(clasVO);
	}

	//클래스 담당 교사 등록
	@Override
	public int hrtchrCreate(ClasVO clasVO) {
		HrtchrVO hrtchrVO = clasVO.getHrtchrVO();
		return this.classroomMapper.hrtchrCreate(hrtchrVO);
	}


	//학교 -> 학급클래스 목록
	@Override
	public ArticlePage<ClasVO> classListAjax(Map<String, Object> map) {
		String schulCode = (String)map.get("schulCode");
		List<ClasVO> clasVOList = this.classroomMapper.classListAjax(map);
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String keyword = map.get("keyword").toString();
	    //총 갯수
		int total = this.classroomMapper.classListGetTotal(map);
		ArticlePage<ClasVO> data = new ArticlePage<ClasVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), clasVOList, keyword, schulCode);
		String url = "/class/classList";
		data.setUrl(url);
		return data;
	}
	

	//클래스 생성 전 중복체크
	@Override
	public int classDupCheck(ClasVO clasVO) {
		log.debug("여기오삼: {}",clasVO);
		return this.classroomMapper.classDupCheck(clasVO);
	}

	//클래스 가입시 학교 코드 가져오기
	@Override
	public String selectSchulCode(String clasCode) {
		return this.classroomMapper.selectSchulCode(clasCode);
	}

	//클래스 가입신청
	@Override
	public int classJoinReqAjax(ClasStdntVO clasStdntVO) {
		int cnt = this.classroomMapper.classJoinDupCheck(clasStdntVO);
		if(cnt>0) { //실패
			return 0;
		}else {
			this.classroomMapper.classJoinReqAjax(clasStdntVO);
			return 1; 
		}
	}

	//클래스 가입신청 목록
	@Override
	public ArticlePage<ClasStdntVO> classJoinReqListAjax(Map<String, Object> map) {
		String clasCode = (String)map.get("clasCode");
		String schulCode = (String)map.get("schulCode");
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String keyword = "";
		List<ClasStdntVO> ClasStdntVOList = this.classroomMapper.classJoinReqListAjax(map);
		int total = this.classroomMapper.classJoinReqGetTotal(map);
		log.info("가입대기list->total : " + total);
	    log.info("currentPage{}",currentPage);
	    ArticlePage<ClasStdntVO> data = new ArticlePage<ClasStdntVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), ClasStdntVOList, keyword);
	    String url = "/class/classJoinReqList";
	    data.setUrl(url);
		return data;
	}

	//클래스 가입신청 처리
	@Override
	public int classJoinAjax(ClasStdntVO clasStdntVO) {
		return this.classroomMapper.classJoinAjax(clasStdntVO);
	}

	//클래스 가입신청 취소
	@Override
	public int classJoinReqCancelAajx(ClasStdntVO clasStdntVO) {
		return this.classroomMapper.classJoinReqCancelAajx(clasStdntVO);
	}

	//선생님화면)학생 구성원 목록
	@Override
	public ArticlePage<ClasStdntVO> classTStudListAjax(Map<String, Object> map) {
		String schulCode = (String)map.get("schulCode");
		String clasCode = (String)map.get("clasCode");
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		//int size = Integer.parseInt((String) map.get("size"));
		String keyword = "";
		log.info("내가왔다 서비스에! : " + size);
		
		List<ClasStdntVO> ClasStdntVOList = this.classroomMapper.classTStudListAjax(map);
		int total = this.classroomMapper.classStudGetTotal(map);
		log.info("구성원학생list->total : " + total);
		ArticlePage<ClasStdntVO> data = new ArticlePage<ClasStdntVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), ClasStdntVOList, keyword);
		String url = "/class/classTStudList";
		data.setUrl(url);
		return data;
	}
	

	//학부모 구성원 목록
	@Override
	public ArticlePage<ClasStdntVO> classTParentListAjax(Map<String, Object> map) {
		String schulCode = (String)map.get("schulCode");
		String clasCode = (String)map.get("clasCode");
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String keyword = "";
		List<ClasStdntVO> ClasStdntVOList = this.classroomMapper.classTParentListAjax(map);
		int total = this.classroomMapper.classPrentGetTotal(map);
		log.info("구성원학부모list->total : " + total);
		ArticlePage<ClasStdntVO> data = new ArticlePage<ClasStdntVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), ClasStdntVOList, keyword);
		String url = "/class/classTParentList";
		data.setUrl(url);
		return data;
	}

	//클래스 구성원  상세정보
	@Override
	public MemberVO classMberDetailAjax(String mberId) {
		return this.classroomMapper.classMberDetailAjax(mberId);
	}
	
	//이메일 값 가져오기
	@Override
	public List<String> getEmailByMemberId(List<String> mberIds, String clasCode) {
		List<String> mberEmails = new ArrayList<String>();
		log.info("mberEmail들어왔낭?" + mberEmails);
		log.info("mberIds들어왔낭?" + mberIds);
		log.info("clasCode들어왔낭?" + clasCode);
		for(String mberId : mberIds) {
			log.info("갔다올게!!! -> " + mberId + "나도 = >" + clasCode);
			MemberVO memberVO = this.classroomMapper.getEmailByMemberId(mberId, clasCode);
			if(memberVO != null) {
				mberEmails.add(memberVO.getMberEmail());
				log.info(mberEmails + "이메일!무뚝뚝잉!");
			}
		}
				//메일보내긩
		String contents = "<div style='background-color:#F4F5F7; padding:20px;'>" +
                "<div style='max-width:600px; margin:0 auto;'>" +
                "<h1 style='text-align:center; font-size:24px; color:#333; margin-bottom:20px;'>인증번호 발송 안내</h1>" +
                "<div style='background-color:#FFFFFF; padding:32px; border-top:3px solid #22B4E6; border-radius:4px;'>" +
                "<h2 style='font-size:24px; font-weight:bold; color:#333; text-align:center; margin-bottom:20px;'>초대코드 : "+clasCode+"</h2>" +
                "<p style='font-size:16px; color:#666; text-align:left;'>위 학생의 학부모님의 계정으로 클래스에 참여할 수 있는 초대코드입니다. <br>초대코드를 사용하여 클래스에 참여하시기 바랍니다.</p>" +
                "</div>" +
                "</div>" +
                "</div>";

				//보내는사람 메일
				String fromMail = "dev_011008@naver.com";
				String password = "javajava";
				
				Map<String, String> mailDTO = new HashMap<String, String>();
				mailDTO.put("title", "[두들] 클래스 초대코드 발송 안내");
				mailDTO.put("fromMail", fromMail);
				mailDTO.put("password", password);
				mailDTO.put("fromName","Doodle");
				mailDTO.put("contents",contents);

				for(String mberEmail : mberEmails) {
					log.info("mberEmail입니다잉",mberEmail);
					mailDTO.put("toMail",mberEmail);
					MailUtil.sendMail(mailDTO);
				}
				
		return mberEmails;
	}

	//학교 소속 회원 테이블 INSERT
	@Override
	public int classInvCodeJoin(ChldrnClasVO chldrnClasVO) {
		return this.classroomMapper.classInvCodeJoin(chldrnClasVO);
	}

	//학교 소속 중복체크
	@Override
	public int schulPsitnDupCheck(ChldrnClasVO chldrnClasVO) {
		return this.classroomMapper.schulPsitnDupCheck(chldrnClasVO);
	}

	//자녀 반 테이블 INSERT
	@Override
	public int chldrnClasInsert(ChldrnClasVO chldrnClasVO) {
		return this.classroomMapper.chldrnClasInsert(chldrnClasVO);
	}

	//학부모 클래스 소속 중복체크
	@Override
	public int classDupCnt(ChldrnClasVO chldrnClasVO) {
		log.info("서비스왔닝?{}",chldrnClasVO);
		
		//클래스 소속 중복 체크
		int classDupCnt = this.classroomMapper.classDupCnt(chldrnClasVO);
		if(classDupCnt > 0) { //중복이면?
			return 0;
		}else {
			//학교 소속 중복체크
			int dupCnt = this.classroomMapper.schulPsitnDupCheck(chldrnClasVO);
			if(dupCnt > 0) { //중복이면?
				//자녀 반 테이블 INSERT
				int cnt = this.classroomMapper.chldrnClasInsert(chldrnClasVO);
				log.info("학교 소속에 있음" , cnt);
				return 1;
			}else { //중복아니면
				//학교 소속 회원 테이블 INSERT
				int cnt = this.classroomMapper.classInvCodeJoin(chldrnClasVO);
				//자녀 반 테이블 INSERT
				cnt += this.classroomMapper.chldrnClasInsert(chldrnClasVO);
				log.info("학교 소속에 없음" , cnt);
				return 1;
			}
		}
	}

	//학생 구성원 수정
	@Override
	public int classStudUpdateAjax(List<ClasStdntVO> clasStdntVOList) {
		log.info("내가왔다 서비스에{}",clasStdntVOList);
		int cnt = 0;
		for(ClasStdntVO clasStdntVO : clasStdntVOList) {
			cnt += this.classroomMapper.classStudUpdateAjax(clasStdntVO);
			log.info("cnt는"+clasStdntVO.getMberId());
		}
		log.info("cnt지롱"+cnt);
		return cnt;
	}
	
	//학생, 학부모화면) 학생조회
	@Override
	public ArticlePage<ClasStdntVO> classStdntListAjax(Map<String, Object> map) {
		String clasCode = (String)map.get("clasCode");
		String schulCode = (String)map.get("schulCode");
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String keyword = "";
		//int size = Integer.parseInt((String) map.get("size"));
		log.info("사이즈!!!!!!!!!!!!!!!!!"+size);
		List<ClasStdntVO> clasStdntVOList = this.classroomMapper.classStdntListAjax(map);
		log.info("서비스다옹"+clasStdntVOList);
		int total = this.classroomMapper.StdntListGetTotal(map);
		log.info("토탈"+clasStdntVOList);
	    log.info("list->total : " + total);
	    log.info("currentPage{}",currentPage);
	    ArticlePage<ClasStdntVO> data = new ArticlePage<ClasStdntVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), clasStdntVOList, keyword);
	    String url = "/class/classStdntList";
	    data.setUrl(url);
		return data;
	}

	//학생, 학부모화면) 학생조회 총 개수
	@Override
	public int StdntListGetTotal(Map<String, Object> map) {
		return this.classroomMapper.StdntListGetTotal(map);
	}
	
	//클래스 수정
	@Override
	public int classUpdateAjax(ClasVO clasVO) {
		return classroomMapper.classUpdateAjax(clasVO);
	}

	//클래스 삭제
	@Override
	public int classDeleteAjax(ClasVO clasVO) {
		return classroomMapper.classDeleteAjax(clasVO);
	}
	
	// 학급 시간표 목록
	@Override
	public List<SkedVO> scheduleList(SkedVO skedVO) {
		return this.classroomMapper.scheduleList(skedVO);
	}

	// 학급시간표 등록
	@Override
	public int scheduleCreate(List<SkedVO> skedVOList) {
		
		int result = 0;
		int maxScheduleSeq = classroomMapper.maxScheduleSeq(skedVOList.get(0));

		for(SkedVO skedVO : skedVOList) {
			// 시간표 코드 설정
			log.debug("maxScheduleSeq -> "+maxScheduleSeq);
			
			// 일련번호 생성
			int nextScheduleSeq = maxScheduleSeq + 1;
			// 일련번호를 포함한 시간표 코드 생성(학교코드+학기+일련번호)
			String nextScheduleCode = skedVO.getClasCode() +skedVO.getSemstr()+String.format("%03d",nextScheduleSeq);
			// 시간표에 생성된 코드 설정
			skedVO.setSkedCode(nextScheduleCode);
			  
			// 가장 큰 일련번호를 새로 생성한 일련번호로 생성
	        maxScheduleSeq = nextScheduleSeq;
		}
		result += this.classroomMapper.scheduleCreate(skedVOList);
		
		return result;
	}

	// 오늘의 시간표 목록
	@Override
	public List<SkedVO> todaySchedule(String clasCode) {
		return this.classroomMapper.todaySchedule(clasCode);
	}	

	// 학기 중복 확인
	@Override
	public int checkScheduleSemstr(SkedVO skedVO) {
		return classroomMapper.checkScheduleSemstr(skedVO);
	}
	
	//클래스 가입 거절 목록
	@Override
	public ArticlePage<ClasStdntVO> classJoinRJListAjax(Map<String, Object> map) {
		String clasCode = (String)map.get("clasCode");
		String schulCode = (String)map.get("schulCode");
		String currentPage = map.get("currentPage").toString();
		String size = map.get("size").toString();
		String keyword = "";
		List<ClasStdntVO> ClasStdntVOList = this.classroomMapper.classJoinRJListAjax(map);
		int total = this.classroomMapper.classJoinRJGetTotal(map);
		log.info("가입대기list->total : " + total);
	    log.info("currentPage{}",currentPage);
	    ArticlePage<ClasStdntVO> data = new ArticlePage<ClasStdntVO>(total, Integer.parseInt(currentPage), Integer.parseInt(size), ClasStdntVOList, keyword);
	    String url = "/class/classJoinRJList";
	    data.setUrl(url);
		return data;
	}

	//내가 속해있는 클래스 가져오기
	@Override
	public List<ClasStdntVO> getMberClasCode(String mberId) {
		log.debug("왓니서비스에???{}",mberId);
		return classroomMapper.getMberClasCode(mberId);
	}


}
