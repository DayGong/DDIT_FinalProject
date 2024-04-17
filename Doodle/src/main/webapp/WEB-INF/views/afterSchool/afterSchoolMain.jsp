<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
//beforeSend 전역변수 처리
const header="${_csrf.headerName}";
const token ="${_csrf.token}";


window.onload = function(){
   console.log("실행되었습니다~ ")
   
   //날짜 포맷 생성  함수
   function dateFormat(date) {
      let dateFormat2 = date.getFullYear() +
      '-' + ( (date.getMonth()+1) < 9 ? "0" + (date.getMonth()+1) : (date.getMonth()+1) )+
      '-' + ( (date.getDate()) < 9 ? "0" + (date.getDate()) : (date.getDate()) );
      return dateFormat2;
   }
   
   // 일자별 날짜 불러오기
   function getDates(startDate, endDate){
      const dateArray = [];
      
      while(startDate <= endDate){
         dateArray.push(startDate.toISOString().split('T')[0]);
         startDate.setDate(startDate.getDate() + 1);
      }
      return dateArray;
   }

   // 방과후버튼 클릭시 생성화면으로 이동하기
   document.querySelector("#addAfterSchool").addEventListener("click", ()=>{
      location.href = "/afterSchool/afterSchoolCreate?schulCode="+"${param.schulCode}";
   });
   
   // 학생 리스트의 결제 완료 버튼 클릭시 수업진행중으로 상태 변경하기
   $(document).on("click",".btnPayDone",function(){
      console.log("결제완료 클릭!");
      
      const atnlcReqstCode = this.closest("tr").querySelector(".atnlcReqstCode").textContent.trim();
      
      let data = {
         "atnlcReqstCode": atnlcReqstCode
      }
      console.log("data : ",data);
      
      $.ajax({
         url : "/afterSchool/lectureStateUpdate",
         contentType : "application/json; charset = utf-8",
         data : JSON.stringify(data),
         type: "post",
         dataType:"json",
         beforeSend : function(xhr){
            xhr.setRequestHeader(header, token);
         },
         success: function(result){
            Swal.fire({
                 title: '학생 상태를 수강중으로 변경하시겠습니까?',
                 text: "수정내용은 바로 반영됩니다.",
                 icon: 'warning',
                 showCancelButton: true,
                 confirmButtonColor: '#3085d6',
                 cancelButtonColor: '#d33',
                 confirmButtonText: '수정',
                 cancelButtonText: '취소',
                 reverseButtons: false, // 버튼 순서 거꾸로
                 
               }).then((result) => { 
                 if (result.isConfirmed) {
                   Swal.fire(
                     '수강중으로 변경 되었습니다.',
                     '목록으로 이동합니다.',
                     'success'
                   ).then(function(){
                         location.href='/afterSchool/afterSchoolMain?mberId=${memberVO.mberId}';
                  });
                 }
              });
         }
      });
   });
   
   
   // 방과후 학교명 클릭시 해당하는 수강신청한 학생 목록 불러오기
   $(document).on("click",'tr[data-code="code"]',function(){
//    $(document).on("click",".aAschaNm",function(){
      console.log("클릭이벤트 발생!");
      
      var aschaCode = this.getAttribute("data-ascha-code");
      var schulNm  = ""; // 학교이름
      var cmmnGrade= ""; // 학년
      var clasNm   = ""; // 반
      var clasInNo = ""; // 번호
      var mberNm   = ""; // 학생이름
      var aschaNm  = ""; // 방과후학교 명
      var cmmnDetailCode = "";    // 수강신청 상태
      var aschaAtnlcCt   = "";   // 방과후학교 금액
      var moblphonNo =   "";      // 연락처(학부모)
      
      console.log("aschaCode : ",aschaCode);
      
      // 수납 안내 문자 전송
      function sendMsg(idx, aschaVO){
         console.log("수납안내 버튼");
         
         // 문자메시지 내용
         // 문자메시지 내용
         var sendStr = `[\${schulNm} 방과후학교 ] \${mberNm} 학생의 \${aschaNm} 과목이 결제가 되지 않았습니다. 수납 부탁드립니다. 금액 : \${aschaAtnlcCt}원 수납경로 : 방과후학교 > 내자녀 방과후학교 > 결제대기버튼 클릭`;

         
         // 알림 
         Swal.fire({
               title: '수납안내 문자를 전송하시겠습니까?',
               text: "",
               icon: 'warning',
               showCancelButton: true,
               confirmButtonColor: '#3085d6',
               cancelButtonColor: '#d33',
               confirmButtonText: '전송',
               cancelButtonText: '취소',
               reverseButtons: false, // 버튼 순서 거꾸로
               
             }).then((result) => { 
                   if (result.isConfirmed) {
                         Swal.fire(
                           '미리보기 입니다',
                           sendStr,
                           'success'
                         ).then(function(){
                           $.ajax({
                              url :"/sms/sendMsg",
                              type:"post",
                              data:JSON.stringify({
                                 "moblphonNo": "010-7182-8948",
                                 "msg": sendStr
                                 }),
                              contentType : "application/json",
                              dataType : "json",
                              async:false,
                              beforeSend:function(xhr){
                                 console.log("Request Data:", xhr);
                                 xhr.setRequestHeader(header, token);
                              },
                              success :function(res){
                                 Swal.fire(
                                 "문자발송에 성공하였습니다.",
                                 "목록으로 돌아갑니다.",
                                 "success"
                                  )
                                 console.log("문자보냇습니도");
                              },
                              error :function(xhr)
                              {
                                 Swal.fire(
                                 "문자발송에 실패하였습니다.",
                                 "다시 시도해주세요.",
                                 "error"
                                  )
                           console.log(`문자보내기에 실패하였습니다. 에러 내용: ${xhr.status}`);   
                              }
                           })
  
                         });
                       }
         });
      }
      
      // 출석부 리스트
       const attendList = function() {
	      $.ajax({
	         url: "/afterSchool/attendanceList",
	         contentType : "application/json;charset=utf-8",
	         data: JSON.stringify({
	            "aschaCode": aschaCode
	            }),
	         type: "post",
	         dataType: "json",   
	         beforeSend: function(xhr){
	            xhr.setRequestHeader(header, token);
	         },
	         success:function(result){
	            console.log("aftresult : ", result);
	            
	            let tblStr = "";
	            
	            if(result.length ===0){
	               tblStr =`
	                     <br>
	                     <table>
	                           <tr><td colspan='8'>수강신청한 학생이 없습니다.</td></tr>
	                           </table>`;
	               disp.innerHTML = tblStr;       
	                           
	            }else{
	                let students = [];   // 학생이름 넣을 배열
	                let studentsId = []; // 학생 아이디 넣을 배열
	                let atnlcReqstCodes = []; // 수강신청 코드 넣을 배열
	                let attends= {};   // 출결정보 저장 예정
	
	               // 단계1 필요한 데이터 모양 완성
	               result.forEach(function(aschaVO, idx){
	                  mberNm =aschaVO.mberNm ;                     // 학생 이름 가져오기
	                  // 배열에 학생이름 넣기
	                  students.push(mberNm);
	                  
	                  // 수강신청 코드 가져오기 
	                  aschaVO.atnlcReqstVOList.forEach(function(atnlcReqstVO, index){
	                     let atnlcReqstCode = atnlcReqstVO.atnlcReqstCode;
	                     let studentId = atnlcReqstVO.stdntId;
	                     
	                     console.log("atnlcReqstCode :",atnlcReqstCode);
	                     
	                     atnlcReqstCodes.push(atnlcReqstCode);
	                     studentsId.push(studentId);
	                  });
	               });
	                
	               // 단계 2  테이블 모양 맹글기
	               let startDate = new Date(result[0].aschaAtnlcBgnde);    // 방과후 시작날짜
	               let endDate = new Date(result[0].aschaAtnlcEndde);   // 방과후 종료 날짜
	               let tblStr = `<table border=1 id=shTbl>
	                           <tr>
	                            <th>날짜/이름</th>
	                          `;
	               for (let i = 0; i < students.length; i++) {
	                  tblStr += `<th>\${students[i]}</th>`;
	               }
	               tblStr += `</tr>`;
	
	               let now = new Date();
	               for (let i = new Date(startDate); i <= endDate; i.setDate(i.getDate() + 1)) {
	                   //now.setDate(now.getDate() + i);
	
	                  let shYear = i.getFullYear();
	                  let shMonth = i.getMonth()+1;
	                  if(shMonth < 10) shMonth = "0"+shMonth;
	                  let shDate = i.getDate();
	                  if(shDate < 10) shDate = "0"+shDate;
	                  let dateStr = `\${shYear}-\${shMonth}-\${shDate}`;
	                  
	                  tblStr += `<tr>
	                              <td class="lectureDate">\${dateStr}</td>
	                           `;
	                  for (let j = 0; j < students.length; j++) {
	                     let mberId = studentsId[j];
	                     let atnlcReqstCode = atnlcReqstCodes[j];
// 	                     console.log("mberId : ",mberId);
	                     
	                     tblStr += `
	                           <td data-mber-id="\${mberId}"
		                           data-atnlc-reqst-code="\${atnlcReqstCode}" 
			                       data-attend-date="\${dateStr}"><button class="btnAttend" data-toggle="modal"
	                              data-target="#AttendModalalert"
	                              data-mber-id="\${mberId}"
	                              data-atnlc-reqst-code="\${atnlcReqstCode}" 
	                              data-attend-date="\${dateStr}"
	                              style="border: white; background: white;">
	                              <i class="fa-regular fa-circle-check"></i>
	                              </button></td>`;
	                  }
	               }
	               tblStr += `   </tr>
	                         </table>`;
	               disp.innerHTML = tblStr;                        
	            }
	            console.log("tblStr : ",tblStr);
	
	            // 단계 3, 테이블 날짜와 학생 출석날짜 비교
	            let shTrs = document.querySelector("#shTbl").querySelectorAll("tr");
	
	            result.forEach(function(aschaVO, idx){
	               let  atnlcReqstVOList  = aschaVO.atnlcReqstVOList;
	               for(let i=0; i<atnlcReqstVOList.length; i++){
	                     let aschaDclzVOList = atnlcReqstVOList[i].aschaDclzVOList;
	                     for(j=0; j< aschaDclzVOList.length; j++){
	                         //console.log("체킁:",aschaDclzVOList[j].aschaAtendDe);
	                        for(k=1; k< shTrs.length; k++){
	                           //console.log(shTrs[k].children[0].innerHTML,aschaDclzVOList[j].aschaAtendDe.split(" ")[0]);
	                           if(shTrs[k].children[0].innerHTML == aschaDclzVOList[j].aschaAtendDe.split(" ")[0]){
	                              shTrs[k].children[idx+1].innerHTML = aschaDclzVOList[j].cmmnDetailCode;
	                              
	                              (function(k, idx) {
	                                  shTrs[k].children[idx+1].addEventListener('click', function() {
	                                      console.log("shTrs[k].children[idx+1] 클릭 :", shTrs[k].children[idx+1]);
	                                      // 클릭요소에서 데이터 추출함.
	                                      
	                                      let data ={
		                                      "mberId" : this.getAttribute('data-mber-id'),
		                                      "atnlcReqstCode" : this.getAttribute('data-atnlc-reqst-code'),
		                                      "aschaAtendDe" : this.getAttribute('data-attend-date'),
		                                      "cmmnDetailCode": ""
	                                      }
	                                      console.log("data! : ", data);

	                                      $('#UpdateModalalert').modal('show');
	                                      attendanceUpdate(data);
	                                      
	                                      // update모달창 속 삭제 버튼 눌렀을 때.
	                            	      document.querySelector("#btnDelete").addEventListener("click", function(){
	                            	    	  attendanceDelete(data); 
	                            	      });
 
	                                  });
	                              })(k, idx);
	                           }
	                        }                    
	                     }
	               }
	
	            });
	
	         }
	      });
      } // 출석부 list 끝
      attendList();
      
      // 출결 수정 ajax
      const attendanceUpdate = function(data){
		 // 모든 출결버튼(수정용) 선택하기
         var buttons = document.querySelectorAll(".cmmnAttendCdUdt");       
         buttons.forEach(function(button){
            button.addEventListener("click", function(){
               var clickAttend = this.value;
               console.log("clickAttend: ", clickAttend);
              
               data.cmmnDetailCode = clickAttend;
			   console.log("attendanceUpdate data :",data);
		    	  $.ajax({
		    		 url : "/afterSchool/attendanceUpdate",
		    		 contentType : "application/json;charser = utf-8",
		    		 data : JSON.stringify(data),
		    		 type : "post",
		    		 dataType : "json",
		    		 beforeSend : function(xhr){
		    			 xhr.setRequestHeader(header, token);
		    		},
		    		 success : function(result){
		    			 console.log(result);
                    Swal.fire({
                       title: '출결 상태를 변경하시겠습니까?',
                       text: "수정내용은 바로 반영됩니다.",
                       icon: 'warning',
                       showCancelButton: true,
                       confirmButtonColor: '#3085d6',
                       cancelButtonColor: '#d33',
                       confirmButtonText: '수정',
                       cancelButtonText: '취소',
                       reverseButtons: false, // 버튼 순서 거꾸로

                    }).then((result) => {
                       if (result.isConfirmed) {
                          Swal.fire(
                             '수정 되었습니다.',
                             '목록으로 이동합니다.',
                             'success'
                          ).then(function () {
                             attendList();
                             $(".modal").modal("hide");
                          });
                       }

                    });
                   }

                });
            });
         });

      }// 출결 수정 ajax 끝
      
      // 출결 삭제 ajax
      const attendanceDelete = function(data){
		console.log("attendanceUpdate delete :",data);
      	
		$.ajax({
			url:"/afterSchool/attendanceDelete",
			contentType : "application/json;charser = utf-8",
	   		data : JSON.stringify(data),
			type : "post",
			dataType : "json",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function(result){
   			 console.log(result);
             Swal.fire({
                title: '출결 상태를 삭제하시겠습니까?',
                text: "",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '삭제',
                cancelButtonText: '취소',
                reverseButtons: false, // 버튼 순서 거꾸로

             }).then((result) => {
                if (result.isConfirmed) {
                   Swal.fire(
                      '삭제 되었습니다.',
                      '목록으로 이동합니다.',
                      'success'
                   ).then(function () {
                      attendList();
                      $(".modal").modal("hide");
                   });
                }

             });
            }
			
		});
		
    	  
      } // 출결 삭제 ajax 끝
      
      
      // 출결버튼 클릭해서 출결처리 하기
      const attendInput = function() {
      
	   	  // 데이터 초기화
	   	 let data = {
	 			    "cmmnDetailCode": "",
	 			    "mberId": "",
	 			    "aschaAtendDe": "",
	 			    "atnlcReqstCode": ""
	   			};
         
         // 날짜별 출석버튼 클릭시 데이터 가지고 오기
         $(document).on("click", ".btnAttend", function() {
		    var mberId = $(this).data("mber-id");
		    var attendDate = $(this).data("attend-date");
		    var atnlcReqstCode = $(this).data("atnlc-reqst-code");
		
		    console.log("mberId: ", mberId);
		    console.log("aschaAtendDe: ", attendDate);
		    console.log("atnlcReqstCode: ", atnlcReqstCode);
		    
            data.mberId = mberId;
            data.aschaAtendDe = attendDate;
            data.atnlcReqstCode = atnlcReqstCode;
		    
		});
         
         // 모든 출결버튼 선택하기
         var buttons = document.querySelectorAll(".cmmnAttendCd");       
         buttons.forEach(function(button){
            button.addEventListener("click", function(){
               var clickAttend = this.value;
               console.log("clickAttend: ", clickAttend);
              
               data.cmmnDetailCode = clickAttend;
		       console.log("data : ",data);
		       
		       // 출결정보 등록하는 ajax
		       $.ajax({
		    	  url : "/afterSchool/attendanceInsert",
		    	  contentType : "application/json;charset = utf-8",
		    	  data: JSON.stringify(data),
		    	  type: "post",
		    	  dataType : "json",
		    	  beforeSend:function(xhr){
		    		  xhr.setRequestHeader(header, token);
		    	  },
		    	  success:function(result){
		    		  console.log("result :", result);
		    		  
		    		  Swal.fire(
					            '출결처리 되었습니다.',
					            '목록으로 돌아갑니다',
					            'success'
						   )
							console.log("출결처리됨~!~!");
							$(".modal").modal("hide");
							attendList();
		    		  },
 
		       });
		       
            });
         }); 
      }
      attendInput();
      
      // 과목 수강중인 학생 리스트 불러오는 ajax
      $.ajax({
         url: "/afterSchool/lectureStudentList",
         contentType : "application/json;charset=utf-8",
         data: JSON.stringify({
            "aschaCode": aschaCode
            }),
         type: "post",
         dataType: "json",   
         beforeSend: function(xhr){
            xhr.setRequestHeader(header, token);
         },
         success:function(result){
            console.log("result : ", result);
            
            let str = "";
            
            if(result.length ===0){
               str ="<tr><td colspan='8'>수강신청한 학생이 없습니다.</td></tr>"
            }else{
               result.forEach(function(aschaVO, idx){
               
                  console.log("체킁:",idx,aschaVO);
                  schulNm  =aschaVO.schulNm  ;
                  cmmnGrade=aschaVO.cmmnGrade;
                  clasNm   =aschaVO.clasNm   ;
                  clasInNo =aschaVO.clasInNo ;
                  mberNm   =aschaVO.mberNm   ;
                  aschaNm  =aschaVO.aschaNm  ;
                  moblphonNo = aschaVO.moblphonNo;
                  cmmnDetailCode = aschaVO.cmmnDetailCode;
                  aschaAtnlcCt   = aschaVO.aschaAtnlcCt;
                  
                  $.each(aschaVO.atnlcReqstVOList, function(index, atnlcReqstVO) {
                     str +=`
                        <tr>
                           <td class="atnlcReqstCode" style="display:none;">\${atnlcReqstVO.atnlcReqstCode}</td>
                           <td>\${idx+1}</td>
                           <td>\${schulNm}</td>
                           <td>\${cmmnGrade}학년</td>
                           <td>\${clasNm}</td>
                           <td>\${clasInNo}</td>
                           <td>\${mberNm}</td>
                           <td>\${aschaNm}</td>
                           <td>`;
                     if (cmmnDetailCode==='종강'){
                        str += `<label style="background: #df3c3c; padding: 5px 20px;
        				    border-radius: 10px; color: white; font-size: 15px;">종강</label>`;
                     }else if( cmmnDetailCode==='수업 진행중'){
                        str += `<label class="btnLetureStart" style="background: #ffd34f; padding: 5px 8px;
        				    border-radius: 10px; color: white; font-size: 15px;">수업 진행중</label>`;
                     }else if(cmmnDetailCode==='결제 완료'){
                        str += `<label class="btnPayDone" style="background: #1F81FF; padding: 5px 8px;
        				    border-radius: 10px; color: white; font-size: 15px;">결제 완료</label>`;
                     }else if(cmmnDetailCode==='결제 대기'){
                        str += `<label class="btnPayWait" style="background: #dfdfdf; padding: 5px 8px;
        				    border-radius: 10px; color: white; font-size: 15px;">결제 대기</label>`;
                     }else{
                        str += `<label style="background: #262626; padding: 5px 20px;
        				    border-radius: 10px; color: white; font-size: 15px;">취소</label>`;
                     }      
                     str +=`
                        </td>
                        </tr>`;

                  });

               });
                        
            }
            console.log("str : ",str);
            document.querySelector("#lectureStudentListBody").innerHTML = str;
         
            // 결제 대기 버튼 클릭시 문자보내는 이벤트 처리
            $(".btnPayWait").click(function(){
               let idx = $(this).data("idx");
               
               // 해당 학생의 aschaVO를 가지고 온다.
               let aschaVO = result[idx];
               // sendMsg를 호출할 때 aschaVO 객체를 전달한다.
               sendMsg(idx, aschaVO);
            });
         }
      });
      
   });
   
   // 선생님이 등록한 방과후학교 목록 불러오기
   let data = {
      "mberId" : "${param.mberId}"   
   };
   console.log("data : ", data);

   // 선생님이 등록한 방과후학교 목록 불러오는 ajax
   $.ajax({
      url: "/afterSchool/afterSchoolTeacherList",
      contentType: "application/json ; charset=utf-8",
      data: data,
      type: "get",
      dataType: "json",
      beforeSend : function(xhr){
         xhr.setRequestHeader(header, token);
      },
      success:function(result){
         console.log("result : ", result);
         let str = "";
		if(result.length  === 0 ){
			str +=`<tr><td colspan='7'style="text-align: center;">개설된 방과후학교가 없습니다.</td></tr>`; 
		}else{
	         result.forEach(function(aschaVO, idx){
	            let aschaAtnlcBgnde = dateFormat(new Date(aschaVO.aschaAtnlcBgnde));
	            let aschaAtnlcEndde = dateFormat(new Date(aschaVO.aschaAtnlcEndde));
	            let lectureName= aschaVO.aschaNm;  // 출석부리스트에 과목이름 넣을 예정
	            
	            str += `
	               <tr data-code="code" data-ascha-code=\${aschaVO.aschaCode}>
	               <td>\${idx+1}</td>
	               <td data-ascha-code=\${aschaVO.aschaCode}>\${aschaVO.aschaNm}</a></td>
	               <td>\${aschaVO.aschaAceptncPsncpa}</td>
	               <td>\${aschaAtnlcBgnde}</td>
	               <td>\${aschaAtnlcEndde}</td>
	               <td>`;
	               
	            if (aschaVO.cmmnAtnlcNm==='종강'){
	            	str += `<label style="background: #df3c3c; padding: 5px 20px;
					    border-radius: 10px; color: white; font-size: 15px;">종강</label>`;
	            }else if(aschaVO.cmmnAtnlcNm==='수업 진행중'){
	               str += `<label style="background: #ffd34f; padding: 5px 8px;
					    border-radius: 10px; color: white; font-size: 15px;">수업 진행중</label>`;
	            }else if(aschaVO.cmmnAtnlcNm==='신청 진행중'){
	               str += `<label style="background: #1F81FF; padding: 5px 8px;
					    border-radius: 10px; color: white; font-size: 15px;">신청 진행중</label>`;
	            }else{
	               str += `<label style="background: #262626; padding: 5px 20px;
					    border-radius: 10px; color: white; font-size: 15px;">폐강</label>`;
	            }
	            str +=`   
	               </td>
	               <td>
	                  <button class="pd-setting btnUpdate" data-ascha-code="\${aschaVO.aschaCode}"
	                  		onclick="btnClick(this)" >수정하기</button>
	               </td>
	            </tr>`;
	   
	               
	         });
// 	         document.querySelector("#lectureNm").innerHTML = lectureName;
		}
         console.log("str : ", str);
         document.querySelector("#teacherListBody").innerHTML = str;

      }
   });
}
function btnClick(btnUpdate){
   event.stopPropagation();
   // alert("btnClick이벤트!"+btnUpdate.dataset.aschaCode);
      // 수정 버튼 클릭시 수정화면으로 이동하기
            
      let aschaCode = event.target.getAttribute("data-ascha-code");
      console.log("aschaCode :",aschaCode);
      location.href = "/afterSchool/afterSchoolUpdate?aschaCode="+aschaCode+"&schulCode=${SCHOOL_INFO.schulCode}";
}


</script>

<style>
#AfterSchoolContainer h3 {
	font-size: 2.2rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 650px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#AfterSchoolContainer h2 {
	font-size: 1.5rem;
	text-align: center;
	backdrop-filter: blur(4px);
	background-color: rgba(255, 255, 255, 1);
	border-radius: 50px;
	box-shadow: 35px 35px 68px 0px rgba(145, 192, 255, 0.5), inset -8px -8px
		16px 0px rgba(145, 192, 255, 0.6), inset 0px 11px 28px 0px
		rgb(255, 255, 255);
	width: 250px;
	padding-top: 35px;
	padding-bottom: 35px;
	margin: auto;
	margin-bottom: 40px;
}

#AfterSchoolContainer {
	min-height: 790px;
}

#AfterSchoolContainer .custom-pagination {
	max-width: 302px;
	margin: auto;
}

#AfterSchoolContainer .custom-pagination .pagination {
	width: max-content;
}
.content {
	display: flex;
	justify-content: center;
	align-items: center;
}

.single-product-text {
	padding: 5px;
}

.overflow-scroll {
	height: 570px;
	overflow-y: auto; /* 세로 스크롤 설정 */
}

.class-container {
	width: 800px;
	margin: 8px;
	height: 820px;
	background-color: #ffffff;
    padding: 15px;
    border-radius: 10px;
    margin: 5px;
    box-shadow: 0px 0px 10px 3px #0c4c9c20, inset 0px 0px 10px 2px #ffffffc0;

}

.btn {
	height: 35px;
	width: 90px;
}

button.pd-setting.btnUpdate {
	background: #df3c3c;
}

.btnPayDone {
	color: #fff;
	background-color: #96DB5B;
	border-color: #96DB5B;
}

td {
	text-align: center;
}
.btn-zone{
	margin: auto;
	text-align: center;
}
#btnList, #addAfterSchool{
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
#btnList:hover,#addAfterSchool:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}#btnList, #addAfterSchool{
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
#addAfterSchool{
	background: #006DF0;
	color:#fff;
}

#addAfterSchool:hover{
	background: #ffd77a;
	transition: all 1s ease;
	color:#333;
	font-weight:600;
}
#shTbl th {
    text-align: center;
    font-size: 17px;
    color:white;
    background-color:rgba(0, 109, 240, 0.8);
}
#shTbl td,
#shTbl tr {
    text-align: center;
    height: 40px;
    width: 110px;
    font-size: 17px;
}
</style>
<div id="AfterSchoolContainer">
	<div class="analytics-sparkle-area">
		<h3>
			<img src="/resources/images/school/aftSchool/aftSchoolIcon1.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
			<span id="schoolNm"></span> <span>&nbsp;방과후학교 관리</span> <img
				src="/resources/images/school/aftSchool/aftSchoolIcon2.png"
				style="width: 50px; display: inline-block; vertical-align: middel;">
		</h3>

		<div class="container-fluid ">
			<div class="content">
				<div class="class-container">
					<div class="courses-title">
						<h2>방과후 개설 목록</h2>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
							style="padding: 0px;">
							<div class="product-status-wrap drp-lst overflow-scroll"
								style="padding: 0px;">
								<table class="table table-hover JColResizer">
									<thead>
										<tr>
											<th>순번</th>
											<th>방과후학교 명</th>
											<th>수용정원(명)</th>
											<th>수강시작일자</th>
											<th>수강종료일자</th>
											<th>상태</th>
											<th>-</th>
										</tr>
									</thead>
									<tbody id="teacherListBody">
										<!-- 여기에 테이블 내용 추가 -->
									</tbody>
								</table>
							</div>
							<hr>
							<!-- 방과후학교 생성 -->
							<div class="btn-zone">
								<button type="button" id="addAfterSchool"
									style="transform: translate(10px, -40px);">추가</button>
							</div>
						</div>
					</div>
				</div>


				<!-- 수강신청한 학생목록 띄우기 -->
				<div class="class-container">
					<div class="courses-title">
						<div>
							<h2>수강신청 학생 목록</h2>
						</div>
						<div style="padding: 0px; transform: translate(10px, -40px);">
							<ul
								class="nav nav-tabs custom-menu-wrap custon-tab-menu-style1 tab-menu-right">
								<li class=""><a data-toggle="tab" href="#TabStudList"
									aria-expanded="false"><span
										class="edu-icon edu-analytics tab-custon-ic"></span>학생 목록</a></li>
								<li class=""><a data-toggle="tab" href="#TabAttend"
									aria-expanded="false"><span
										class="edu-icon edu-analytics-arrow tab-custon-ic"></span>출석부</a></li>
							</ul>
							<div class="tab-content">
								<div id="TabStudList"
									class="tab-pane flipInY custon-tab-style1 active">
									<div class="product-status-wrap drp-lst overflow-scroll"
										style="padding: 0px;">
										<table class="table JColResizer">
											<thead>
												<tr>
													<th>순번</th>
													<th>학교</th>
													<th>학년</th>
													<th>반</th>
													<th>번호</th>
													<th>이름</th>
													<th>방과후학교명</th>
													<th>상태</th>
												</tr>
											</thead>
											<tbody id="lectureStudentListBody">
											<tr><td colspan='8' style="text-align: center;">과목을 선택해주세요.</td></tr>
											</tbody>
										</table>
									</div>
								</div>
								<div id="TabAttend" class="tab-pane flipInY custon-tab-style1">
									<div class="overflow-scroll" style="padding: 0px;">
										<h4 id="lectureNm">출석부</h4>
										<div id="disp">
											<!-- 출석부 출력되는 부분 -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 출석체크 모달 -->
<div id="AttendModalalert"
   class="modal modal-edu-general default-popup-PrimaryModal fade in"
   role="dialog" style="display: none; padding-right: 17px;">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-close-area modal-close-df">
            <a class="close" data-dismiss="modal" href="#"><i
               class="fa fa-close"></i></a>
         </div>
         <div class="modal-body">
            <i class="educate-icon educate-checked modal-check-pro"></i>
            <h2>출석체크</h2>
            <p>해당 학생의 출결상태를 선택하세요</p>
<!--             <select> -->
<!--             	<option>선택하세요.</option> -->
<!--             	<option value="A06001">출석</option> -->
<!--             	<option value="A06002">결석</option> -->
<!--             	<option value="A06004">지각</option> -->
<!--             	<option value="A06003">조퇴</option> -->
<!--             	<option value="A06005">공결</option> -->
<!--             	<option value="A06006">외출</option> -->
<!--             </select> -->
            <button type="button" class="btn btn-custon-rounded-two btn-primary cmmnAttendCd" value="A06001">출석</button>
            <button type="button" class="btn btn-custon-rounded-two btn-danger cmmnAttendCd"  value="A06002">결석</button>
            <button type="button" class="btn btn-custon-rounded-two btn-success cmmnAttendCd" value="A06004">지각</button>
            <button type="button" class="btn btn-custon-rounded-two btn-warning cmmnAttendCd" value="A06003">조퇴</button>
            <button type="button" class="btn btn-custon-rounded-two btn-default cmmnAttendCd" value="A06005">공결</button>
            <button type="button" class="btn btn-custon-rounded-two btn-default cmmnAttendCd" value="A06006">외출</button>
            
         </div>
         <div class="modal-footer">
            <a data-dismiss="modal" href="#">닫기</a>
         </div>
      </div>
   </div>
</div>
<!-- 출석체크 모달 끝 -->

<!-- 출석 수정 모달 -->
<div id="UpdateModalalert"
   class="modal modal-edu-general default-popup-PrimaryModal fade in"
   role="dialog" style="display: none; padding-right: 17px;">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-close-area modal-close-df">
            <a class="close" data-dismiss="modal" href="#"><i
               class="fa fa-close"></i></a>
         </div>
         <div class="modal-body">
            <i class="educate-icon educate-checked modal-check-pro"></i>
            <h2>출석수정</h2>
            <p>수정할 출결상태를 선택하세요</p>
            <button type="button" class="btn btn-custon-rounded-two btn-primary cmmnAttendCdUdt" value="A06001">출석</button>
            <button type="button" class="btn btn-custon-rounded-two btn-danger cmmnAttendCdUdt" value="A06002">결석</button>
            <button type="button" class="btn btn-custon-rounded-two btn-success cmmnAttendCdUdt" value="A06004">지각</button>
            <button type="button" class="btn btn-custon-rounded-two btn-warning cmmnAttendCdUdt" value="A06003">조퇴</button>
            <button type="button" class="btn btn-custon-rounded-two btn-default cmmnAttendCdUdt" value="A06005">공결</button>
            <button type="button" class="btn btn-custon-rounded-two btn-default cmmnAttendCdUdt" value="A06006">외출</button>
            
         </div>
         <div class="modal-footer">
            <a id ="btnDelete" href="#" style="background: #e12503;">출석 삭제</a>
            <a data-dismiss="modal" href="#">닫기</a>
         </div>
      </div>
   </div>
</div>
<!-- 출석체크 모달 끝 -->

