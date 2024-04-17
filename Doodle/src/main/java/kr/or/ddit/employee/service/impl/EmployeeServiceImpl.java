package kr.or.ddit.employee.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.employee.service.EmployeeService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SchulPsitnMberVO;
import kr.or.ddit.vo.SchulVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	PasswordEncoder passwordEncode;
	
	@Autowired
	String uploadFolder;
	
	//직원 마이페이지
	@Override
	public String mypage() {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 교직원 리스트
	@Override
	public List<SchulVO> employeeList(Map<String, Object> map) {
		return this.employeeMapper.employeeList(map);
	}
	
	// 교직원 리스트 총 게시물 수
	@Override
	public int getEmployeeTotal(Map<String, Object> map) {
		return this.employeeMapper.getEmployeeTotal(map);
	}
	
	// 교직원 상세
	@Override
	public SchulVO employeeDetail(Map<String,Object> map) {
		return this.employeeMapper.employeeDetail(map);
	}
	
	// 멤버 등록
	@Transactional
	public int insertMember(MemberVO memberVO, MultipartFile uploadFile) {

		// 파일객체가 있다면 폴더생성
		if (uploadFile != null && uploadFile.getSize() > 0) {
			//C:/eGovFrameDev-3.10.0-64bit/workspace/Doodle/src/main/webapp/resources/upload/profile/<-이미지
			File fileFolder = new File(uploadFolder + "\\profile\\");
			fileFolder.mkdirs();

			//랜덤 파일명 생성
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + uploadFile.getOriginalFilename();

			//회원정보에 회원 프로필 사진 정보 저장
			memberVO.setMberImage(uploadFileName);

			String savePath = uploadFolder + "\\profile\\" + uploadFileName;

			File file = new File(savePath);

			try {
				//파일업로드
				uploadFile.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		}else {
			//회원 기본이미지 
			String profile = "";
			memberVO.setMberImage(profile);
		}
		//비밀번호 암호화
		String password = memberVO.getPassword();
		log.debug("memberVO -> password: " + password);

		String encodedPw = this.passwordEncode.encode(password);
		log.debug("encodedPw: " + encodedPw);

		memberVO.setPassword(encodedPw);
		log.debug("updateEncodedPassword -> memberVO: " + memberVO);
		
		int result = this.employeeMapper.insertMember(memberVO);
		
		return result;
	}
	
	// 교직원 등록
	public int insertSchoolMember(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.insertSchoolMember(schulPsitnMberVO);
	}
	
	//교직원 등록시 아이디 중복체크
	public int idDupChk(MemberVO memberVO){
		return this.employeeMapper.idDupChk(memberVO);
	};

	// 멤버 수정
	@Override
	public int updateMember(MemberVO memberVO, MultipartFile uploadFile) {
		
		//기존 이미지 불러오기
		String memImage = this.employeeMapper.employeeMemberImage(memberVO);
		
		log.debug("updateMember->memImage : " + memImage);
		
		// 파일객체가 있다면 폴더생성
		if (uploadFile != null && uploadFile.getSize() > 0) {
			//C:/eGovFrameDev-3.10.0-64bit/workspace/Doodle/src/main/webapp/resources/upload/profile/<-이미지
			//D:\\upload
			File fileFolder = new File(uploadFolder + "\\profile\\");
			fileFolder.mkdirs();

			//랜덤 파일명 생성
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid + "_" + uploadFile.getOriginalFilename();

			//회원정보에 회원 프로필 사진 정보 저장
			memberVO.setMberImage(uploadFileName);

			String savePath = uploadFolder + "\\profile\\" + uploadFileName;

			File file = new File(savePath);

			try {
				//파일업로드
				uploadFile.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

		}else {
			//기존 이미지로 저장
			memberVO.setMberImage(memImage);
		}
		/*
		MemberVO(mberId=758109299996, password=null, mberNm=123, ihidnum=null, moblphonNo=123
		, mberEmail=123, zip=123, mberAdres=123 123 1111 aa
		, mberImage=dc58d6dd-e43c-4e81-9682-f6227c0c4b1b_Anne-Marie(앤마리)-2002.jpg
		, mberSecsnAt=null, cmmnDetailCode=null, multipartFile=null, schulPsitnMberVO=null
		, cmmnDetailCodeVOList=null, vwMemberAuthVOList=null)
		 */
		log.debug("updateEmployeeMember->memberVO : " + memberVO);
		
		int result = this.employeeMapper.updateMember(memberVO);
		
		return result;
	}
	@Override
	public int updateEmployeeSchulPsitnMber(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.updateEmployeeSchulPsitnMber(schulPsitnMberVO);
	}
	
	// 교직원 삭제
	@Override
	public int employeeDeleteAjax(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.employeeDeleteAjax(schulPsitnMberVO);
	}
	
	// 학생 리스트
	@Override
	public List<SchulVO> studentList(Map<String, Object> map) {
		return this.employeeMapper.studentList(map);
	}
	
	// 학생 리스트 총 갯수
	@Override
	public int getStudentTotal(Map<String, Object> map) {
		return this.employeeMapper.getStudentTotal(map);
	}
	
	// 학생 상세
	@Override
	public SchulVO studentDetail(Map<String, Object> map) {
		return this.employeeMapper.studentDetail(map);
	}
	
	
	// 학생 등록
	public int insertSchoolStudent(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.insertSchoolStudent(schulPsitnMberVO);
	}
	
	// 학생 수정
	@Override
	public int updateStudentSchulPsitnMber(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.updateStudentSchulPsitnMber(schulPsitnMberVO);
	}
	
	// 학생 삭제
	@Override
	public int studentDeleteAjax(SchulPsitnMberVO schulPsitnMberVO) {
		return this.employeeMapper.studentDeleteAjax(schulPsitnMberVO);
	}
	
	//엑셀 파일 업로드로 등록
	@Override
	public List<HashMap<Integer, String>> excelResgistration(MultipartFile upload) {
		log.debug("엑셀파일 사이즈 ->" + upload.getSize());
		log.debug("엑셀파일 이름->" + upload.getOriginalFilename());

		HashMap<Integer, String> excelMap = new HashMap<Integer, String>();// 값을 담을 변수
		List<HashMap<Integer, String>> excelList = new ArrayList<HashMap<Integer,String>>();

		try {
			int rowIndex = 0;
			int columIndex = 0;

			DecimalFormat df = new DecimalFormat();
			//(xls인 경우)
			if(upload.getOriginalFilename().equals("xls")) {
				//시트 읽기
				HSSFWorkbook workBook = new HSSFWorkbook(upload.getInputStream());
				HSSFSheet sheet = workBook.getSheetAt(0);
				//행의 수 체크
				int rows = sheet.getLastRowNum()+1;
				System.out.println("행의 수 :" + rows);
				for (rowIndex = 1; rowIndex < rows; rowIndex++) {
					//행 읽기
					HSSFRow row = sheet.getRow(rowIndex);
					if(row != null) {
						//셀의 수 체크
						int cells = row.getPhysicalNumberOfCells();
						for (columIndex = 0; columIndex <= cells-1; columIndex++) {
							HSSFCell cell = row.getCell(columIndex);
							String value = "";
							if(cell == null) {
								excelMap.put(columIndex, value);
								continue;
							}else {
								switch (cell.getCellType()) {
								case FORMULA:
									value = cell.getCellFormula();
									break;
								case NUMERIC:
									value = String.valueOf(cell.getNumericCellValue());
									break;
								case STRING:
									value = cell.getStringCellValue();
									break;
								case BLANK:
									value = String.valueOf(cell.getBooleanCellValue());
									break;
								case ERROR:
									value = String.valueOf(cell.getErrorCellValue());
								default:
									value = cell.getStringCellValue();
									break;
								}
							}
							excelMap.put(columIndex, value);
						}
						excelList.add(excelMap);
						excelMap = new HashMap<Integer, String>();
					}
				}
			}else {//(xlsx인 경우)
//				FileInputStream file = new FileInputStream(upload.getInputStream().ge);
				XSSFWorkbook workBook = new XSSFWorkbook(upload.getInputStream());
				XSSFSheet sheet = workBook.getSheetAt(0);
				//행의 수 체크
				int rows = sheet.getLastRowNum()+1;
				System.out.println("행의 수 :" + rows);
				for (rowIndex = 1; rowIndex < rows; rowIndex++) {
					//행을 읽습니다.
					XSSFRow row = sheet.getRow(rowIndex);
					if(row != null) {
						//셀의 수를 체크해줍니다.
						int cells = row.getPhysicalNumberOfCells();
						for (columIndex = 0; columIndex <= cells-1; columIndex++) {
							//셀 값을 확인합니다.
							XSSFCell cell = row.getCell(columIndex);
							String value = "";
							if(cell == null) {
								excelMap.put(columIndex, value);
								continue;
							}else {
								//타입 별로 value에 값을 넣어줍니다.
								switch (cell.getCellType()) {
								case FORMULA:
									value = cell.getCellFormula();
									break;
								case NUMERIC:
									value = String.valueOf(cell.getNumericCellValue());
									break;
								case STRING:
									value = cell.getStringCellValue();
									break;
								case BLANK:
									value = String.valueOf(cell.getBooleanCellValue());
									break;
								case ERROR:
									value = String.valueOf(cell.getErrorCellValue());
								default:
									value = cell.getStringCellValue();
									break;
								}
							}
							excelMap.put(columIndex, value);

							System.out.println(rowIndex +" 행 : " + columIndex +"번째의 값은 : " + value);

							log.debug(" excelMap 값 -> " + excelMap);
						}
						excelList.add(excelMap);
						excelMap = new HashMap<Integer, String>();
					}
				}
			}


		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("excelList->"+ excelList);


		return excelList;
	}
	
	//아이디 최대값
	@Override
	public String selectMaxId(String cmmnDetailCode) {
		return this.employeeMapper.selectMaxId(cmmnDetailCode);
	}
	//멤버 삭제
	@Override
	public int deleteMember(String mberId) {
		return this.employeeMapper.deleteMember(mberId);
	}

	
	
}
