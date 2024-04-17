<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- Signature_pad -->
<!-- https://github.com/szimek/signature_pad -->
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>
<!-- Signature_pad -->
<style>

/* sign */
.wrapper {
	position: relative;
	width: 200px;
	height: 200px;
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

.signature-pad {
	position: absolute;
	left: 0;
	top: 0;
	width: 400px;
	height: 200px;
	background-color: white;
	border-radius: 10px;
}

.modal-content {
	width: 1000px;
	background-color: #e4eff9;
}

.modal-body {
	width: 998px;
	background-color: rgba(255, 255, 255, 0.6);
	border-radius: 26px;
	backdrop-filter: blur(6px);
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
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
	
}

#signUpContainer h2 {
	font-size: 2rem;
}

#signUpContainer span {
	font-size: 1.2rem;
}

.signUpinputAll, .signUpinputAll tr {
	text-align: left;
}

.signUpinputAll tr {
	display: block;
}

.signUpinputAll .tableT {
	width: 80px;
}

.signUpinputAll .tableM {
	width: 130px;
}

.signUpinputAll tr, #schoolDetailTitle {
	margin-bottom: 20px;
}

#file {
	width: 260px;
}
/* sign */
<!-- /* Font Definitions */
@font-face {
	font-family: Batang;
	panose-1: 2 3 6 0 0 1 1 1 1 1;
}

@font-face {
	font-family: Gulim;
	panose-1: 2 11 6 0 0 1 1 1 1 1;
}

@font-face {
	font-family: "Cambria Math";
	panose-1: 2 4 5 3 5 4 6 3 2 4;
}

@font-face {
	font-family: "Arial Unicode MS";
	panose-1: 2 11 6 4 2 2 2 2 2 4;
}

@font-face {
	font-family: "\@Gulim";
	panose-1: 2 11 6 0 0 1 1 1 1 1;
}

@font-face {
	font-family: GulimChe;
	panose-1: 2 11 6 9 0 1 1 1 1 1;
}

@font-face {
	font-family: "\@GulimChe";
}

@font-face {
	font-family: "Malgun Gothic";
	panose-1: 2 11 5 3 2 0 0 2 0 4;
}

@font-face {
	font-family: "\@Malgun Gothic";
}

@font-face {
	font-family: "\@Arial Unicode MS";
	panose-1: 2 11 6 4 2 2 2 2 2 4;
}

@font-face {
	font-family: 宋 ?;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HYSinMyeongJo-Medium;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HYGothic-Medium;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HY궁서;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "Yet R";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HYGothic-Extra;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "HCI Tulip";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: 휴먼명조;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HYMyeongJo-Extra;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HY울릉도M;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: -소망M;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: HY둥근고딕B;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: BatangChe;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}  

@font-face {
	font-family: "HCI Poppy";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "HCI Hollyhock";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: 휴먼고딕;
	panose-1: 0 0 0 0 0 0 0 0 0 0; 
}

@font-face {
	font-family: 함초롬돋움;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: 한컴바탕;
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HYSinMyeongJo-Medium";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HY울릉도M";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@宋?";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@휴먼명조";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@함초롬돋움";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@한컴바탕";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@휴먼고딕";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HYGothic-Extra";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HYMyeongJo-Extra";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@BatangChe";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HYGothic-Medium";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HY둥근고딕B";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@Batang";
	panose-1: 2 3 6 0 0 1 1 1 1 1;
}

@font-face {
	font-family: "\@-소망M";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@HY궁서";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}

@font-face {
	font-family: "\@Yet R";
	panose-1: 0 0 0 0 0 0 0 0 0 0;
}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal {
	margin: 0in;
	text-autospace: none;
	word-break: break-all;
	font-size: 11.0pt;
	font-family: "Malgun Gothic", sans-serif;
}

p.a, li.a, div.a {
	mso-style-name: 바탕글;
	margin: 0in;
	text-align: justify;
	text-justify: inter-ideograph;
	line-height: 103%;
	layout-grid-mode: char;
	text-autospace: none;
	word-break: break-all;
	font-size: 10.0pt;
	font-family: "HYSinMyeongJo-Medium", serif;
	color: black;
}

p.a0, li.a0, div.a0 {
	mso-style-name: 머리말;
	margin: 0in;
	text-align: justify;
	text-justify: inter-ideograph;
	text-autospace: none;
	font-size: 9.0pt;
	font-family: "함초롬돋움", serif;
	color: black;
}

.MsoChpDefault {
	font-family: "Malgun Gothic", sans-serif;
}   
/* Page Definitions */
@page WordSection1 {
	size: 595.25pt 841.85pt;
	margin: 70.85pt 42.5pt 42.5pt 42.5pt;
}

div.WordSection1 {
	page: WordSection1;
}
/* List Definitions */
ol {
	margin-bottom: 0in;
}

ul {
	margin-bottom: 0in;
}

input, textarea{
	background-color: white;
}

#updateBtn, #saveBtn, #sign, #tchrSaveBtn, #app-pdf-btn {
	vertical-align: middle;
	display: inline-block;
	border: none;
	height: 50px;
	text-align: center;
	font-weight: 700;
	width: 200px;
	margin: auto;
	border-radius: 10px;
	background: #006DF0;
	color: #fff;
	font-size: 1.2rem;
}

.goList, .cancelBtn {
	vertical-align: middle;
	display: inline-block;
	border: none;
	height: 50px;
	text-align: center;
	font-weight: 700;
	width: 200px;
	margin: auto;
	border-radius: 10px;
	background: #C0C0C0;
	color: #fff;
	font-size: 1.2rem;
}

#refusal, #deleteBtn {
	vertical-align: middle;
	display: inline-block;
	border: none;
	height: 50px;
	text-align: center;
	font-weight: 700;
	width: 200px;
	margin: auto;
	border-radius: 10px;
	background: #333;
	color: #fff;
	font-size: 1.2rem;
}

#save-png, #draw, #erase, #clear, #sign-close{
	vertical-align: middle;
	display: inline-block;
	border: none;
	height: 50px;
	text-align: center;
	font-weight: 700;
	width: 98px;
	margin: auto;
	border-radius: 10px;
	background: #333;
	color: #fff;
	font-size: 0.9rem;
	margin-top: 5px;
}

#sign-submit-btn {
	vertical-align: middle;
	display: inline-block;
	border: none;
	height: 50px;
	text-align: center;
	font-weight: 700;
	width: 98px;
	margin: auto;
	border-radius: 10px;
	background: #006DF0;
	color: #fff;
	font-size: 0.9rem;
}

.cancelBtn:hover, #updateBtn:hover, #deleteBtn:hover, #saveBtn:hover,
	#sign:hover, #tchrSaveBtn:hover, #refusal:hover, .goList:hover, #frm #btnPostNum:hover,
	#frm #idChk:hover, #app-pdf-btn:hover, #save-png:hover, #draw:hover, #erase:hover, 
	#clear:hover, #sign-close:hover, #sign-submit-btn:hover {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
}

/* 기본적으로는 보더가 없는 상태 */
input, textarea {
	border: none;
}

/* 호버 시에만 보더를 추가 */
input:hover, textarea:hover {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
}

/* 입력 포커스 시에도 보더를 추가 */
input:focus, , textarea:focus {
	background: #ffd77a;
	color: #333;
	transition: all 1s;
}

select {
	width: 17px;
	border: none;
	appearance: none;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="/resources/js/jquery.min.js"></script>


<script>
const docCode = '${sanctnDocVO.docCode}';
const clasStdntCode = '${sanctnDocVO.clasStdntCode}';
const cmmnGrade = '${sanctnDocVO.clasVO.cmmnGrade}';
const exprnLrnBgndeVal = '${sanctnDocVO.exprnLrnBgnde}';


//오늘의 날짜를 가져오는 함수
function getTodayDate(){
	var selectDate = new Date();
	var d = selectDate.getDate();
	var m = selectDate.getMonth() + 1;
	var y = selectDate.getFullYear();
   
	if(m < 10) m = "0" + m;
	if(d < 10) d = "0" + d;
   
	return y + "-" + m + "-" + d; 
}

// 이미지를 등록할 때 미리보기를 #small-image-show에 등록하는 함수
function displayPreviewImage(file) {
    var reader = new FileReader();
    reader.onload = function(e) {
        var img = new Image();
        img.src = e.target.result;
        img.onload = function() {
            var canvas = document.createElement('canvas');
            var ctx = canvas.getContext('2d');
            var aspectRatio = img.width / img.height; // 이미지의 가로 세로 비율 계산
            var targetWidth = 218; // 원하는 너비
            var targetHeight = 198; // 원하는 높이
            canvas.width = targetWidth;
            canvas.height = targetHeight;
            ctx.drawImage(img, 0, 0, targetWidth, targetHeight); // 이미지 크기 조정
            var smallImageShow = document.getElementById('small-image-show');
            smallImageShow.innerHTML = ''; // 이전 미리보기 삭제
            smallImageShow.appendChild(canvas); // 새로운 미리보기 추가
        };
    };
    reader.readAsDataURL(file);
}
 
/* pdf파일로 저장하는 function */
let jsPDF = jspdf.jsPDF;

function pdfPrint() {
    var pdfDiv = $('#pdfDiv')[0];
    html2canvas(pdfDiv, {
        scale: 2, // PDF의 해상도를 조절할 수 있습니다. 필요에 따라 조절해보세요.
        scrollY: -window.scrollY // 페이지 스크롤 위치를 고려하여 캡처합니다.
    }).then(function(canvas) {
        var filename = 'FieldSupply_' + getTodayDate(Date.now()) + '${sanctnDocVO.familyRelateVO.stdntVO.mberNm}.pdf';
        var doc = new jsPDF('p', 'mm', 'a4');

        // 이미지 데이터 생성
        var imgData = canvas.toDataURL('image/png');

        // 이미지 크기 계산
        var pageWidth = 190;
        var pageHeight = 297; // A4 용지 크기: 210mm x 297mm
        var margin = 10; // 출력 페이지 여백설정
        var imgWidth = pageWidth;
        var imgHeight = canvas.height * imgWidth / canvas.width;

        // 페이지 추가를 위한 높이 계산
        var heightLeft = imgHeight;
        var position = margin;

        // 이미지를 페이지에 추가
        doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);

        // 이미지가 여러 페이지에 걸칠 경우 처리
        heightLeft -= pageHeight;
        while (heightLeft >= 0) {
            position = heightLeft - imgHeight;
            doc.addPage(); // 새 페이지 추가
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
        }

        // 이미지 데이터 저장
        var imageDataBlob = dataURItoBlob(imgData);

        // PDF 저장
        doc.save(filename);

//         // 이미지 데이터 다운로드 링크 생성
//         var link = document.createElement('a');
//         link.href = URL.createObjectURL(imageDataBlob);
//         link.download = 'FieldSupply_' + getTodayDate(Date.now()) + '${sanctnDocVO.familyRelateVO.stdntVO.mberNm}.png';
//         link.click();
    });
}

// data URI를 Blob 객체로 변환하는 함수
function dataURItoBlob(dataURI) {
    var byteString = atob(dataURI.split(',')[1]);
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
    var ab = new ArrayBuffer(byteString.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ab], { type: mimeString });
}


function resultSAlert(result, actTitle, reloadPage) {
	let res = "성공";
	let icon = "success";
	
	if (result < 1) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.reload(); });
}
window.onload = function() {
	
	$('#app-pdf-btn').click(function(){
		pdfPrint();
	});
	
    $("#tcherSanctn").css("width", "193px");
    $("#tcherSanctn").css("height", "87.72px");

    $("#deputyPrncpalSanctn").css("width", "193px");
    $("#deputyPrncpalSanctn").css("height", "87.72px");

    /* 서명 등록 */
    $("#sign-submit-btn").on("click", function() {
    	//서명이 이미 등록되어 있다면
    	if('${SCHOOL_USER_INFO.sign}' !==''){
    		 // 담임일 경우
            <sec:authorize access = "hasRole('A14002')" >
                let tcherId = '${CLASS_TCH_INFO.mberId}';
                let tcherSanctn = '${SCHOOL_USER_INFO.sign}';
            </sec:authorize>
            // 교감일 경우 
            <sec:authorize access = "hasRole('A14005')" >
                let deputyPrncpalId = '${SCHOOL_USER_INFO.mberId}';
                let deputyPrncpalSanctn = '${SCHOOL_USER_INFO.sign}';
            </sec:authorize>
            var frm = new FormData($("#sign-frm")[0]);
            frm.append("docCode", docCode);

            // 담임일 경우
            <sec:authorize access = "hasRole('A14002')" >
                frm.append("tcherId", tcherId);
                frm.append("tcherSanctn", tcherSanctn);
            </sec:authorize>

            // 교감일 경우
            <sec:authorize access = "hasRole('A14005')" >
                frm.append("deputyPrncpalId", deputyPrncpalId);
                frm.append("deputyPrncpalSanctn", deputyPrncpalSanctn);
            </sec:authorize>

            $.ajax({
                url: "/approval/approvalSign",
                processData: false,
                contentType: false,
                data: frm,
                type: "post",
                dataType: "text",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(
                        "${_csrf.headerName}",
                        "${_csrf.token}");
                },
                success: function(result) {
                    // 성공했을때 1, 실패했을때 0
                    if (result == 1 || result == 2) {
                    	resultSAlert(result, '체험학습신청 결재를', '체험학습 상세 화면으로 이동합니다.');
                    } else {
                        alertError('서명 등록에 실패하였습니다.', ' ');
                    }
                }
            });
    	}else{
	        let file = $("#file").files;
	        // 담임일 경우
	        <sec:authorize access = "hasRole('A14002')" >
	            let tcherId = '${CLASS_TCH_INFO.mberId}';
	        </sec:authorize>
	        // 교감일 경우
	        <sec:authorize access = "hasRole('A14005')" >
	            let deputyPrncpalId = '${SCHOOL_USER_INFO.mberId}';
	        </sec:authorize>
	
	        var frm = new FormData($("#sign-frm")[0]);
	        frm.append("docCode", docCode);
	
	        // 담임일 경우
	        <sec:authorize access = "hasRole('A14002')" >
	            frm.append("tcherId", tcherId);
	        </sec:authorize>
	
	        // 교감일 경우
	        <sec:authorize access = "hasRole('A14005')" >
	            frm.append("deputyPrncpalId", deputyPrncpalId);
	        </sec:authorize>
	
	        $.ajax({
	            url: "/approval/approvalSign",
	            processData: false,
	            contentType: false,
	            data: frm,
	            type: "post",
	            dataType: "text",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(
	                    "${_csrf.headerName}",
	                    "${_csrf.token}");
	            },
	            success: function(result) {
	                // 성공했을때 2, 실패했을때 0
	                if (result == 2) {
	                	resultSAlert(result, '체험학습신청 결재를', '체험학습 상세 화면으로 이동합니다.');
	                } else {
	                    alertError('서명 등록에 실패하였습니다.', ' ');
	                }
	            }
	        });
    	}
    });
    
    
		
    /* 서명모달 닫기 */
    $("#sign-close").on("click", function() {
        $("#small-image-show").html("");
        $("#file").val("");
    });

    /* 신청 거절 */
    $("#refusal").on("click", function() {
        if (!confirm("체험학습 신청을 거절하시겠습니까?")) {
            alert("취소되었습니다.");
            return;
        }
        var data = {
            "docCode": docCode
        };

        $.ajax({
            url: "/approval/approvalRefuse",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(
                    "${_csrf.headerName}",
                    "${_csrf.token}");
            },
            success: function(result) {

                let clasCode = '${CLASS_INFO.clasCode}';

                if (result == 1) {
                    alert("체험학습 신청 거부가 완료되었습니다.");
                    //담임
                    <sec:authorize access = "hasRole('A14002')" >
                    	location.href = "/approval/approvalList?clasCode=" + clasCode;
                    </sec:authorize>
                    //교감
                    <sec:authorize access = "hasRole('A14005')" >
                    let schulCode = document.querySelector("#schulCode").value;
                    	location.href = "/approval/approvalList?schulCode=" + schulCode; //체험학습 신청 목록으로
                    </sec:authorize>
                } else {
                    alert("체험학습 신청 거부가 실패했습니다.");
                }
            }
        });
    });
    
	/* 목록으로 */
	$(".goList").on("click", function() {
		window.history.back();
	});

	 /* 결재창 열기 */
    $("#sign").on("click", function() {
    	//서명이 이미 있다면 보여주기
    	if('${SCHOOL_USER_INFO.sign}' !==''){
    		var img = $('<img>', {
    	        id: 'signature',
    	        src: '/upload/sign/' + '${SCHOOL_USER_INFO.sign}'
    	    });
    	    
    	    img.css({
    	        width: '218px',
    	        height: '198px'
    	    });
    		
    		$("#small-image-show").append(img);
    	}
    	
        // 이미지 파일을 선택하면 미리보기를 등록하는 이벤트 핸들러
        document.getElementById('file').addEventListener(
            'change',
            function() {
                var file = this.files[0];
                if (file) {
                    displayPreviewImage(file);
                }
            });

        /* sign */
        var canvas = document.getElementById('signature-pad');

        // 픽셀 비율을 고려하여 캔버스 좌표 공간을 조정합니다.
        // 모바일 장치에서 선명하게 보이도록 합니다.
        // 이것은 또한 캔버스가 지워지게 합니다.
        function resizeCanvas() {
            // 아주 이상한 이유로 100% 미만으로 축소하면,
            // 일부 브라우저는 devicePixelRatio를 1 미만으로 보고합니다.
            // 그러면 캔버스의 일부만 지워집니다.
            var ratio = Math.max(
                window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio); // 레티나 디스플레이 지원
        }

        // 모달이 열릴 때 resizeCanvas 함수를 호출하여 캔버스 크기를 조정
        $('#signPadModal').on('shown.bs.modal', function() {
            resizeCanvas();
        });

        // 창 크기가 변경될 때마다 캔버스 크기를 조정합니다.
        window.onresize = resizeCanvas;
        resizeCanvas();

        // 서명 패드를 생성합니다.
        var signaturePad = new SignaturePad(canvas, {
            backgroundColor: 'rgb(255, 255, 255)', // 배경색-흰색 rgb(255, 255, 255, 0) 투명색
            penColor: "rgb(1, 2, 3)" // 펜 색상(검정색)
        });

        // PNG 형식으로 서명 저장 버튼을 클릭할 때 동작합니다.
        document.getElementById('save-png').addEventListener(
            'click',
            function() {
                // 서명이 비어있는지 확인합니다.
                if (signaturePad.isEmpty()) {
                    return alert("서명을 부탁 드립니다");
                }

                // 서명을 PNG 이미지로 변환합니다.
                var data = signaturePad.toDataURL('image/png');

                // 이미지를 미리보기로 표시합니다.
                $("#img01").attr('src', data);

                /* 서명 저장 */
                var link = document.createElement('a');
                link.href = data;
                link.download = "image.png";
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                signaturePad.clear();
                /* 서명 저장 */
            });

        document.getElementById('clear').addEventListener(
            'click',
            function() {
                signaturePad.clear(); // 서명 지우기
            });

        document.getElementById('draw').addEventListener(
            'click',
            function() {
                var ctx = canvas.getContext('2d');
                ctx.globalCompositeOperation = 'source-over'; // 기본 그리기 모드로 설정
            });

        document.getElementById('erase').addEventListener(
            'click',
            function() {
                var ctx = canvas.getContext('2d');
                ctx.globalCompositeOperation = 'destination-out'; // 지우개 모드로 설정
            });
        /* sign */
    });
	 
	/* 결재창 닫기 */
	$("#tchrCancelBtn").on("click", function() {
		$("#tchrSaveDiv").css("display", "none");
		$("#tchrUpdateDiv").css("display", "block");
	});

	$("#tchrSaveBtn").on("click", function() {
		$("#tchrSaveDiv").css("display", "none");
		$("#tchrUpdateDiv").css("display", "block");
	});
	/* 신청서 삭제 */
    $("#deleteBtn").on("click", function() {
        if (!confirm("삭제하시겠습니까?")) {
            alert("삭제가 취소되었습니다.");
            return;
        }
        var data = {
            "docCode": docCode
        };

        $.ajax({
            url: "/approval/approvalDelete",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(
                    "${_csrf.headerName}",
                    "${_csrf.token}");
            },
            success: function(result) {
                if (result == 1) {
                    alert("게시글이 성공적으로 삭제되었습니다.");
                    location.href = "/approval/approvalList?clasStdntCode=" +
                        clasStdntCode; //체험학습 신청 목록으로
                } else {
                    alert("게시글 삭제가 실패했습니다.");
                }
            }
        });
    });
    /* 취소버튼 클릭 */
    $("#cancelBtn").on("click", function() {
        $("#updateDiv").css("display", "block");
        $("#saveDiv").css("display", "none");

        $("#exprnLrnBgnde").attr('disabled', true);
        $("#exprnLrnEndde").attr('disabled', true);
        //radio버튼 눌림 방지 
        $("input[type='radio']").attr("onclick", "return false;");
        $("#purps").attr('disabled', true);
        $("#dstn").attr('disabled', true);
        $("#docCn").attr('disabled', true);
        $("#rqstDe").attr('disabled', true);
    });


    /* 저장버튼 클릭 */
    $("#saveBtn").on("click", function() {

        //학습형태가 없을 때 
        if (document.querySelector('input[name="lrnStle"]:checked') == null || document.querySelector('input[name="lrnStle"]:checked') == '') {
            alertError('학습형태를 선택해주세요.', ' ');
            return;
        }

        let docCode = document.querySelector("#docCode").value;
        let cmmnDocKnd = document.querySelector("#cmmnDocKnd").value;
        let stdntId = document.querySelector("#stdntId").value;
        let exprnLrnBgnde = document.querySelector("#exprnLrnBgnde").value;
        let exprnLrnEndde = document.querySelector("#exprnLrnEndde").value;
        let lrnStle = document.querySelector('input[name="lrnStle"]:checked').value;
        let purps = document.querySelector("#purps").value;
        let dstn = document.querySelector("#dstn").value;
        let stdnprntId = document.querySelector("#stdnprntId").value;
        let docCn = document.querySelector("#docCn").value;
        let rqstDe = getTodayDate();
        let schulCode = document.querySelector("#schulCode").value;
        let clasCode = document.querySelector("#clasCode").value;
        let clasStdntCode = document.querySelector("#clasStdntCode").value;

        //체험학습시작일이 없을 때 
        if (exprnLrnBgnde == 'null' || exprnLrnBgnde == '') {
            alertError('체험학습시작일을 선택해주세요.', ' ');
            $("#exprnLrnBgnde").focus();
            return;
        }

        //체험학습종료일이 없을 때 
        if (exprnLrnEndde == 'null' || exprnLrnEndde == '') {
            alertError('체험학습종료일을 선택해주세요.', ' ');
            $("#exprnLrnEndde").focus();
            return;
        }

        //체험학습시작일이 체험학습종료일보다 클 때
        if (exprnLrnBgnde > exprnLrnEndde) {
            alertError('체험학습시작일이 체험학습종료일보다 클 수 없습니다.', ' ');
            $("#exprnLrnBgnde").focus();
            return;
        }

        //목적이 없을 때 
        if (purps == 'null' || purps == '') {
            alertError('목적을 입력해주세요.', ' ');
            $("#purps").focus();
            return;
        }

        //목적지가 없을 때 
        if (dstn == 'null' || dstn == '') {
            alertError('목적지를 입력해주세요.', ' ');
            $("#dstn").focus();
            return;
        }

        //체험학습계획이 없을 때 
        if (docCn == 'null' || docCn == '') {
            alertError('체험학습계획을 입력해주세요.', ' ');
            $("#docCn").focus();
            return;
        }

        let fieldStudyApplyFrm = new FormData($("#fieldStudyApplyFrm")[0]);
        fieldStudyApplyFrm.append("docCode", docCode);
        fieldStudyApplyFrm.append("cmmnDocKnd", cmmnDocKnd);
        fieldStudyApplyFrm.append("stdntId", stdntId);
        fieldStudyApplyFrm.append("exprnLrnBgnde", exprnLrnBgnde);
        fieldStudyApplyFrm.append("exprnLrnEndde", exprnLrnEndde);
        fieldStudyApplyFrm.append("stdnprntId", stdnprntId);
        fieldStudyApplyFrm.append("rqstDe", rqstDe);
        fieldStudyApplyFrm.append("schulCode", schulCode);
        fieldStudyApplyFrm.append("clasCode", clasCode);
        fieldStudyApplyFrm.append("clasStdntCode", clasStdntCode);

        $.ajax({
            url: "/approval/approvalUpdate",
            processData: false,
            contentType: false,
            data: fieldStudyApplyFrm,
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(
                    "${_csrf.headerName}",
                    "${_csrf.token}");
            },
            success: function(result) {

                //result : SanctnDocVO

                $("#updateDiv").css("display",
                    "block");
                $("#saveDiv")
                    .css("display", "none");

                resultAlert(result, '체험학습신청 수정을', '체험학습 상세 화면으로 이동합니다.');

            }
        });
    });

    /* 수정버튼 클릭 */
    $("#updateBtn").on("click", function() {
        $("#updateDiv").css("display", "none");
        $("#saveDiv").css("display", "block");
        $("#exprnLrnBgnde").removeAttr('disabled');
        $("#exprnLrnEndde").removeAttr('disabled');
        //radio버튼 눌림 방지 해제
        $("input[type='radio']").attr("onclick", "return true;");
        $("#purps").removeAttr('disabled');
        $("#dstn").removeAttr('disabled');
        $("#docCn").removeAttr('disabled');
        $("#rqstDe").removeAttr('disabled');
    });


    switch (cmmnGrade) {
        case "A22001":
            document.querySelector("#cmmnGrade").innerText = "1";
            break;
        case "A22002":
            document.querySelector("#cmmnGrade").innerText = "2";
            break;
        case "A22003":
            document.querySelector("#cmmnGrade").innerText = "3";
            break;
        case "A22004":
            document.querySelector("#cmmnGrade").innerText = "4";
            break;
        case "A22005":
            document.querySelector("#cmmnGrade").innerText = "5";
            break;
        case "A22006":
            document.querySelector("#cmmnGrade").innerText = "6";
            break;
    }

    let fieldStudyApplyFrm = document.fieldStudyApplyFrm;
    let lrnStle = '${sanctnDocVO.lrnStle}';

    if (lrnStle === "가족행사 참여를 통한 체험학습") {
        fieldStudyApplyFrm.lrnStle[0].checked = true;
    } else {
        fieldStudyApplyFrm.lrnStle[1].checked = true;
    }

    //radio버튼 눌림 방지
    $("input[type='radio']").attr("onclick", "return false;");

    // 체험학습시작일 시작 날짜를 클릭하면 오늘 이후로 날짜가 시작
    $('#exprnLrnBgnde').attr('min', getTodayDate());

    // 체험학습시작일 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정
    $("#exprnLrnBgnde").on("input", function() {
        let exprnLrnBgnde = $('#exprnLrnBgnde').val();
        $('#exprnLrnEndde').attr('min', exprnLrnBgnde);
    });

    // 체험학습종료일 종료 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정
    $("#exprnLrnEndde").on("input", function() {
        let exprnLrnEndde = $('#exprnLrnEndde').val();
        $('#exprnLrnBgnde').attr('max', exprnLrnEndde);
    });
    
    //담임이 서명하면 
	if ('${sanctnDocVO.tcherSanctn}' !== '') {
	    var img = $('<img>', {
	        id: 'tcherSanctn',
	        src: '/upload/sign/' + '${sanctnDocVO.tcherSanctn}'
	    });
	    
	    img.css({
	        width: '197.72px',
	        height: '87.72px'
	    });
	
	    $('#tcherSanctnTd').append(img);
	}
    
    //교감이 서명하면 
	if ('${sanctnDocVO.deputyPrncpalSanctn}' !== '') {
	    var img = $('<img>', {
	        id: 'deputyPrncpalSanctn',
	        src: '/upload/sign/' + '${sanctnDocVO.deputyPrncpalSanctn}'
	    });
	    
	    img.css({
	        width: '197.72px',
	        height: '92.44px'
	    });
	
	    $('#deputyPrncpalSanctnTd').append(img);
	}

}
</script>
<div class=WordSection1 id="pdfDiv" style="width: 810px; margin: auto;">
	<form id="fieldStudyApplyFrm" name="fieldStudyApplyFrm" method="post" style="width: 810px;">
		<input type="text" id="docCode" name="docCode" style="display: none;"
			value="${sanctnDocVO.docCode}" disabled> <input type="text"
			id="cmmnDocKnd" name="cmmnDocKnd" style="display: none;"
			value="A25001" disabled> <input type="text"
			id="clasStdntCode" name="clasStdntCode" style="display: none;"
			value="${sanctnDocVO.clasStdntCode}" disabled> <input
			type="text" id="clasCode" name="clasCode" style="display: none;"
			value="${sanctnDocVO.clasCode}" disabled>
		<p class=a
			style='margin-left: 10.0pt; text-indent: -10.0pt; line-height: 116%'>
			<span style='font-size: 12.0pt; line-height: 116%'>&nbsp;</span>
		</p>
		<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
			style='border-collapse: collapse; border: none'>
			<tr style='height: 13.8pt'>
				<td width=420 colspan=8 rowspan=3
					style='width: 315.1pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 13.8pt'>
					<p class=a align=center
						style='text-align: center; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 20.0pt; line-height: 103%; font-family: "HY울릉도M", serif; color: #353535'>교외체험학습
							신청서</span>
					</p>
				</td>
				<td width=23 rowspan=3
					style='width: 16.95pt; border: solid gray 1.0pt; border-left: none; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 13.8pt'>
					<p class=a align=center
						style='text-align: center; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; line-height: 103%; font-family: "Gulim", sans-serif; color: #353535'>결</span>
					</p>
					<p class=a align=center
						style='text-align: center; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; line-height: 103%; font-family: "Gulim", sans-serif; color: #353535'>재</span>
					</p>
				</td>
				<td width=99 colspan=2
					style='width: 74.35pt; border: solid gray 1.0pt; border-left: none; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 13.8pt'>
					<p class=a align=center
						style='text-align: center; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; line-height: 103%; font-family: "Gulim", sans-serif; color: #353535'>담임</span>
					</p> <input type="text" id="tcherId" name="tcherId"
					style="display: block;">
				</td>
				<td width=99 colspan=2
					style='width: 74.35pt; border: solid gray 1.0pt; border-left: none; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 13.8pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN style='font-size: 11.0pt; font-family: GulimChe'>교감</span>
					</p> <input type="text" id="deputyPrncpalId" name="tcherId"
					style="display: block;">
				</td>
			</tr>
			<tr style='height: 13.8pt'>
				<td  id="tcherSanctnTd" width=99 colspan=2 rowspan=2
					style='width: 74.35pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 65.8pt'>
				
				</td>

				<td id="deputyPrncpalSanctnTd" width=99 colspan=2 rowspan=2
					style='width: 74.35pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 65.8pt'>
				
				</td>


			</tr>
			<tr style='height: 13.8pt'>
			</tr>

			<tr style='height: 26.15pt'>
				<td width=70
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 26.15pt'>
					<input type="text" id="stdntId" name="stdntId"
					style="display: none;" value="${sanctnDocVO.stdntId}" disabled>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>성명</span>
					</p>
				</td>
				<td width=173 colspan=3
					style='width: 129.5pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 26.15pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span
							style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt'>${sanctnDocVO.familyRelateVO.stdntVO.mberNm}</span>
					</p> 
				</td>
				<td width=62 colspan=2
					style='width: 46.35pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 26.15pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 11.0pt; font-family: "Gulim", sans-serif; color: #1B1760; letter-spacing: -.35pt'>학년
							반</span>
					</p>
				</td>
				<td width=337 colspan=7
					style='width: 252.6pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 26.15pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>    
							<span lang=ZH-CN id="cmmnGrade"></span><span lang=ZH-CN>학년</span> 
							<input type="text" id="clasCode" name="clasCode"
							style="display: none"> <span lang=ZH-CN>${sanctnDocVO.clasVO.clasNm}</span>  
							${sanctnDocVO.clasStdntVO.clasInNo}<span lang=ZH-CN>번</span>
						</span>   
					</p>
				</td>
			</tr>
			<tr style='height: 21.35pt'>
				<td width=70 rowspan=1
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 21.35pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>기간</span>
					</p>
				</td>

				<td width=43 rowspan=1
					style='width: .45in; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; background: #F2F2F2; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 21.35pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span style='font-size: 10.5pt; font-family: "휴먼명조", serif'>1</span><span
							lang=ZH-CN style='font-size: 10.5pt'>일</span><span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "휴먼명조", serif'> </span>
					</p>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN style='font-size: 10.5pt'>단위</span>
					</p>
				</td>
				<td width=129 colspan=2
					style='width: 97.1pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 21.35pt'>
					<p class=a align=center
						style='text-align: center; word-break: normal'>
						<span lang=ZH-CN>신청 기간</span>(<span lang=ZH-CN>보호자</span>)
					</p>
				</td>
				<td width=399 colspan=9
					style='width: 298.95pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 21.35pt'>
					<p class=a style='line-height: normal; text-align: center;'>
						<span
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>
							<input type="date" id="exprnLrnBgnde" name="exprnLrnBgnde"
							value="<fmt:formatDate value="${sanctnDocVO.exprnLrnBgnde}" pattern="yyyy-MM-dd" />"
							disabled> ~  <input type="date" id="exprnLrnEndde"
							name="exprnLrnEndde"
							value="<fmt:formatDate value="${sanctnDocVO.exprnLrnEndde}" pattern="yyyy-MM-dd" />"
							disabled>
						</span>
					</p>
				</td>
			</tr>
			<tr style='height: 25.25pt'>
				<td width=70
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>학습형태</span>
					</p>
				</td>
				<td width=571 colspan=12
					style='width: 428.45pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'> </span>
						<input type="radio" id="lrnStle1" name="lrnStle"
							value="가족행사 참여를 통한 체험학습"> <span lang=ZH-CN
							style='font-size: 11.0pt; font-family: "휴먼명조", serif; letter-spacing: -.55pt'><label
							for="lrnStle1">가족행사 참여를 통한 체험학습</label></span><span
							style='font-size: 10.5pt; font-family: "휴먼명조", serif; color: #353535'>    
						</span> <input type="radio" id="lrnStle2" name="lrnStle"
							value="주제가 있는 체험학습"> <span lang=ZH-CN
							style='font-size: 11.0pt; font-family: "휴먼명조", serif; letter-spacing: -.55pt'><label
							for="lrnStle2">주제가 있는 체험학습</label></span><span
							style='font-size: 11.0pt; font-family: "휴먼명조", serif; letter-spacing: -.55pt'>
							     </span>
					</p>
				</td>
			</tr>
			<tr style='height: 25.1pt'>
				<td width=70
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.1pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>목적</span>
					</p>
				</td>
				<td width=343 colspan=6
					style='width: 257.05pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.1pt'>
					<input type="text" id="purps" name="purps"
					style='text-align: center; font-family: GulimChe; width: 361px;'
					value="${sanctnDocVO.purps}" disabled>
				</td>
				<td width=88 colspan=3
					style='width: 65.85pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; background: #F2F2F2; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.1pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>목적지</span>
					</p>
				</td>
				<td width=141 colspan=3
					style='width: 105.5pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.1pt'>
					 <input type="text" id="dstn" name="dstn"
					style='text-align: center; font-family: GulimChe; width: 221px;'
					value="${sanctnDocVO.dstn}" disabled>
				</td>
			</tr>
			<tr style='height: 25.25pt'>
				<td width=70
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<input type="text" id="stdnprntId" name="stdnprntId"
					style="display: none;" value="${sanctnDocVO.stdnprntId}" disabled>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 11.0pt; font-family: "Gulim", sans-serif; letter-spacing: -.35pt'>보호자명</span>
					</p>
				</td>
				<td width=137 colspan=2
					style='width: 102.65pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span
							style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt'>${sanctnDocVO.familyRelateVO.parentMemberVO.mberNm}</span>
					</p> 
				</td>
				<td width=92 colspan=2
					style='width: 68.7pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; background: #F2F2F2; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>관계</span>
					</p>
				</td>
				<td width=114 colspan=2
					style='width: 85.65pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a style='line-height: normal; text-align: center;'>
						<span
							style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt'>${sanctnDocVO.familyRelateVO.cmmnDetailCode}</span>
					</p> 
				</td>
				<td width=88 colspan=3
					style='width: 65.85pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; background: #F2F2F2; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 11.0pt; font-family: "Gulim", sans-serif; letter-spacing: -.35pt'>연락처</span>
					</p>
				</td>
				<td width=141 colspan=3
					style='width: 105.5pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 25.25pt'>
					<p class=a style='line-height: normal; text-align: center;'>
						<span
							style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt'>${sanctnDocVO.familyRelateVO.parentMemberVO.moblphonNo}</span>
					</p> 
				</td>
			</tr>
			<tr style='height: 122.75pt'>
				<td width=70
					style='width: 52.4pt; border: solid gray 1.0pt; border-top: none; background: #F1F1F1; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 122.75pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>교외체험</span>
					</p>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>학습계획</span>
					</p>
				</td>
				<td width=571 colspan=12
					style='width: 428.45pt; border-top: none; border-left: none; border-bottom: solid gray 1.0pt; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 122.75pt; text-align: center;'>
					 <textarea id="docCn" name="docCn" style="width: 711px; height: 154px;"
						disabled>${sanctnDocVO.docCn}</textarea>
				</td>
			</tr>
			<tr style='height: 88.3pt'>
				<td width=641 colspan=13
					style='width: 480.9pt; border-top: none; border-left: solid gray 1.0pt; border-bottom: none; border-right: solid gray 1.0pt; padding: 1.4pt 1.4pt 1.4pt 1.4pt; height: 88.3pt'>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<b><span lang=ZH-CN>위와</span></b><b><span lang=ZH-CN
							style='font-family: "휴먼명조", serif'> </span></b><b><span
							lang=ZH-CN>같이</span></b><b><span lang=ZH-CN
							style='font-family: "휴먼명조", serif'> </span></b><b><span
							lang=ZH-CN>교외체험학습을</span></b><b><span lang=ZH-CN
							style='font-family: "휴먼명조", serif'> </span></b><b><span
							lang=ZH-CN>신청합니다</span></b><b><span
							style='font-family: "휴먼명조", serif'>. </span></b>
					</p>
					<div align=center>
						<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
							style='border-collapse: collapse; border: none'>
							<tr style='height: 51.85pt'>
								<td width=626
									style='width: 469.85pt; border: solid black 1.0pt; padding: 1.4pt 5.1pt 1.4pt 5.1pt; height: 51.85pt'>
									<p class=a style='line-height: 116%'>
										<span style='color: red; letter-spacing: -.35pt'> </span><b><span
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>(</span></b><b><span
											lang=ZH-CN style='color: red; letter-spacing: -.35pt'>연속</span></b><b><span
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>)
												5</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>일</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>이상</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>교외체험학습</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>시</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><u><span lang=ZH-CN
												style='color: red; letter-spacing: -.35pt'>주</span></u></b><b><u><span
												style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>1</span></u></b><b><u><span
												lang=ZH-CN style='color: red; letter-spacing: -.35pt'>회</span></u></b><b><u><span
												lang=ZH-CN
												style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
											</span></u></b><b><u><span lang=ZH-CN
												style='color: red; letter-spacing: -.35pt'>이상</span></u></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>학생이</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>담임교사와</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><u><span lang=ZH-CN
												style='color: red; letter-spacing: -.35pt'>통화</span></u></b><b><span
											lang=ZH-CN style='color: red; letter-spacing: -.35pt'>하여</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>안전</span></b><b><span
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>,
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>건강을</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>확인</span></b><b><span
											lang=ZH-CN
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>
										</span></b><b><span lang=ZH-CN
											style='color: red; letter-spacing: -.35pt'>시키겠습니다</span></b><b><span
											style='font-family: "휴먼명조", serif; color: red; letter-spacing: -.35pt'>.
										</span></b>
									</p>
									<p class=a style='line-height: 116%'>
										<b><span style='font-family: "휴먼명조", serif; color: red'>                                
										</span></b><b><span
											style='font-family: "Arial Unicode MS", sans-serif; color: red'>
												<i class="fa-regular fa-square-check" style="color: black"></i>
										</span></b><b><span style='font-family: "휴먼명조", serif; color: red'>
										</span></b><b><span lang=ZH-CN style='color: black'>동의합니다</span></b>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<p class=MsoNormal>
						<span style='font-size: 1.0pt'>&nbsp;</span>
					</p>
					<p class=a align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span style='font-size: 10.5pt; font-family: "Gulim", sans-serif'>&nbsp;</span>
					</p>
				</td>
			</tr>
	
			<tr>
				<td width=641 colspan=13
					style='width: 480.9pt; border: solid gray 1.0pt; border-top: none; padding: 1.4pt 1.4pt 1.4pt 1.4pt'>
					<p class=a id="rqstDe" align=center
						style='text-align: center; line-height: normal; word-break: normal'>
						<span
							style='font-size: 12.0pt; font-family: GulimChe; letter-spacing: -.4pt'> 
							<fmt:formatDate value="${sanctnDocVO.rqstDe}" pattern="yyyy-MM-dd" /> 
						</span>
					</p>
					<div style="display: flex; justify-content: flex-end;">
						<div style="margin-right: 10px;">
							<div class=a align=right
								style='text-align: right; line-height: normal; word-break: normal'>
								<span lang=ZH-CN
									style='font-size: 13.0pt; font-family: GulimChe; letter-spacing: -.45pt; margin-right: 9px;'>학&nbsp;생</span>
							</div>
							<div class=a align=right
								style='text-align: right; line-height: normal; word-break: normal'>
								<span lang=ZH-CN
									style='font-size: 13.0pt; font-family: GulimChe; letter-spacing: -.45pt; margin-right: 9px;'>가&nbsp;족</span>
							</div>
						</div>
						<div style="margin-right: 10px;">
							<div class=a align=right
								style='text-align: right; line-height: normal; word-break: normal'>
								<span lang=ZH-CN
									style='font-size: 13.0pt; font-family: GulimChe; letter-spacing: -.45pt'>${sanctnDocVO.familyRelateVO.stdntVO.mberNm}</span>
							</div>
							<div class=a align=right
								style='text-align: right; line-height: normal; word-break: normal'>
								<span lang=ZH-CN
									style='font-size: 13.0pt; font-family: GulimChe; letter-spacing: -.45pt'>${sanctnDocVO.familyRelateVO.parentMemberVO.mberNm}</span>
							</div>
						</div>
<!-- 						<div> -->
<!-- 							<div> -->
<!-- 								(<span -->
<!-- 									style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt' -->
<!-- 									lang=ZH-CN>인</span>) -->
<!-- 							</div> -->
<!-- 							<div> -->
<!-- 								(<span -->
<!-- 									style='font-size: 11.0pt; font-family: GulimChe; letter-spacing: -.35pt' -->
<!-- 									lang=ZH-CN>인</span>) -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div> <input type="text" id="schulCode" name="schulCode"
					style="display: none;" value="${sanctnDocVO.schulCode}" disabled>
					<p class=a style='line-height: normal'>
						<span lang=ZH-CN
							style='font-size: 10.5pt; font-family: "Gulim", sans-serif; color: #353535'>${sanctnDocVO.schulVO.schulNm}장
							귀하</span>
					</p>
				</td>
			</tr>
			<tr height=0>
				<td width=70 style='border: none'></td>
				<td width=43 style='border: none'></td>
				<td width=94 style='border: none'></td>
				<td width=36 style='border: none'></td>
				<td width=56 style='border: none'></td>
				<td width=6 style='border: none'></td>
				<td width=108 style='border: none'></td>
				<td width=8 style='border: none'></td>
				<td width=23 style='border: none'></td>
				<td width=58 style='border: none'></td>
				<td width=41 style='border: none'></td>
				<td width=38 style='border: none'></td>
				<td width=62 style='border: none'></td>
			</tr>
		</table>
	</form>
	<div style="width: 798.03px;">
		<p class=a style='line-height: normal'>
			<span style='font-family: "휴먼명조", serif'> </span><span lang=ZH-CN
				style='font-size: 11.0pt; font-family: "휴먼명조", serif'>교외체험학습
				규정에 의거 학습기간 중 성실히 체험학습에 임하며 제반 규정을 준수하고 만약의 경우 야기되는<br> 모든 사항에
				대하여 보호자와 학생이 전적으로 책임을 져야 한다는 것을 확인합니다
			</span><span style='font-size: 11.0pt; font-family: "휴먼명조", serif'>.</span>
		</p>

		<p class=a style='line-height: 130%; margin-top: 10px;'>
			※ 1일 단위, 반일(12시 30분 기준) 단위 운영 가능&#13;&#10;<br> ※ 체험학습의 목적 및
			학습계획(일정, 장소, 활동내용 등)을 구체적으로 작성&#13;&#10;<br> ※ 체험학습 참가 1일 전까지
			학교장에게 신청서 제출 및 승인 (전날까지 제출하지 않고 체험학습을 실시할 경우 미인정결석으로 처리)&#13;&#10;<br>
			※ 보호자가 신청서를 제출하였다 하여 체험학습이 허가된 것이 아니며 담임교사로부터 최종 허가 여부를 연락(전화 또는 문자)
			<br> &nbsp;&nbsp;&nbsp;&nbsp;받은 후 실시하여야 함&#13;&#10;
		</p>

		<span
			style='font-size: 11.0pt; font-family: "Malgun Gothic", sans-serif'><br
			clear=all style='page-break-before: always'> </span>
	</div>
</div>
<c:if
	test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01003'}">
	<c:if
		test="${sanctnDocVO.cmmnProcessSttus eq 'A11001' || sanctnDocVO.cmmnProcessSttus eq 'A11003'}">
		<div id="updateDiv"
			style="width: 1000px; margin: auto; margin-bottom: 15px; text-align: center;">
			<button id="updateBtn" type="button" style="padding: 10px 15px; width: 195px;">수정하기</button>
			<button id="deleteBtn" type="button" style="padding: 10px 15px; width: 195px; margin-left: 40px;">삭제하기</button>
			<button class="goList" style="padding: 10px 15px; width: 195px; margin-left: 40px;">목록으로</button>
		</div>
		<div id="saveDiv"
			style="width: 435px; margin: auto; margin-bottom: 15px; display: none;">
			<button id="saveBtn" type="button"
				style="padding: 10px 15px; width: 195px;">저장하기</button>
			<button id="cancelBtn" class="cancelBtn" type="button"
				style="padding: 10px 15px; width: 195px; margin-left: 40px;">취소</button>
		</div>
	</c:if>
</c:if>

<!-- 권한이 교감/담임교사일 경우만 보여져야한다 -->
<!-- 시그니처 패드 -->
<c:if
	test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A01002' || USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode eq 'ROLE_A01002'}">
		<div id="signPlace">
			<div id="tchrDiv">
				<!-- 결재/거절 버튼 -->
				<div id="tchrUpdateDiv"
					style="width: 1000px; margin: auto; margin-bottom: 15px; text-align: center;">
						<c:choose>
							<c:when test="${sanctnDocVO.cmmnProcessSttus eq 'A11001'&& USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A14002'|| USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode eq 'ROLE_A14002'}">
								<button id="sign" style="padding: 10px 15px; width: 195px;" data-toggle="modal" data-target="#signPadModal">결재하기</button>
							</c:when>
							<c:when test="${sanctnDocVO.cmmnProcessSttus eq 'A11005'&& USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode eq 'ROLE_A14005'|| USER_INFO.vwMemberAuthVOList[1].cmmnDetailCode eq 'ROLE_A14005'}">
								<button id="sign" style="padding: 10px 15px; width: 195px;" data-toggle="modal" data-target="#signPadModal">결재하기</button>
							</c:when>
						</c:choose>
					<c:if test="${sanctnDocVO.cmmnProcessSttus eq 'A11001' || sanctnDocVO.cmmnProcessSttus eq 'A11003' || sanctnDocVO.cmmnProcessSttus eq 'A11005'}">
						<button id="refusal"
							style="padding: 10px 15px; width: 195px; margin-left: 40px;">거절</button>
				   </c:if>
				   <sec:authorize access = "hasAnyRole('A14002','A14005')" >
				   <c:if test="${sanctnDocVO.cmmnProcessSttus eq 'A11002' }">
					   <button type="button" id="app-pdf-btn"
					   		style="padding: 10px 15px; width: 195px; margin-left: 40px;"
						>PDF로 다운로드</button>
					</c:if>
				   </sec:authorize>
				   
					<button class="goList"
						style="padding: 10px 15px; width: 195px; margin-left: 40px;">목록으로</button>
				</div>
				<!-- 결재/거절 버튼 -->
			</div>
		</div>
	
</c:if>
<!-- 서명 모달 창 시작 -->
<div class="modal" tabindex="-1" id="signPadModal">
	<div class="modal-dialog">
		<div class="modal-content" style="border-radius: 26px;">
			<div class="modal-header" style="border-bottom: 0px;">
				<h2 class="modal-title">* 서명 이미지를 등록해주세요</h2>
			</div>
			<div class="modal-body">
				<div id="signUpContainer">
					<!-- 					<div>* 서명 이미지를 등록해주세요</div> -->
					<div id="sign-file-reg-div">
						<div>
							<form id="sign-frm">
								<input type="file" accept="image/*" id="file" name="uploadFile">
							</form>
							<div id="sign-file-div" style="text-align: left;"
								onclick="document.getElementById('file').click()">
								<span class="material-symbols-outlined">upload</span>이곳을 클릭해서
								이미지를 등록하세요
							</div>
						</div>
					</div>
					<div
						style="display: flex; justify-content: space-evenly; margin-top: 20px;">
						<div>
							<div style="width: 400px;">* 서명 이미지가 없다면 아래에 서명해주세요</div>
							<div class="wrapper">
								<canvas id="signature-pad" class="signature-pad" width=400
									height=200 style="border: 1px solid gray"></canvas>
							</div>
							<div>
								<button id="save-png">서명 저장하기</button>
								<button id="draw">그리기</button>
								<button id="erase">지우기</button>
								<button id="clear">초기화</button>
							</div>
						</div>
						<div style="border: 1px solid gray; width: 220px; height: 220px; border-radius: 10px;">
							<div style="border-bottom: 1px solid gray; text-align: center;">등록한 서명</div>

							<div id="small-image-show"
								style="text-align: center; height: 198px;"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="border-top: 0px">
					<button type="button"  id="sign-submit-btn">등록</button>
					<button type="button"  id="sign-close"
						data-bs-dismiss="modal" data-toggle="modal" data-target="#signPadModal">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 서명 모달 창 끝 -->




