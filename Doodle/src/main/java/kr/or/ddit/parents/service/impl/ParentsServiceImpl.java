package kr.or.ddit.parents.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.parents.mapper.ParentsMapper;
import kr.or.ddit.parents.service.ParentsService;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;

@Service
public class ParentsServiceImpl implements ParentsService {
	
	@Autowired
	ParentsMapper parentsMapper;

	//학부모 마이페이지
	@Override
	public MemberVO myInfo(String loginId) {
		return this.parentsMapper.myInfo(loginId);
	}

	//프로필 수정
	@Override
	public int updateProfile(MemberVO memVO) {
		return this.parentsMapper.updateProfile(memVO);
	}

	//자녀 리스트
	@Override
	public List<FamilyRelateVO> childList(String loginId) {
		return this.parentsMapper.childList(loginId);
	}

	//자녀 학교 리스트
	@Override
	public List<SchulPsitnMberVO> childSchulList(String loginId) {
		return this.parentsMapper.childSchulList(loginId);
	}

	//자녀 클래스 리스트
	@Override
	public List<ClasStdntVO> childClassList(String loginId) {
		return this.parentsMapper.childClassList(loginId);
	}

}
