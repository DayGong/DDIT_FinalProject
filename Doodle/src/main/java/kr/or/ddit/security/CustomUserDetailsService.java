package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.CommonMapper;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

/*
UserDetailsService : 스프링 시큐리티에서 제공해주고 있는
사용자 상세 정보를 갖고 있는 인터페이스
 */
@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private CommonMapper commonMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//MVC에서는 Controller로 리턴하지 않고, CustomUser로 리턴함
		//CustomUser : 사용자 정의 유저 정보. extends User를 상속받고 있음
		
		//1) 사용자 정보를 검색
		//username : 로그인 시 입력 받은 회원의 아이디. <input type="text" name="username"
		MemberVO memberVO = this.commonMapper.loginChk(username);
		
		//2) 스프링 시큐리티의 User 객체의 정보로 넣어줌 => 프링이가 이제부터 해당 유저를 관리
		//User : 스프링 시큐리에서 제공해주는 사용자 정보 클래스
		/*
		 memberVO(우리) -> user(시큐리티)
		 -----------------
		 userId        -> username
		 userPw        -> password
		 enabled       -> enabled
		 auth들                -> authorities
		 */
		return memberVO == null?null:new CustomUser(memberVO);
	}

}


