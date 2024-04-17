package kr.or.ddit.school.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.school.service.SchoolService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.EdcInfoNttVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SchafsSchdulVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/school")
@Slf4j
@Controller
public class SchoolController {
	
	@Autowired
	SchoolService schoolService;
	
	@Autowired
	String uploadFolder;
	
	//학교 공지사항 게시판 목록
	@GetMapping("/notice")
	public String notice() {
		return "school/notice";
	}

	//급식
	@GetMapping("/meal")
	public String meal() {
		return "school/meal";
	}
	
	//시간표
	@GetMapping("/schedule")
	public String schedule() {
		return "school/schedule";
	}
	
	//학생(전교생) 관리 
	@GetMapping("/studentsManage")
	public String studentsManage() {
		return "school/studentsManage";
	}
	
	//학급 클래스 목록
	@GetMapping("/classList")
	public String classList() {                                
		return "school/classList";
	}
	
	/** 학교 목록 찾기 메인 화면 */
	@GetMapping("/schoolList")
	public String schoolSearchMain() {
		return "school/schoolList";
	}
	
	/** 학교 목록 불러오기 */
	@ResponseBody
	@PostMapping("/schoolListAjax")
	public ArticlePage<SchulVO> schoolListAjax(@RequestBody(required = false) Map<String, Object> map) {
		ArticlePage<SchulVO> data = this.schoolService.schoolListAjax(map);
		
		return data;
	}
	
	//자료실 게시판 ----------------------------------------------------------
	//자료실 게시판 조회
	@GetMapping("/dataRoom")
	public String dataRoom(HttpServletRequest request, Model model) {
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		// 세션에 저장된 클래스 정보 가져오기
		log.info("SCHOOL_INFO >> " + schulVO);
		model.addAttribute("schulCode", schulVO.getSchulCode());
      return "school/dataRoom";
   }
	
   @ResponseBody
   @PostMapping("/dataRoomAjax")
   public ArticlePage<NttVO> dataRoomAjax(@RequestBody(required=false) Map<String,Object> map) {
      //map : null 또는 map : {"keyword":"신용"}
      log.info("map!!! : " + map);
      // 키값 설정
      String schulCode = (String)map.get("schulCode");
      
      List<NttVO> nttVOList = this.schoolService.dataRoom(map);
      log.info("list->studVOList : " + nttVOList);      
      String currentPage = map.get("currentPage").toString();
      
      String keyword = "";
      if (map.get("keyword") == null) {
    	  keyword = "";
      } else {
    	  keyword = map.get("keyword").toString();
      }
      log.info("dataRoomAjax->keyword : " + keyword);
      
      //총 갯수
      int size = 10;
      int total = this.schoolService.dataRoomGetTotal(map);
      log.info("list->total : " + total);
      
      log.info("dataRoomAjax->keyword : " + keyword);
      
      ArticlePage<NttVO> data = new ArticlePage<NttVO>(total, Integer.parseInt(currentPage), size, nttVOList, keyword, schulCode);
      String url = "/school/dataRoom";
      data.setUrl(url);
      
      return data;
   }
   
	 //자료실 게시판 글 등록 폼 출력 메서드
 	@GetMapping("/dataRoomCreate")
 	public String dataRoomCreate(HttpServletRequest request, Model model) {
 		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
 		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
 		model.addAttribute("schulCode", schulVO.getSchulCode());
 		return "school/dataRoomCreate";
 	}
	
 	//자료실 글 등록 실행 메서드
	@ResponseBody
	@PostMapping("/dataRoomCreateAjax")
	public String dataRoomCreateAjax(HttpServletRequest request, NttVO nttVO, @RequestParam("upload") List<MultipartFile> uploadList) {
		// 로그인한 회원의 세션 정보 가져옴
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
		int cnt = schoolService.dataRoomCreateAjax(memberVO, nttVO, uploadList, schulVO);
		if(cnt>0) { //성공
			return nttVO.getNttCode();
		}else {
			return "fail";
		}
	}
   
    //자료실 게시판 상세조회
    @GetMapping("/dataRoomDetail")
  	public String dataRoomDetail(NttVO nttVO, HttpServletRequest request ,Model model) {
    	SchulVO schulVO = (SchulVO) request.getSession().getAttribute("SCHOOL_INFO");
  	
    	log.info("nttVO!!!!!!!!!"+nttVO);
  		nttVO = this.schoolService.dataRoomDetail(nttVO);
  		//첨부파일 가져오기
  		List<AtchFileVO> atchFileVOList = schoolService.selectAtchList(nttVO.getNttAtchFileCode());
  		log.info("detail->atchFileVOList" + atchFileVOList);
  		model.addAttribute("nttVO", nttVO);
  		
  		//세션으로 게시글 작성자와 동일한지 정보확인
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("atchFileVOList", atchFileVOList);
		model.addAttribute("schulCode", schulVO.getSchulCode());
  		return "school/dataRoomDetail";
  	}
    
    // 자유게시판 첨부파일 다운로드 기능 구현
 	@PostMapping("/download")
 	public void downloadFile(AtchFileVO atchFileVO, HttpServletResponse response) throws Exception {

 		try {
 			atchFileVO = schoolService.getFileName(atchFileVO);

 			//파일이 실제로 업로드 되어있는 파일 경로 지정하기
 			//uploadFolder=>D:\\upload 디비에 저장된 파일 이름(\\freeBoard\\가 저장되어있음)
 			String filePath = uploadFolder;

 			uploadFolder.replace("\\", "/");

 			//경로와 파일 명으로 파일 객체 생성
 			File dFile = new File(filePath,atchFileVO.getAtchFileCours());
//		 				log.info("dFile->" + dFile.toString());
 			//파일 길이 가져오기
 			int size = (int)dFile.length();
//		 				log.info("파일길이 size=>" + size);

 			if(size > 0) {
 				String encodedFilename = "attachment; filename*=" + "UTF-8" + "''" + URLEncoder.encode(atchFileVO.getAtchFileNm(), "UTF-8");
 				response.setContentType("application/octet-stream; charset=utf-8");

 				// Header 설정
 				response.setHeader("Content-Disposition", encodedFilename);

 				// ContentLength 설정
 				response.setContentLength(size);

 				BufferedInputStream in = null;
 				BufferedOutputStream out = null;

 				/* BufferedInputStream
 				 *
 				java.io의 가장 기본 파일 입출력 클래스
 				입력 스트림(통로)을 생성해줌
 				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
 				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
 				*/
 				in = new BufferedInputStream(new FileInputStream(dFile));

 					/* BufferedOutputStream
 				 *
 				java.io의 가장 기본이 되는 파일 입출력 클래스
 				출력 스트림(통로)을 생성해줌
 				사용법은 간단하지만, 버퍼를 사용하지 않기 때문에 느림
 				속도 문제를 해결하기 위해 버퍼를 사용하는 다른 클래스와 같이 쓰는 경우가 많음
 				*/
 				out = new BufferedOutputStream(response.getOutputStream());

 				try {
 						byte[] buffer = new byte[4096];
 						int bytesRead = 0;
 						/*
 						모두 현재 파일 포인터 위치를 기준으로 함 (파일 포인터 앞의 내용은 없는 것처럼 작동)
 						int read() : 1byte씩 내용을 읽어 정수로 반환
 						int read(byte[] b) : 파일 내용을 한번에 모두 읽어서 배열에 저장
 						int read(byte[] b. int off, int len) : 'len'길이만큼만 읽어서 배열의 'off'번째 위치부터 저장
 						*/
 						while ((bytesRead = in .read(buffer)) != -1) {
 							out.write(buffer, 0, bytesRead);
 						}
 						// 버퍼에 남은 내용이 있다면, 모두 파일에 출력
 						out.flush();
 				} finally {
 				 /*
 				 현재 열려 in,out 스트림을 닫음
 				 메모리 누수를 방지하고 다른 곳에서 리소스 사용이 가능하게 만듬
 				 */
 				 in.close();
 				 out.close();
 				}
 			} else {
 				throw new FileNotFoundException("파일이 없습니다.");
 			}
 		} catch (Exception e) {
 			log.info(e.getMessage());
 		}
 	}
    
    
    //게시글 수정 폼 출력
  	@PostMapping("/dataRoomUpdate")
  	public String dataRoomUpdate(NttVO nttVO, AtchFileVO atchFileVO,Model model) {
  			log.info("nttVO 첨부파일 수정할 게시물 코드 : " + atchFileVO.getAtchFileCode());
  			log.info("nttVO 수정할 게시물코드: " + nttVO.getNttCode());
  			log.info("nttVO 수정할 게시물 기존 제목 : " + nttVO.getNttNm());
  			log.info("nttVO 수정할 게시물 기존 내용 " + nttVO.getNttCn());
  		List<AtchFileVO> atchFileVOList = schoolService.selectAtchList(atchFileVO.getAtchFileCode());
  		nttVO = schoolService.selectNttVO(nttVO);
//		  			log.info("수정할 게시물 첨부파일 atchFileVOList->" + atchFileVOList);
  		model.addAttribute("atchFileVOList", atchFileVOList);
  		model.addAttribute("nttVO", nttVO);
  		model.addAttribute("atchFileVO", atchFileVO);

  		return "school/dataRoomUpdate";
  		}
  	
  	@ResponseBody
  	@PostMapping("/dataRoomUpdateAjax")
  	public int dataRoomUpdateAjax (NttVO nttVO, AtchFileVO atchFileVO, String snArr,@RequestParam("upload") List<MultipartFile> uploadList, HttpServletRequest request) {
  		String[] snArray = null;
  		if(snArr != null && !"".equals(snArr)) {
  			snArray = snArr.split(","); // ['4','2']
  		}
  		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
  		int result = schoolService.dataRoomUpdateAjax(nttVO, atchFileVO, snArray,uploadList,memberVO);
  		
  		return result;
  	}
  	
	
	//자료실 게시판 삭제
	@ResponseBody
	@PostMapping("/dataRoomDeleteAjax")
	public int dataRoomDeleteAjax(@RequestBody NttVO nttVO) {
		log.info("dataRoomDeleteAjax->nttVO : " + nttVO);
		
		String nttCode = nttVO.getNttCode();
		
		//nttCode-> 1
		log.info("nttCode-> " + nttVO);
		
		int result = this.schoolService.dataRoomDeleteAjax(nttVO);
		
		log.info("dataRoomDeleteAjax->result : " + result);
		
		return result;
	}
	
	//교육 정보 조회 게시판으로 가는 메서드
	@GetMapping("/eduInfo")
    public String edcInfoList(HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
        return "school/eduInfo";
	}
	
	@ResponseBody
	@PostMapping("/edcInfoListAjax")
	public ArticlePage<EdcInfoNttVO> edcInfoListAjax(@RequestBody Map<String,Object> map) {
//			String size = (String)map.get("size").toString();
//			log.info("size->" +size);
		ArticlePage<EdcInfoNttVO> edcInfoNttVOList = this.schoolService.edcInfoListAjax(map);
		return edcInfoNttVOList;
	}
	
	//교육 정보 인서트 (크롤링)
	@ResponseBody
	@PostMapping("/eduInfoInsertAjax")
	 public int eduInfoInsertAjax(@RequestBody List<Map<String, String>> edcInfoNttVO) {
		log.info("EdcInfoNttVO-->"+edcInfoNttVO);
		//크롤링 해온 거 DB에 insert
		int result = this.schoolService.eduInfoInsertAjax(edcInfoNttVO);
		log.info("인서트 후 result-->"+result);
		return result;
	}
		
}
