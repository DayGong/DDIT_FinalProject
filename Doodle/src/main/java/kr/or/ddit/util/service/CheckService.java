package kr.or.ddit.util.service;

import javax.servlet.http.HttpServletRequest;

public interface CheckService {

	public boolean checkBelongCl(HttpServletRequest request, String clasCode);

	public boolean checkBelongSch(HttpServletRequest httpReq, String schulCode);

}
