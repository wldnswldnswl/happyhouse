<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<style>
.badge-num {
  box-sizing:border-box;
  font-family: 'Trebuchet MS', sans-serif;
  background: #f4623a;
  cursor:default;
  border-radius: 50%;
  color: #fff;
  font-weight:bold;
  font-size: 15px;
  height: 28px;
  line-height:1.55em;
  top:18px;
  right:370px;
  border:3px solid #fff;
  position: absolute;
  text-align: center;
  width: 28px;
  box-shadow: 1px 1px 5px rgba(0,0,0, .2);
}
.badge-num:after {
  content: '';
  position: absolute;
  top:0px;
  left:0px;
  border:2px solid rgba(255,0,0,.5);
  opacity:0;
  border-radius: 50%;
  width:100%;
  height:100%;
/*   animation: sonar 1.5s 1; */
}
@keyframes sonar { 
  0% {transform: scale(.9); opacity:1;}
  100% {transform: scale(2);opacity: 0;}
}
@keyframes pulse {
  0% {transform: scale(1);}
  20% {transform: scale(1.4); } 
  50% {transform: scale(.9);} 
  80% {transform: scale(1.2);} 
  100% {transform: scale(1);}
}

</style>
<script>
$(document).ready(function () {
   $("select[id$='Sido']").change(function() {// id명이 Sido로 끝나는 태그 선택(회원가입폼-makeSido, 정보수정폼-modifySido)
      $.get("${root}/localcode/gugun/"+$(this).val(),function(data, status){
            $(".gugun").empty();
            $(".gugun").append('<option value="0">선택</option>');
            $.each(data, function(index, vo) {
               $(".gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
            });//each
         }//function
         , "json"
      );//get
   });//change
   
   $("select[id$='Gugun']").change(function() {// id명이 Gugun으로 끝나는 태그 선택
      $.get("${root}/localcode/dong/"+$(this).val()                        
            ,function(data, status){
               $(".dong").empty();
               $(".dong").append('<option value="0">선택</option>');
               $.each(data, function(index, vo) {
                  $(".dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
               });//each
            }//function
            , "json"
      );//get
   });//change
   $(".loadData").click(function(){
      $.get("${root}/localcode/sido/default"
            ,function(data, status){
               $.each(data, function(index, vo) {
                  $(".sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
               });//each
            }//function
            , "json"
      );//get
      $("select[id$='Sido'] option:eq(0)").prop("selected",true);
      $("select[id$='Gugun'] option:eq(0)").prop("selected",true);
      $("select[id$='Dong'] option:eq(0)").prop("selected",true);//로딩시 첫번째 요소 선택
   });//loadData: map 선택시 데이터 갱신
   
   // 내정보 보기
   $("#info").click(function(){
      showMyInfo();
      //click="alert('dd');showMyInfo();
   });
   
   // 내정보 수정
   $("#updateform").click(function(){
      $.ajax({
         type : "put", //요청 메소드 방식
         url : "${root}/user/info/member",
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         data:{
            id:$("#modifyId").val(),
            pwd:$("#modifyPwd").val(),
            name:$("#modifyName").val(),
            email:$("#modifyEmail").val(),
         },
         success : function(data) {
            // (미완) 다시 해보기
            $("#myId").text(data.id);
            $("#myPwd").text(data.pwd);
            $("#myName").text(data.name);
            $("#myEmail").text(data.email);
          }
      });//ajax      
   });
   
   //탈퇴하기
   $(".exit").click(function(){ 
      $.ajax({
         type : "post", //요청 메소드 방식
         url : "${root}/user/info",
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         data:{
            id:$("#myId").text()
         },
         complete : function(data) {
            console.log("Dta: "+data);
            $("#withdraw").modal();
          }
      });//ajax      
   });//exit
   
 	//알림버튼 누르기
 	$("#signal").click(function(){ 
		console.log("알림 모달 띄우기");
		
		$.ajax({
	         type : "get", //요청 메소드 방식
	         url : "${root}/signal/popup",
	         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
	         data:{
	            id: "${id}"
	         },
	         complete : function(data) {
	        	$("#signalResult").empty();
	     		var idx = 1;
	     		var result = data.responseJSON;
	     		console.log(result);
	     		$.each(result, function(index, vo) {
	     			$("<tr>")
	     			.append("<td>"+ idx++ +"</td>")
	     			.append("<td>"+vo.dong_name+"</td>")
	     			.append("<td>"+vo.title+"</td>")
	     			.appendTo("#signalResult");
	     		});//each
	     		$("#signalList").modal();
	          }
	      });//ajax      
	});//exit
	
	// 시그널 보내기
	var id = '<%=(String)session.getAttribute("id")%>';
	console.log(id);
	if(id != "null"){
		console.log("in");
		setTimeout(setSignal, 0);
		setInterval(setSignal, 5000);
	}
});// document ready

   // 로그인
   function doLogin() {
	console.log("로그인");
      $("#loginForm").submit();
   }

   //로그아웃
   function doLogout() {
      $("#logoutForm").submit();
   }
   
   //회원가입
   function signUp() {
      $("#makeSidoName").val($("#makeSido option:selected").text());
      $("#makeGugunName").val($("#makeGugun option:selected").text());
      $("#makeDongName").val($("#makeDong option:selected").text());
      $("#signUpForm").submit();
   }//signUp
   
   // 내 정보 수정 (지역 추가해야 함)
   function doUpdate() {
      $.ajax({
         type : "put", //요청 메소드 방식
         url : "${root}/user/info/member",
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         data:{
            id:$("#modifyId").val(),
            pwd:$("#modifyPwd").val(),
            name:$("#modifyName").val(),
            email:$("#modifyEmail").val()
         }
      });
      $("#modifySidoName").val($("#modifySido option:selected").text());
      $("#modifyGugunName").val($("#modifyGugun option:selected").text());
      $("#modifyDongName").val($("#modifyDong option:selected").text());
      //$("#updateform").submit();showMyInfo()
   }
   
   // 비밀번호 찾기
   function findPassword(){
      $.ajax({
         type : "get", //요청 메소드 방식
         url : "${root}/user/findPwd",
         data : {id:$("#idforPwd").val(), email:$("#emailforPwd").val()},
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         success : function(result) {
            if(result.errorMsg != null){
               alert("정보가 일치하지 않습니다.");
            }else{
               alert($("#emailforPwd").val() + "로 임시비밀번호를 전송했습니다.");
            }
         }
      })
   }
   
   // 내 정보 보기
   function showMyInfo() {
      $.ajax({
         type : "get", //요청 메소드 방식
         url : "${root}/user/info",
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         data:{
            id:"${id}"
         },
         success : function(result) {
            const user = result["user"];
            const region = result["address"];
            console.log("result: "+result["user"].id);
            //서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
            //result - 응답데이터
            //$('#result').text(result);
            $("#myId").text(user.id);
            $("#myPwd").text(user.pwd);
            $("#myName").text(user.name);
            $("#myEmail").text(user.email);
            $("#myInterest").text(region.sidoName+" "+region.gugunName+" "+region.dongName);
            //if(result.sido == null || result.sido.trim() == "")
            //   $("#myInterest").text("설정안함");
            //else $("#myInterest").text(result.sido+" "+result.gugun+" "+result.dong);
         },
         error : function() {
            alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
         }
      });
   }
   
   // 내 정보 수정
   function editInfo() {
      $.ajax({
         type : "get", //요청 메소드 방식
         url : "${root}/user/info",
         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
         data:{
            id:"${id}"
         },
         success : function(result) {
            const user = result["user"];
            const region = result["address"];

            console.log(user);
            $("#modifyId").val(user.id);
            $("#modifyPwd").val(user.pwd);
            $("#modifyName").val(user.name);
            $("#modifyEmail").val(user.email);
            console.log("갱신");
            <%--$("#modifySido").val(result.sido);
            $("#modifyGugun").val(result.gugun);
            $("#modifyDong").val(result.dong); --%>
         },
         error : function() {
            alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
         }
      });
   }
   
   
   // 알림 기능  
   function setSignal(){
	   $.ajax({
	         type : "get", //요청 메소드 방식
	         url : "${root}/signal",
	         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
	         data:{
	            id:"${id}"
	         },
	         success : function(data) {
	        	 console.log("시그널 업데이트");
	        	 updateBadge(data);
	         },
	         error : function() {
	            alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
	         }
	      });
   }
   
   function updateBadge(data){//To rerun the animation the element must be re-added back to the DOM 
	   var badge = document.getElementById('signal');
   		
	   var badgeChild = badge.children[0];

   		if(badgeChild.className==='badge-num') 
	    badge.removeChild(badge.children[0]); 
   		var badgeNum = document.createElement('a');
   		badgeNum.setAttribute('class','badge-num'); 
   		if(data > 0){
   			badgeNum.setAttribute('style', 'animation:pulse 1.5s 1');
   			
   		}
   		badgeNum.innerHTML = data; 
   		var insertedElement = badge.insertBefore(badgeNum,badge.firstChild); 
  		console.log(badge.children[0]); 
   } 
   function goDealReviewPage(){
	   $.ajax({
	         type : "get", //요청 메소드 방식
	         url : "${root}/signal/dealReview.do",
	         dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
	         data:{
	            id:"${id}"
	         },
	         success : function(data) {
	        	 console.log("go DealReviewPage");
	        	 window.location.href = "/dealReview.do";
	         },
	         error : function() {
	            alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
	         }
	      });
   }
</script>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3"
   id="mainNav">
   <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="${root}/">Woong's house</a>
      <button class="navbar-toggler navbar-toggler-right" type="button"
         data-toggle="collapse" data-target="#navbarResponsive"
         aria-controls="navbarResponsive" aria-expanded="false"
         aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
         <ul class="navbar-nav ml-auto my-2 my-lg-0">
         
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/searchPage.do">실거래가</a></li>
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/surround.do">안심병원</a></li>
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/interest.do">주변상권</a></li>
               <%-- href="${root}/user/getInterest.do">관심지역</a></li>--%>
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/notice.do">공지사항</a></li>
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/news.do">오늘의뉴스</a></li>
            <li class="nav-item menuClick"><a class="nav-link js-scroll-trigger"
               href="${root}/dealReview.do">실물후기</a></li>
            <%-- <li class="nav-item"><a class="nav-link js-scroll-trigger"
               href="${root}/sitemap.do">사이트맵</a></li>--%>
            <%-- 권한별 메뉴 로딩 --%>   
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               내 정보</a>
               <div class="dropdown-menu nav-item" aria-labelledby="navbarDropdown">
                  <c:choose>
                  	 <c:when test="${user!=null}">
							<%-- <a class="dropden-item nav-link memberInfo" href="#">${userName }님 로그인 중 </a> --%>
							<a class="dropden-item nav-link memberInfo" id="info"
                           		data-toggle="modal" data-target="#memberInfo">회원정보</a>
							<a href="/logout" class="dropden-item nav-link memberInfo" role="button">로그아웃</a>
			         </c:when>
                     <c:when test="${sessionScope.id != null}">
                        <a class="dropden-item nav-link memberInfo" id="info"
                           data-toggle="modal" data-target="#memberInfo">회원정보</a>
                        <a class="dropden-item nav-link memberInfo"
                           data-toggle="modal" data-target="#logOut">로그아웃</a>
                        <c:if test="${user_state==100}">
                           <a class="dropden-item nav-link memberInfo"
                              href="${root}/userlist.do">관리자 메뉴</a>
                              <%-- href="${root}/user/all">관리자 메뉴</a>--%>
                        </c:if>
                     </c:when>
                     <c:otherwise>
                        <a class="dropden-item nav-link visiterInfo loadData"
                           data-toggle="modal" data-target="#signUp">회원가입</a>
                        <a class="dropden-item nav-link visiterInfo"
                           data-toggle="modal" data-target="#logIn">로그인</a>    					
                     </c:otherwise>
                  </c:choose>
                  
               </div>
            </li>
              <li class="nav-item menuClick">
            	<c:if test="${sessionScope.id != null}">
            		<div id="signal"><a class="badge-num"></a></div>
            	</c:if>
            	<c:if test="${user != null}">
            		<div id="signal"><a class="badge-num"></a></div>
            	</c:if>
            </li>

         </ul>
      </div>
   </div>

</nav>

<%-- 모달창 모음 --%>
<div class="modal" id="memberInfo">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">회원 정보 확인</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <div class="form-group form-inline justify-content-between">
               <label>아이디 :</label> <label id="myId"></label>
            </div>
            <div class="form-group form-inline justify-content-between">
               <label>비밀번호 :</label> <label id="myPwd"></label>
            </div>

            <div class="form-group form-inline justify-content-between">
               <label>이름 :</label> <label id="myName"></label>
            </div>
            <div class="form-group form-inline justify-content-between">
               <label>E-Mail :</label> <label id="myEmail"></label>
            </div>
            <div class="form-group form-inline justify-content-between">
               <label for="preferLocation">대표관심지역</label><label id="myInterest">설정안함</label>
            </div>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
               data-dismiss="modal">확인</button>
            <button type="button" class="btn loadData"
               data-toggle="modal" data-target="#modifyInfo" onclick="editInfo()">수정</button>
            <button type="button" class="btn exit"
               data-toggle="modal" data-dismiss="modal">탈퇴</button>
         </div>
      </div>
   </div>
</div>

<div class="modal" id="withdraw">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">회원 탈퇴</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <h5>고마웠어!! 배웅은 없다.</h5>
            <img alt="대충 인사하는 짤" src="">
            <p>회원탈퇴되었습니다.</p>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
                   onclick="location.href='${root}/user/destroy.do'">확인</button>
         </div>

      </div>
   </div>
</div>

<div class="modal" id="modifyInfo">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">회원 정보 수정</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <div id="updateform">
            <%-- form id="updateform" method="put" action="${root}/user">--%>
               <div class="form-group form-inline justify-content-between">
                  <label for="makeId">아이디</label> <input type="text"
                     class="form-control" name="id" id="modifyId" placeholder="아이디"
                     readonly>
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="makePwd">비밀번호</label> <input type="password"
                     class="form-control" name="pwd" id="modifyPwd" placeholder="비밀번호">
               </div>

               <div class="form-group form-inline justify-content-between">
                  <label for="makeName">이름</label> <input type="text"
                     class="form-control" name="name" id="modifyName"
                     placeholder="아이디">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="makeEmail">이메일</label> <input type="text"
                     class="form-control" name="email" id="modifyEmail"
                     placeholder="아이디">
               </div>
               <%--<div class="form-group form-inline justify-content-between">
                  <label for="preferLocation">대표관심지역</label>
                     <select id="modifySido" class="form-control sido" name="sido">
                        <option value="0">선택</option>
                     </select>
                     <select id="modifyGugun" class="form-control gugun" name="gugun">
                        <option value="0">선택</option>
                     </select>
                     <select id="modifyDong" class="form-control dong" name="dong">
                        <option value="0">선택</option>
                     </select>
               </div>
                <input type="hidden" name="sidoName" id="modifySidoName" /> <input
                  type="hidden" name="gugunName" id="modifyGugunName" /> <input
                  type="hidden" name="dongName" id="modifyDongName" /> --%>
               <!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
            <%--</form> --%>
            </div>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
               data-dismiss="modal">취소</button>
            <button type="button" class="btn" data-dismiss="modal"
               onclick="doUpdate()">수정</button>
         </div>

      </div>
   </div>
</div>

<div class="modal" id="signUp">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">회원가입</h4>
            <c:if test="${requestScope.errorMsg != null}">
               <div style="color: red">${requestScope.errorMsg}</div>
            </c:if>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <form id="signUpForm" method="post"
               action="${root}/user/register/member">
               <div class="form-group form-inline justify-content-between">
                  <label for="makeId">아이디</label> <input name="id" type="text"
                     class="form-control" id="makeId" placeholder="아이디">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="makePwd">비밀번호</label> <input name="pwd"
                     type="password" class="form-control" id="makePwd"
                     placeholder="비밀번호">
               </div>

               <div class="form-group form-inline justify-content-between">
                  <label for="makeName">이름</label> <input name="name" type="text"
                     class="form-control" id="makeName" placeholder="아이디">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="makeEmail">이메일</label> <input name="email" type="text"
                     class="form-control" id="makeEmail" placeholder="이메일">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="preferLocation">대표관심지역</label> <select id="makeSido"
                     class="form-control sido" name="sido">
                     <option selected value="">선택</option>
                  </select> <select id="makeGugun" class="form-control gugun" name="gugun">
                     <option selected value="">선택</option>
                  </select> <select id="makeDong" class="form-control dong" name="dong">
                     <option selected value="">선택</option>
                  </select>
               </div>
               <input type="hidden" name="sidoName" id="makeSidoName" /> <input
                  type="hidden" name="gugunName" id="makeGugunName" /> <input
                  type="hidden" name="dongName" id="makeDongName" />
               <!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
            </form>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
               data-dismiss="modal">취소</button>
            <button type="button" class="btn" data-dismiss="modal"
               onClick="signUp();">회원가입</button>
         </div>
      </div>
   </div>
</div>

<div class="modal" id="findPwd">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">비밀번호 찾기</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <form id="findPwdForm" method="post" action="findPwd.do">
               <div class="container form-group center-block"
                  style="display: inline-block; text-align: center;">
                  <h5>비밀번호를 잊어버리셨나요?</h5>
                  <h6>기존에 가입하신 이메일을 입력하시면 비밀번호 변경메일을 발송해드립니다.</h6>
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="idforPwd">아이디</label> <input name="id" type="text"
                     class="form-control" id="idforPwd" placeholder="아이디">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="emailforPwd">이메일</label> <input name="email"
                     type="email" class="form-control" id="emailforPwd"
                     placeholder="이메일">
               </div>
            </form>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="btn btn-primary"
               onclick="findPassword();" data-dismiss="modal">비밀번호 변경 메일
               받기</button>
         </div>

      </div>
   </div>
</div>

<div class="modal" id="logOut">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">로그아웃</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <form action="${root}/user/logout.do" method="get" id="logoutForm">
               <div class="form-group form-inline justify-content-between">
                  <label for="log" style="display: contents;">정말 로그아웃
                     하시겠습니까? </label>
               </div>
            </form>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
               data-dismiss="modal">아니요</button>
            <button type="button" class="btn" data-dismiss="modal"
               onClick="doLogout();">네</button>
         </div>

      </div>
   </div>
</div>

<!-- 로그인 모달/스크립트 -->
<div class="modal" id="logIn">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <c:if test="${requestScope.errorMsg != null}">
               <div style="color: red">${requestScope.errorMsg}</div>
            </c:if>
            <h4 class="modal-title">로그인</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <form action="user/login.do" method="get" id="loginForm">
               <div class="form-group form-inline justify-content-between">
                  <label for="id">아이디 </label> <input type="text"
                     class="form-control" id="id" name="id">
               </div>
               <div class="form-group form-inline justify-content-between">
                  <label for="pwd">비밀번호</label> <input type="password"
                     class="form-control" name="pwd" id="pwd">
               </div>

               <div class="container form-group center-block"
                  style="display: inline-block; text-align: center;">
                  <span>비밀번호를 잊어버리셨나요? </span> <a data-toggle="modal"
                     data-dismiss="modal" href="#findPwd">비밀번호 찾기</a>
               </div>
               
               <div class="container form-group center-block text-center"
               		style="height: 120px;">
               		<div style="height:5%"></div>
               		<div>
               			<a class="" href="/oauth2/authorization/naver">
               				<img src="assets/img/naver_login.png"  style="height:55px; width:254.32px;">
               				<%--<div>네이버 아이디로 로그인</div> --%>
               		    </a>
               		</div>
               		<div style="height:5%"></div>
               		<div>
               			<a class="" href="/oauth2/authorization/google">
               				<img src="assets/img/btn_google_signin_dark_pressed_web@2x.png" style="height:59px; width:263.5px;" > 
               		    </a>
               		</div>
	        	
	          </div>	           	

            </form>
            
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button type="button" class="center-block btn"
               data-dismiss="modal">취소</button>
            <button onClick="doLogin();" type="button" class="btn"
               data-dismiss="modal">로그인</button>
         </div>
      </div>
   </div>
</div>

<div class="modal" id="signalList">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <div class="modal-header">
            <h4 class="modal-title">알림 목록</h4>
         </div>

         <!-- Modal body -->
         <div class="modal-body">
            <div class="form-group form-inline justify-content-between">
            	<table class="table mt-2" style="text-align:center" >
            		<thead>
            			<tr>
            				<th>번호</th>
							<th>법정동</th>
							<th>제목</th>
						</tr>
					</thead>
					<tbody id="signalResult"></tbody>
            	</table>
            </div>
         </div>

         <!-- Modal footer -->
         <div class="modal-footer"
            style="display: inline-block; text-align: center;">
            <button onClick="goDealReviewPage();" type="button" class="btn">확인</button>
            <button type="button" class="center-block btn"
               data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>
