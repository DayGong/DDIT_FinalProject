package kr.or.ddit.util;

import java.util.List;

//페이징 관련 정보 + 게시글 정보
// new ArticlePage<FreeBoardVO>(total, currentPage, size, content);
public class ArticlePage<T> {
	// 전체글 수
	private int total;
	// 현재 페이지 번호
	private int currentPage;
	// 전체 페이지수
	private int totalPages;
	// 블록의 시작 페이지 번호
	private int startPage;
	// 블록의 종료 페이지 번호
	private int endPage;
	// 검색어
	private String keyword = "";
	// 요청URL
	private String url = "";
	// select 결과 데이터
	private List<T> content;
	// 페이징 처리
	private String pagingArea = "";
	// 블록 크기
	private int blockSize = 5;
	
	private String code = "";
	
	private String schulCode = "";
	
	// 생성자(Constructor) : 페이징 정보를 생성
	public ArticlePage(int total, int currentPage, int size, List<T> content, String keyword) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;
		this.keyword = keyword;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
				// 3 = 31 / 10
			totalPages = total / size;// 75

			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		String localUrl = this.url;
		
		pagingArea += "<div class='col-sm-12 col-md-7' style='width:100%;'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='" + localUrl + "?currentPage=" + (this.startPage - blockSize) + "&keyword="
				+ this.keyword + "' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";

		for (int pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='" + this.url + "?currentPage=" + pNo + "&keyword=" + this.keyword
					+ "' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next '";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='" + localUrl + "?currentPage=" + (this.startPage + blockSize) + "&keyword=" + this.keyword
				+ "' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";

	}// end 생성자
	
	//employeeList, studentList
	// 생성자(Constructor) : 페이징 정보를 생성
	public ArticlePage(int total, int currentPage, int size, List<T> content, String keyword, String code) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;
		this.keyword = keyword;
		this.code = code;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
				// 3 = 31 / 10
			totalPages = total / size;// 75

			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}

//		String localUrl = this.url;
		
		int pNo = 0;
		
		pagingArea += "<div class='col-sm-12 col-md-7' style='width:100%;'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate' style='margin-bottom: 5px;'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			pNo = this.startPage;
		}else {
			pNo = (this.startPage - blockSize);
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";

		for (pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next'";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;'";
			pNo = this.totalPages;
		}else {
			pNo = (this.startPage + blockSize);
		}
		pagingArea += "' id='example2_next'>";
		pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";

	}// end 생성자
	
	
	// 생성자(Constructor) : 페이징 정보를 생성
	public ArticlePage(int total, int currentPage, int size, List<T> content) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
				// 3 = 31 / 10
			totalPages = total / size;// 75

			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		String localUrl = this.url;
		
		pagingArea += "<div class='col-sm-12 col-md-7' style='width:100%;'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='" + localUrl + "?currentPage=" + (this.startPage - blockSize) + "' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";

		for (int pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='" + this.url + "?currentPage=" + pNo + "' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next '";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='" + localUrl + "?currentPage=" + (this.startPage + blockSize) + "' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";

	}// end 생성자
	
	// 설문 게시판 페이징
	public ArticlePage(int total, int currentPage, int size, String keyword, String url, List<T> content) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;
		this.keyword = keyword;
		this.url = url;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
				// 3 = 31 / 10
			totalPages = total / size;// 75

			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		String localUrl = this.url;
		
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='javascript:void(0);' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";

		for (int pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='javascript:void(0);' onclick='fn_surveyPaging(this, " + pNo + ");' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next '";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='javascript:void(0);' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";

	}// end 생성자
	
	
	// 방과후학교 목록 페이징
	public ArticlePage(int total, int currentPage, int size, List<T> content, String keyword, String schulCode, String schulCode2) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;
		this.keyword = keyword;
		this.schulCode = schulCode;
		
		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
			// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
			// 3 = 31 / 10
			totalPages = total / size;// 75
			
			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}
			
			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1
			
			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}
			
			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5
			
			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		String localUrl = this.url;
		
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='" + localUrl + "?currentPage=" + (this.startPage - blockSize) + "&keyword="
				+ this.keyword + "&schulCode="+this.schulCode+"' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";
		
		for (int pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='" + this.url + "?currentPage=" + pNo + "&keyword=" + this.keyword
					+ "&schulCode="+this.schulCode+"' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next '";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;";
			localUrl = "#";
		}else {
			localUrl = this.url;
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='" + localUrl + "?currentPage=" + (this.startPage + blockSize) + "&keyword=" + this.keyword
				+ "&schulCode="+this.schulCode+"' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";
		
	}// end 생성자
	
	// 상담 일지 게시판(loadCnsltDiaryList.jsp), 신고 게시판(complaintBoardList.jsp) 
	// 생성자(Constructor) : 페이징 정보를 생성
	public ArticlePage(int currentPage, int size, List<T> content, String keyword, int total) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;// 753
		this.currentPage = currentPage;// 1
		this.content = content;
		this.keyword = keyword;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 0;// 전체 페이지 수
			startPage = 0;// 블록 시작번호
			endPage = 0; // 블록 종료번호
		} else {// 글이 있다면
				// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
				// 3 = 31 / 10
			totalPages = total / size;// 75

			// 나머지가 있다면, 페이지를 1 증가
			if (total % size > 0) {// 나머지3
				totalPages++;// 76
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;// 1

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);// 5

			// 종료페이지번호 > 전체페이지수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}

		int pNo = 0;
		
		pagingArea += "<div class='col-sm-12 col-md-7' style='width:100%;'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate' style='margin-bottom: 5px;'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous '";
		if (this.startPage < blockSize + 1) {
			pagingArea += "style='display:none;";
			pNo = this.startPage;
		}else {
			pNo = (this.startPage - blockSize);
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";

		for (pNo = this.startPage; pNo <= this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if (this.currentPage == pNo) {
				pagingArea += "active";
			}
			if(pNo==0) {
				pagingArea += "'style='display:none;";
			}
			pagingArea += "'>";
			pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>" + pNo + "</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next'";
		if (this.endPage >= this.totalPages) {
			pagingArea += "style='display:none;'";
			pNo = this.totalPages;
		}else {
			pNo = (this.startPage + blockSize);
		}
		pagingArea += "' id='example2_next'>";
		pagingArea += "<a href='#' onclick='fn_search(" + pNo + ")' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";

	}// end 생성자

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<T> getContent() {
		return content;
	}

	public void setContent(List<T> content) {
		this.content = content;
	}

	// 전체 글의 수가 0인가?
	public boolean hasNoArticles() {
		return this.total == 0;
	}

	// 데이터가 있나?
	public boolean hasArticles() {
		return this.total > 0;
	}

	// 페이징 블록을 자동화
	public String getPagingArea() {
		return this.pagingArea;
	}

	public void setPagingArea(String pagingArea) {
		this.pagingArea = pagingArea;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "ArticlePage [total=" + total + ", currentPage=" + currentPage + ", totalPages=" + totalPages
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", keyword=" + keyword + ", url=" + url
				+ ", content=" + content + ", pagingArea=" + pagingArea + ", blockSize=" + blockSize + ", code=" + code
				+ "]";
	}

	
}