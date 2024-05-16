<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<script type="text/javascript" src="/resources/js/commonFunction.js"></script>
<!-- 네이버 스마트 에디터 JS -->
<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="UTF-8"></script>
<!-- 그림판 -->
<link type="text/css" rel="stylesheet" href="/resources/css/diary/bcPaint.css" />
<script type="text/javascript" src="/resources/js/diary/bcPaint.js"></script>
<style>
#DiaryContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	width: 370px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}
.DiaryAll {
	width: 1400px;
	margin: auto;
	backdrop-filter: blur(10px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 0px 35px 68px 0px rgba(145, 192, 255, 0.5), inset 0px -6px 16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px rgb(255, 255, 255);
	padding: 50px 80px;
}
.DiaryAll .DiaryTit {
	display: flex;
	justify-content: space-between;
	position:relative;
}
.DiaryAll .title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-top: 6px;
}
#insertBtn, #goDiary {
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
#insertBtn {
	background: #666;
	color:#fff;
}
#insertBtn:hover, #goDiary:hover {
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}
.btn-zone {
	display: flex;
	justify-content: center;
	margin: auto;
	text-align: center;
}

/* 날씨 */
.weather {
	border: 1px solid #B0E0E6;
	background-color: #f2f9fa;
	opacity: 0.8;
	border-radius: 10px;
	text-align:center;
	height: 80px;
	width: 80px;
	line-height: normal;
	font-weight:bold;
	position: absolute;
	top: 20%;
	right:2%;
	transform: translate(10%, 60%);
	z-index: 2;
}
.weather_icon {
	margin-right: 5px;
	line-height: 1.3;
}

/* 감정 이모티콘 */
.emotionDiv {
	display: flex;
	justify-content: space-between;
	flex-direction: row;
}
.emotionImg {
	width: 40px;
	height: 40px;
}
.emotion-inner-div {
	padding: 10px 15px;
	border-radius: 10px;
	background-color: #F3F8FF;
}
.emotion-inner-div:hover, .isSelected {
	cursor: pointer;
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
}

.autoBtn {
	background: #333;
	height: 40px;
	border: none;
	padding: 10px 15px;
	border-radius: 10px;
	font-family: 'Pretendard' !important;
	font-weight: 600;
	color: #fff;
}
</style>
<script type="text/javascript">
	// 네이버 스마트 에디터 API 시작
	let oEditors = [];
	let diaryAddSmartEditor = function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "nttCn",
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : '<c:url value="/resources/se2/SmartEditor2Skin.html"/>',
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : false,			/ 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bSkipXssFilter : true,				// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
				SE2M_FontName: {
					// 초기 글꼴 설정
					htMainFont: {'id': '나눔고딕','name': '나눔고딕','size': '18','url': '','cssUrl': ''}
				},
			}, // boolean
			fOnAppLoad : function(){},
			fCreator: "createSEditor2"
		});
	}; // end smartEditor
	// 네이버 스마트 에디터 API 끝
	
	// 오늘 날짜를 가져오는 함수
	let setDate = function() {
		let date = new Date();
		let year = date.getFullYear();
		let month = String(date.getMonth() + 1).padStart(2, '0');
		let day = String(date.getDate()).padStart(2, '0');
		
		return `\${year}년 \${month}월 \${day}일`;
	}
	
	$(function() {
		<!------------------------- 자동 완성 버튼 시작 --------------------------->
		$(document).on("click", "#diaryAutoBtn", function() {
			let txt = "전학을 와서 많이 떨리고 설렜다!<br>친절하신 선생님! 재밌는 친구들! 그리고 즐거운 과제까지!!<br>칭찬 스티커도 받았어요~!~!\n그야말로 최고의 하루입니다!!";
			$(".emotion-inner-div").eq(0).attr("class", "emotion-inner-div isSelected");
			$("#nttNm").val("첫 전학의 설렘이 즐거운 하루~!");
			oEditors.getById["nttCn"].exec("PASTE_HTML", [txt]);
			$("#nttAtchFileCode").val("최고");
		});
		<!------------------------- 자동 완성 버튼 끝 ----------------------------->
		
	    diaryAddSmartEditor();	// 네이버 스마트 에디터
	    let nttCode = `${param.nttCode}`;
	    $("#day").html(setDate());	// 날짜 설정
		
		if (nttCode !== null && nttCode !== '' && nttCode !== undefined) {
		    $.ajax({
		    	type: "get",
		    	url: "/diary/getDiaryDetail?nttCode=" + nttCode,
		    	success: function(result){
					let nttCode = `\${result.nttCode}`;
					let nttNm = `\${result.nttNm}`;
					let nttCn = `\${result.nttCn}`;
					let emo = `\${result.nttAtchFileCode}`;
					let emoTxt = "";
					let emoDiv = "";

					// oEditors.getById["nttCn"] 값을 못 불러와서 생성후 불러오도록 setTimeout 설정
					setTimeout(()=>{
						oEditors.getById["nttCn"].exec("PASTE_HTML", [nttCn]);
					},300)
					
					$("#day").html(`\${result.strNttWritngDt}`);	// 날짜 설정
		            		$("#nttCode").val(nttCode);			// 코드 설정
					$("#nttNm").val(nttNm);				// 제목 설정
					
					// 감정 설정
					for (let i = 0; i < $(".emotion-inner-div").length; i++) {
						emoTxt = $(".emotion-inner-div span").eq(i).html();
						emoDiv =  $(".emotion-inner-div:contains(" + emoTxt + ")");
						if (emo === emoTxt) {
							$(".emotion-inner-div").removeClass("isSelected");		// 모든 감정 요소에서 isSelected 클래스를 제거
							emoDiv.attr("class", "emotion-inner-div isSelected");		// 해당 감정 요소에 isSelected 클래스를 추가
							
							let value = emoDiv.find('span').text();
							$("#nttAtchFileCode").val(value);
						}
					}
		    	} // end success
		    }); // end ajax
		} // end if
		
		// 그림판 이미지 저장 및 등록
		$(document).on('click', '#bcPaint-export', function(){
			
			// 그림판에서 그린 이미지를 가져와서 스마트 에디터에 추가하는 코드
		    	var imgData = $('#bcPaintCanvas')[0].toDataURL('image/png');

			// $("#tareaUpload").val(imgData);
			let formData = new FormData();
			formData.append("imgData", imgData);

			$.ajax({
				type: "post",
				url: "/diary/diaryImgUpload",
				processData: false,
				contentType: false,
				data: formData,
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success: function(result) {
					let file = `<img class="drawImg" src='/upload/diary/\${result}'/>`;
					
					oEditors.getById["nttCn"].exec("PASTE_HTML", [file]);
				}
			});
		}); // end 그림판 이미지 저장 및 등록

		// 등록버튼 클릭 이벤트 시작
		$("#insertBtn").on("click",function(){
			let nttNm = $("#nttNm").val();
			let emotion = $("#nttAtchFileCode").val();
			let nttCn = oEditors.getById["nttCn"].getIR();	// 에디터에 적은 내용 가져오기
			// 게시글 null체크
			if (nttNm == null || nttNm == '') {
				alertError("제목을 입력해주세요.", "");
				return;
			} else if (nttCn == null || nttCn == '' || nttCn == '<br>') {
				alertError("내용을 입력해주세요.", "");
				return;
			} else if (emotion == null || emotion == '') {
				alertError("기분을 선택해주세요.", "");
				return;
			}
			
			oEditors.getById["nttCn"].exec("UPDATE_CONTENTS_FIELD",[]);
			let frm = new FormData($("#frm")[0]);			// 게시글 등록 변수
			
			// 게시글 등록 실행
			$.ajax({
				type: "post",
				url: "/diary/addDiaryAct",
				processData: false,
				contentType: false,
				data: frm,
				dataType: "text",
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success: function(result) {
					let res = "성공";
					let icon = "success";
					
					if (result != 1) { res = "실패"; icon = "error"; }
					
					Swal.fire({
				      title: "일기 등록을 " + res + "하였습니다.",
				      text: ' ',
				      icon: icon
					}).then(result => {
						if (nttCode !== null && nttCode !== '' && nttCode !== undefined) {
							location.href = "/diary/diaryViewDetail?nttCode=" + nttCode;
						} else {
							location.href = "/diary/goToDiaryList";
						}
					});
				}
			})	
		}); // end insertBtn click
	
		// 목록 버튼
		$("#goDiary").on("click", function() {
			location.href = "/diary/goToDiaryList";
		});
		
		// 초등학교 지역을 구해와 날씨 정보를 불러오는 ajax
		getSchulArea().then((area) => getWethr(area));
		
		// 감정 선택
		$(".emotion-inner-div").on("click", function() {
		    $(".emotion-inner-div").removeClass("isSelected");		// 모든 감정 요소에서 isSelected 클래스를 제거
			$(this).attr("class", "emotion-inner-div isSelected");	// 클릭한 감정 요소에 isSelected 클래스를 추가
			
			let value = $(this).find('span').text();
			$("#nttAtchFileCode").val(value);
		});
	}); // end ready

	// 초등학교 지역 구해오는 ajax
	function getSchulArea() {
		return new Promise ((resolve, reject) => {
			$.ajax({
				type: "get",
				url: "/diary/getSchulArea",
				success: function(result) {
					resolve(result);
				}
			})
		});
	}
	
	// 지역 날씨 구해오는 ajax
	function getWethr(area) {
		// 날씨 api
		$.ajax({
			type: "get",
			url: "https://api.openweathermap.org/data/2.5/weather?q=" + area + "&appid=ec911e343913cf4c59f72fbd172aa4af&units=metric",
			dataType: "json",
			success: function(data) {
				// 날씨 아이콘 변경
		    	const changeWeatherIcon = (description) => {
					let iconClass = '';
					let iconColor ='';
			        let weatherTxt = "";
	
					if (description == 'clear sky') {
						iconClass = 'fas fa-sun';
						iconColor = 'orange';
						weatherTxt = '맑음';
					} else if (description == 'few clouds') {
						iconClass = 'fas fa-cloud-sun';
						iconColor = 'gray';
						weatherTxt = '구름 조금';
					} else if (description.includes('clouds') || !(description == 'few clouds')) {
						iconClass = 'fas fa-cloud';
						iconColor = 'skyblue';
						weatherTxt = '구름 많음';
					} else if (description.includes('rain')) {
						iconClass = 'fas fa-cloud-rain';
						iconColor = 'skyblue';
						weatherTxt = '비';
					} else if (description == 'thunderstorm') {
						iconClass = 'fas fa-bolt';
						iconColor = 'gray';
						weatherTxt = '천둥번개';
					} else if (description == 'snow') {
						iconClass = 'fas fa-snowflake';
						iconColor = 'gray';
						weatherTxt = '눈';
					} else if (description == 'mist') {
						iconClass = 'fas fa-water';
						iconColor = 'gray';
						weatherTxt = '안개';
					}
					return { iconClass, iconColor, weatherTxt };
		        }
	
			    // 날씨 아이콘 추가 및 변경
			    const weatherDescription = data.weather[0].description;
			    const { iconClass, iconColor, weatherTxt } = changeWeatherIcon(weatherDescription);
			    const iconHtml = '<i class="' + iconClass + '" style="color: ' + iconColor + ';"></i>';
			    $('.weather_icon').html(iconHtml);
			    $('.currTemp').html(weatherTxt);
			    $("#wethr").val(weatherTxt + iconHtml);
			    
			} // end success
		});
	} // end getWethr
</script>
<div id="DiaryContainer">
	<h3>
		<img src="/resources/images/classRoom/diary/titleImg1.png" style="width:50px; display:inline-block; vertical-align:middel;">
		일기장
		<img src="/resources/images/classRoom/diary/titleImg2.png" style="width:50px; display:inline-block; vertical-align:middel;">
	</h3>
	<form id="frm">
		<input type="hidden" id="nttCode" name="nttCode"/>
		<div class="DiaryAll" style="width: 1400px; margin: auto; margin-bottom:50px;">
			<div class="DiaryTit">
				<table style="width: 100%; margin-bottom:6px;">
					<!------------------------- 자동 완성 버튼 시작 --------------------------->
					<tr>
						<td><i class="fa fa-pencil-square-o autoBtn" id="diaryAutoBtn" aria-hidden="true" style="cursor: pointer; height: 15px; width: 15px;"></i></td>
					</tr>
					<!------------------------- 자동 완성 버튼 끝 ----------------------------->
					<tr style="height: 50px; font-size: 1.4rem; vertical-align: middle;">
						<td style="width: 40%; font-size: 1.8rem;">
							<span id="day"></span>
						</td>
						<td style="width: 20%; font-size: 1.8rem;">
							<input type="hidden" id="wethr" name="wethr"/>
							<span class="currTemp"></span><span class="weather_icon" style="margin-left: 10px;"></span>
						</td>
						<td style="width: 40%;">
							<input type="hidden" id="nttAtchFileCode" name="nttAtchFileCode"/>
							<div class="emotionDiv">
								<div class="emotion-inner-div">
									<img src="/resources/images/classRoom/diary/best.png" class="emotionImg"><br/>
									<span>최고</span>
								</div>
								<div class="emotion-inner-div">
									<img src="/resources/images/classRoom/diary/good.png" class="emotionImg"><br/>
									<span>좋아</span>
								</div>
								<div class="emotion-inner-div">
									<img src="/resources/images/classRoom/diary/normal.png" class="emotionImg"><br/>
									<span>보통</span>
								</div>
								<div class="emotion-inner-div">
									<img src="/resources/images/classRoom/diary/soso.png" class="emotionImg"><br/>
									<span>나빠</span>
								</div>
								<div class="emotion-inner-div">
									<img src="/resources/images/classRoom/diary/worst.png" class="emotionImg"><br/>
									<span>최악</span>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="DiaryTit">
				<input type="text" class="form-control input-sm" name="nttNm" id="nttNm" placeholder="제목을 입력해주세요." style="width:95%;border:none;background: none;height: 50px;font-size: 1.4rem;display: inline-block;vertical-align: middle; margin-bottom:6px;">
				<img src="/resources/images/classRoom/freeBrd/line.png" style="position: absolute;left: 0px;top: 10px;z-index: -1;">
			</div>
			<div class="mb-3" style="display:flex;">
				<div id="bcPaint"></div>
				<script type="text/javascript">
					$('#bcPaint').bcPaint();
				</script>
			</div>
			<div class="diary-cont">
				​​​​​​​​<div id="smarteditor">
					<textarea name="nttCn" id="nttCn" style="width: 100%; height: 412px;"></textarea>
				</div>
			</div>
			<div class="btn-zone">
				<input type="button" value="목록" id="goDiary"/>
				​​​​​​​​<input type="button" value="등록" id="insertBtn"/>
			</div>
		</div>
	</form>
</div>
