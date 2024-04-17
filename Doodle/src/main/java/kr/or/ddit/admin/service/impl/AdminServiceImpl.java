package kr.or.ddit.admin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mapper.AdminMapper;
import kr.or.ddit.admin.service.AdminService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ClasAlbumVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.HmpgManageVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SttemntSearchVO;
import kr.or.ddit.vo.SttemntVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper adminMapper;

	// 신고 게시판 목록을 출력하는 메서드
	@Override
	public ArticlePage<SttemntSearchVO> loadSttemntList(SttemntSearchVO sttemntSearchVO) {
		String keyword = sttemntSearchVO.getKeyword();
		int currentPage = sttemntSearchVO.getCurrentPage();
		int size = sttemntSearchVO.getSize();
		int sttemntTotal = this.adminMapper.getSttemntListTotal(sttemntSearchVO);
		
		log.debug("loadSttemntList ServiceImpl sttemntSearchVO => " + sttemntSearchVO);
		log.debug("loadSttemntList ServiceImpl sttemntTotal => " + sttemntTotal);
		
		List<SttemntSearchVO> sttemntSearchVOList = this.adminMapper.loadSttemntList(sttemntSearchVO);
		log.debug("loadSttemntList ServiceImpl sttemntSearchVOList => " + sttemntSearchVOList);
		
		ArticlePage<SttemntSearchVO> sttemntPage = new ArticlePage<SttemntSearchVO>(currentPage, size, sttemntSearchVOList, keyword, sttemntTotal);
		
		return sttemntPage;
	}

	// 신고 내용 목록을 불러오는 메서드
	@Override
	public List<CmmnDetailCodeVO> getComplaintCn() {
		List<CmmnDetailCodeVO> complaintCnList = this.adminMapper.getComplaintCn();
		
		return complaintCnList;
	}

	// 신고 내용을 저장하는 메서드
	@Override
	public int addComplaint(SttemntVO sttemntVO) {
		
		// 신고된 게시물의 정보를 불러오는 메서드
		ClasAlbumVO clasAlbumVO = this.adminMapper.getClasAlbumInfo(sttemntVO.getNttCode());
		sttemntVO.setClasCode(clasAlbumVO.getClasCode());		// 반 코드
		sttemntVO.setWrterId(clasAlbumVO.getMberId());			// 작성자 아이디
		sttemntVO.setCmmnSttemntProcessSttus("A21001");				// 초기 공통 신고 처리 상태를 미확인으로 설정
		
		log.debug("addComplaint clasAlbumVO => " + clasAlbumVO);
		log.debug("addComplaint sttemntVO => " + sttemntVO);
		
		int result = this.adminMapper.addComplaint(sttemntVO);
		
		return result;
	}

	// 상태를 변경하는 메서드
	@Override
	public int updateProcessSttus(Map<String, Object> map) {
		// 신고 테이블의 신고 게시물 처리 상태를 변경하는 메서드(이상없음, 정지)
		int result = this.adminMapper.updateProcessSttus(map);
		
		// 게시물이 변경되었다면 갤러리 게시물의 신고 상태를 변경 
		if (result > 0) { this.adminMapper.changeTargetComplaintSttus(map); }
		
		return result;
	}

	// 관리자 메인 화면에서 신고 게시물 수를 불러오는 메서드
	@Override
	public int getComplaintNtt() {
		int result = this.adminMapper.getComplaintNtt();
		
		return result;
	}

	// 오늘 접수된 신고 게시물 수를 불러오는 메서드
	@Override
	public int getTodayComplaintNtt() {
		int result = this.adminMapper.getTodayComplaintNtt();
		
		return result;
	}

	// 미확인 신고 게시물 수를 불러오는 메서드
	@Override
	public int getUncnfrmComplaintNtt() {
		int result = this.adminMapper.getUncnfrmComplaintNtt();
		
		return result;
	}

	// 이상 없음 처리된 게시물 수를 불러오는 메서드
	@Override
	public int getNoProblemComplaintNtt() {
		int result = this.adminMapper.getNoProblemComplaintNtt();
		
		return result;
	}

	// 정지 처리된 게시물 수를 불러오는 메서드
	@Override
	public int getStopComplaintNtt() {
		int result = this.adminMapper.getStopComplaintNtt();
		
		return result;
	}

	// 브라우저 수를 구하는 메서드
	@Override
	public HmpgManageVO getHmpgBrwsrCo() {
		HmpgManageVO hmpgManageVO = this.adminMapper.getHmpgBrwsrCo();
		
		return hmpgManageVO;
	}

	// 총 방문자 수를 구하는 메서드
	@Override
	public int getTotalVisitrCo() {
		int visitrCo = this.adminMapper.getTotalVisitrCo();
		
		return visitrCo;
	}
	
	// 오늘 로그인한 회원 수를 구하는 메서드
	@Override
	public int getTodayLoginCo() {
		int loginCo = this.adminMapper.getTodayLoginCo();
		
		return loginCo;
	}

	// 전날과 비교해서 방문자 수와 회원가입한 회원 수를 조회하는 메서드
	@Override
	public HmpgManageVO getCmprBfeCo() {
		HmpgManageVO hmpgManageVO = this.adminMapper.getCmprBfeCo();
		log.debug("getCmprBfeCo hmpgManageVO => ", hmpgManageVO);
		
		return hmpgManageVO;
	}

	// 게시물 테이블을 조회수 내림차순으로 가져오는 메서드
	@Override
	public List<NttVO> getNttList() {
		List<NttVO> nttVOList = this.adminMapper.getNttList();
		
		return nttVOList;
	}

	// 차트에 뿌려질 일주일 방문객 수 가져오는 메서드
	@Override
	public List<HmpgManageVO> setVisitrChart() {
		List<HmpgManageVO> HmpgManageVOList = this.adminMapper.setVisitrChart();
		
		return HmpgManageVOList;
	}

}
