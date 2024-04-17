package kr.or.ddit.admin.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ClasAlbumVO;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.HmpgManageVO;
import kr.or.ddit.vo.NttVO;
import kr.or.ddit.vo.SttemntSearchVO;
import kr.or.ddit.vo.SttemntVO;

public interface AdminMapper {

	// 신고 게시판의 목록 개수를 구하는 메서드
	public int getSttemntListTotal(SttemntSearchVO sttemntSearchVO);

	// 신고 게시판의 목록을 가져오는 메서드
	public List<SttemntSearchVO> loadSttemntList(SttemntSearchVO sttemntSearchVO);

	// 신고 내용 목록을 불러오는 메서드
	public List<CmmnDetailCodeVO> getComplaintCn();

	// 신고된 게시물의 정보를 불러오는 메서드(반 앨범인 경우)
	public ClasAlbumVO getClasAlbumInfo(String nttCode);

	// 게시물의 공통 신고 상태 명을 불러오는 메서드
	public String getCmmnSttemntCn(String string);

	// 신고 게시물에 내용을 저장하는 메서드
	public int addComplaint(SttemntVO sttemntVO);

	// 상태를 변경하는 메서드
	public int updateProcessSttus(Map<String, Object> map);

	// 게시물이 변경되었다면 갤러리 게시물의 신고 상태를 변경 
	public void changeTargetComplaintSttus(Map<String, Object> map);

	// 관리자 메인 화면에서 신고 게시물 수를 불러오는 메서드
	public int getComplaintNtt();

	// 오늘 접수된 신고 게시물 수를 불러오는 메서드
	public int getTodayComplaintNtt();

	// 미확인 신고 게시물 수를 불러오는 메서드
	public int getUncnfrmComplaintNtt();

	// 이상 없음 처리된 게시물 수를 불러오는 메서드
	public int getNoProblemComplaintNtt();

	// 정지 처리된 게시물 수를 불러오는 메서드
	public int getStopComplaintNtt();

	// 브라우저 수를 구하는 메서드
	public HmpgManageVO getHmpgBrwsrCo();

	// 총 방문자 수를 구하는 메서드
	public int getTotalVisitrCo();

	// 전날과 비교해서 방문자 수와 회원가입한 회원 수를 조회하는 메서드
	public HmpgManageVO getCmprBfeCo();

	// 오늘 로그인한 회원 수를 구하는 메서드
	public int getTodayLoginCo();

	// 게시물 테이블을 조회수 내림차순으로 가져오는 메서드
	public List<NttVO> getNttList();

	// 차트에 뿌려질 일주일 방문객 수 가져오는 메서드
	public List<HmpgManageVO> setVisitrChart();
}
