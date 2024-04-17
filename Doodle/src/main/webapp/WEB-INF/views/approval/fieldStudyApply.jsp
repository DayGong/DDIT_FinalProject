<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:GulimChe;
	panose-1:2 11 6 9 0 1 1 1 1 1;}
@font-face
	{font-family:"\@GulimChe";}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:"\@Malgun Gothic";}
@font-face
	{font-family:"\@Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:宋?;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HYSinMyeongJo-Medium;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HYGothic-Medium;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HY궁서;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Yet R";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HYGothic-Extra;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"HCI Tulip";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:휴먼명조;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HYMyeongJo-Extra;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HY울릉도M;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:-소망M;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:HY둥근고딕B;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:BatangChe;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"HCI Poppy";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"HCI Hollyhock";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:휴먼고딕;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:함초롬돋움;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:한컴바탕;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HYSinMyeongJo-Medium";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HY울릉도M";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@宋?";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@휴먼명조";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@함초롬돋움";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@한컴바탕";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@휴먼고딕";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HYGothic-Extra";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HYMyeongJo-Extra";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@BatangChe";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HYGothic-Medium";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HY둥근고딕B";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@-소망M";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@HY궁서";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@Yet R";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	text-autospace:none;
	word-break:break-all;
	font-size:11.0pt;
	font-family:"Malgun Gothic",sans-serif;}
p.a, li.a, div.a
	{mso-style-name:바탕글;
	margin:0in;
	text-align:justify;
	text-justify:inter-ideograph;
	line-height:103%;
	layout-grid-mode:char;
	text-autospace:none;
	word-break:break-all;
	font-size:10.0pt;
	font-family:"HYSinMyeongJo-Medium",serif;
	color:black;}
p.a0, li.a0, div.a0
	{mso-style-name:머리말;
	margin:0in;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	font-size:9.0pt;
	font-family:"함초롬돋움",serif;
	color:black;}
.MsoChpDefault
	{font-family:"Malgun Gothic",sans-serif;}
 /* Page Definitions */
 @page WordSection1
	{size:595.25pt 841.85pt;
	margin:70.85pt 42.5pt 42.5pt 42.5pt;}
div.WordSection1
	{page:WordSection1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->

#insertBtn{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:200px;
	margin:auto;
	border-radius: 10px;
	background: #006DF0;
	color: #fff;
	font-size: 1.2rem;
	
}

#autoBtn{
	vertical-align:middle;
	display:inline-block;
	border:none;
	height: 50px;
	text-align: center;
	font-weight:700;
	width:50px;
	margin:auto;
	border-radius: 10px;
	background: rgba(255, 255, 255, 0.8);
	color: #333;
	font-size: 1.2rem;
}

#insertBtn:hover, #goList:hover, #frm #btnPostNum:hover, #frm #idChk:hover, #autoBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
}

/* 기본적으로는 보더가 없는 상태 */
input, textarea {
    border: none;
}

/* 호버 시에만 보더를 추가 */
input:hover, textarea:hover {
    background: #ffd77a;
	color:#333;
	transition:all 1s;
}

/* 입력 포커스 시에도 보더를 추가 */
input:focus,, textarea:focus {
   background: #ffd77a;
	color:#333;
	transition:all 1s;
}

select {
	width:17px;
	border: none;
	appearance: none;
}

</style>
<script src="/resources/js/jspdf.min.js"></script>
<script src="/resources/js/bluebird.min.js"></script>
<script src="/resources/js/html2canvas.min.js"></script>
<script src="/resources/js/jquery.min.js"></script>


<script>
let user = '${USER_INFO}';
const parentNm ='${USER_INFO.mberNm}';
const parentMoblphonNo = '${USER_INFO.moblphonNo}';
const cmmnGrade = '${vwStdntStdnprntVO.cmmnGrade}';

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

function resultSAlert(result, actTitle, reloadPage) {
	let clasStdntCode = document.querySelector("#clasStdntCode").value;
	let res = "성공";
	let icon = "success";
	
	if (result != 1) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.href="/approval/approvalList?clasStdntCode="+clasStdntCode; });
}

window.onload = function() {
	
	//자동입력
	$("#autoBtn").on("click",function(){
		
		document.querySelector("#exprnLrnBgnde").value = "2024-04-17";
		
		document.querySelector("#exprnLrnEndde").value = "2024-04-17";
		
		let lrnStle2 = document.querySelector("#lrnStle2");
		lrnStle2.click();
		document.querySelector("#purps").value = "봉사활동";
		
		document.querySelector("#dstn").value = "강원도 양양 바닷가";
		document.querySelector("#docCn").value = "체험학습을 신청합니다.";
	});
	
	// 신청일을 오늘 날짜로 입력
	$("#rqstDe").html(getTodayDate());
	
	// 체험학습시작일 시작 날짜를 클릭하면 오늘 이후로 날짜가 시작
	$('#exprnLrnBgnde').attr('min', getTodayDate());
	
	// 체험학습시작일 시작 날짜를 클릭하면 종료 날짜의 최소 시작 날짜가 시작 날짜로 설정
	$("#exprnLrnBgnde").on("input", function(){
		let exprnLrnBgnde = $("#exprnLrnBgnde").val();
		$("#exprnLrnEndde").attr("min", exprnLrnBgnde);
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
	
	
	document.querySelector("#insertBtn").addEventListener("click",function(){
		
		//학습형태가 없을 때 
		if(document.querySelector('input[name="lrnStle"]:checked') == null || document.querySelector('input[name="lrnStle"]:checked') == ''){
			alertError('학습형태를 선택해주세요.', ' ');
			return;
		}
		
		let stdntId = document.querySelector("#stdntId").value;
		let exprnLrnBgnde = document.querySelector("#exprnLrnBgnde").value;
		let lrnStle = document.querySelector('input[name="lrnStle"]:checked').value;
		let purps = document.querySelector("#purps").value;
		let dstn = document.querySelector("#dstn").value;
		let stdnprntId = document.querySelector("#stdnprntId").value;
		let docCn = document.querySelector("#docCn").value;
		let rqstDe = getTodayDate();
		let schulCode = document.querySelector("#schulCode").value;
		let cmmnDocKnd = document.querySelector("#cmmnDocKnd").value;
		let clasStdntCode = document.querySelector("#clasStdntCode").value;
		let clasCode = '${CLASS_INFO.clasCode}';
		let exprnLrnEndde = document.querySelector("#exprnLrnEndde").value;
		
		//체험학습시작일이 없을 때 
		if(exprnLrnBgnde == 'null' || exprnLrnBgnde == ''){
			alertError('체험학습시작일을 선택해주세요.', ' ');
			$("#exprnLrnBgnde").focus();
			return;
		}
		
		//체험학습종료일이 없을 때 
		if(exprnLrnEndde == 'null' || exprnLrnEndde == ''){
			alertError('체험학습종료일을 선택해주세요.', ' ');
			$("#exprnLrnEndde").focus();
			return;
		}
		
		//체험학습시작일이 체험학습종료일보다 클 때
		if(exprnLrnBgnde > exprnLrnEndde){
			alertError('체험학습시작일이 체험학습종료일보다 클 수 없습니다.', ' ');
			$("#exprnLrnBgnde").focus();
			return;
		}
		
		//목적이 없을 때 
		if(purps == 'null' || purps == ''){
			alertError('목적을 입력해주세요.', ' ');
			$("#purps").focus();
			return;
		}
		
		//목적지가 없을 때 
		if(dstn == 'null' || dstn == ''){
			alertError('목적지를 입력해주세요.', ' ');
			$("#dstn").focus();
			return;
		}
		
		//체험학습계획이 없을 때 
		if(docCn == 'null' || docCn == ''){
			alertError('체험학습계획을 입력해주세요.', ' ');
			$("#docCn").focus();
			return;
		}
		
		
		let fieldStudyApplyFrm = new FormData($("#fieldStudyApplyFrm")[0]);
		fieldStudyApplyFrm.append("rqstDe",rqstDe);
		
		$.ajax({
			url:"/approval/insertDoc",
			processData:false,
			contentType:false,
			data:fieldStudyApplyFrm,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				resultSAlert(result,'체험학습신청 등록을','체험학습 목록으로 이동합니다.');
			}
		});
	});
	
}
</script>
<div class=WordSection1 id="pdfDiv" style="width: 810px; margin: auto;">
<form id="fieldStudyApplyFrm" method="post" style="width: 810px">
<input type="text" id="cmmnDocKnd" name="cmmnDocKnd" style="display: none;" value="A25001">
<input type="text" id="clasStdntCode" name="clasStdntCode" style="display: none;" value="${CLASS_STD_INFO.clasStdntCode}">
<input type="text" id="clasCode" name="clasCode" style="display: none;" value="${CLASS_INFO.clasCode}">
<p class=a style='margin-left:10.0pt;text-indent:-10.0pt;line-height:116%'><span
style='font-size:12.0pt;line-height:116%'>&nbsp;</span></p>
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none'>
 <tr style='height:13.8pt'>
  <td width=420 colspan=8 rowspan=3 style='width:315.1pt;border-top:none;
  border-left:none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:13.8pt'>
  <p class=a align=center style='text-align:center;word-break:normal'><span
  lang=ZH-CN style='font-size:20.0pt;line-height:103%;font-family:"HY울릉도M",serif;
  color:#353535'>교외체험학습 신청서</span></p>
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
 <tr style='height:13.8pt'>
 </tr>
 
 <tr style='height:26.15pt'>
  <td width=70 style='width:52.4pt;border:solid gray 1.0pt;border-top:none;
  background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;height:26.15pt'>
  <input type="text" id="stdntId" name="stdntId" style="display: none;" value="${CLASS_STD_INFO.mberId}">
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>성명</span></p>
  </td>
  <td width=173 colspan=3 style='width:129.5pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:26.15pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:11.0pt;font-family:GulimChe;
  letter-spacing:-.35pt'>${vwStdntStdnprntVO.mberNm}</span></p>
  </td>
  <td width=62 colspan=2 style='width:46.35pt;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;background:#F1F1F1;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:26.15pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:11.0pt;font-family:"Gulim",sans-serif;
  color:#1B1760;letter-spacing:-.35pt'>학년 반</span></p>
  </td>
  <td width=337 colspan=7 style='width:252.6pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:26.15pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>     
	<span lang=ZH-CN id="cmmnGrade"></span><span lang=ZH-CN>학년</span> 
	<span lang=ZH-CN>${vwStdntStdnprntVO.clasNm}</span>  
	${CLASS_STD_INFO.clasInNo}<span lang=ZH-CN>번</span></span>
    
  </p>
  </td>
 </tr>
 <tr style='height:21.35pt'>
  <td width=70 rowspan=1 style='width:52.4pt;border:solid gray 1.0pt;
  border-top:none;background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;
  height:21.35pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>기간</span></p>
  </td>
  <td width=43 rowspan=1 style='width:.45in;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;background:#F2F2F2;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:21.35pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:10.5pt;font-family:"휴먼명조",serif'>1</span><span
  lang=ZH-CN style='font-size:10.5pt'>일</span><span lang=ZH-CN
  style='font-size:10.5pt;font-family:"휴먼명조",serif'> </span></p>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt'>단위</span></p>
  </td>
  <td width=129 colspan=2 style='width:97.1pt;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:1.4pt 1.4pt 1.4pt 1.4pt;
  height:21.35pt'>
  <p class=a align=center style='text-align:center;word-break:normal'><span
  lang=ZH-CN>신청 기간</span>(<span lang=ZH-CN>보호자</span>)</p>
  </td>
  <td width=399 colspan=9 style='width:298.95pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:21.35pt'>
  <p class=a style='line-height:normal; text-align: center;'><span style='font-size:10.5pt;
  font-family:"Gulim",sans-serif;color:#353535'>
  <input type="date" id="exprnLrnBgnde" name="exprnLrnBgnde"> 
  ~ 
  <input type="date" id="exprnLrnEndde" name="exprnLrnEndde"></span></p>
  </td>
 </tr>
 <tr style='height:25.25pt'>
  <td width=70 style='width:52.4pt;border:solid gray 1.0pt;border-top:none;
  background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>학습형태</span></p>
  </td>
  <td width=571 colspan=12 style='width:428.45pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'> </span>
  <input type="radio" id="lrnStle1" name="lrnStle" value="가족행사 참여를 통한 체험학습">
  <span lang=ZH-CN style='font-size:11.0pt;font-family:
  "휴먼명조",serif;letter-spacing:-.55pt'><label for="lrnStle1">가족행사 참여를 통한 체험학습</label></span><span
  style='font-size:10.5pt;font-family:"휴먼명조",serif;color:#353535'>      </span>
  <input type="radio" id="lrnStle2" name="lrnStle" value="주제가 있는 체험학습">
  <span lang=ZH-CN style='font-size:11.0pt;font-family:"휴먼명조",serif;letter-spacing:
  -.55pt'><label for="lrnStle2">주제가 있는 체험학습</label></span><span style='font-size:11.0pt;font-family:"휴먼명조",serif;
  letter-spacing:-.55pt'>       </span></p>
  </td>
 </tr>
 <tr style='height:25.1pt'>
  <td width=70 style='width:52.4pt;border:solid gray 1.0pt;border-top:none;
  background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.1pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>목적</span></p>
  </td>
  <td width=343 colspan=6 style='width:257.05pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.1pt'>
	<input type="text" id="purps" name="purps" style='text-align:center; font-family:GulimChe; width: 361px;'>
  </td>
  <td width=88 colspan=3 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;background:#F2F2F2;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.1pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>목적지</span></p>
  </td>
  <td width=141 colspan=3 style='width:105.5pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.1pt'>
	<input type="text" id="dstn" name="dstn" style='text-align:center; font-family:GulimChe; width: 221px;'>
  </td>
 </tr>
 <tr style='height:25.25pt'>
  <td width=70 style='width:52.4pt;border:solid gray 1.0pt;border-top:none;
  background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <input type="text" id="stdnprntId" name="stdnprntId" style="display: none;" value="${USER_INFO.mberId}">
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:11.0pt;font-family:"Gulim",sans-serif;
  letter-spacing:-.35pt'>보호자명</span></p>
  </td>
  <td width=137 colspan=2 style='width:102.65pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:11.0pt;font-family:GulimChe;
  letter-spacing:-.35pt'>${vwStdntStdnprntVO.stdnprntNm}</span></p>
  </td>
  <td width=92 colspan=2 style='width:68.7pt;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;background:#F2F2F2;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>관계</span></p>
  </td>
  <td width=114 colspan=2 style='width:85.65pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a style='line-height:normal; text-align:center;'><span style='font-size:11.0pt;
  font-family:GulimChe;letter-spacing:-.35pt'>${vwStdntStdnprntVO.cmmnDetailCode}</span></p>
  </td>
  <td width=88 colspan=3 style='width:65.85pt;border-top:none;border-left:none;
  border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;background:#F2F2F2;
  padding:1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:11.0pt;font-family:"Gulim",sans-serif;
  letter-spacing:-.35pt'>연락처</span></p>
  </td>
  <td width=141 colspan=3 style='width:105.5pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:25.25pt'>
  <p class=a style='line-height:normal; text-align:center;'><span style='font-size:11.0pt;
  font-family:GulimChe;letter-spacing:-.35pt'>${vwStdntStdnprntVO.moblphonNo}</span></p>
  </td>
 </tr>
 <tr style='height:122.75pt'>
  <td width=70 style='width:52.4pt;border:solid gray 1.0pt;border-top:none;
  background:#F1F1F1;padding:1.4pt 1.4pt 1.4pt 1.4pt;height:122.75pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>교외체험</span></p>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span lang=ZH-CN style='font-size:10.5pt;font-family:"Gulim",sans-serif;
  color:#353535'>학습계획</span></p>
  </td>
  <td width=571 colspan=12 style='width:428.45pt;border-top:none;border-left:
  none;border-bottom:solid gray 1.0pt;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:122.75pt; text-align: center;'>
	<textarea id="docCn" name="docCn" style="width: 711px; height: 154px;"></textarea>
  </td>
 </tr>
 <tr style='height:88.3pt'>
  <td width=641 colspan=13 style='width:480.9pt;border-top:none;border-left:
  solid gray 1.0pt;border-bottom:none;border-right:solid gray 1.0pt;padding:
  1.4pt 1.4pt 1.4pt 1.4pt;height:88.3pt'>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><b><span lang=ZH-CN>위와</span></b><b><span lang=ZH-CN
  style='font-family:"휴먼명조",serif'> </span></b><b><span lang=ZH-CN>같이</span></b><b><span
  lang=ZH-CN style='font-family:"휴먼명조",serif'> </span></b><b><span lang=ZH-CN>교외체험학습을</span></b><b><span
  lang=ZH-CN style='font-family:"휴먼명조",serif'> </span></b><b><span lang=ZH-CN>신청합니다</span></b><b><span
  style='font-family:"휴먼명조",serif'>. </span></b></p>
  <div align=center>
  <table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
   style='border-collapse:collapse;border:none'>
   <tr style='height:51.85pt'>
    <td width=626 style='width:469.85pt;border:solid black 1.0pt;padding:1.4pt 5.1pt 1.4pt 5.1pt;
    height:51.85pt'>
    <p class=a style='line-height:116%'><span style='color:red;letter-spacing:
    -.35pt'> </span><b><span style='font-family:"휴먼명조",serif;color:red;
    letter-spacing:-.35pt'>(</span></b><b><span lang=ZH-CN style='color:red;
    letter-spacing:-.35pt'>연속</span></b><b><span style='font-family:"휴먼명조",serif;
    color:red;letter-spacing:-.35pt'>) 5</span></b><b><span lang=ZH-CN
    style='color:red;letter-spacing:-.35pt'>일</span></b><b><span lang=ZH-CN
    style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'> </span></b><b><span
    lang=ZH-CN style='color:red;letter-spacing:-.35pt'>이상</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>교외체험학습</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>시</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><u><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>주</span></u></b><b><u><span
    style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>1</span></u></b><b><u><span
    lang=ZH-CN style='color:red;letter-spacing:-.35pt'>회</span></u></b><b><u><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></u></b><b><u><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>이상</span></u></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>학생이</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>담임교사와</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><u><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>통화</span></u></b><b><span
    lang=ZH-CN style='color:red;letter-spacing:-.35pt'>하여</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>안전</span></b><b><span
    style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>, </span></b><b><span
    lang=ZH-CN style='color:red;letter-spacing:-.35pt'>건강을</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>확인</span></b><b><span
    lang=ZH-CN style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>
    </span></b><b><span lang=ZH-CN style='color:red;letter-spacing:-.35pt'>시키겠습니다</span></b><b><span
    style='font-family:"휴먼명조",serif;color:red;letter-spacing:-.35pt'>. </span></b></p>
    <p class=a style='line-height:116%'><b><span style='font-family:"휴먼명조",serif;
    color:red'>                                 </span></b><b><span
    style='font-family:"Arial Unicode MS",sans-serif;color:red'>
    	<i class="fa-regular fa-square-check" style="color:black"></i>
    </span></b><b><span
    style='font-family:"휴먼명조",serif;color:red'> </span></b><b><span lang=ZH-CN
    style='color:black'>동의합니다</span></b></p>
    </td>
   </tr>
  </table>
  </div>
  <p class=MsoNormal><span style='font-size:1.0pt'>&nbsp;</span></p>
  <p class=a align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:10.5pt;font-family:"Gulim",sans-serif'>&nbsp;</span></p>
  </td>
 </tr>
 
 <tr>
  <td width=641 colspan=13 style='width:480.9pt;border:solid gray 1.0pt;
  border-top:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
  <p class=a id="rqstDe" align=center style='text-align:center;line-height:normal;
  word-break:normal'><span style='font-size:12.0pt;font-family:GulimChe;
  letter-spacing:-.4pt'> 
  </span>
  </p>
  <div style="display: flex; justify-content: flex-end;">
	  <div style="margin-right: 10px;">
		  <div class=a align=right style='text-align:right;line-height:normal;word-break:
		  normal'><span lang=ZH-CN style='font-size:13.0pt;font-family:GulimChe;
		  letter-spacing:-.45pt; margin-right: 9px;'>학&nbsp;생</span></div>
		  <div class=a align=right style='text-align:right;line-height:normal;word-break:
		  normal'><span lang=ZH-CN style='font-size:13.0pt;font-family:GulimChe;
		  letter-spacing:-.45pt; margin-right: 9px;'>가&nbsp;족</span></div>
	  </div>
	  <div style="margin-right: 10px;">
		  <div class=a align=right style='text-align:right;line-height:normal;word-break:
		  normal'><span lang=ZH-CN style='font-size:13.0pt;font-family:GulimChe;
		  letter-spacing:-.45pt'>${vwStdntStdnprntVO.mberNm}</span></div>
		  <div class=a align=right style='text-align:right;line-height:normal;word-break:
		  normal'><span lang=ZH-CN style='font-size:13.0pt;font-family:GulimChe;
		  letter-spacing:-.45pt'>${vwStdntStdnprntVO.stdnprntNm}</span></div>
	  </div>
<!-- 	  <div> -->
<!-- 		  <div>(<span style='font-size:11.0pt; font-family:GulimChe; letter-spacing:-.35pt' lang=ZH-CN>인</span>)</div> -->
<!-- 		  <div>(<span style='font-size:11.0pt; font-family:GulimChe; letter-spacing:-.35pt' lang=ZH-CN>인</span>)</div> -->
<!-- 	  </div> -->
  </div>
  <input type="text" id="schulCode" name="schulCode" style="display: none;" value="${SCHOOL_INFO.schulCode}">
  <p class=a style='line-height:normal'><span lang=ZH-CN style='font-size:10.5pt;
  font-family:"Gulim",sans-serif;color:#353535'>${vwStdntStdnprntVO.schulNm}장 귀하</span></p>
  </td>
 </tr>
 <tr height=0>
  <td width=70 style='border:none'></td>
  <td width=43 style='border:none'></td>
  <td width=94 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=56 style='border:none'></td>
  <td width=6 style='border:none'></td>
  <td width=108 style='border:none'></td>
  <td width=8 style='border:none'></td>
  <td width=23 style='border:none'></td>
  <td width=58 style='border:none'></td>
  <td width=41 style='border:none'></td>
  <td width=38 style='border:none'></td>
  <td width=62 style='border:none'></td>
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

<div style="width: 300px; margin: auto; margin-bottom: 15px; display: flex;">
	<button id="autoBtn" type="button">
		<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
	</button>
	<button id="insertBtn" type="button">신청하기</button>
</div>










