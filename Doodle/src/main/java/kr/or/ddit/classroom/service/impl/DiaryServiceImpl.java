package kr.or.ddit.classroom.service.impl;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.or.ddit.classroom.mapper.DiaryMapper;
import kr.or.ddit.classroom.service.DiaryService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.DiarySearchVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DiaryServiceImpl implements DiaryService {
	
	@Autowired
	DiaryMapper diaryMapper;

	// 일기장  쓰기에서 날씨를 불러오기위해 학교가 소속된 지역을 가져오는 메서드
	@Override
	public String getSchulArea(String schulCode) {
		String area = this.diaryMapper.getSchulArea(schulCode);
		
		switch (area.trim()) {
			case "서울특": case "서울": 	area = "seoul"; break;
			case "부산광": case "부산": 	area = "busan"; break;
			case "대구광": case "대구": 	area = "daegu"; break;
			case "인천광": case "인천": 	area = "incheon"; break;
			case "광주광": case "광주": 	area = "gwangju"; break;
			case "대전광": case "대전": 	area = "daejeon"; break;
			case "울산광": case "울산":	area = "ulsan"; break;
			case "세종특": case "세종": 	area = "sejong"; break;
			case "경기도": 				area = "gyeonggi-do"; break;
			case "강원도": 				area = "gangwon-do"; break;
			case "충청북": 				area = "chungcheongbuk-do"; break;
			case "충청남": 				area = "chungcheongnam-do"; break;
			case "전라북": case "전북": 	area = "jeollabuk-do"; break;
			case "전라남": case "전남": 	area = "jeollanam-do"; break;	
			case "경상북": case "경북": 	area = "gyeongsangbuk-do"; break;
			case "경상남": case "경남": 	area = "gyeongsangnam-do"; break;	
			case "제주특": case "제주": 	area = "jeju-do"; break;	
			default: break;
		}
		
		return area;
	}

	// 일기장 등록
	@Override
	public int addDiaryAct(HttpServletRequest request, NttVO nttVO) {
		ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO");
		nttVO.setMberId(clasStdntVO.getMberId());
		nttVO.setClasCode(clasStdntVO.getClasCode());
		nttVO.setSchulCode(clasStdntVO.getSchulCode());
		
		log.debug("addDiaryAct nttVO => " + nttVO);
		
		int result = this.diaryMapper.addDiaryAct(nttVO);	// 게시물만 저장
		return result;
	}

	// 일기장 목록 불러오기
	@Override
	public ArticlePage<NttVO> getDiaryList(HttpServletRequest request, DiarySearchVO diarySearchVO) {
		String keyword = diarySearchVO.getKeyword();
		int currentPage = diarySearchVO.getCurrentPage();
		int size = diarySearchVO.getSize();
		MemberVO mberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String teacherId = this.diaryMapper.getTeacherId(clasVO);	// 반 선생님 아이디
		diarySearchVO.setSchulCode(clasVO.getSchulCode());			// 학교 코드
		diarySearchVO.setClasCode(clasVO.getClasCode());			// 학급 코드

		if (mberVO.getMberId().equals(teacherId)) {
			diarySearchVO.setMberId("DOODLE");
		}
		
		int diaryTotal = this.diaryMapper.getDiaryTotal(diarySearchVO);
		List<NttVO> nttVOList = this.diaryMapper.getDiaryList(diarySearchVO);
		
		log.debug("getDiaryList currentPage => " + currentPage);
		log.debug("getDiaryList diaryTotal => " + diaryTotal);
		log.debug("getDiaryList sessionId => " + mberVO.getMberId());
		log.debug("getDiaryList teacherId => " + teacherId);
		log.debug("getDiaryList nttVOList => " + nttVOList);
		 
		ArticlePage<NttVO> nttPage = new ArticlePage<NttVO>(currentPage, size, nttVOList, keyword, diaryTotal);
		return nttPage;
	}
	
	// 일기 상세보기로 이동
	@Override
	public Map<String, Object> diaryViewDetail(HttpServletRequest request, Model model, String nttCode) {
		MemberVO mberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		String teacherId = this.diaryMapper.getTeacherId(clasVO);	// 반 선생님 아이디
		NttVO nttVO = this.diaryMapper.getDiaryDetail(nttCode);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mberVO", mberVO);
		map.put("clasVO", clasVO);
		map.put("teacherId", teacherId);
		map.put("writerId", nttVO.getMberId());
		
		log.debug("diaryViewDetail mberVO => " + mberVO);
		log.debug("diaryViewDetail clasVO => " + clasVO);
		log.debug("diaryViewDetail teacherId => " + teacherId);
		log.debug("diaryViewDetail writerId => " + nttVO.getMberId());
		
		return map;
	}

	// 일기장 상세보기 정보 가져오기
	@Override
	public NttVO getDiaryDetail(String nttCode) {
		NttVO nttVO = this.diaryMapper.getDiaryDetail(nttCode);
		
		return nttVO;
	}

	// 댓글 리스트 가져옴
	@Override
	public List<AnswerVO> getDiaryReplyList(String nttCode) {
		List<AnswerVO> answerVOList = this.diaryMapper.getDiaryReplyList(nttCode);
		
		return answerVOList;
	}
	
	// 댓글 상세 정보 가져옴
	@Override
	public AnswerVO getDiaryReplyDetail(String answerCode) {
		AnswerVO answerVO = this.diaryMapper.getDiaryReplyDetail(answerCode);
		
		return answerVO;
	}

	// 댓글 등록하기
	@Override
	public int addReply(HttpServletRequest request, AnswerVO answerVO) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		answerVO.setSchulCode(clasVO.getSchulCode());
		int result = this.diaryMapper.addReply(answerVO);
		return result;
	}
	
	// 댓글 수정하기
	@Override
	public AnswerVO modDiaryReply(AnswerVO answerVO) {
		AnswerVO resAnswerVO = null;
		int res = this.diaryMapper.modDiaryReply(answerVO);
		
		if (res == 1 || res == 0) {
			resAnswerVO = this.diaryMapper.getDiaryReplyDetail(answerVO.getAnswerCode());
		}
		
		return resAnswerVO;
	}

	// 댓글 삭제하기
	@Override
	public int delDiaryReply(String answerCode) {
		int result = this.diaryMapper.delDiaryReply(answerCode);
		return result;
	}

	// 일기 삭제하기
	@Override
	public int delDiary(String nttCode) {
		int result = this.diaryMapper.delDiary(nttCode);
		return result;
	}

	// 일기장 이미지 파일업로드
	@Override
	public String diaryImgUpload(String imgData) {
		String uploadFolder = "D:\\upload\\diary\\";
		String fileName = UUID.randomUUID().toString();
		String fileURL = uploadFolder + fileName + ".png";
		decoder(imgData, fileURL);

		return fileName + ".png";
	}
	
	public static boolean decoder(String base64, String target){
		String data = base64.split(",")[1];
		
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);
		
		try {
			BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
			ImageIO.write(bufImg, "png", new File(target));
		} catch (IOException e) {
			e.printStackTrace();
			
			return false;
		}
		return true;
	}
	
}
