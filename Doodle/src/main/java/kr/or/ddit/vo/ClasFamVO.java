package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ClasFamVO {
	private String clasCode;
    private String stdnprntId;
    private String stdntId;
    private String cmmnDetailCodeNm;
    private String mberNm;
    private String mberImage;
    private String cmmnDetailCode;
    
    //ClasFamVO : FamilyRelateVO = 1 : N 
    private List<FamilyRelateVO> familyRelateVOList;
    
    private MemberVO stdnprntVO;
    private MemberVO stdntVO;
}
