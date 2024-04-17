package kr.or.ddit.student.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.student.mapper.StudentMapper;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.TaskResultVO;

@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	StudentMapper studentMapper;
	
	//학생 마이페이지
	@Override
	public MemberVO myInfo(String loginId) {
		return this.studentMapper.myInfo(loginId);
	}

	//학생 소속 학교 리스트
	@Override
	public List<SchulPsitnMberVO> mySchulList(String loginId) {
		return this.studentMapper.mySchulList(loginId);
	}

	//학생 소속 클래스 리스트
	@Override
	public List<ClasStdntVO> myClassList(String loginId) {
		return this.studentMapper.myClassList(loginId);
	}

	//학부모 인증(학생이)
	@Override
	public String parentCertification() {
		return null;
	}
	
	//프로필 수정
	@Override
	public int updateProfile(MemberVO memVO) {
		return this.studentMapper.updateProfile(memVO);
	}

	//칭찬 스티커 수
	@Override
	public int getComplimentStickerCount(String mberId) {
		return this.studentMapper.getComplimentStickerCount(mberId);
	}

	// 칭찬 스티커 내역
	@Override
	public List<TaskResultVO> getComplimentStickerStatus(String mberId) {
		return this.studentMapper.getComplimentStickerStatus(mberId);
	}

}
