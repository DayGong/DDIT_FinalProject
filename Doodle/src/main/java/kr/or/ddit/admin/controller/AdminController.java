package kr.or.ddit.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.admin.service.AdminService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.HmpgManageVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SttemntSearchVO;
import kr.or.ddit.vo.SttemntVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Slf4j
@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	/** 관리자 메인 화면으로 이동하는 메서드 */
	@GetMapping("/adminMain")
	public String adminMain() {
		return "admin/adminMain";
	}
	
	/** 신고 게시판 목록으로 이동하는 메서드 */
	@GetMapping("/complaint")
	public String complaint() {
		return "admin/complaintBoardList";
	}
	
	/** 신고 게시판 목록을 출력하는 메서드 */
	@ResponseBody
	@PostMapping("/loadSttemntList")
	public ArticlePage<SttemntSearchVO> loadSttemntList(SttemntSearchVO sttemntSearchVO) {
		ArticlePage<SttemntSearchVO> sttemntSearchVOList = this.adminService.loadSttemntList(sttemntSearchVO);
		log.debug("loadSttemntList Controller sttemntSearchVOList => " + sttemntSearchVOList);
		
		return sttemntSearchVOList;
	}
	
	/** 신고 내용 목록을 불러오는 메서드 */
	@ResponseBody
	@GetMapping("/getComplaintCn")
	public List<CmmnDetailCodeVO> getComplaintCn() {
		List<CmmnDetailCodeVO> complaintCnList = this.adminService.getComplaintCn();
		log.debug("getComplaintCn complaintCnList => " + complaintCnList);
		
		return complaintCnList;
	}
	
	/** 신고 내용을 저장하는 메서드 */
	@ResponseBody
	@PostMapping("/addComplaint")
	public int addComplaint(SttemntVO sttemntVO) {
		int result = this.adminService.addComplaint(sttemntVO);
		log.debug("addComplaint result => " + result);
		
		return result;
	}
	
	/** 상태를 변경하는 메서드 */
	@ResponseBody
	@PostMapping("/updateProcessSttus")
	public int updateProcessSttus(@RequestBody Map<String, Object> map) {
		int result = this.adminService.updateProcessSttus(map);
		log.debug("updateProcessSttus result => " + result);
		
		return result;
	}
	
	/** 관리자 메인 화면에서 신고 게시물 수를 불러오는 메서드 */
	@ResponseBody
	@GetMapping("getComplaintNtt")
	public int getComplaintNtt() {
		int result = this.adminService.getComplaintNtt();
//		log.debug("getComplaintNtt result => " + result);
		
		return result;
	}
	
	/** 오늘 접수된 신고 게시물 수를 불러오는 메서드 */
	@ResponseBody
	@GetMapping("/getTodayComplaintNtt")
	public int getTodayComplaintNtt() {
		int result = this.adminService.getTodayComplaintNtt();
//		log.debug("getTodayComplaintNtt result => " + result);
		
		return result;
	}
	
	/** 미확인 신고 게시물 수를 불러오는 메서드 */
	@ResponseBody
	@GetMapping("/getUncnfrmComplaintNtt")
	public int getUncnfrmComplaintNtt() {
		int result = this.adminService.getUncnfrmComplaintNtt();
//		log.debug("getUncnfrmComplaintNtt result => " + result);
		
		return result;
	}
	
	/** 이상 없음 처리된 게시물 수를 불러오는 메서드 */
	@ResponseBody
	@GetMapping("/getNoProblemComplaintNtt")
	public int getNoProblemComplaintNtt() {
		int result = this.adminService.getNoProblemComplaintNtt();
//		log.debug("getNoProblemComplaintNtt result => " + result);
		
		return result;
	}
	
	/** 정지 처리된 게시물 수를 불러오는 메서드 */
	@ResponseBody
	@GetMapping("/getStopComplaintNtt")
	public int getStopComplaintNtt() {
		int result = this.adminService.getStopComplaintNtt();
//		log.debug("getStopComplaintNtt result => " + result);
		
		return result;
	}
	
	/** 브라우저 수를 구하는 메서드 */
	@ResponseBody
	@GetMapping("/getHmpgBrwsrCo")
	public HmpgManageVO getHmpgBrwsrCo() {
		HmpgManageVO hmpgManageVO = this.adminService.getHmpgBrwsrCo();
		log.debug("getHmpgBrwsrCo hmpgManageVO => " + hmpgManageVO);
		
		return hmpgManageVO;
	}
	
	/** 총 방문자 수를 구하는 메서드 */
	@ResponseBody
	@GetMapping("/getTotalVisitrCo")
	public int getTotalVisitrCo() {
		int visitrCo = this.adminService.getTotalVisitrCo();
		log.debug("getTotalVisitrCo visitrCo => " + visitrCo);
		
		return visitrCo;
	}
	
	/** 오늘 로그인한 회원 수를 구하는 메서드 */
	@ResponseBody
	@GetMapping("/getTodayLoginCo")
	public int getTodayLoginCo() {
		int loginCo = this.adminService.getTodayLoginCo();
		log.debug("getTodayLoginCo loginCo => " + loginCo);
		
		return loginCo;
	}
	
	/** 전날과 비교해서 방문자 수와 회원가입한 회원 수를 조회하는 메서드 */
	@ResponseBody
	@GetMapping("/getCmprBfeCo")
	public HmpgManageVO getCmprBfeCo() {
		HmpgManageVO hmpgManageVO = this.adminService.getCmprBfeCo();
		log.debug("getCmprBfeCo hmpgManageVO => " + hmpgManageVO);
		
		return hmpgManageVO;
	}
	
	/** 게시물 테이블을 조회수 내림차순으로 가져오는 메서드 */
	@ResponseBody
	@GetMapping("/getNttList")
	public List<NttVO> getNttList() {
		List<NttVO> nttVOList = this.adminService.getNttList();
		log.debug("getNttList nttVOList => " + nttVOList);
		
		return nttVOList;
	}
	
	/** 차트에 뿌려질 일주일 방문객 수 가져오는 메서드 */
	@ResponseBody
	@GetMapping("/setVisitrChart")
	public List<HmpgManageVO> setVisitrChart() {
		List<HmpgManageVO> HmpgManageVOList = this.adminService.setVisitrChart();
		log.debug("setVisitrChart HmpgManageVOList => " + HmpgManageVOList);
		
		return HmpgManageVOList;
	}
}
