package kr.or.ddit.parents.service;


public interface ParentsService {

	//학부모 마이페이지
	public String mypage();
	
	//학부모 인증 신청(학생에게)
	public String parentCertification();
	
	//학급클래스 신청
	public String classRequest();
	
	//상담 신청
	public String consultRequest();
	
	//방과후학교 신청
	public String afterSchoolRequest();
	
	//방과후학교 결제
	public String afterSchoolPay();
}
