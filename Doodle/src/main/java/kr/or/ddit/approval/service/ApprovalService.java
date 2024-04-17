package kr.or.ddit.approval.service;



import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.SanctnDocSearchVO;
import kr.or.ddit.vo.SanctnDocVO;
import kr.or.ddit.vo.VwStdntStdnprntVO;

public interface ApprovalService {
	
	//교외체험학습 관련 학부모와 학생의 정보
	VwStdntStdnprntVO studentInfo(VwStdntStdnprntVO vwStdntStdnprntVO);
	
	//체험학습 신청서 등록
	int insertDoc(SanctnDocVO sanctnDocVO);
	
	//학부모-체험학습 문서 목록 데이터
	ArticlePage<SanctnDocVO> loadSanctnDocList(HttpServletRequest request, SanctnDocSearchVO sanctnDocSearchVO);
	
	//학부모-체험학습 문서 상세
	SanctnDocVO approvalDetail(String docCode);
	
	//학부모-체험학습 문서 수정
	int approvalUpdate(SanctnDocVO sanctnDocVO);
	
	//학부모-체험학습 문서 삭제
	int approvalDelete(SanctnDocVO sanctnDocVO);

	//선생님-체험학습 문서 목록 데이터
//	ArticlePage<SanctnDocVO> loadSanctnDocListT(SanctnDocSearchVO sanctnDocSearchVO);

	//선생님-체험학습신청 거절
	int approvalRefuse(SanctnDocVO sanctnDocVO);

	//담임 선생님-체험학습신청 결재
	int approvalSign(HttpServletRequest request,SanctnDocVO sanctnDocVO, MultipartFile uploadFile);

}
