package kr.or.ddit.approval.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.approval.mapper.ApprovalMapper;
import kr.or.ddit.approval.service.ApprovalService;
import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.SanctnDocSearchVO;
import kr.or.ddit.vo.SanctnDocVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.VwStdntStdnprntVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	ApprovalMapper approvalMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	String uploadFolder;
	
	//교외체험학습 관련 학부모와 학생의 정보
	@Override
	public VwStdntStdnprntVO studentInfo(VwStdntStdnprntVO vwStdntStdnprntVO) {
		return this.approvalMapper.studentInfo(vwStdntStdnprntVO);
	}
	
	//체험학습 신청서 등록
	@Override
	public int insertDoc(SanctnDocVO sanctnDocVO) {
		return this.approvalMapper.insertDoc(sanctnDocVO);
	}
	
	//학부모-체험학습 문서 목록 데이터
	@Override
	public ArticlePage<SanctnDocVO> loadSanctnDocList(HttpServletRequest request ,SanctnDocSearchVO sanctnDocSearchVO) {
		String clasStdntCode = "";
		String clasCode = "";
		String schulCode = "";
		log.debug("loadSanctnDocList->sanctnDocSearchVO전 : " + sanctnDocSearchVO);
		
		//학부모라면 - A01003
		if(request.isUserInRole("A01003")){
			clasStdntCode = sanctnDocSearchVO.getClasStdntCode();
		//담임 - A14002
		}else if(request.isUserInRole("A14002")){
			clasCode = sanctnDocSearchVO.getClasCode();
		//교감 - A14005
		}else {
			schulCode = sanctnDocSearchVO.getSchulCode();
		}
		
//		String clasStdntCode = sanctnDocSearchVO.getClasStdntCode();
		String keyword = sanctnDocSearchVO.getKeyword();
		int currentPage = sanctnDocSearchVO.getCurrentPage();
		int size = sanctnDocSearchVO.getSize();
		
		log.debug("loadSanctnDocList->sanctnDocSearchVO후 : " + sanctnDocSearchVO);
		
		//학부모-체험학습 문서 갯수 
		int total = this.approvalMapper.getApprovalTotal(sanctnDocSearchVO);
		log.debug("loadSanctnDocList->total : " + total);
		
		List<SanctnDocVO> sanctnDocVOList = this.approvalMapper.loadSanctnDocList(sanctnDocSearchVO);
		log.debug("loadSanctnDocList->sanctnDocVOList : " + sanctnDocVOList);
		
		ArticlePage<SanctnDocVO> sanctnDocPage;
		//학부모라면 - A01003
		if(request.isUserInRole("A01003")){
			sanctnDocPage = new ArticlePage<SanctnDocVO>(total, currentPage, size, sanctnDocVOList, keyword, clasStdntCode);
			log.debug("학부모loadSanctnDocList->sanctnDocPage : " + sanctnDocPage);
		//담임 - A14002
		}else if(request.isUserInRole("A14002")){
			sanctnDocPage = new ArticlePage<SanctnDocVO>(total, currentPage, size, sanctnDocVOList, keyword, clasCode);
			log.debug("담임loadSanctnDocList->sanctnDocPage : " + sanctnDocPage);
		//교감 - A14005
		}else {
			sanctnDocPage = new ArticlePage<SanctnDocVO>(total, currentPage, size, sanctnDocVOList, keyword, schulCode);
			log.debug("교감loadSanctnDocList->sanctnDocPage : " + sanctnDocPage);
		}
		return sanctnDocPage;
	}
	
	//학부모-체험학습 문서 상세
	@Override
	public SanctnDocVO approvalDetail(String docCode) {
		return this.approvalMapper.approvalDetail(docCode);
	}

	//학부모-체험학습 문서 수정
	@Override
	public int approvalUpdate(SanctnDocVO sanctnDocVO) {
		return this.approvalMapper.approvalUpdate(sanctnDocVO);
	}
	
	//학부모-체험학습 문서 삭제
	@Override
	public int approvalDelete(SanctnDocVO sanctnDocVO) {
		return this.approvalMapper.approvalDelete(sanctnDocVO);
	}
	
	//선생님-체험학습 문서 목록 데이터
//	@Override
//	public ArticlePage<SanctnDocVO> loadSanctnDocListT(SanctnDocSearchVO sanctnDocSearchVO) {
//		log.debug("loadSanctnDocList->sanctnDocSearchVO전 : " + sanctnDocSearchVO);
//		String clasCode = sanctnDocSearchVO.getClasCode();
//		String keyword = sanctnDocSearchVO.getKeyword();
//		int currentPage = sanctnDocSearchVO.getCurrentPage();
//		int size = sanctnDocSearchVO.getSize();
//		
//		log.debug("loadSanctnDocListT->sanctnDocSearchVO후 : " + sanctnDocSearchVO);
//		
//		//선생님-체험학습 문서 갯수 
//		int total = this.approvalMapper.getApprovalTotalT(sanctnDocSearchVO);
//		log.debug("loadSanctnDocListT->total : " + total);
//		
//		List<SanctnDocVO> sanctnDocVOList = this.approvalMapper.loadSanctnDocListT(sanctnDocSearchVO);
//		log.debug("loadSanctnDocListT->sanctnDocVOList : " + sanctnDocVOList);
//		
//		ArticlePage<SanctnDocVO> sanctnDocPage = new ArticlePage<SanctnDocVO>(total, currentPage, size, sanctnDocVOList, keyword, clasCode);
//		log.debug("loadSanctnDocListT->sanctnDocPage : " + sanctnDocPage);
//		return sanctnDocPage;
//	}
	
	//선생님-체험학습신청 거절
	@Override
	public int approvalRefuse(SanctnDocVO sanctnDocVO) {
		return this.approvalMapper.approvalRefuse(sanctnDocVO);
	}
	
	//체험학습신청 결재
	@Transactional
	@Override
	public int approvalSign(HttpServletRequest request,SanctnDocVO sanctnDocVO, MultipartFile uploadFile) {
		
		//담임이라면
		if(request.isUserInRole("A14002")){
			//서명을 새로 등록 했을 때
			// 파일객체가 있다면 폴더생성
			if (uploadFile != null && uploadFile.getSize() > 0) {
				File fileFolder = new File(uploadFolder + "\\sign\\");
				fileFolder.mkdirs();
				
				String uploadFileName = uploadFile.getOriginalFilename();
				
				//체험학습 신청 문서에 서명 이미지 저장
				sanctnDocVO.setTcherSanctn(uploadFileName);
				log.debug("담임approvalSign->sanctnDocVO : " + sanctnDocVO);
				String savePath = uploadFolder + "\\sign\\" + uploadFileName;
				
				File file = new File(savePath);
				
				try {
					//파일업로드
					uploadFile.transferTo(file);
					
					int result = this.approvalMapper.approvalSign(sanctnDocVO);
					log.debug("담임approvalSign->sanctnDocVO! : " + sanctnDocVO);
					
//					//학교회원에 서명 추가
					SchulPsitnMberVO schulPsitnMberVO = (SchulPsitnMberVO)request.getSession().getAttribute("SCHOOL_USER_INFO");
					schulPsitnMberVO.setSign(sanctnDocVO.getTcherSanctn());
					log.debug("approvalSign->schulPsitnMberVO : " + schulPsitnMberVO);
					
					result += this.employeeMapper.insertSign(schulPsitnMberVO);
					log.debug("담임approvalSign->result : " + result);
					return result;
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}else {//서명이 이미 등록되어 있다면
				SchulPsitnMberVO schulPsitnMberVO = (SchulPsitnMberVO)request.getSession().getAttribute("SCHOOL_USER_INFO");
				String sign = schulPsitnMberVO.getSign();
				sanctnDocVO.setTcherSanctn(sign);
				
				int result = this.approvalMapper.approvalSign(sanctnDocVO);
				log.debug("담임approvalSign->result2 : " + result);
				return result;
			}
		}
		//교감이라면
		if(request.isUserInRole("A14005")){
			// 파일객체가 있다면 폴더생성
			if (uploadFile != null && uploadFile.getSize() > 0) {
				File fileFolder = new File(uploadFolder + "\\sign\\");
				fileFolder.mkdirs();
				
				String uploadFileName = uploadFile.getOriginalFilename();
				
				//체험학습 신청 문서에 서명 이미지 저장
				sanctnDocVO.setDeputyPrncpalSanctn(uploadFileName);
				log.debug("교감approvalSign->sanctnDocVO : " + sanctnDocVO);
				String savePath = uploadFolder + "\\sign\\" + uploadFileName;
				
				File file = new File(savePath);
				
				try {
					//파일업로드
					uploadFile.transferTo(file);
					
					int result = this.approvalMapper.approvalSign(sanctnDocVO);
					
					//학교회원에 서명 추가
					SchulPsitnMberVO schulPsitnMberVO = (SchulPsitnMberVO)request.getSession().getAttribute("SCHOOL_USER_INFO");
					schulPsitnMberVO.setSign(sanctnDocVO.getDeputyPrncpalSanctn());
					log.debug("approvalSign->schulPsitnMberVO : " + schulPsitnMberVO);
					
					result += this.employeeMapper.insertSign(schulPsitnMberVO);
					log.debug("교감approvalSign->result : " + result);
					return result;
					
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}else {
				SchulPsitnMberVO schulPsitnMberVO = (SchulPsitnMberVO)request.getSession().getAttribute("SCHOOL_USER_INFO");
				String sign = schulPsitnMberVO.getSign();
				sanctnDocVO.setDeputyPrncpalSanctn(sign);
				
				int result = this.approvalMapper.approvalSign(sanctnDocVO);
				log.debug("교감approvalSign->result2 : " + result);
				return result;
			}
		}
		return 0;
	}
	
}
