<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <button onclick="fOnePage(1)">일단 1 페이지</button>
<button onclick="fTotalPage()">일단 왕창 페이지</button> -->
<script>
var currentPage = "${param.currentPage}";
var keyword = "";
var size = 10;


window.onload = function(){
	//기본 조회
	fn_search(1);
	
	//input태그에서 엔터시 검색버튼누르기
	var input = $("#keyword");
	
	 input.on("keypress", function(event) {
	      if (event.key === "Enter") {
	          event.preventDefault();
	          $("#btnSearch").click();
	      }
	  });
}

//검색 조회
function btnSearch(){
	fn_search(1);
}

function fn_search(page){
	var keyword = $("#keyword").val();
	if(currentPage == "") currentPage = "1"; 
	var data = {
		"keyword":keyword,
		"currentPage":currentPage,
		"size":size
	}
	console.log("data", data);

		$.ajax({
        url: "/school/edcInfoListAjax",
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
			//console.log("result.pagingArea", result.pagingArea);
			//console.log("totalCnt: ",result.total);		//토탈개수
			if (result.total == 0) {
                $("#keyword").val('');

                var	str = `<tr data-index="0" class="none-tr">
								<td style="text-align: center;" colspan="6" >조회된 자료가 없습니다.</td>
							</tr>`;
                
                $("#eduBody").html(str);
            } else {
                var str = ""; // 결과를 누적하기 위해 빈 문자열로 초기화

                $.each(result.content, function(idx, edcInfoNttVO) {
					str += `<tr>
					          <td>\${result.total - (edcInfoNttVO.rnum-1)}</td> //19부터 0까지 나오니까 -1
					          <td><a href=\${edcInfoNttVO.edcInfoNttUrl} target="_blank">\${edcInfoNttVO.edcInfoNttNm}</td>
					          <td>\${edcInfoNttVO.edcInfoNttWrter}</td>
					          <td>\${edcInfoNttVO.edcInfoNttWritngDt}</td>
					       </tr>`;
				});
				$("#eduBody").html(str);
			}
			$("#divPaging").html(result.pagingArea);
		},
		error: function(xhr, status, error) {
            console.error(status, error);
		}
	});//아작스끝
	
}



    const goView = function(...jAr){
        return `https://www.moe.go.kr/boardCnts/viewRenew.do?boardID=\${jAr[0]}&boardSeq=\${jAr[1]}&lev=\${jAr[2]}&searchType=\${jAr[3]}&statusYN=\${jAr[4]}&page=\${jAr[5]}&s=moe&m=020501&opType=\${jAr[6]}`;
    }

    let jieunTotal;
    function fTotalPage(){
		alert("잠시만 기다려주세요..");
        jieunTotal = [];
        for(page=1; page<=50; page++){
            fOnePage(page)
        }
    }
    //크롤링
    function fOnePage(page){
		
        let xhr = new XMLHttpRequest();

        xhr.open("get",`https://www.moe.go.kr/boardCnts/listRenew.do?type=default&page=\${page}&m=020501&s=moe&boardID=333`,true);
        xhr.onload = ()=>{
            let content= xhr.responseText;
            let starIndex = content.indexOf("<table>");
            let endIndex = content.indexOf("</table>",starIndex+7);

            //console.log(content.substring(starIndex,endIndex+8));
            let tblString = content.substring(starIndex,endIndex+8); // 그냥 문자열

            let jieunDiv = document.createElement('div');
            jieunDiv.innerHTML = tblString;    // 실제 html table로 맹금(dom)

            let trs = jieunDiv.querySelectorAll("tr");
            let pageData = [];
            for(let i=0; i<trs.length; i++){
                if(i==0) continue;
                let tr = trs[i];
 
                // console.log("title: ", tr.children[1].children[0].innerHTML);
                // console.log("date: ", tr.children[3].innerHTML);
				// console.log("writer: ", tr.children[2].innerHTML);
				let edcInfoNttNm = tr.children[1].children[0].innerHTML.trim();
				let edcInfoNttWritngDt = tr.children[3].innerHTML;
				let edcInfoNttWrter = tr.children[2].innerHTML;
				
				//console.log("title -> ", edcInfoNttNm);

                let tr2Text = tr.children[1].innerHTML;
                let linkStartIndex = tr2Text.indexOf("goView");
                let linkEndIndex = tr2Text.indexOf(")",linkStartIndex+5);

				let edcInfoNttUrl = eval(tr2Text.substring(linkStartIndex,linkEndIndex+1)); // eval은 보통 해킹의도가 엿보임! 
                console.log("link:", eval(tr2Text.substring(linkStartIndex,linkEndIndex+1)));

                // 데이터 묶기
                /* let oneData = {
                    title: tr.children[1].children[0].innerHTML.trim(),
                    date : tr.children[3].innerHTML,
					writer : tr.children[2].innerHTML,
                    link : eval(tr2Text.substring(linkStartIndex,linkEndIndex+1)) 
				} */
				let oneData = {
					"edcInfoNttNm" : edcInfoNttNm,				//게시물명
					"edcInfoNttWritngDt" : edcInfoNttWritngDt,	//작성일시
					"edcInfoNttWrter" : edcInfoNttWrter,		//작성자
					"edcInfoNttUrl" :	edcInfoNttUrl			//경로
				}

				//console.log("원데이터~~",oneData);
                pageData = [...pageData,oneData]; //모든 페이지 한꺼번에 데이터 추가, 10개씩
                jieunTotal.push(oneData); //jieunTotal배열에 한꺼번에 추가, 계속담는거(전체)
				
            }
            console.log("최종결과 확인:",pageData);

            console.log("지은",page);
            if(page >= 50){
                console.log("글거온 데이터",jieunTotal);

				//크롤링한거 insert하는 Ajax시작
				$.ajax({
					url: "/school/eduInfoInsertAjax",
					type: "post",
					data: JSON.stringify(jieunTotal),
					contentType: "application/json;charset=utf-8",
					//dataType: "text",
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result) {
						console.log("result:",result);
						if(result > 0){
							alert("성공!");
							fn_search(1);
						}
					}

				});//크롤링한거 insert하는 Ajax끝
            }
        }
        xhr.send();
    }
    // javascript:goView('333', '98513', '0', null, 'W', '1', 'N', '');
    //https://www.moe.go.kr/boardCnts/viewRenew.do?boardID=333&boardSeq=98513&lev=0&searchType=null&statusYN=W&page=1&s=moe&m=020501&opType=N
</script>
<style>
#eduInfoContainer h3{
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
#eduInfoContainer{
		min-height: 790px;
}
#eduInfoContainer .custom-pagination{
	max-width:302px;
	margin: auto;
}
.searchForm{
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 5px;
		padding: 15px 20px;
}
#btnSearch,#createBtn{
		background: #333;
		height: 40px;
		border: none;
		padding: 10px 15px;
		border-radius: 10px;
		font-family: 'Pretendard' !important;
		font-weight: 600;
		color: #fff;
}
#btnSearch:hover, #insertBtn:hover{
	background: #ffd77a;
	color:#333;
	transition:all 1s;
	font-weight: 700;
}
#createBtn{
	background: #006DF0;
}

.fixed-table-body tbody tr.none-tr:hover {
background: #f5f5f5!important;
}
	
	</style>
<div id="eduInfoContainer">
	<div class="sparkline13-list">
		<h3>
			<img src="/resources/images/school/eduInfo1.png" style="width:50px; display:inline-block; vertical-align:middel;">
				교육부 소식 안내
			<img src="/resources/images/school/dataRoom2.png" style="width:50px; display:inline-block; vertical-align:middel;">		
		</h3>
		<div class="sparkline13-graph">
			<div class="datatable-dashv1-list custom-datatable-overright">
				<div class="bootstrap-table">
					<div class="fixed-table-toolbar">
						<div class="pull-left button">
							<c:if test="${USER_INFO.vwMemberAuthVOList[0].cmmnDetailCode == 'ROLE_A01000'}">
								<button type="button" id="createBtn" onclick="fTotalPage()">크롤링해오기</button>
							</c:if>
						</div>
						<div class="pull-right search" style="margin-bottom: 20px;">
								<!-- 검색어 시작 -->
								<input class="searchForm" type="text" placeholder="제목을 입력해 주세요." name="keyword" id="keyword" value="${keyword}">
								<button type="button" id="btnSearch"  onclick="btnSearch()">검색</button>
								<!-- 검색어 끝 -->
						</div>
					</div>
					<div class="fixed-table-container" style="padding-bottom: 0px;">
						<div class="fixed-table-body">
							<table class="table">
								<thead>
									<tr>
										<th>순번</th>
										<th>제목</th>
										<th>작성자</th>
										<th>등록일</th>
									</tr>
								</thead>
								<tbody id="eduBody">
								</tbody>
							</table>
						</div>
						<!-- 페이징을 보여줄 html;값 가져오기 -->
						<div class="pagination text-center" style="width:100%;" id="divPaging"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>