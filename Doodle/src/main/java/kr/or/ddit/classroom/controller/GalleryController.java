package kr.or.ddit.classroom.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.classroom.service.GalleryService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AtchFileVO;
import kr.or.ddit.vo.ClasAlbumVO;
import kr.or.ddit.vo.ClasStdntVO;
import kr.or.ddit.vo.ClasVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/gallery")
@Controller
public class GalleryController {
	
	@Autowired
	GalleryService galleryService;
	
	// 학급 갤러리 앨범 목록
	@GetMapping("/{clasCode}")
	public String albumList(HttpServletRequest request, Model model,
			@RequestParam(value = "clasCode", required = false, defaultValue = "") String clasCode) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		model.addAttribute("clasCode", clasVO.getClasCode());
		
		log.debug("CLASS_INFO >> "+clasVO);
		
		return "gallery/gallery";
	}

	// 학급 앨범 목록 AJAX - 페이지네이션 적용
	@ResponseBody
	@PostMapping("/albumListAjax")
	public ArticlePage<ClasAlbumVO> albumListAjax(HttpServletRequest request, Model model,
			@RequestBody Map<String, Object> map) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		int size = 8;
		int total = this.galleryService.getTotalGallery(map);
		String keyword = map.get("keyword").toString();
		String url = "/gallery/gallery"+clasVO.getClasCode();

		// 앨범 리스트
		List<ClasAlbumVO> clasAlbumVOList = this.galleryService.clasAlbumList2(map);

		model.addAttribute("clasCode", clasVO.getClasCode());

		// 페이지네이션 ArticlePage(int total, int currentPage, int size, List<T> content, String keyword)
		ArticlePage<ClasAlbumVO> data = new ArticlePage<ClasAlbumVO>(total,	Integer.parseInt(map.get("currentPage").toString()), size, clasAlbumVOList, keyword);
		data.setUrl(url);
		
		log.debug("map : " + map);
		log.debug("list -> clasAlbumVOList :" + clasAlbumVOList);
		log.debug("list->total : " + total);
		log.debug("albumListAjax->keyword : " + keyword);
		log.debug("url:"+url);
		log.debug("clasAlbumVOList : " + clasAlbumVOList);

		return data;
	}

	// 앨범 추가
	@ResponseBody
	@PostMapping("/createAlbum") // FILE이 포함되어있으면 MULTIPART/FORM-DATA
	public List<ClasAlbumVO> createAlbum(HttpServletRequest request, Model model,
				ClasAlbumVO clasAlbumVO) {

		ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO");
		model.addAttribute("clasStdntCode", clasStdntVO.getClasStdntCode());
		model.addAttribute("mberId", clasStdntVO.getMberId());
		
		// 세션에서 가지고온 값 clasAlbumVO에 저장
		clasAlbumVO.setClasStdntCode(clasStdntVO.getClasStdntCode());
		clasAlbumVO.setMberId(clasStdntVO.getMberId());
		
		int result = this.galleryService.createAlbum(clasAlbumVO);
		List<ClasAlbumVO> clasAlbumVOList = this.galleryService.clasAlbumList(clasAlbumVO.getClasCode());

		log.debug("CLASS_STD_INFO >> "+clasStdntVO);
		log.debug("createAlbum -> clasAlbumVO : " + clasAlbumVO);
		log.debug("createAlbum-> result : " + result);
		log.debug("clasAlbumVOList : " + clasAlbumVOList);

		return clasAlbumVOList;
	}

	// 학급 앨범 삭제
	@ResponseBody
	@PostMapping("/deleteAlbum")
	public int deleteAlbum(
			@RequestParam(value = "atchFileCode", required = false, defaultValue = "") String atchFileCode) {
		int result = galleryService.deleteAlbum(atchFileCode);
		
		log.debug("deleteAlbum-> atchFileCode: " + atchFileCode);
		log.debug("deleteAlbum->result : " + result);
		
		return result;
	}

	// 학급 앨범 수정
	@ResponseBody
	@PostMapping("/updateAlbum")
	public List<ClasAlbumVO> updateAlbum(HttpServletRequest request, Model model,
						ClasAlbumVO clasAlbumVO) {
		ClasStdntVO clasStdntVO = (ClasStdntVO) request.getSession().getAttribute("CLASS_STD_INFO");
		
		// 세션에서 가지고 온 값 clasAlbumVO에 저장
		model.addAttribute("clasStdntCode", clasStdntVO.getClasStdntCode());
		clasAlbumVO.setMberId(clasStdntVO.getMberId());

		int result = galleryService.updateAlbum(clasAlbumVO);
		List<ClasAlbumVO> atchFileVOList = this.galleryService.galleryDetail(clasAlbumVO.getAtchFileCode());
		
		log.debug("CLASS_STD_INFO >> "+clasStdntVO);
		log.debug("updateAlbum-> ClasAlbumVO: " + clasAlbumVO);
		log.debug("updateAlbum-> result :" + result);
		log.debug("galleryDetailAjax->atchFileCode  : " + clasAlbumVO.getAtchFileCode());
		log.debug("atchFileVOList : " + atchFileVOList);

		return atchFileVOList;
	}
	
	// 해시태그 목록
	@ResponseBody
	@PostMapping("/albumTagList")
	public List<String> albumTagList(HttpServletRequest request, Model model,
			@RequestParam(value = "clasCode", required = false, defaultValue = "") String clasCode) {
		ClasVO clasVO = (ClasVO) request.getSession().getAttribute("CLASS_INFO");
		model.addAttribute("clasCode", clasVO.getClasCode());
		
		List<String> albumTagVOList = this.galleryService.albumTagList(clasVO.getClasCode());
		
		log.debug("CLASS_INFO >> "+clasVO);
		log.debug("AlbumTagList =>" + albumTagVOList);
		
		return albumTagVOList;
	}

	// 학급 갤러리 상세 리스트
	@GetMapping("/galleryDetail")
	public String galleryDetail(Model model,
			@RequestParam(value = "atchFileCode", required = false, defaultValue = "") String atchFileCode,
			@RequestParam(value = "clasCode", required = false, defaultValue = "") String clasCode,
			@RequestParam(value = "complaint", required = false, defaultValue = "") String complaint,
			HttpServletRequest request) {
		
		// 세션에 저장된 클래스 정보 가져오기
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("USER_INFO");
		String viewName = "gallery/galleryDetail";
		
		model.addAttribute("mberId", memberVO.getMberId());
		
		log.debug("galleryDetail USER_INFO => " + memberVO);
		
		if(!complaint.equals("")) {
			viewName = "noTiles/gallery/galleryDetail";
		}
		return viewName;
	}

	// 학급 갤러리 상세리스트 AJAX
	@ResponseBody
	@GetMapping("/galleryDetailAjax")
	public List<ClasAlbumVO> galleryDetailAjax(
			@RequestParam(value = "atchFileCode", required = false, defaultValue = "") String atchFileCode) {
		List<ClasAlbumVO> atchFileVOList = this.galleryService.galleryDetail(atchFileCode);
		
		log.debug("galleryDetailAjax->atchFileCode  : " + atchFileCode);
		log.debug("atchFileVOList : " + atchFileVOList);

		return atchFileVOList;
	}

	// 갤러리 사진 삭제
	@ResponseBody
	@PostMapping("/deleteImage")
	public int deleteImage(@RequestBody AtchFileVO atchFileVO) {
		int result = this.galleryService.deleteImage(atchFileVO);

		log.debug("atchFileVO : " + atchFileVO);
		log.debug("deleteImage->result : " + result);

		return result;
	}

	// 갤러리 사진 수정
	@ResponseBody
	@PostMapping("/updateImage")
	public int updateImage(@RequestBody AtchFileVO atchFileVO) {
		int result = this.galleryService.updateImage(atchFileVO);

		log.debug("atchFileVO : " + atchFileVO);
		log.debug("updateImage->result : " + result);

		return result;
	}
	
	/** 신고 후 신고 누적과 게시물 신고 상태 update하는 메서드 */
	@ResponseBody
	@PostMapping("/modNttSttemnt")
	public int modNttSttemnt(String atchFileCode) {
		int result = this.galleryService.modNttSttemnt(atchFileCode);
		log.debug("modNttSttemnt result => " + result);
		
		return result;
	}
	
}
