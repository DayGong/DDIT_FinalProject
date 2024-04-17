/**
 * 
 */

const getScoreTableStr = function(ueRes, ueIdx = -1, stdIdx = -1){
	/*
	2번째 매개변수 : 단원평가 필터링
	3번째 매개변수 : 학생 필터링
	
	-2 : 선택 없음
	-1 : 전체 선택
	0~ : 유효한 인덱스
	*/

	let str = `<table class = "d-tb" style ="width : 100%">`;	
	
	// 선택 없음
	if(ueIdx == -2 || stdIdx == -2){
		// 문제 기본 정보
		str += `
				<tr>
					<th colspan = "2">단원평가 명</th>
					<td colspan = "4"></td>
					<th colspan = "2" style ="text-align:center;">단원평가 기간</th>
					<td colspan = "4"></td>
					<th rowspan = "4" id = "blank" style ="width:5%"></th>
				</tr>
				<tr>
					<th colspan = "2">응시 인원</th>
					<td style ="text-align:center;"></td>
					<th colspan = "2" style ="text-align:center;">미응시 인원</th>
					<td style ="text-align:center;"></td>
					<th colspan = "2" style ="text-align:center;">총 인원</th>
					<td style ="text-align:center;"></td>
					<th colspan = "2" style ="text-align:center;">반 평균 점수</th>
					<td style ="text-align:center;"></td>
				</tr>`;
		// 문제 문항
		str +=	`<tr>
					<th colspan = "2">문항 번호</th>
					<td style="width:7.5%; text-align:center;"">1</td>
					<td style="width:7.5%; text-align:center;"">2</td>
					<td style="width:7.5%; text-align:center;"">3</td>
					<td style="width:7.5%; text-align:center;"">4</td>
					<td style="width:7.5%; text-align:center;"">5</td>
					<td style="width:7.5%; text-align:center;"">6</td>
					<td style="width:7.5%; text-align:center;"">7</td>
					<td style="width:7.5%; text-align:center;"">8</td>
					<td style="width:7.5%; text-align:center;"">9</td>
					<td style="width:7.5%; text-align:center;"">10</td>
				</tr>
				<tr>
					<th colspan ="2">정답</th>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
					<td style ="text-align:center;"></td>
				</tr>
				<tr>
					<td id = "rs" style ="display:none;">4</td>
				</tr>
				</table>`;
		
		return str;
	}
	
	// 단원평가 정보
	ueRes.forEach(function(unitTest,index){
		// 필터링 있으면 index와 비교해서 continue
		if(index != ueIdx && ueIdx != -1){ return; }
		
		let rs = 4; // rowspan;

		if(index != 0 && ueIdx == -1){
			str += `<tr><th colspan ='100%;'></th></tr>`;
		}
		
		// 문제 기본 정보
		str += `<tr>
					<th colspan = "2">단원평가 명</th>
					<td colspan = "4" >${unitTest.unitEvlNm}</td>
					<th colspan = "2" style ="text-align:center;">단원평가 기간</th>
					<td colspan = "4" >${dateToMinFormat(unitTest.unitEvlBeginDt)}~${dateToMinFormat(unitTest.unitEvlEndDt)}</td>
					<th rowspan = "4" id = "blank" style ="width:5%"></th>
				</tr>
				<tr>
					<th colspan = "2">응시 인원</th>
					<td style ="text-align:center;">${unitTest.doneCnt}</td>
					<th style ="text-align:center;" colspan = "2">미응시 인원</th>
					<td style ="text-align:center;">${unitTest.yetCnt}</td>
					<th style ="text-align:center;" colspan = "2">총 인원</th>
					<td style ="text-align:center;">${unitTest.allCnt}</td>
					<th style ="text-align:center;" colspan = "2" style ="text-align:center;">반 평균 점수</th>
					<td style ="text-align:center;">${unitTest.avgClasScore}</td>
				</tr>`;
		// 문제 문항
		str +=	`<tr>
					<th colspan = "2">문항 번호</th>
					<td style="width:7.5%; text-align:center;">1</td>
					<td style="width:7.5%; text-align:center;">2</td>
					<td style="width:7.5%; text-align:center;">3</td>
					<td style="width:7.5%; text-align:center;">4</td>
					<td style="width:7.5%; text-align:center;">5</td>
					<td style="width:7.5%; text-align:center;">6</td>
					<td style="width:7.5%; text-align:center;">7</td>
					<td style="width:7.5%; text-align:center;">8</td>
					<td style="width:7.5%; text-align:center;">9</td>
					<td style="width:7.5%; text-align:center;">10</td>
				</tr>
				<tr>
					<th colspan ="2">정답</th>`;
		
		// 문제 정답	
		unitTest.quesList.forEach(function(ques,index2){
			// 10개 단위로 줄바꿈
			if((index2+1) % 10 == 1 && index2+1 != 1){
				str +=	`</tr>
						 <tr>
							<th colspan ="2">문항 번호</th>`;
				
				let temp = Math.floor(((index2+1)/10))%10;
				str +=	`	<td style ="text-align:center;">${temp}1</td>
							<td style ="text-align:center;">${temp}2</td>
							<td style ="text-align:center;">${temp}3</td>
							<td style ="text-align:center;">${temp}4</td>
							<td style ="text-align:center;">${temp}5</td>
							<td style ="text-align:center;">${temp}6</td>
							<td style ="text-align:center;">${temp}7</td>
							<td style ="text-align:center;">${temp}8</td>
							<td style ="text-align:center;">${temp}9</td>
							<td style ="text-align:center;">${temp+1}0</td>
						</tr>
						<tr>
							<th colspan ="2">정답</th>`;
				
				rs += 2;
			}

			str += `<td style ="text-align:center;">${ques.quesCnsr}</td>`;
		})
		// 문제 갯수 모자르면 빈칸으로 채움
		let temp = unitTest.quesList.length%10;
		if(temp!=0){
			for(let i = 0; i < 10-temp; ++i){
				str += `<td></td>`;
			}
		}
		str += `</tr>`;
		
		// 학생 정보
		unitTest.unitEvlScoreVOList.forEach(function(member,index3){
			// 필터링 있으면 index와 비교해서 continue
			if(index3 != stdIdx && stdIdx != -1){ return; }
			
			str += `<tr>
					<th style="width:5%;">${member.clasInNo}</th>
					<td style="width:15%;">${member.mberNm}</td>`;
			
			// 학생 답안
			member.aswperList.forEach(function(aswper,index4){
				// 10개 단위로 줄바꿈
				if((index4+1)%10==1 && index4+1 != 1){
					str+=`</tr>
						  <tr>
							  <th></th>
							  <td></td>`;
				}
				str += `<td style ="text-align:center;">${aswper.aswperCn}</td>`;
			})
			// 답안 갯수 모자르면 빈칸으로 채움
			let temp = member.aswperList.length%10;
			if(temp!=0){
				for(let i = 0; i < 10-temp; ++i){
					str += `<td></td>`;
				}
			}
			
			str += `<td style = "text-align :right;">${member.scre}점</td>
					</tr>`;
					
		})
		str += `<td id = "rs" style ="display:none;">${rs}</td>`;
	})
	str += `</table>`;
	
	return str;
}