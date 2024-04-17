/*
	공통으로 사용하는 함수 모음
	
	사용 방법 :
	1. jsp 파일에 <script type="text/javascript" src="/resources/js/commonFunction.js"></script> 을 추가한다.
	2. 사용하고 싶은 함수를 골라 사용한다.
*/

// error 형태의 알림창
function alertError(title, text) {
	Swal.fire({
		title: title,
		text: text,
		icon: 'error',
		confirmButtonColor: '#d33',
		confirmButtonText: '닫기'
	});
}

// 확인 형태의 알림창 (현재 화면 재로드)
// 예시
// success: function(result) {
// 		resultAlert(result, '상담 예약 거부를', '상담 예약 화면으로 이동합니다.');
// }
function resultAlert(result, actTitle, reloadPage) {
	let res = "성공";
	let icon = "success";
	
	if (result != 1) { res = "실패"; icon = "error"; }
	
	Swal.fire({
      title: actTitle + " " + res + '하였습니다.',
      text: reloadPage,
      icon: icon
	}).then(result => { location.reload(); });
}

function resultAlert2(result, title, text, reloadPage) {
	let res = "성공";
	let icon = "success";
	if (result != 1) { res = "실패"; icon = "error"; }
	
	Swal.fire({
		title: title + " " + res + '하였습니다.',
		text: text,
		icon: icon
	}).then(result => { 
		if(reloadPage!=null && reloadPage!=''){
			location.href=reloadPage;
		}
	

	});
}

function resultConfirm(title, text, reloadPage) {
	Swal.fire({
		title: title,
		text: text,
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '확인',
		cancelButtonText: '취소',
		reverseButtons: false,
	}).then(result => {
		if(reloadPage!=null && reloadPage!=''){
			if(result.isConfirmed) {
				location.href=reloadPage; 
			}
		}
		
	});
}

// 주말 확인 함수
function getDayOfWeek(yyyyMMdd){
	const dayOfWeek = new Date(yyyyMMdd).getDay(); 
	
	//0:일, 1:월, 2:화, 3:수, 4:목, 5:금, 6:토
	if (dayOfWeek == 0 || dayOfWeek == 6) {
		return false;
	}
    
	return true;
} // end getDayOfWeek

// 오늘 이전 날짜면 false 리턴, 오늘 이후 날짜면 true 리턴
function prevToday(yyyyMMdd) {
	const selectDay = new Date(yyyyMMdd);
	const today = new Date();
	
	if (dateFormat(selectDay) < dateFormat(today)) { return false; }
	
	return true;
} // end prevToday

// 날짜 포맷 함수(ex: 2024-03-12)
function dateFormat(date){
	var selectDate = new Date(date);
	var d = selectDate.getDate();
	var m = selectDate.getMonth() + 1;
	var y = selectDate.getFullYear();
   
	if(m < 10) m = "0" + m;
	if(d < 10) d = "0" + d;
   
	return y + "-" + m + "-" + d; 
}

// 분 단위까지 출력하는 날짜 포맷 함수 
//(ex: 2024-03-12 13:50)
function dateToMinFormat(date){
   var selectDate = new Date(date);
   var d = selectDate.getDate();
   var m = selectDate.getMonth() + 1;
   var y = selectDate.getFullYear();
   var hour = selectDate.getHours();
   var min = selectDate.getMinutes();
   
   if(m < 10)    m    = "0" + m;
   if(d < 10)    d    = "0" + d;
   if(hour < 10) hour = "0" + hour;
   if(min < 10)  min  = "0" + min;
   
   return y + "-" + m + "-" + d + " " + hour + ":" + min; 
}

/*
날짜 형식 변경 함수
Mon Apr 15 15:00:00 KST 2024
==> 2024-4-15

사용 방법 :
<script>
modelDateFormat("날짜데이터");
</script>

매개변수에 model에 담긴 date타입의 데이터를 넣는다.
ex) modelDateFormat("${modelVO.startDate}");

*/
modelDateFormat = function(date){
	const season = {
		Jan : "01",
		Feb : "02",
		Mar : "03",
		Apr : "04",
		May : "05",
		Jun : "06",
		Jul : "07",
		Aug : "08",
		Sep : "09",
		Oct : "10",
		Nov : "11",
		Dec : "12"
		}
	
	let stringList = date.split(" ");
	let y = stringList[5];
	let M = season[stringList[1]];
	let d = stringList[2];
	
	return y+"-"+M+"-"+d;
}
// Mon Apr 15 15:00:00 KST 2024
// ==> 2024-4-15 15:00
modelDateToMinFormat = function(date){
	const season = {
		Jan : "01",
		Feb : "02",
		Mar : "03",
		Apr : "04",
		May : "05",
		Jun : "06",
		Jul : "07",
		Aug : "08",
		Sep : "09",
		Oct : "10",
		Nov : "11",
		Dec : "12"
		}
	
	let stringList = date.split(" ");
	let y = stringList[5];
	let M = season[stringList[1]];
	let d = stringList[2];
	let hms = stringList[3].split(":");
	let h = hms[0];
	let m = hms[1];
	
	return y+"-"+M+"-"+d+" "+h+":"+m;
}

/*
글자수 많으면 "문자열..." 로 나타내는 함수

사용방법 :
let str ="매우매우매우 긴 문자열";
console.log(cutStr(str,5));

파라미터 :
1. 자를 문자열
2. 문자 최대 출력 수

결과 값 :
"매우매우매..."
*/
cutStr = function(str, len = 40){
	if(str.length >= len){
		return str.substr(0,len)+"...";
	}else{
		return str;
	}
}

/*
학년 코드를 숫자로 변환시켜주는 함수

사용 방법 :
toNumGrade(cmmnCode);

파라미터 : 
"A16001" 형식의 문자열

결과 값 :
"1"
*/
toNumGrade = function(gradeCode){
	return gradeCode.substr(5,6);
}

//