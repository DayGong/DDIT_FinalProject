package kr.or.ddit.common.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.CommonMapper;
import kr.or.ddit.common.service.CommonService;
import kr.or.ddit.util.service.SessionService;
import kr.or.ddit.vo.CmmnDetailCodeVO;
import kr.or.ddit.vo.FamilyRelateVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	SessionService sessionService;
	@Autowired
	CommonMapper commonMapper;

	@Autowired
	PasswordEncoder passwordEncode;

	@Autowired
	String uploadFolder;
	//D:\\upload

	// 메인페이지
	@Override
	public String main() {
		return null;
	}

	// 회원가입
	@Override
	@Transactional
	public int signUp(MemberVO memberVO, MultipartFile uploadFile, List<String> mberChildIdList, String familyChoice) {

		// 파일객체가 있다면 폴더생성
		if (uploadFile != null && uploadFile.getSize() > 0) {
			//D:\\upload<-이미지
			File fileFolder = new File(uploadFolder + "\\profile\\");
			fileFolder.mkdirs();

			//랜덤 파일명 생성
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + uploadFile.getOriginalFilename();

			//회원정보에 회원 프로필 사진 정보 저장
			memberVO.setMberImage(uploadFileName);

			String savePath = uploadFolder + "\\profile\\" + uploadFileName;
								//D:\\upload"\\profile\\이미지이름
			File file = new File(savePath);

			try {
				//파일업로드
				uploadFile.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		}

		//비밀번호 암호화
		String pw = memberVO.getPassword();
		log.info("memberVO -> password: " + pw);

		String encodedPw = this.passwordEncode.encode(pw);
		log.info("encodedPw: " + encodedPw);

		memberVO.setPassword(encodedPw);
		log.info("updateEncodedPassword -> memVO: " + memberVO);

		//회원정보 Mapper에 전송
		int res = commonMapper.signUp(memberVO);

		// 가족관계 insert 결과를 담을 변수
		int res2 = 0;
		// 학교소속회원 insert 결과를 담을 변수
		int res3 = 0;
		List<String> schools = new ArrayList<String>();
		//자녀가 여러명이고 자녀마다 학교코드가 다를 수 있으므로 자녀아이디를 하나씩 검색해서 학교코드를 가져오도록 반복문 돌리기
		for (int i = 0; i < mberChildIdList.size(); i++) {
			//(학부모 회원가입시)자녀아이디로 학교 코드 가져오기
			String getSchulCode = commonMapper.getSchulCode(mberChildIdList.get(i));

			log.info("getSchulCode -> 학교 코드: " + getSchulCode);

			//가족관계 VO호출(학부모 회원가입시 같이 인서트해야함)
			FamilyRelateVO frlVO  = new FamilyRelateVO();

			//가족관계 데이터 세팅
			//학교코드
			frlVO.setSchulCode(getSchulCode);
			//가족관계
			frlVO.setCmmnDetailCode(familyChoice);
			//학생(자녀)아이디
			frlVO.setStdntId(mberChildIdList.get(i));
			//학부모 아이디
			frlVO.setStdnprntId(memberVO.getMberId());

			log.info("frlVO -> 가족관계: " + frlVO);

			//가족관계 Mapper에 전송 성공 했을 때 자녀 수 만큼 값을 리턴함
			res2 += commonMapper.insertFamilyRelate(frlVO);


			// 학교소속회원 insert
			boolean isDuplicate = false; // 학교 코드 중복
			for(String s : schools) {
				if(s.equals(getSchulCode)) {
					isDuplicate = true;
					break;
				}
			}

			if(!isDuplicate) {
				SchulPsitnMberVO spmVO = new SchulPsitnMberVO();
				spmVO.setSchulCode(getSchulCode);
				spmVO.setMberId(memberVO.getMberId());

				res3 += commonMapper.insertSchulPsitnMber(spmVO);

				schools.add(getSchulCode);
			}

		}

		//성공/실패를 컨트롤러에 반환할 변수 선언
		int result = 0;
		//학부모 인서트가 성공해서 1일때 && 가족관계가 인서트 성공했을때(자녀의 수 만큼) && 학교소속회원 insert
		if(res == 1 && res2 == mberChildIdList.size() && res3 > 0) {
			result = 1;
			//result 결과값 1을 던짐
		}
		//결과값 리턴
		return result;
	}

	// 로그인
	@Override
	public String loginForm() {
		// TODO Auto-generated method stub
		return null;
	}

	// FAQ 게시판 목록
	@Override
	public String faq() {
		// TODO Auto-generated method stub
		return null;
	}

	// 학원 조회
	@Override
	public String academy() {
		// TODO Auto-generated method stub
		return null;
	}

	// 중복체크
	@Override
	public int idDupChk(MemberVO memberVO) {
		int res = commonMapper.idDupChk(memberVO);
		return res;
	}

	// 학부모 회원가입시 자녀아이디 체크
	@Override
	public int childChk(MemberVO memberVO) {
		// 학생이라고 일단 고정해서 보냄
		memberVO.setCmmnDetailCode("ROLE_A01001");
		int res = commonMapper.childChk(memberVO);
		return res;
	}

	//가족 관계 종류 불러오는 리스트 (회원가입에서 띄워야함)
	@Override
	public List<CmmnDetailCodeVO> familyCategory() {
		List<CmmnDetailCodeVO> familyChoiceList = commonMapper.familyCategory();
		return familyChoiceList;
	}

	// 방문자 수와 브라우저를 등록하는 메서드
	@Override
	public void addVisitrCo(HttpServletRequest request) {
		String agent =	request.getHeader("User-Agent").toLowerCase();
		String browserName = "Unknown";
		log.info("addVisitrCo agent => " + agent);

		if(agent != null) {
            if(agent.contains("whale")) {
                browserName = "Whale";
            } else if(agent.contains("edg")) {
                browserName = "Edge";
            } else if(agent.contains("chrome")) {
                browserName = "Chrome";
            }  else {
            	browserName = "etc";
            }
        }
		log.info("addVisitrCo browserName => " + browserName);

		int result = this.commonMapper.addVisitrCo(browserName);
		log.info("addVisitrCo result => " + result);
	}

	// 로그인 수를 등록하는 메서드
	@Override
	public void addLoginCo() {
		int result = this.commonMapper.addLoginCo();
		log.info("addVisitrCo result => " + result);
	}

	// 최초 1회 비밀번호 변경
	@Override
	public int updatePassword(MemberVO memberVO) {
		return this.commonMapper.updatePassword(memberVO);
	}

}
