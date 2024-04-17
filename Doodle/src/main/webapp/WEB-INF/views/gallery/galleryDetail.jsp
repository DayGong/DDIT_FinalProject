<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!-- 스와이프 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
window.onload = function() {
   document.getElementById("btnList").addEventListener("click",()=>{
      location.href = "/gallery/gallery?clasCode=" + "${CLASS_INFO.clasCode}";
   })
   
   // 사용자 세션 확인용 -> 지워도 됩니다.
   console.log("sessionMemberVO => " + `${sessionMemberVO}`);
}

<!-- 신고 submit javascript 시작 --------------------------------->
// 신고 후 게시물 신고 누적과 게시물 신고 상태를 update하는 함수
function fn_modNttSttemnt(atchFileCode) {
	console.log("atchFileCode -> " + atchFileCode);
	$.ajax({
		type: "post",
		url: "/gallery/modNttSttemnt",
		data: { "atchFileCode" : atchFileCode },
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(res) {
			console.log("res => " + res);
		}
	});
}

// 신고 게시판에 신고를 등록하는 함수
function fn_addComplaint() {
	let atchFileCode = "${param.atchFileCode}";
	let sttemntLeng = document.querySelectorAll("input[name='complaintCn']:checked").length;
	
	if (sttemntLeng == 0) { alertError('신고 내용을 입력해주세요'); return; }
	let sttemntCn = document.querySelector("input[name='complaintCn']:checked").value;
	
	let formData = new FormData();
	formData.append("nttSe", "bbsAlbum");						// 게시물 구분
	formData.append("nttCode", atchFileCode);					// 게시물 코드
	formData.append("cmmnSttemntCn", sttemntCn);				// 공통 신고 내용(A24)
	formData.append("sttemntId", `${sessionMemberVO.mberId}`);	// 신고자 아이디
	
	$.ajax({
		type: "post",
		url: "/admin/addComplaint",
		processData: false,
		contentType: false,
		data: formData,
		dataType: "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(result) {
			let res = "신고가 정상적으로 접수되었습니다.";
			let icon = "success";
			
			if (result != 1) { res = "신고를 실패하였습니다."; icon = "error"; }
			if (result == 1) { fn_modNttSttemnt(atchFileCode); }
			
			Swal.fire({
		      title: res,
		      text: ' ',
		      icon: icon
			}).then(result => { location.href = "/gallery/gallery?clasCode=" + "${clasCode}"; });
		}
	});
}
<!-- 신고 submit javascript 끝 ----------------------------------->

$(function(){
	//날짜 포맷 생성  함수
	function dateFormat(date) {
		let dateFormat2 = date.getFullYear() +
		'-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
		'-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
		return dateFormat2;
	}
	
	$("#atchFileDe").val(dateFormat(new Date()));	// 파일 등록 일자
	$("#updtDe").val(dateFormat(new Date()));		// 수정 일자
	// 날짜 함수 끝~
	
	
	// 갤러리 상세내용 불러오기
	loadGalleryDetail();
	function loadGalleryDetail(){
		$.ajax({
		    url: "/gallery/galleryDetailAjax",
		    contentType: "application/json;charset=utf-8",
		    data: {
		        atchFileCode: "${param.atchFileCode}"
		    },
		    type: "get",
		    dataType: "json",
		    success: function(result) {
		        console.log("result : ", result);
		
		        let carouselItems = "";
		        let index = 0; // 캐러셀 인덱스 변수 추가
		        let mberId = "${mberId}";	// 로그인한 아이디
		        
		        if(result.length === 1) {
		        	$('.carousel-button').hide();
		        }
		        
		        $.each(result, function(idx, clasAlbumVO) {
		        	if(mberId===clasAlbumVO.mberId){
		        		$('#btnModify').show();
		                $('#btnDeleteAll').show();
		        	}else{
		        		$('#btnModify').hide();
		                $('#btnDeleteAll').hide();
		        		
		        	}
		        	
		            $.each(clasAlbumVO.atchFileVOList, function(innerIdx, atchFileVO) {
		                carouselItems += "<div class='swiper-slide'>";
		                carouselItems += "<img src='/upload" + atchFileVO.atchFileCours + "'alt='" + atchFileVO.atchFileNm + "'>";
		                carouselItems += "</div>";
		            });
		        });
		        
		        // 앨범에 등록된 해시태그 출력
		        let hashTag = "";
		        
	        	$.each(result[0].albumTagVOList, function(idx, albumTagVO){
	        		if(albumTagVO.tagNm !==null){
		        		hashTag += `<label class="hashTagList">#\${albumTagVO.tagNm}&nbsp;</label>`;
	        		}else{
	        			hashTag +=`<div></div>`;
	        		}
	        	})
		        	
		        console.log("hashTag : ",hashTag);
	        	$(".hashTagList").html(hashTag);
	        	

	        	// 캐러셀에 이미지 추가
		        $('.swiper-slide').html(carouselItems);
		
		        let carouselImages = $('.swiper-slide img');
		        carouselImages.hide().first().show(); // 첫 번째 이미지만 표시
		
		        // 캐러셀 버튼 이벤트 설정(다음 버튼)
		        document.querySelector('.next').addEventListener('click', function() {
		            carouselImages.eq(index).hide();
		            index = (index + 1) % carouselImages.length;
		            carouselImages.eq(index).show();
		        });
		
		        // 캐러셀 버튼 이벤트 설정(이전 버튼)
		        document.querySelector('.prev').addEventListener('click', function() {
		            carouselImages.eq(index).hide();
		            index = (index - 1 + carouselImages.length) % carouselImages.length;
		            carouselImages.eq(index).show();
		        });
		
		        // 앨범 정보 데이터 설정(같은 앨범속 사진이므로 [0]번째 데이터를 추출함.)
		        document.querySelector(".albumTitle").value = result[0].albumNm;
		        document.querySelector(".albumRegister").textContent = result[0].mberNm;
		        let albumDe = dateFormat(new Date(result[0].albumDe));
		        document.querySelector(".albumRegistDate").textContent = albumDe;
		        
		     	// 수정 버튼 클릭시 기존제목, 기존사진, 기존 해시태그 가져와서 input요소에 설정함.
		        document.querySelector("#btnModify").addEventListener("click", function() {
		            // 앨범 제목 설정
		            document.querySelector("#albumNmModify").value = result[0].albumNm;
		            
		            // 날짜 설정
		            let albumUpdtDe = dateFormat(new Date());
		            document.querySelector("#albumUpdtDe").value = albumUpdtDe;

		            // 이미지 추가
		            let imagesHTML = '';
		            $.each(result, function(idx, clasAlbumVO) {
		                $.each(clasAlbumVO.atchFileVOList, function(innerIdx, atchFileVO) {
		                    imagesHTML += "<div class='swiper-slide'>";
		                    imagesHTML += "<img src='/upload" + atchFileVO.atchFileCours + "'alt='" + atchFileVO.atchFileNm + "'>";
		                    imagesHTML += "</div>";
		                });
		            });
		            $('#divImage').html(imagesHTML);

		            // 해시태그 추가
		            let hashTagHTML = '';
		            $.each(result[0].albumTagVOList, function(idx, albumTagVO) {
		                hashTagHTML += "<li class='tag-item'>" + albumTagVO.tagNm + "<span class='del-btn' idx='" + idx + "'>x</span></li>";
		            });
		            $('#tag-list').html(hashTagHTML);

		        });
		     	
				/* 신고 javascript 시작 ----------------------------------------------------------------------------------- */
		    	document.querySelector("#complaintBtn").addEventListener("click", function() {
		    		document.querySelector("#complaintNm").innerHTML = result[0].albumNm;
		    		document.querySelector("#complaintDe").innerHTML = albumDe;
		    		document.querySelector("#complaintMber").innerHTML = result[0].mberNm;
		    		
		    		$.ajax({
		    			type: "get",
		    			url: "/admin/getComplaintCn",
		    			dataType: "json",
		    			success: function(res) {
		    				let html = "";
		    				for(let i = 0; i < res.length; i++) {
		    					let resRow = res[i];
		    					html += `<tr>
		    								<td>
		    									<input type="radio" name="complaintCn" id="complaintCn\${i}" value="\${resRow.cmmnDetailCode}"/>
		    									<label for="complaintCn\${i}">\${resRow.cmmnDetailCodeNm}</label>
		    								</td>
		    							</tr>`;
		    				}
		    				document.querySelector("#complaintCnBox").innerHTML = html;
		    			}
		    		}); // end /admin/getComplaintCn Ajax
		    	});// end #complaintBtn click event
		    /* 신고 javascript 끝 ------------------------------------------------------------------------------------- */
		    }
		});
	}
	
	// 모달 내에서도 기존에 입력된 해시태그에 스크립트 적용하기
	$('#modalUpdate').on('show.bs.modal', function(e){
		let hashTagHTML = '';
	    $('#tag-list li').each(function(idx, tagItem) {
	        let tagText = $(tagItem).text();
	        hashTagHTML += "<li class='tag-item'>" + tagText + "<span class='del-btn' idx='" + idx + "'>x</span></li>";
	    });
	    $('#tag-list-modal').html(hashTagHTML);
	});
	
	
	// 모달창 닫기 시작
	$('#btnUpdateCancel').on("click",function(){
		$(".modal").modal("hide");
	});
	
	// 모달창 닫을때 초기화 하기
	$('.modal').on('hidden.bs.modal', function (e) {
		console.log('modal close');
		// 수정 부분 초기화
		$(this).find('#atchFileNm').val('');		// 파일 이름 초기화
		$(this).find('input[type=file]').val('');	// 파일 초기화
		$(this).find('#divImage').html('');			// 이미지 미리보기 초기화
		$(this).find('#tag-list').html('');			// 입력된 해시태그 초기화
		$(this).find('#tag').val('');				// 해시태그 입력부분 초기화
		
	}); // 모달창 닫기 끝

	
	// 모달창 승인버튼 누를 시 update
	document.querySelector("#btnUpdate").addEventListener("click",function(){
		let pathname = window.location.pathname;
		pathname = "${param.atchFileCode}";//OJ20240101ALB00007
		pathname = pathname.substring(0,10);//OJ20240101
		console.log("pathname :  "  + pathname);
		
		let atchFileCode = "${param.atchFileCode}";
		let albumNm = $("#albumNmModify").val();	// 사진 제목
		let albumDe = $("#albumUpdtDe").val();		// 등록일자
		let inputImgs = $("#inputImgs")[0];			// 파일
		
		let files = inputImgs.files;				// 이미지 파일 꺼내오기
		
		// FormData 객체 생성(가상 폼)
		let formData = new FormData();
		formData.append("clasCode",pathname);//OJ20240101
		formData.append("albumNm",albumNm);
		formData.append("albumUpdtDe",dateFormat(new Date()));
		formData.append("inputImgs",inputImgs);
		formData.append("atchFileCode",atchFileCode);//*******앨범 하나 OJ20240101ALB00007
		
        for (let key of formData.keys()) {
        	console.log(key, ":", formData.get(key));
        }
		
		// FormData에 각각의 이미지를 넣는다.
		for(let i = 0; i < files.length; i++){
			formData.append('uploadFile',files[i]);
		}		
		
		$.ajax({
			url:"/gallery/updateAlbum",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//res : ClasAlbumVO
				console.log("insertImages->result: ", result);
				Swal.fire({
			        title: '갤러리를 수정하시겠습니까?',
			        text: "수정내용은 바로 반영됩니다.",
			        icon: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#3085d6',
			        cancelButtonColor: '#d33',
			        confirmButtonText: '예',
			        cancelButtonText: '아니오',
			        reverseButtons: false, // 버튼 순서 거꾸로
			        
			      }).then((result) => {
			        if (result.isConfirmed) {
				          Swal.fire(
				            '갤러리가 수정 되었습니다.',
				            '화면으로 이동합니다.',
				            'success'
				          ).then(function(){
							    $('.modal').modal('hide');
							    loadGalleryDetail();
							});
				        }
				     });
				},
				error: function(xhr, status, error){
					Swal.fire({
			            icon: 'error',
			            title: '갤러리 수정 중 오류가 발생했습니다',
			            text: '다시 확인해주세요.'
			        });
				}
		});//end ajax		
	});	
 
	
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
         // 이미지를 읽기
         let reader = new FileReader();
         
         $("#divImage").html("");
         
         reader.onload = function(e){
            $(".divImage").css({"background-image":"url("+e.target.result+")","background-position":"center","background-size":"cover"});
            let img = "<img src="+e.target.result+" style='width:20%;' />";
            $("#divImage").append(img); 
         }
         reader.readAsDataURL(f);
      });
   } // 이미지 미리보기 끝	
	
	
	// deleteAll 버튼 클릭시 앨범삭제하기
	$("#btnDeleteAll").on("click",function(){
		
		// url 주소에서 atchFileCode만 추출 
		let atchFileCode = window.location.search.split('=')[1];
		console.log("atchFileCode: " + atchFileCode);
		
		let clasCode = atchFileCode.split('ALB')[0];
		console.log("clasCode: " + clasCode);
		
		Swal.fire({
			   title: '정말로 삭제하시겠습니까?',
			   text: '삭제 후에 다시 되돌릴 수 없습니다.',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonColor: '#3085d6',
			   cancelButtonColor: '#d33',
			   confirmButtonText: '삭제',
			   cancelButtonText: '취소',
			   reverseButtons: false
			}).then(result => {
			   if (result.isConfirmed) {
			      let formData = new FormData();
			      formData.append("atchFileCode", atchFileCode);
			      
			      $.ajax({
			         url: "/gallery/deleteAlbum",
			         contentType: false,
			         processData: false,
			         data: formData,
			         type: "post",
			         dataType: "text",
			         beforeSend: function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			         },
			         success: function(result) {
			            if (result != "0") {
			               console.log("삭제처리");
			               Swal.fire('삭제 완료되었습니다.', '', 'success').then(() => {
			                   window.location.href = "http://localhost/gallery/gallery?clasCode="+"${CLASS_INFO.clasCode}";
			                });
			            } else {
			               Swal.fire('삭제 실패하였습니다.', '', 'error');
			            }
			         },
			         error: function(xhr, status, error) {
			            console.error("에러발생 :", error);
			            Swal.fire('삭제 중 오류가 발생했습니다.', '', 'error');
			         }
			      });
			   }
			});
	}); // 앨범 전체삭제 끝
	
});

</script>
<style>
.swiper-slide img {
	object-fit: contain;
	height : 620px; 
	width :100%;
	margin: 0px 15px;
	border-radius: 50px;
	box-shadow: 0px 0px 15px 1px #0000000c;
}
div#GalleryContainer {
	text-align: -webkit-center;
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
.GalleryAll, .replyContainer{
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}

.GalleryAll .free-cont{
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px 20px;
	min-height: 83px;
	margin-top: 50px;
}
.GalleryAll .FreeTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}


.GalleryAll .title{
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}
.sparkline8-list {
	padding: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.swiper-slide {
	text-align: center;
}

.gallery {
	height: 750px;
	text-align: -webkit-center;
    margin-top: 20px;
}

.hashTagList label {
	background: #FCC25B;
	padding: 1px 5px 1px 7px;
	margin: 5px;
	border-radius: 10px;
    font-size: 1.2rem;
}

/* 신고 시작 ----------------------------------------------------------------------------------- */
#complaintBtn {
	cursor: pointer;
}

.modal-content, .modal-body {
	width: 750px;
}

.modal-title {
	margin-left: 50px;
}

.table tbody tr td {
	vertical-align: middle;
}

#signUpContainer {
	color: #333;
	padding: 30px 40px;
	background-color: rgba(255, 255, 255, 0.6);
	border-radius: 26px;
	backdrop-filter: blur(6px);
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 100%;
}

#signUpContainer h2 {
	font-size: 2rem;
}

#signUpContainer span {
	font-size: 1.2rem;
}

.signUpinputAll, .signUpinputAll tr {
	text-align: left;
	width: 100%;
}

.signUpinputAll tr {
	display: block;
}

.signUpinputAll .tableT {
	width: 80px;
}

.signUpinputAll .tableM {
	width: 130px;
	font-size: 1.2rem;
}

.signUpinputAll tr {
	margin-bottom: 10px;
}

.tableT h2 {
	display: inline;
	vertical-align: middle;
}

.signUpTbody tr {
	width: 100%;
	font-size: 1.2rem;
}
.btn-zone{
	margin: auto;
	text-align: center;
}

.freeInfo{
	margin-top: 20px;
	padding-left: 10px;
	font-size: 1rem;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
}
#btnList, #btnDeleteAll, #btnModify{
	display:inline-block;
	text-align: center;
	background: #006DF0;
	padding: 15px 30px;
	font-size: 1rem;
	border: none;
	color: #fff;
	font-weight: 700;
	border-radius: 5px;
	margin-top: 30px;
	margin-bottom: 40px;
	margin-right:15px;
}
#btnDeleteAll{
	background: #111;
	color:#fff;
}

#btnModify{
	background: #666;
	color:#fff;
}

#btnList:hover,#btnModify:hover,#btnDeleteAll:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}
/* 신고 끝 ------------------------------------------------------------------------------------- */
</style>
<div id="GalleryContainer">
	<div class="main-sparkline8-hd">
		<h3>
			<img src="/resources/images/classRoom/gallery/galleryIcon1.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
			<span id="schoolNm"></span> <span>&nbsp;우리반 갤러리</span> <img
				src="/resources/images/classRoom/gallery/galleryIcon2.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
		</h3>
	</div>
	<div class="GalleryAll"
		style="width: 1400px; margin: auto; margin-bottom: 50px; min-height: 530px;">
		<div class="FreeTit">
			<img src="/resources/images/classRoom/gallery/galleryIcon3.png"
					style="width: 50px; display: inline-block; vertical-align: middel;">
			<input type="text" class="form-control albumTitle"
				style="width: 95%; border: none; background: none; height: 50px; font-size: 1.4rem; display: inline-block; vertical-align: middle; margin-bottom: 6px;" readonly>
				<img src="/resources/images/classRoom/freeBrd/line.png"
				style="position: absolute; left: 0px; top: 10px; z-index: -1;">
		</div>
		<div class="freeInfo">
			<span style="font-size: 14px;">
			<img src="/resources/images/classRoom/freeBrd/freeDateIcon.png" alt="게시글 등록일자 아이콘"
				style="width: 12px; margin-top: 4px; vertical-align: top; display: inline-block;" />
				<small style="font-weight: 600; color: #222; font-size: 13px;">등록일자: </small>
				<span class="albumRegistDate" style="color: #666; font-size: 13px;"></span>
			</span>
			<span style="margin-left: 15px; font-size: 13px;">
			<img src="/resources/images/classRoom/freeBrd/freePersonIcon.png" alt="게시글 작성자 아이디 아이콘"
				style="width: 12px; margin-top: 5px; vertical-align: top; display: inline-block;" />
				<small style="font-weight: 600; color: #222; font-size: 13px; line-height: 1.75;">작성자 : </small>
				<span class="albumRegister" style="color: #666; font-size: 13px;"></span>
			</span>
			<!----------------신고--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<span id="complaintBtn" data-toggle="modal"
				data-target="#complaintModal"
				style="font-size: 16px; float: right; margin-right: 10px;">
				<img src="/resources/images/classRoom/freeBrd/freeSiren.png"
				alt="게시글 신고 횟수 아이콘"
				style="width: 14px; margin-top: 2px; vertical-align: text-top; display: inline-block;" />
				<small style="font-weight: 600; color: #d9564e; font-size: 13px;">신고하기
			</small>
			</span>
			<!----------------신고 끝--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
		</div>
		<div class="gallery">
			<div class="swiper">
				<!-- 캐러샐 적용 시작 -->
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="..." alt="...">
					</div>
				</div>
				<div class="carousel-button">
					<div class="swiper-button-prev prev"></div>
					<div class="swiper-button-next next"></div>
				</div>
				<!-- 캐러샐 적용 끝 -->
			</div>
			<div class="image_aside">
				<div class="form-group" style="display:inline-grid;margin: 10px;">
					<label class="hashTagList"></label>
				</div>
				<div class="btn-zone">
					​​​​​​​​<input type="button" value="목록" id="btnList" />
					​​​​​​​​<input type="button" value="수정" id="btnModify" data-toggle="modal" data-target="#modalUpdate" style="display:none;"/> 
					​​​​​​​​<input type="button" value="삭제" id="btnDeleteAll" style="display:none;"/>
				</div>

			</div>

		</div>
	</div>
</div>


<!-- 앨범 수정 -->
<div id="modalUpdate" class="modal modal-edu-general default-popup-PrimaryModal fade in" role="dialog" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
			<div class="modal-header header-color-modal bg-color-1">
				<div class="modal-close-area modal-close-df">
					<a class="close" data-dismiss="modal" href="#"><i
						class="fa fa-close"></i></a>
				</div>
			</div>
			<div class="modal-body">

				<h2>앨범 수정</h2>
				<div class="form-group">
					<label for="">앨범 이름</label> <input type="text"
						class="form-control is-valid albumTitle" id="albumNmModify"
						placeholder="앨범 이름" />
				</div>

				<div class="form-group">
					<label for="">앨범 수정 날짜</label> <input type="text" name=""
						class="form-control" id="albumUpdtDe" name="albumUpdtDe"
						placeholder="현재날짜 표시" required readonly />
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
							<input type="text" id="tag" size="7"
								class="search-int form-control" placeholder="엔터로 해시태그를 등록해주세요." />
						</div>
						<ul id="tag-list"></ul>
					</div>
				</div>

				<div class="form-group">
					<label for="">사진 첨부</label> <input type="file" class="form-control"
						id="inputImgs" multiple>
				</div>
			</div>
			<div id="divImage"></div>
			<div class="modal-footer">
               <button type="button" class="btn btn-custon-rounded-four btn-primary" id="btnUpdate">수정</button>
               <button type="button" class="btn btn-custon-rounded-four btn-danger" id="btnUpdateCancel">수정 취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 신고 모달 창 시작 --------------------------------------------------------------->
<div id="complaintModal" class="modal modal-edu-general default-popup-PrimaryModal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header header-color-modal bg-color-1">
            	<table class="modal-title">
            		<tr>
            			<td class="tableT">
	            			<img src="/resources/images/admin/complaint.png" style="width:50px;">
	            			<h2>신고하기</h2>
            			</td>
            		</tr>
            	</table>
                <div class="modal-close-area modal-close-df">
                    <a class="close" data-dismiss="modal" href="#"><i class="fa fa-close"></i></a>
                </div>
            </div>
            <div class="modal-body">
				<div id="signUpContainer">
					<table class="signUpinputAll">
						<tbody class="signUpTbody" >
							<tr><td><h3>신고 게시물 정보</h3></td></tr>
							<tr>
								<td class="tableM"><span>제목</span></td>
								<td id="complaintNm"></td>
							</tr>
							<tr>
								<td class="tableM"><span>작성 일자</span></td>
								<td id="complaintDe"></td>
								<td style="width: 10%"></td>
								<td class="tableM"><span>작성자</span></td>
								<td id="complaintMber"></td>
							</tr>
						</tbody>
					</table>
					<hr/>
					<table class="signUpinputAll">
						<thead>
							<tr><td><h3>신고 내용</h3></td></tr>
						</thead>
						<tbody id="complaintCnBox" class="signUpTbody"></tbody>
					</table>
				</div>
            </div>
			<div style="text-align: center;"><span style="color: red; font-size: 1rem;">신고 후 취소는 불가합니다. 신중히 신고해주세요.</span></div>
            <div class="modal-footer">
            	<a href="javascript:fn_addComplaint()">신고하기</a>
                <a data-dismiss="modal" href="#">닫기</a>
            </div>
        </div>
    </div>
</div>
<!-- 신고 모달 창 끝  ---------------------------------------------------------------->
<script>
//해시태그 

var tag = {};
var counter = 0;

// 입력한 값을 태그로 생성한다.
function addTag(value) {
    tag[counter] = value;
    counter++; // del-btn 의 고유 id 가 된다.
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
</script>
<style>

</style>


