package kr.or.ddit.classroom.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.classroom.mapper.FreeBoardMapper;
import kr.or.ddit.classroom.service.FreeBoardService;
import kr.or.ddit.common.mapper.CommonMapper;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.IemRspnsVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchulVO;
import kr.or.ddit.vo.VoteNdQustnrVO;
import kr.or.ddit.vo.VoteQustnrDetailIemVO;
import kr.or.ddit.vo.VoteQustnrIemVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	//자유게시판 매퍼 호출
	@Autowired
	FreeBoardMapper mapper;

	//회원가입에 있는 메소드를 사용하기 위해 CommonMapper호출
	@Autowired
	CommonMapper commonMapper;

	//파일 업로드 경로 호출
	@Autowired
	String uploadFolder;
	//D:\\upload

	@Override
	public int freeBoarRegistration(MemberVO memberVO, NttVO nttVO, List<MultipartFile> uploadList, ClasVO clasVO) {
		nttVO.setClasCode(clasVO.getClasCode());
		nttVO.setMberId(memberVO.getMberId());//작성자 아이디 vo 세팅

		//학교 코드 가져오는 메소드
		String schulCode = commonMapper.getSchulCode(memberVO.getMberId());
		nttVO.setSchulCode(schulCode);//작성자 아이디로 조회한 학교 코드 vo 세팅
		log.info("nttVO의 schulCode 학교코드 값 -> " + schulCode);

		int res = mapper.freeBoarRegistration(nttVO);//게시글 텍스트 전송

		int res2 = 0;
		int result = 0;
		// 폴더생성
		if (uploadList != null && uploadList.size() != 0 && uploadList.get(0).getSize() > 0) {
			File fileFolder = new File(uploadFolder + "\\freeBoard\\");
			// D:\\upload\\freeBoard\\이미지
			// 개수만큼 폴더생성
			fileFolder.mkdirs();

			String atchFileCode = mapper.getFreeMaxCode(nttVO);
			AtchFileVO atchfileVO = new AtchFileVO();
			atchfileVO.setAtchFileCode(atchFileCode);//첨부파일 작성자 첨부파일코드

			// ↓시퀀스컬럼의 값을 위한 변수 ↓
			int fileCnt = 0;
			// 사용자가 올린 파일 복사
			for (MultipartFile multipartFile : uploadList) {
				String uuid = UUID.randomUUID().toString();

				String uploadFileName = uuid +"_"+ multipartFile.getOriginalFilename();
				// 복사할 파일을 어디에 저장할 지 경로 정하기 ↓↓↓↓↓
				String Filepath = uploadFolder  +"\\freeBoard\\"+ uploadFileName;
				//D:\\upload\\freeBoard\\uuid\\파일이름


				File saveFile = new File(Filepath);

				// 복사한 경로에 이미지 파일 업로드 ↓↓↓↓↓
				try {
					multipartFile.transferTo(saveFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// (디비에 파일 저장하는 것임)ATACHFILE테이블에 파일 경로 및 컬럼 값 데이터 입력 ↓↓↓↓↓


				fileCnt++;
				atchfileVO.setAtchFileSn(fileCnt);//첨부파일 순번
				atchfileVO.setAtchFileCours("/freeBoard/"+ uploadFileName);//첨부파일경로
				atchfileVO.setAtchFileNm(multipartFile.getOriginalFilename());//첨부파일 이름
				atchfileVO.setAtchFileTy(multipartFile.getContentType());//첨부파일 유형
				atchfileVO.setRegistId(nttVO.getMberId());//첨부파일 등록자 아이디
				res2 = mapper.uploadFile(atchfileVO);
			}

			if((res + res2)==2){
				result = 1;
			}
		}else {
			result = res;
		}
		//1이면 성공 0이면 실패
		return result;

	}
	//가장 최근 게시물 코드 값 불러오기 Max값에서 +1해줌
	@Override
	public String getNttMaxCode() {
		String res = mapper.getNttMaxCode();
		return res;
	}

	//자유게시판 테이블 데이터 불러오기
	@Override
	public List<NttVO> selectNttList(Map<String, Object> map) {
		List<NttVO>nttVOList = mapper.selectNttList(map);
		return nttVOList;
	}

	//자유게시판 전체 게시물 수 불러오기
	@Override
	public int selectNttCount(Map<String, Object> map) {
		return mapper.selectNttCount(map);
	}

	//자유게시판 상세조회 데이터 가져오기
	@Override
	public NttVO freeBoardDetail(NttVO nttVO) {
		return mapper.freeBoardDetail(nttVO);
	}
	//자유게시판 조회수 증가 디비에 넣기
	@Override
	public int rdCntadd(NttVO nttVO) {
		return mapper.rdCntadd(nttVO);
	}
	///자유게시판 상세조회 해당 게시글 첨부파일 가져오기, //자유게시판 상세조회 해당 게시글 전체 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	@Override
	public List<AtchFileVO> selectAtchList(String nttAtchFileCode) {
		return mapper.selectAtchList(nttAtchFileCode);
	}

	//자유게시판 상세조회 해당 게시글 개별 첨부파일 다운로드를 위한 디비에 저장된 파일 명 가져오기
	@Override
	public AtchFileVO getFileName(AtchFileVO atchFileCode) {
		return mapper.getFileName(atchFileCode);
	}

	//자유게시판 상세조회 삭제
	@Override
	public int deleteFreeBoard(NttVO nttVO) {
		int res = mapper.deleteFreeBoard(nttVO);
		int res2 = mapper.deleteAtchFile(nttVO.getNttAtchFileCode());

		int result = res + res2;

		if((res + res2)==2){
			result = 1;
		}else {
		result = res;
		}
		return result;
	}
	//자유게시판 상세조회 수정
	@Override
	public int updateFreeBoardAjax(NttVO nttVO, AtchFileVO atchFileVO, String[] snArray, List<MultipartFile> uploadList,MemberVO memberVO) {
		int res= 0;
		if(snArray != null) {
			AtchFileVO atchFileVO2 = new AtchFileVO();
			for (int i = 0; i < snArray.length; i++) {
				atchFileVO2.setAtchFileCode(atchFileVO.getAtchFileCode());
				atchFileVO2.setAtchFileSn(Integer.parseInt(snArray[i]) );
				mapper.deleteAtchFile2(atchFileVO2);
			}

			List<AtchFileVO>fileVOList =  mapper.selectAtchList(atchFileVO.getAtchFileCode());
			for (int i = 0; i < fileVOList.size(); i++) {
				Map<String, Object> updateAtchFileSnMap = new HashMap<String, Object>();
				updateAtchFileSnMap.put("atchFileCode", atchFileVO.getAtchFileCode());
				updateAtchFileSnMap.put("orignAtchFileSn", fileVOList.get(i).getAtchFileSn());
				updateAtchFileSnMap.put("atchFileSn", i+1);
				mapper.updateFileSn(updateAtchFileSnMap);
			}
		}

		if (uploadList != null && uploadList.size() != 0 && uploadList.get(0).getSize() > 0) {
			List<AtchFileVO> fileVOList =  mapper.selectAtchList(atchFileVO.getAtchFileCode());
			File fileFolder = new File(uploadFolder + "\\freeBoard\\");
			// D:\\upload\\freeBoard\\이미지
			// 개수만큼 폴더생성
			fileFolder.mkdirs();

			String atchFileCode = "";
			if(fileVOList != null && fileVOList.size() > 0) {
				atchFileCode = atchFileVO.getAtchFileCode();
			}else {
				// 등록할때는 파일 안올리고 수정할 때 처음 올리는 상황
				atchFileCode = mapper.getFreeMaxCode(nttVO);
			}
			AtchFileVO atchfileVO = new AtchFileVO();
			atchfileVO.setAtchFileCode(atchFileCode);//첨부파일 작성자 첨부파일코드

			// ↓시퀀스컬럼의 값을 위한 변수 ↓
			int fileCnt = fileVOList.size();
			// 사용자가 올린 파일 복사
			for (MultipartFile multipartFile : uploadList) {
				String uuid = UUID.randomUUID().toString();

				String uploadFileName = uuid +"_"+ multipartFile.getOriginalFilename();
				// 복사할 파일을 어디에 저장할 지 경로 정하기 ↓↓↓↓↓
				String Filepath = uploadFolder  +"\\freeBoard\\"+ uploadFileName;
				//D:\\upload\\freeBoard\\uuid\\파일이름

				File saveFile = new File(Filepath);

				// 복사한 경로에 이미지 파일 업로드 ↓↓↓↓↓
				try {
					multipartFile.transferTo(saveFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				// (디비에 파일 저장하는 것임)ATACHFILE테이블에 파일 경로 및 컬럼 값 데이터 입력 ↓↓↓↓↓

				multipartFile.getOriginalFilename();

				++fileCnt;
				atchfileVO.setAtchFileSn(fileCnt);//첨부파일 순번
				atchfileVO.setAtchFileCours("/freeBoard/"+ uploadFileName);//첨부파일경로
				atchfileVO.setAtchFileNm(multipartFile.getOriginalFilename());//첨부파일 이름
				atchfileVO.setAtchFileTy(multipartFile.getContentType());//첨부파일 유형
				atchfileVO.setRegistId(memberVO.getMberId());//첨부파일 등록자 아이디
				mapper.uploadFile(atchfileVO);
			}


		}
		res = mapper.updateFreeBoardAjax(nttVO);

		return res;
	}

	//게시물 셀렉트 메서드
	@Override
	public NttVO selectNttVO(NttVO nttVO) {
		return mapper.selectNttVO(nttVO);
	}
	//댓글 등록 메서드
	@Override
	public int createReply(AnswerVO answerVO, MemberVO memberVO) {
		int res = 0;
		int squ = mapper.getMaxAnswerCode();
		//작성자의 반 코드 가져오기
		String schulCode = commonMapper.getSchulCode(memberVO.getMberId());
		//댓글 VO에 반코드 세팅
		answerVO.setSchulCode(schulCode);
		//댓글 코드에 시퀀스 세팅
		answerVO.setAnswerCode(String.valueOf(squ));
		res = mapper.createReply(answerVO);
		return res;
	}

	//댓글 조회 메서드
	@Override
	public List<AnswerVO> selectReply(NttVO nttVO) {
		return mapper.selectReply(nttVO);
	}

	//댓글 삭제 메서드
	@Override
	public int deleteReply(AnswerVO answerVO) {
		return mapper.deleteReply(answerVO);
	}

	//설문 게시판 등록 메서드
		@SuppressWarnings("unchecked")
		@Override
		public int surveyCreateAjax(Map<String, Object> map) {

			//758109210076 (담임 아이디)
			boolean chk = false;
			int res = 0;
			try {

				//설문/투표테이블 맥스값 가져오기
				int voteQustnrCode = mapper.getMaxSurveyVoteCode();

				log.info("map ->" + map);
				//투표&설문설정VO
				VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();

				// VOTE_ND_QUSTNR INSERT
				// PK 들고와야함

				// 설문지 이름 VO에 세팅
				voteNdQustnrVO.setVoteQustnrNm(String.valueOf(map.get("voteQustnrNm")));
				// 설문지 목적 및 내용
				voteNdQustnrVO.setVoteQustnrCn(String.valueOf(map.get("voteQustnrCn")));

				//설문 시작 날짜 변환
				String begDate = map.get("voteQustnrBeginDt").toString();
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				Date format1 = sdf1.parse(begDate);
				//설문 시작 날짜 VO세팅
				voteNdQustnrVO.setVoteQustnrBeginDt(format1);

				//설문 종료 날짜 변환
				String endDate = map.get("voteQustnrEndDt").toString();
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
				Date format2 = sdf2.parse(endDate);
				//설문 종료 날짜 VO세팅
				voteNdQustnrVO.setVoteQustnrEndDt(format2);

				//설문 공통 코드 VO세팅
				voteNdQustnrVO.setCmmnDetailCode("A08003");

				//설문 코드 VO세팅(시퀀스로관리)
				voteNdQustnrVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));

				//설문 반코드 VO세팅
				voteNdQustnrVO.setClasCode(map.get("clasCode").toString());

				//설문 학교코드 VO세팅
				voteNdQustnrVO.setSchulCode(map.get("schulCode").toString());

				//설문 담임교사 VO세팅
				voteNdQustnrVO.setMberId(map.get("mberId").toString());

				//설문 인서트 mapper
				res = mapper.insertQust(voteNdQustnrVO);

				//성공여부
				if(res>=1) {
					chk = true;
				}

				//세부항목순번
				int cnt = 0;
				List<Map<String, Object>> qustnrList = (List<Map<String, Object>>) map.get("qustnrList");
				for(Map<String, Object> tempMap : qustnrList) {

					//설문 항목 VO 생성(설문지 질문)
					VoteQustnrIemVO voteQustnrIemVO = new VoteQustnrIemVO();
					//설문 항목 순번 (질문 번호) VO세팅
					voteQustnrIemVO.setVoteIemSn(++cnt);
					//설문 항목의 설문 코드 VO세팅
					voteQustnrIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
					//설문의 항목 내용 (질문 내용) VO세팅
					voteQustnrIemVO.setVoteIemCn(String.valueOf(tempMap.get("voteIemCn")));


					//질문 VOTE_QUSTNR_IEM INSERT
					// pk 들고와야함
					//객관식 타입에만 voteDetailIemCn에 값이 있음
					if(tempMap.get("voteDetailIemCn") != null) {
						//객관식 구분 값 "M" 설문 항목 테이블에 VO세팅
						voteQustnrIemVO.setVoteQustnrType("M");
						//설문 세부 항목 리스트 Map에서 꺼내기
						res = mapper.insertQustIem(voteQustnrIemVO);

						//성공여부
						if(res >= 1) {
							chk = true;
						}

						List<String> voteDetailIemCnList = (List<String>) tempMap.get("voteDetailIemCn");
						//설문 세부 항목 VO 생성
						VoteQustnrDetailIemVO voteQustnrDetailIemVO = new VoteQustnrDetailIemVO();
						//설문 세부 항목 길이 만큼 반복문 돌림
						int detailCnt = 0;
						for(String str : voteDetailIemCnList) {
							// str : 보기
							// VOTE_QUSTNR_DETAIL_IEM insert
							//설문 세부 항목 순번 VO세팅
							voteQustnrDetailIemVO.setVoteDetailIemSn(++detailCnt);
							//설문 항목 순번 VO세팅
							voteQustnrDetailIemVO.setVoteIemSn(cnt);
							//설문  코드 VO세팅
							voteQustnrDetailIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
							//설문 세부 항목 내용 VO 세팅
							voteQustnrDetailIemVO.setVoteDetailIemCn(str);

							res = mapper.insertQustDetail(voteQustnrDetailIemVO);
						}
					}else {
						voteQustnrIemVO.setVoteQustnrType("S");
						res =  mapper.insertQustIem(voteQustnrIemVO);
						//성공여부
						if(res >= 1) {
							chk = true;
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			if(chk) {
				res = 1;
			}
			return res;
		}



	//설문조사 리스트 가져오기
	@Override
	public List<VoteNdQustnrVO> surveyList(Map<String, Object> map) {
		return mapper.surveyList(map);
	}
	//설문조사 max값 가져오기
	@Override
	public int getTotalSurvey(Map<String, Object> surveyMap) {
		return mapper.getTotalSurvey(surveyMap);
	}
	//설문조사 상세조회
	@Override
	public VoteNdQustnrVO surveyDetailView(String voteQustnrCode) {
		return mapper.surveyDetailView(voteQustnrCode);
	}
	//설문 질문 조회
	@Override
	public List<VoteQustnrIemVO> iemVOList(String voteQustnrCode) {
		return mapper.iemVOList(voteQustnrCode);
	}
	//설문 질문 보기 조회
	@Override
	public List<VoteQustnrDetailIemVO> detailVOList(String voteQustnrCode) {
		return mapper.detailVOList(voteQustnrCode);
	}
	//설문 학교 조회
	@Override
	public SchulVO getSchulNm(String clasCode) {
		return mapper.getSchulNm(clasCode);
	}
	//사용자가 입력한 설문 답변 등록
	@SuppressWarnings("unchecked")
	@Override
	public int surbeyRegistrationAjax(Map<String, Object> data) {
		//data에서 문제와 문제답변내용 리스트 꺼내서 리스트에 담기
		List<Map<String, Object>> QVList = (List<Map<String, Object>>) data.get("QVList");

		log.info("QVList값-> "+ QVList);

		int res = 0;
		//해당 리스트를 사용해서 vo에 데이터 값 넣기
		for (int i = 0; i < QVList.size(); i++) {
			IemRspnsVO iemRspnsVO = new IemRspnsVO();
			iemRspnsVO.setVoteIemSn(Integer.valueOf(String.valueOf(QVList.get(i).get("voteIemSn"))));
			iemRspnsVO.setQuesRspnsCn(String.valueOf(QVList.get(i).get("voteDetailIemCn")));
			iemRspnsVO.setMberId(String.valueOf(data.get("mberId")));
			iemRspnsVO.setClasCode(String.valueOf(data.get("clasCode")));
			iemRspnsVO.setVoteQustnrCode(String.valueOf(data.get("voteQustnrCode")));
			res = mapper.surbeyRegistrationAjax(iemRspnsVO);
		}

		int result = 0;
		if(res > 0) {
			result = 1;
		}

		return result;
	}
	//설문 참여 여부 확인
	@Override
	public int survayChk(VoteNdQustnrVO voteNdQustnrVO) {
		int res = mapper.survayChk(voteNdQustnrVO);
		int result = 0;
		if(res > 0) {
			result = 1;
		}
		return result;
	}
	//설문 수정 폼 등록
	@Override
	public int surveyUpdateAjax(Map<String, Object> map) throws ParseException {
		//기존 질문/보기 내용 삭제 (사용자가 수정하면서 질문의 개수나 보기의 개수를 수정했을 수 있으므로 기존 정보 먼저 삭제)
		log.info("수정버튼 눌렀을 때 가져온 데이터 map-> " + map);
		String voteQustnrCode = String.valueOf(map.get("voteQustnrCode"));


		int res = mapper.surveyDelDetail(voteQustnrCode);
		int res2 = mapper.surveyDelQustustion(voteQustnrCode);

		int res3 = res + res2;//질문과 보기가 모두 삭제되었으면 0보다 큰 숫자

		VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();
		//update할 설문 정보 vo세팅
		voteNdQustnrVO.setVoteQustnrCode(voteQustnrCode);
		voteNdQustnrVO.setVoteQustnrNm(String.valueOf(map.get("voteQustnrNm")));
		voteNdQustnrVO.setVoteQustnrCn(String.valueOf(map.get("voteQustnrCn")));
		//설문 시작 날짜 변환
		String begDate = map.get("voteQustnrBeginDt").toString();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		Date format1 = sdf1.parse(begDate);
		//설문 시작 날짜 VO세팅
		voteNdQustnrVO.setVoteQustnrBeginDt(format1);

		//설문 종료 날짜 변환
		String endDate = map.get("voteQustnrEndDt").toString();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		Date format2 = sdf2.parse(endDate);
		//설문 종료 날짜 VO세팅
		voteNdQustnrVO.setVoteQustnrEndDt(format2);
		int result = 0;
		int updateResult = 0;
		int res4 = 0;
		int res5 = 0;
		boolean chk = false;
		//질문 보기 삭제가 완료되면 다시 질문,보기 인서트/ 설문설정 업데이트
		if(res3 > 0){
			result = mapper.surveyUpdateAjax(voteNdQustnrVO);//설문설정 업데이트
			//질문,보기 인서트
			//세부항목순번
			int cnt = 0;
			List<Map<String, Object>> qustnrList = (List<Map<String, Object>>) map.get("qustnrList");
			for(Map<String, Object> tempMap : qustnrList) {
				//설문 항목 VO 생성(설문지 질문)
				VoteQustnrIemVO voteQustnrIemVO = new VoteQustnrIemVO();
				//설문 항목 순번 (질문 번호) VO세팅
				voteQustnrIemVO.setVoteIemSn(++cnt);
				//설문 항목의 설문 코드 VO세팅
				voteQustnrIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
				//설문의 항목 내용 (질문 내용) VO세팅
				voteQustnrIemVO.setVoteIemCn(String.valueOf(tempMap.get("voteIemCn")));


				//질문 VOTE_QUSTNR_IEM INSERT
				// pk 들고와야함
				//객관식 타입에만 voteDetailIemCn에 값이 있음
				if(tempMap.get("voteDetailIemCn") != null) {
					//객관식 구분 값 "M" 설문 항목 테이블에 VO세팅
					voteQustnrIemVO.setVoteQustnrType("M");
					//설문 세부 항목 리스트 Map에서 꺼내기
					res = mapper.insertQustIem(voteQustnrIemVO);

					List<String> voteDetailIemCnList = (List<String>) tempMap.get("voteDetailIemCn");
					//설문 세부 항목 VO 생성
					VoteQustnrDetailIemVO voteQustnrDetailIemVO = new VoteQustnrDetailIemVO();
					//설문 세부 항목 길이 만큼 반복문 돌림
					int detailCnt = 0;
					for(String str : voteDetailIemCnList) {
						// str : 보기
						// VOTE_QUSTNR_DETAIL_IEM insert
						//설문 세부 항목 순번 VO세팅
						voteQustnrDetailIemVO.setVoteDetailIemSn(++detailCnt);
						//설문 항목 순번 VO세팅
						voteQustnrDetailIemVO.setVoteIemSn(cnt);
						//설문  코드 VO세팅
						voteQustnrDetailIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
						//설문 세부 항목 내용 VO 세팅
						voteQustnrDetailIemVO.setVoteDetailIemCn(str);

						res4 = mapper.insertQustDetail(voteQustnrDetailIemVO);
					}
				}else {
					voteQustnrIemVO.setVoteQustnrType("S");
					res5 =  mapper.insertQustIem(voteQustnrIemVO);
				}
			}
		}

			res5 = 1;

		return res5;
	}
	//설문 응답 유무 확인
	@Override
	public int answerChk(String voteQustnrCode) {
		int res = mapper.answerChk(voteQustnrCode);
		return res;
	}
	//설문 삭제
	@Override
	public int surveyDeleteAjax(String data) {
		//해당 설문의 사용자 응답 테이블 데이터 삭제
		mapper.deleteIemRspns(data);
		//해당 설문의 보기 테이블 데이터 삭제
		mapper.deleteQustnDetail(data);
		int result = 0;
		//해당 설문의 질문 테이블 데이터 삭제
		int res3 = mapper.deleteQustnIem(data);
		//해당 설문의 설문 설정 테이블 데이터 삭제
		int res4 = mapper.deleteVoteNdQustnr(data);
		//정상적으로 삭제가 되었으면 반환값 1
		if(res3 > 0 && res4 > 0){
			result = 1;
		}

		return result;
	}
	//투표 생성
	@Override
	public int voteCreateAjax(Map<String, Object> map) {
		log.info("서비스 임플에서 map 데이터 -> "+ map);

		//758109210076 (담임 아이디)
		boolean chk = false;
		int res = 0;
		try {

			//설문/투표테이블 맥스값 가져오기
			int voteQustnrCode = mapper.getMaxSurveyVoteCode();

			log.info("map ->" + map);
			//투표&설문설정VO
			VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();

			// VOTE_ND_QUSTNR INSERT
			// PK 들고와야함

			// 투표 이름 VO에 세팅
			voteNdQustnrVO.setVoteQustnrNm(String.valueOf(map.get("voteQustnrNm")));
			// 투표 목적 및 내용
			voteNdQustnrVO.setVoteQustnrCn(String.valueOf(map.get("voteQustnrCn")));

			// 투표 시작 날짜 변환
			String begDate = map.get("voteQustnrBeginDt").toString();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			Date format1 = sdf1.parse(begDate);
			// 투표 시작 날짜 VO세팅
			voteNdQustnrVO.setVoteQustnrBeginDt(format1);

			// 투표 종료 날짜 변환
			String endDate = map.get("voteQustnrEndDt").toString();
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			Date format2 = sdf2.parse(endDate);
			// 투표 종료 날짜 VO세팅
			voteNdQustnrVO.setVoteQustnrEndDt(format2);

			// 투표 공통 코드 VO세팅
			voteNdQustnrVO.setCmmnDetailCode("A08004");

			// 투표 코드 VO세팅(시퀀스로관리)
			voteNdQustnrVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));

			// 투표 반코드 VO세팅
			voteNdQustnrVO.setClasCode(map.get("clasCode").toString());

			// 투표 학교코드 VO세팅
			voteNdQustnrVO.setSchulCode(map.get("schulCode").toString());

			// 투표 담임교사 VO세팅
			voteNdQustnrVO.setMberId(map.get("mberId").toString());

			// 투표 인서트 mapper
			res = mapper.insertQust(voteNdQustnrVO);

			//성공여부
			if(res>=1) {
				chk = true;
			}

			//세부항목순번
			int cnt = 0;
			List<Map<String, Object>> qustnrList = (List<Map<String, Object>>) map.get("qustnrList");
			for(Map<String, Object> tempMap : qustnrList) {

				// 투표 항목 VO 생성(투표 주제)
				VoteQustnrIemVO voteQustnrIemVO = new VoteQustnrIemVO();
				// 투표 항목 순번 (투표 항목 번호) VO세팅
				voteQustnrIemVO.setVoteIemSn(++cnt);
				// 투표 항목 투표 코드 VO세팅
				voteQustnrIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
				// 투표 항목 내용 (항목 내용) VO세팅
				voteQustnrIemVO.setVoteIemCn(String.valueOf(tempMap.get("voteIemCn")));

				//항목 VOTE_QUSTNR_IEM INSERT
				// pk 들고와야함
				if(tempMap.get("voteDetailIemCn") != null) {
					//투표 구분 값
					voteQustnrIemVO.setVoteQustnrType("V");
					//설문 세부 항목 리스트 Map에서 꺼내기
					res = mapper.insertQustIem(voteQustnrIemVO);

					//성공여부
					if(res >= 1) {
						chk = true;
					}

					List<String> voteDetailIemCnList = (List<String>) tempMap.get("voteDetailIemCn");
					//설문 세부 항목 VO 생성
					VoteQustnrDetailIemVO voteQustnrDetailIemVO = new VoteQustnrDetailIemVO();
					//설문 세부 항목 길이 만큼 반복문 돌림
					int detailCnt = 0;
					for(String str : voteDetailIemCnList) {
						// str : 보기
						// VOTE_QUSTNR_DETAIL_IEM insert
						//설문 세부 항목 순번 VO세팅
						voteQustnrDetailIemVO.setVoteDetailIemSn(++detailCnt);
						//설문 항목 순번 VO세팅
						voteQustnrDetailIemVO.setVoteIemSn(cnt);
						//설문  코드 VO세팅
						voteQustnrDetailIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
						//설문 세부 항목 내용 VO 세팅
						voteQustnrDetailIemVO.setVoteDetailIemCn(str);

						res = mapper.insertQustDetail(voteQustnrDetailIemVO);
						chk = true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(chk) {
			res = 1;
		}
		return res;
	}
	@Override
	public int voteUpdateAjax(Map<String, Object> map) throws ParseException {
		String voteQustnrCode = String.valueOf(map.get("voteQustnrCode"));
		int res = mapper.surveyDelDetail(voteQustnrCode);
		int res2 = mapper.surveyDelQustustion(voteQustnrCode);
		int res3 = res + res2;//질문과 보기가 모두 삭제되었으면 0보다 큰 숫자
		VoteNdQustnrVO voteNdQustnrVO = new VoteNdQustnrVO();
		//update할 투표 정보 vo세팅
		voteNdQustnrVO.setVoteQustnrCode(voteQustnrCode);
		voteNdQustnrVO.setVoteQustnrNm(String.valueOf(map.get("voteQustnrNm")));
		voteNdQustnrVO.setVoteQustnrCn(String.valueOf(map.get("voteQustnrCn")));
		//설문 시작 날짜 변환
		String begDate = map.get("voteQustnrBeginDt").toString();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		Date format1 = sdf1.parse(begDate);
		//설문 시작 날짜 VO세팅
		voteNdQustnrVO.setVoteQustnrBeginDt(format1);

		//설문 종료 날짜 변환
		String endDate = map.get("voteQustnrEndDt").toString();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		Date format2 = sdf2.parse(endDate);
		//설문 종료 날짜 VO세팅
		voteNdQustnrVO.setVoteQustnrEndDt(format2);
		int result = 0;
		int updateResult = 0;
		int res4 = 0;
		int res5 = 0;
		boolean chk = false;

		//질문 보기 삭제가 완료되면 다시 질문,보기 인서트/ 설문설정 업데이트
				if(res3 > 0){
					result = mapper.surveyUpdateAjax(voteNdQustnrVO);//설문설정 업데이트
					//질문,보기 인서트
					//세부항목순번
					int cnt = 0;
					List<Map<String, Object>> qustnrList = (List<Map<String, Object>>) map.get("qustnrList");
					for(Map<String, Object> tempMap : qustnrList) {
						//설문 항목 VO 생성(설문지 질문)
						VoteQustnrIemVO voteQustnrIemVO = new VoteQustnrIemVO();
						//설문 항목 순번 (질문 번호) VO세팅
						voteQustnrIemVO.setVoteIemSn(++cnt);
						//설문 항목의 설문 코드 VO세팅
						voteQustnrIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
						//설문의 항목 내용 (질문 내용) VO세팅
						voteQustnrIemVO.setVoteIemCn(String.valueOf(tempMap.get("voteIemCn")));


						//질문 VOTE_QUSTNR_IEM INSERT
						// pk 들고와야함
						//객관식 타입에만 voteDetailIemCn에 값이 있음
						if(tempMap.get("voteDetailIemCn") != null) {
							//객관식 구분 값 "M" 설문 항목 테이블에 VO세팅
							voteQustnrIemVO.setVoteQustnrType("V");
							//설문 세부 항목 리스트 Map에서 꺼내기
							res = mapper.insertQustIem(voteQustnrIemVO);

							List<String> voteDetailIemCnList = (List<String>) tempMap.get("voteDetailIemCn");
							//설문 세부 항목 VO 생성
							VoteQustnrDetailIemVO voteQustnrDetailIemVO = new VoteQustnrDetailIemVO();
							//설문 세부 항목 길이 만큼 반복문 돌림
							int detailCnt = 0;
							for(String str : voteDetailIemCnList) {
								// str : 보기
								// VOTE_QUSTNR_DETAIL_IEM insert
								//설문 세부 항목 순번 VO세팅
								voteQustnrDetailIemVO.setVoteDetailIemSn(++detailCnt);
								//설문 항목 순번 VO세팅
								voteQustnrDetailIemVO.setVoteIemSn(cnt);
								//설문  코드 VO세팅
								voteQustnrDetailIemVO.setVoteQustnrCode(String.valueOf(voteQustnrCode));
								//설문 세부 항목 내용 VO 세팅
								voteQustnrDetailIemVO.setVoteDetailIemCn(str);
								res4 = mapper.insertQustDetail(voteQustnrDetailIemVO);
							}
							if(res4 > 0){
								res5 = 1;
							}
						}
					}
				}

		return res5;
	}
	//최근에 마감된 투표 가져오기
	@Override
	public List<Map<String, Object>> recentVotes() {
		List<Map<String, Object>> voteNdQustnrVOMapList = mapper.recentVotes();
		return voteNdQustnrVOMapList;
	}
	//최근에 마감된 투표값 정보
	@Override
	public List<Map<String, Object>> getVoteInfo(Map<String, Object> parameterMap) {
		List<Map<String, Object>> VoteQustnrIemVOMapList = mapper.getVoteInfo(parameterMap);
		return VoteQustnrIemVOMapList;
	}
	//응시/미응시 인원 수 가져오기
	@Override
	public List<Map<String, Object>> getResponseMember(Map<String, Object> parameterMap) {
		 List<Map<String, Object>> getResponseMember = mapper.getResponseMember(parameterMap);
		return getResponseMember;
	}

	@Override
	public List<HashMap<Integer, String>> surveyExcelRegistration(MultipartFile upload) {
		log.info("엑셀파일 사이즈 ->" + upload.getSize());
		log.info("엑셀파일 이름->" + upload.getOriginalFilename());

		HashMap<Integer, String> excelMap = new HashMap<Integer, String>();// 값을 담을 변수
		List<HashMap<Integer, String>> excelList = new ArrayList<HashMap<Integer,String>>();

		try {
			int rowIndex = 0;
			int columIndex = 0;

			DecimalFormat df = new DecimalFormat();
			//(xls인 경우)
			if(upload.getOriginalFilename().equals("xls")) {
				//시트 읽기
				HSSFWorkbook workBook = new HSSFWorkbook(upload.getInputStream());
				HSSFSheet sheet = workBook.getSheetAt(0);
				//행의 수 체크
				int rows = sheet.getPhysicalNumberOfRows();
				for (rowIndex = 4; rowIndex < rows; rowIndex++) {
					//행 읽기
					HSSFRow row = sheet.getRow(rowIndex);
					if(row != null) {
						//셀의 수 체크
						int cells = row.getPhysicalNumberOfCells();
						for (columIndex = 0; columIndex <= cells-1; columIndex++) {
							HSSFCell cell = row.getCell(columIndex);
							String value = "";
							if(cell == null) {
								excelMap.put(columIndex, value);
								continue;
							}else {
								switch (cell.getCellType()) {
								case FORMULA:
									value = cell.getCellFormula();
									break;
								case NUMERIC:
									value = String.valueOf(cell.getNumericCellValue());
									break;
								case STRING:
									value = cell.getStringCellValue();
									break;
								case BLANK:
									value = String.valueOf(cell.getBooleanCellValue());
									break;
								case ERROR:
									value = String.valueOf(cell.getErrorCellValue());
								default:
									value = cell.getStringCellValue();
									break;
								}
							}
							excelMap.put(columIndex, value);
						}
						excelList.add(excelMap);
						excelMap = new HashMap<Integer, String>();
					}
				}
			}else {//(xlsx인 경우)
//				FileInputStream file = new FileInputStream(upload.getInputStream().ge);
				XSSFWorkbook workBook = new XSSFWorkbook(upload.getInputStream());
				XSSFSheet sheet = workBook.getSheetAt(0);
				//행의 수 체크
				int rows = sheet.getPhysicalNumberOfRows();
				for (rowIndex = 4; rowIndex < rows; rowIndex++) {
					//행을 읽습니다.
					XSSFRow row = sheet.getRow(rowIndex);
					if(row != null) {
						//셀의 수를 체크해줍니다.
						int cells = row.getPhysicalNumberOfCells();
						for (columIndex = 0; columIndex <= cells-1; columIndex++) {
							//셀 값을 확인합니다.
							XSSFCell cell = row.getCell(columIndex);
							String value = "";
							if(cell == null) {
								excelMap.put(columIndex, value);
								continue;
							}else {
								//타입 별로 value에 값을 넣어줍니다.
								switch (cell.getCellType()) {
								case FORMULA:
									value = cell.getCellFormula();
									break;
								case NUMERIC:
									value = String.valueOf(cell.getNumericCellValue());
									break;
								case STRING:
									value = cell.getStringCellValue();
									break;
								case BLANK:
									value = String.valueOf(cell.getBooleanCellValue());
									break;
								case ERROR:
									value = String.valueOf(cell.getErrorCellValue());
								default:
									value = cell.getStringCellValue();
									break;
								}
							}
							excelMap.put(columIndex, value);

							System.out.println(rowIndex +" 행 : " + columIndex +"번째의 값은 : " + value);

							log.info(" excelMap 값 -> " + excelMap);
						}
						excelList.add(excelMap);
						excelMap = new HashMap<Integer, String>();
					}
				}
			}


		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("excelList->"+ excelList);


		return excelList;
	}
	@Override
	public int updateReply(AnswerVO answerVO) {
		return mapper.updateReply(answerVO);
	}


}
