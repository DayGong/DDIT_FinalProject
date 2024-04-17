/**
사용 방법 :

<script type="text/javascript" src="/resources/js/cjh.js"></script>

<script>
cjh.modelDateFormat("모델데이터");
</script>

모델데이터라고 적힌 매개변수에는 "Mon Apr 15 15:00:00 KST 2024" 형식의 데이터를 넣어준다. 
ex) cjh.modelDateFormat("${modelVO.startDate}");
*/

var cjh = {};

//querySelector 함축 함수
cjh.selOne = function(target){
	return document.querySelector(target);
}
cjh.selAll = function(target){
	return document.querySelectorAll(target);
}

// 날짜 형식 변경 함수
// Mon Apr 15 15:00:00 KST 2024
// => 2024-4-15
cjh.modelDateFormat = function(date){
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
	
	console.log("season:", season);
	
	let stringList = date.split(" ");
	let y = stringList[5];
	let M = season[stringList[1]];
	let d = stringList[2];
	
	return y+"-"+M+"-"+d;
}
// Mon Apr 15 15:00:00 KST 2024
// => 2024-4-15 15:00
cjh.modelDateToMinFormat = function(date){
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
	
	console.log("season:", season);
	
	let stringList = date.split(" ");
	let y = stringList[5];
	let M = season[stringList[1]];
	let d = stringList[2];
	let hms = stringList[3].split(":");
	let h = hms[0];
	let m = hms[1];
	
	return y+"-"+M+"-"+d+" "+h+":"+m;
}

// 현재시각을 초과했는지
// 매개변수 "2024-03-19", "2024-03-19 15:00" 등
cjh.isOverNowTime = function(date, eq = false){
	let nowdate   = new Date();
	let mydate = new Date(date);
	
	if(eq){
		if(mydate >= nowdate){
			return true;
		}else{
			return false;
		}
	}
	
	if(mydate > nowdate){
		return true;
	}else{
		return false;
	}
}

// 현재 시각보다 작은지
cjh.isUnderNowTime = function(date, eq = false){
	let nowdate   = new Date();
	let mydate = new Date(date);
	
	if(eq){
		if(mydate <= nowdate){
			return true;
		}else{
			return false;
		}
	}
	
	if(mydate < nowdate){
		return true;
	}else{
		return false;
	}
}

// 오늘을 초과했는지
cjh.isOverToday = function(date, eq=false){
	let today = new Date();
	let myday = new Date(date);
	
	today = Math.floor(today.getTime()/(1000*60*60*24));
	myday  = Math.floor(myday.getTime()/(1000*60*60*24));

	today *= (1000*60*60*24);
	myday *= (1000*60*60*24);
	
	if(eq){
		if(myday >= today){
			return true;
		}else {
			return false;
		}
	}
	
	if(myday > today){
		return true;
	}else {
		return false;
	}
}

// 오늘보다 작은 날짜인지
cjh.isUnderToday = function(date, eq=false){
	let today = new Date();
	let myday = new Date(date);
	
	today = Math.floor(today.getTime()/(1000*60*60*24));
	myday  = Math.floor(myday.getTime()/(1000*60*60*24));

	today *= (1000*60*60*24);
	myday *= (1000*60*60*24);
	
	if(eq){
		if(myday <= today){
			return true;
		}else {
			return false;
		}
	}
	
	if(myday < today){
		return true;
	}else {
		return false;
	}
}


/* 
	SweetAlert - alert
	
	사용 방법 : 
	cjh.swAlert("title", "text", "warning");
*/
cjh.swAlert = async function(title = '', msg = '', icon = "success") {
	await Swal.fire({
		title : title,
		text : msg,
		icon: icon, // warning, error, success, info, question
		confirmButtonText: '닫기',
		confirmButtonColor: 'var(--blue-color)', // confrim 버튼 색깔 지정
	});
}

/* 
	SweetAlert - confirm
	
	사용 방법 : 
	cjh.swConfirm("title", "text", "warning").then(function(res){
		if(res.isConfirmed){
			...
		}
	})
	
	버튼 색과 text를 바꾸고 싶을 때 :
	cjh.swConfirm("title", "text", "warning", "삭제", "돌아가기", "red", "gray").then(function(res){
		if(res.isConfirmed){
			...
		}
	})
	
	파라미터를 수락text, 거절text, 수락색상, 거절색상 순으로 기입
*/
cjh.swConfirm = async function(title = '', msg = '', icon = 'warning', confirmText = '네', cancelText = '아니오'
								, confirmColor ='blue', cancelColor = 'gray') {
									
	confirmColor = cjh.getColor(confirmColor);
	cancelColor = cjh.getColor(cancelColor);
	
	let confirmRes = await Swal.fire({
		title : title,
		text : msg,
		icon : icon, // warning, error, success, info, question
		showCancelButton: true, 
		confirmButtonText : confirmText,
		cancelButtonText : cancelText,
		confirmButtonColor: confirmColor, // confrim 버튼 색깔 지정
	    cancelButtonColor : cancelColor, // cancel 버튼 색깔 지정
	});
	
	return confirmRes;
}



cjh.swSelect = async function(inputData = {}, title = '', msg = '', icon = 'info', confirmText = '확인', cancelText = '취소'
								, confirmColor ='blue', cancelColor = 'gray') {
		
	confirmColor = cjh.getColor(confirmColor);
	cancelColor = cjh.getColor(cancelColor);
	
	let returnData = "";
	
	let {value:selVal} = await Swal.fire({
		title : title,
		text : msg,
		icon : icon, // warning, error, success, info, question
		input : 'select', // text, select, radio
		inputOptions: inputData,
		inputPlaceholder: "눌러서 선택하세요..",
		showCancelButton: true, 
		confirmButtonText : confirmText,
		cancelButtonText : cancelText,
		confirmButtonColor: confirmColor, // confrim 버튼 색깔 지정
	    cancelButtonColor : cancelColor, // cancel 버튼 색깔 지정

		inputValidator:(value) => {
			returnData = value;
		}
	});
	
	return returnData;
}

cjh.getColor = function(color){
	switch (color){
		case 'blue' :
		return 'var(--blue-color)';
		case 'yellow' :
		return 'var(--yellow-color)';
		case 'red' :
		return 'var(--red-color)';
		case 'green' :
		return 'var(--green-color)';
		case 'gray' :
		return 'var(--gray-color-dark)';
		default:
		return 'var(--blue-color)';
	}
	
} 