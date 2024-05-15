<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script type ="text/javascript">
// 이미지 오류시 지정이미지 뜨게하기
function noImage(image){
	image.src = '/resources/images/gallery/루피1.png';
}

$(function(){
	// 자동 등록
	$("#btnAuto").on("click",function(){
		// 앨범 제목
		$("#albumNm").val("세종 베어트리파크로 체험학습 갔어요");
		// 해시태그
		addTag("세종");
    	addTag("현장체험학습");
    	addTag("베어트리파크");
		
		$("#tag-list").append('<li class="tag-item">세종<span class="del-btn" idx="0">x</span></li>');
		$("#tag-list").append('<li class="tag-item">현장체험학습<span class="del-btn" idx="1">x</span></li>');
		$("#tag-list").append('<li class="tag-item">베어트리파크<span class="del-btn" idx="1">x</span></li>');
	});
	
	$("#studentFreeBoardLi").css("display", "block");
	$("#teacherFreeBoardLi").css("display", "block");
	$("#parentFreeBoardLi").css("display", "block");
	//날짜 포맷 생성  함수
	function dateFormat(date) {
		let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
		return dateFormat2;
	}

	$("#albumDe").val(dateFormat(new Date()));	// 파일 등록 일자
	$("#updtDe").val(dateFormat(new Date()));	// 수정 일자
	$("#albumDate").val(dateFormat(new Date()));// list부분 날짜
	// 날짜 함수 끝~//
	
	// 이미지 미리보기 시작
	$("#inputImgs").on("change", handleImg);
	
	// e : onchange 이벤트 객체
	function handleImg(e){
		let files = e.target.files;
		let fileArr = Array.prototype.slice.call(files);
		fileArr.forEach(function(f){
			// 이미지 파일이 아닌 경우
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다"); 
				return;
			}
			
			// 초기화
			$("#divImage").html("");

			// 이미지를 읽기
			let reader = new FileReader();
			reader.onload = function(e){
				$(".divImage").css({"background-image":"url("+e.target.result+")","background-position":"center","background-size":"cover"});
				let img = "<img src="+e.target.result+" style='width:20%;' />";
				$("#divImage").append(img); 
			}
			reader.readAsDataURL(f);
		});
	} // 이미지 미리보기 끝
	
	// 모달창 닫기 시작
	$('#insertCancel').on("click",function(){
		$(".modal").modal("hide");
	});
   
	$('#modifyCancel').on("click",function(){
		$(".modal").modal("hide");
	});	
	
	// 모달창 닫을때 초기화 하기
	$('.modal').on('hidden.bs.modal', function (e) {
		// 앨범 추가 부분 초기화
		$(this).find('#albumNm').val('');			// 앨범 이름 초기화
		$(this).find('input[type=file]').val('');	// 파일 초기화
		$(this).find('#divImage').html('');			// 이미지 미리보기 초기화
		$(this).find('#tag-list').html('');			// 입력된 해시태그 초기화
		$(this).find('#tag').val('');				// 해시태그 입력부분 초기화
	}); // 모달창 닫기 끝

	$(document).ready(function(){
		loadAlbumTagList();	// 페이지 로드 시 앨범 태그를 불러옴
	    loadAlbumList();	// 페이지 로드 시 앨범 리스트를 불러옴
	});
	
	// 전체보기 버튼 클릭시 리스트 출력
	$("#btnList").on("click", function(){
		loadAlbumList();
	});
	
	//해시태그 
	var tag = {};
	var counter = 0;

	// 입력한 값을 태그로 생성한다.
	function addTag(value) {
	    tag[counter] = value;
	    counter++; // del-btn의 고유 id
	}

	// tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
	function marginTag() {
	    return Object.values(tag).filter(function (word) {
	        return word !== "";
	    });
	}

	// 서버에 제공
	$("#tag-form").on("submit", function (e) {
	    var value = marginTag(); // return array
	    $("#rdTag").val(value);
	
	    $(this).submit();
	});

	 $("#tag").on("keypress", function (e) {
		var self = $(this);

		//엔터나 스페이스바 눌렀을때 실행
		if (e.key === "Enter" || e.keyCode == 32) {
			var tagValue = self.val(); // 값 가져오기

			// 해시태그 값 없으면 실행X
			if (tagValue !== "") {
				// 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
				var result = Object.values(tag).filter(function (word) {
					return word === tagValue;
				});

				// 해시태그가 중복되었는지 확인
				if (result.length == 0) {
					$("#tag-list").append("<li class='tag-item'>" + tagValue + "<span class='del-btn' idx='" + counter + "'>x</span></li>");
					addTag(tagValue);
					self.val("");
				} else {
					Swal.fire({
						title: '태그값이 중복됩니다.',
						text: "다시 입력하세요.",
						icon: 'warning',
						showCancelButton: false,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33'
					})
				}
			}
			e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
		}

		// 삭제 버튼 
		// 인덱스 검사 후 삭제
		$(document).on("click", ".del-btn", function (e) {
			var index = $(this).attr("idx");
			tag[index] = "";
			$(this).parent().remove();
		});
	});	

	// 앨범 리스트 불러오기
	function loadAlbumList(){
		// 페이지 네이션
		let currentPage = "${param.currentPage}";
		if(currentPage == ""){
			currentPage = "1";
		}
		
		let data = {
			"clasCode": "${CLASS_INFO.clasCode}",
			"keyword" : "${param.keyword}",
			"currentPage" : currentPage
		};
		$.ajax({
		    url: "/gallery/albumListAjax",
		    contentType: "application/json; charset=utf-8",
		    data: JSON.stringify(data),
		    type: "post",
		    dataType: "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
		    success: function (result) {
		        var albumCount = 0;
		        var str ="";

		        if(result.total ===0){
		        	str += `<div style="text-align: center;font-size: 1.1rem;">등록된 앨범이 없습니다.</div>`;
					document.querySelector('.container').innerHTML = str;
		        }else{
			        $.each(result.content, function (idx, clasAlbumVO) {
				        var albumDate = new Date(clasAlbumVO.albumDe);
			        	
			        	// 썸네일 사진 가지고 오기(파일명에 's_' 붙은거 가지고 오려고 합니다)
			        	// 파일 경로(ex : /2024/03/13/)
			        	var folderPath = clasAlbumVO.atchFileCours.substring(0, clasAlbumVO.atchFileCours.lastIndexOf("/") + 1);
			        	// 파일 이름 갖고오기(ex : 51e7d73a-b77e-44bc-9a3f-95ce81d3099c_P1234.jpg)
				        var fileName = clasAlbumVO.atchFileCours.substring(clasAlbumVO.atchFileCours.lastIndexOf("/") + 1);
				        // 썸네일 파일 경로
				        var thumbnailPath ="/upload"+folderPath + "s_" + fileName;
				       	
			        	// 새로운 row 시작
			            if(albumCount % 4 == 0) {
			                str += "<div class='row'>";
			            }
		 	            str += "<div class='col-lg-3 col-md-6 col-sm-6 col-xs-12' style='height: 440px; width: 280px;margin:5px;'>";
			            str += "<div class='courses-inner res-mg-b-30' style='height: 440px; width: 280px; margin:10px; border-radius:10px'>";
			            str += "<div style='text-align: center;'>";
		 	            
		 	        	// 신고가 된 게시물은 조회가 되지않도록
						if ( clasAlbumVO.nttSttemntSttus === "A15001" ) {						
		 	            	str += "<img alt='로고' id='studImage' src='" + thumbnailPath + "' onclick=\"location.href='/gallery/galleryDetail?atchFileCode=" + clasAlbumVO.atchFileCode +"'\" style='cursor: pointer;'>"; // 수정된 부분
						} else {
							str += `<img alt='신고된게시물' src='/upload/admin/errorImg.png' onclick="javascript:alertError('신고가 접수된 게시글입니다.')" style="width: 220px; height: 270px; cursor: pointer;"/>`;
						}
			            str += "</div>";
			            str += "<div class='courses-title'>";
			            str += "<h2>" + clasAlbumVO.albumNm + "</h2>";
			            str += "</div>";
			            str += "<div>";
			            str += "<p id='albumDate'>작성 일자 : "+ albumDate.toLocaleDateString() + "</p>";
			            str += "</div>";
			            str += "<div>";
			            str += "<p>작성자 : "+ clasAlbumVO.mberNm + "</p>";
			            str += "</div>";
			            str += "</div>";
			            str += "</div>";
			        
				     	// 한 줄에 4개씩 출력하도록 설정
			            if(albumCount % 4 == 3) {
			                str += "</div>"; // row 닫기
			            }
			
			            albumCount++;
			        });      
			            
		         	// 마지막에 row가 닫히지 않은 경우를 위해 확인 및 닫기
		            if(albumCount % 4 != 0) {
		                str += "</div>"; // 마지막 줄의 row 닫기
		            }
			        $('.courses-area').empty();
			        $('.courses-area').prepend(str);
			        
			        // 페이징 처리
			        $("#divPaging").html(result.pagingArea);
		    	}
			    
		    }
		});
	}
	
	// 우리반 해시태그 출력
	function loadAlbumTagList(){
	    let data = {
	        "clasCode": "${CLASS_INFO.clasCode}"
	    };
	    
	    $.ajax({
	        url:"/gallery/albumTagList",
	        contentType:"application/json; charset=utf-8",
	        data: data, // JSON.stringify(data) 대신 data를 직접 전달
	        type: "post",
	        dataType: "json",
	        beforeSend:function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success: function(result) {
	            var hashTagStr = "";
	            
	            $.each(result, function(idx, str){
		            hashTagStr += "<button type='button' id='hashtag' class='btn btn-custon-rounded-three btn-default tag' data-tag ='"+str+"'>";
		            hashTagStr += "<span>#</span>";
		            hashTagStr += str ;
		            hashTagStr += "</button>";
	            });
	            
	            $('.hashTag').html(hashTagStr);
	        }
	    });
	}

	$(document).on('click', '.tag',function(){
    	var tag = $(this).data('tag').toString();
    	let keyword = tag;							// 클릭한 태그 keyword로 지정
		let currentPage = "${param.currentPage}";	// 페이지 네이션
		if(currentPage == ""){
			currentPage = "1";
		}
		
		let data = {
			"clasCode": "${CLASS_INFO.clasCode}",
			"keyword" : keyword,
			"currentPage" : currentPage
		};
		
		$.ajax({
		    url: "/gallery/albumListAjax",
		    contentType: "application/json; charset=utf-8",
		    data: JSON.stringify(data),
		    type: "post",
		    dataType: "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
		    success: function (result) {
		        var albumCount = 0;
		        var str ="";

		        $.each(result.content, function (idx, clasAlbumVO) {
			        var albumDate = new Date(clasAlbumVO.albumDe);
		        	
		        	// 썸네일 사진 가지고 오기(파일명에 's_' 붙은거 가지고 오려고 합니다)
		        	// 파일 경로(ex : /2024/03/13/)
		        	var folderPath = clasAlbumVO.atchFileCours.substring(0, clasAlbumVO.atchFileCours.lastIndexOf("/") + 1);
		        	// 파일 이름 갖고오기(ex : 51e7d73a-b77e-44bc-9a3f-95ce81d3099c_P1234.jpg)
			        var fileName = clasAlbumVO.atchFileCours.substring(clasAlbumVO.atchFileCours.lastIndexOf("/") + 1);
			        // 썸네일 파일 경로
			        var thumbnailPath ="/upload"+folderPath + "s_" + fileName;
			       	
		        	// 새로운 row 시작
		            if(albumCount % 4 == 0) {
		                str += "<div class='row'>";
		            }
		            str += "<div class='col-lg-3 col-md-6 col-sm-6 col-xs-12' style='height: 440px; width: 280px;margin:5px;'>";
		            str += "<div class='courses-inner res-mg-b-30' style='height: 440px; width: 280px; margin:10px; border-radius:10px'>";
		            str += "<div style='text-align: center;'>";
	 	            
	 	        	// 신고가 된 게시물은 조회가 되지않도록
					if ( clasAlbumVO.nttSttemntSttus === "A15001" ) {						
	 	            	str += "<img alt='로고' id='studImage' src='" + thumbnailPath + "' onclick=\"location.href='/gallery/galleryDetail?atchFileCode=" + clasAlbumVO.atchFileCode +"'\" style='cursor: pointer;'>"; // 수정된 부분
					} else {
						str += `<img alt='신고된게시물' src='/upload/admin/errorImg.png' onclick="javascript:alertError('신고가 접수된 게시글입니다.')" style="width: 220px; height: 270px; cursor: pointer;"/>`;
					}
		            str += "</div>";
		            str += "<div class='courses-title'>";
		            str += "<h2>" + clasAlbumVO.albumNm + "</h2>";
		            str += "</div>";
		            str += "<div>";
		            str += "<p id='albumDate'>작성 일자 : "+ albumDate.toLocaleDateString() + "</p>";
		            str += "</div>";
		            str += "<div>";
		            str += "<p>작성자 : "+ clasAlbumVO.mberNm + "</p>";
		            str += "</div>";
		            str += "</div>";
		            str += "</div>";
		        
			     	// 한 줄에 4개씩 출력하도록 설정
		            if(albumCount % 4 == 3) {
		                str += "</div>"; // row 닫기
		            }
		
		            albumCount++;
		        });      
		            
	         	// 마지막에 row가 닫히지 않은 경우를 위해 확인 및 닫기
	            if(albumCount % 4 != 0) {
	                str += "</div>"; // 마지막 줄의 row 닫기
	            }
	 
				$('.courses-area').empty();
				$('.courses-area').prepend(str);
				
				// 페이징 처리
				$("#divPaging").html(result.pagingArea);
			}
		});
	});

    // 앨범 추가하기 버튼 클릭 이벤트
	$("#btnNew").on("click", function(){
        let clasCode = "${CLASS_INFO.clasCode}";
        let albumNm = $("#albumNm").val();    	// 사진 제목
        let albumDe = $("#albumDe").val();    	// 등록일자
        let mberNm = $("#mberNm").val();    	// 작성자
        let inputImgs = $("#inputImgs")[0]; 	// 파일
        let albumTag =	marginTag(); 			// 해시태그 값 가져오기
        
        // 앨범등록시 null 체크
        if(albumNm == null || albumNm==''){
        	Swal.fire({
				title: '앨범 이름을 입력해주세요!',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33'
      	    })
        	return;
        }
        else if(albumTag == null || albumTag==''){
        	Swal.fire({
				title: '해시태그를 등록 해주세요!',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33'
			})
          	return;
		}
        else if(inputImgs.files.length === 0){
        	Swal.fire({
				title: '사진을 등록 해주세요!',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33'
			})
          	return;
		}// null 체크 끝        

        // 이미지 파일 꺼내오기
        let files = inputImgs.files;
        
        // FormData 객체 생성(가상 폼)
        let formData = new FormData();
        formData.append("clasCode",clasCode);
        formData.append("albumNm",albumNm);
        formData.append("albumDe",albumDe);
        formData.append("mberNm",mberNm);
        formData.append("inputImgs",inputImgs);
        
        albumTag.forEach(function(str, idx ){
	        //albumTag : 111,222,333
	        formData.append("albumTagVOList["+idx+"].tagNm", str);
        });

        // FormData에 각각의 이미지를 넣는다.
        for(let i = 0; i < files.length; i++){
            formData.append('uploadFile',files[i]);
        }       
        
        $.ajax({
            url:"/gallery/createAlbum",
            processData:false,
            contentType:false,
            data:formData,
            type:"post",
            dataType:"json",
            beforeSend:function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            },
            success:function(result){
               $("#modalInsert").modal('hide');
               
                // 앨범 등록 완료 알림 창
                Swal.fire({
					icon: 'success',
					title: '앨범이 등록되었습니다.',
					text: '목록으로 이동합니다.'
				});
                loadAlbumList();
                loadAlbumTagList();
            },
            error: function(xhr, status, error) {
                // 앨범 등록 실패 알림 창
                Swal.fire({
					icon: 'error',
					title: '앨범 등록에 실패하였습니다.',
					text: '다시 시도해주세요.'
				});
            }
        });//end ajax
	});
});
</script>
<style>
img#studImage {
	width: 250px;
	height: 270px;
	display: block; /* 이미지를 블록 요소로 만들어 가운데 정렬 */
	margin: 0 auto; /* 이미지를 가로로 가운데 정렬 */
}

div#divImage {
	padding: 5px 30px 5px 30px;
	text-align: center;
}

.courses-inner.res-mg-b-30 {
	border: 1px solid #ccc;
	margin-bottom: 10px;
}

span.del-btn {
	padding: 4px;
}

li.tag-item {
	padding: 5px;
}

ul#tag-list {
	display: flex;
}

.pagination {
	display: inline-flex;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px;
	transform: translate(-380px, -10px);
}

#GalleryContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 500px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#GalleryContainer {
	min-height: 790px;
}

#GalleryContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#GalleryContainer .custom-pagination .pagination {
	width: max-content;
}

.hashTag {
	text-align-last: center;
}

.modal-body {
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(99, 117, 141, 0.5), inset -8px -8px
		16px 0px rgba(99, 117, 141, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	padding-top: 35px;
	padding-bottom: 35px;
	margin: 50px;
	margin-bottom: 40px;
}

h4 {
	text-align: center;
}

button#hashtag {
	margin: 0 3px;
	border-radius: 15px;
	background: #FCC25B;
	font-size: 1.0rem;
	color: black;
	border-color: #FCC25B;
	width: auto;
	display: inline-block;
}

img#studImage {
	object-fit: contain;
}

.courses-title h2 {
	color: #303030;
	margin-top: 13px;
	font-size: 1.3rem;
}

#btnNewFolder, #btnList, #insertCancel,#btnNew {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}

#btnNewFolder:hover, #btnList:hover, #insertCancel:hover, #btnNew:hover {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
	font-weight: 700;
}

#btnNewFolder,
#btnNew {
	background: #006DF0;
}
#btnList{
	background:#666;
}
#insertCancel{
	background:#df3c3c;
}
</style>
<div id="GalleryContainer">
	<div class="sparkline8-hd">
		<div class="main-sparkline8-hd">
			<h3>
				<img src="/resources/images/classRoom/gallery/galleryIcon1.png"
					style="width: 50px; display: inline-block; vertical-align: middel;">
				<span id="schoolNm"></span> <span>&nbsp;우리반 갤러리</span> <img
					src="/resources/images/classRoom/gallery/galleryIcon2.png"
					style="width: 50px; display: inline-block; vertical-align: middel;">
			</h3>
		</div>
	</div>
	<div>
		<h4>우리반 앨범 해시태그</h4>
		<div class="hashTag" style="margin: 10px;"></div>	
	</div>
	<div class="row" style="margin-bottom: 20px;">
		<!-- 앨범 추가하기 버튼 시작 -->
		<div class="col-md-10 text-right" id="newAlbumForm" style="margin-left: 45px;">
			<!-- 학생일때 앨범추가하기 -->
			<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A01001'}">
				<button type="button" 
					id="btnNewFolder" class="btn btn-custon-rounded-four btn-primary" 
					data-toggle="modal" data-target="#modalInsert">앨범 추가하기</button>
			</c:if>
			<button type="button" id="btnList" class="btn btn-custon-rounded-four btn-default">전체보기</button>
		</div>
		<!-- 앨범 추가하기 버튼 끝 -->
	</div>

	<div class="container">
		<div class="courses-area">
			<div style="text-align: center;font-size: 1.1rem;">등록된 앨범이 없습니다.</div>
		</div>
	</div>
	<div>
		<div class="pull-right pagination" id="divPaging"></div>
	</div>
</div>
<!-- 새 앨범 등록 모달 시작-->
<div id="modalInsert" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header header-color-modal bg-color-1">
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
				</div>
			</div>
			<div class="modal-body">
				<h2>앨범 등록</h2>
				<div class="form-group">
					<label for="">앨범 이름</label> 
					<input type="text" class="form-control is-valid" id="albumNm" name="albumNm" placeholder="앨범 이름" />
				</div>
				<div class="form-group">
					<label for="">앨범 등록 날짜</label>
					<input type="text" name="" class="form-control" id="albumDe" name="albumDe" placeholder="현재날짜 표시" required readonly />
				</div>
				<div class="form-group">
					<div class="tr_hashTag_area">
						<p>
							<label for="">해시태그</label>
						</p>
						<div class="form-group">
							<input type="hidden" value="" name="tag" id="rdTag" />
						</div>
			
						<div class="form-group" class="sr-input-func">
							<input type="text" id="tag" size="7" class="search-int form-control" placeholder="엔터로 해시태그를 등록해주세요."/>
						</div>
						<ul id="tag-list"></ul>
					</div>
				</div>
				<div class="form-group">
					<label for="">사진 첨부</label>
					<input type="file" class="form-control" id="inputImgs" multiple>
				</div>
			</div>
			<div id="divImage"></div>
			<div class="modal-footer">
				<button id="btnAuto" style="background:white; border:white">
					<i class="fa fa-pencil-square-o" aria-hidden="true" style="height:25px; width:25px; margin:5px; margin: 20px 10px 0 10px;"></i>
				</button>
				<button type="button" class="btn btn-custon-rounded-four btn-default" id="insertCancel">등록 취소</button>
				<button type="button" class="btn btn-custon-rounded-four btn-primary" id="btnNew">등록</button>
			</div>
		</div>
	</div>
</div>
<!-- 새 앨범 등록 모달 끝-->