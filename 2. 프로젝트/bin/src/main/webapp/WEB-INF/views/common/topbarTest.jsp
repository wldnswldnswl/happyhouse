<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!-- /HappyHouse_Web_Front_test -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function () {
	$(".exit").click(function(){ 
		$("#withdraw").modal();
		$.ajax({
			type : "post", //요청 메소드 방식
			url : "${pageContext.request.contextPath}/delete.do",
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			data:{
				id:$("#memberInfo #myId").text()
			}
		});
		$("#withdraw").modal();
	});
	
	$(".loadData").click(function () {
		console.log("clicked");
		$.get("${root}/localicode/sido/default
				,function(data, status){
					$.each(data, function(index, vo) {
						$(".sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
					});//each
				}//function
				, "json"
			);//get
			$("select[id$='Sido'] option:eq(0)").prop("selected",true);
			$("select[id$='Gugun'] option:eq(0)").prop("selected",true);
			$("select[id$='Dong'] option:eq(0)").prop("selected",true);//로딩시 첫번째 요소 선택
	});
		
	$("select[id$='Sido']").change(function() {// id명이 Sido로 끝나는 태그 선택(회원가입폼-makeSido, 정보수정폼-modifySido)
			$.get("${root}/map"
					,{act:"gugun", sido:$(this).val()}
					,function(data, status){
						$(".gugun").empty();
						$(".gugun").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$(".gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
						});//each
					}//function
					, "json"
			);//get
		//}
		
	});//change
	$("select[id$='Gugun']").change(function() {// id명이 Gugun으로 끝나는 태그 선택
		$.get("${root}/map"
				,{act:"dong", gugun:$(this).val()}
				,function(data, status){
					$(".dong").empty();
					$(".dong").append('<option value="0">선택</option>');
					$.each(data, function(index, vo) {
						$(".dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
});
	function doLogin() {
		$("#loginForm").submit();
	}
	function doLogout() {
		$("#logoutForm").submit();
	}
	function signUp() {
		$("#makeSidoName").val($("#makeSido option:selected").text());
		$("#makeGugunName").val($("#makeGugun option:selected").text());
		$("#makeDongName").val($("#makeDong option:selected").text());
		$("#signUpForm").submit();
	}
	function doUpdate() {
		$("#modifySidoName").val($("#modifySido option:selected").text());
		$("#modifyGugunName").val($("#modifyGugun option:selected").text());
		$("#modifyDongName").val($("#modifyDong option:selected").text());
		$("#updateform").submit();
	}
	
	function findPassword(){
		$.ajax({
			type : "get", //요청 메소드 방식
			url : "${pageContext.request.contextPath}/findPwd.do",
			data : {id:$("#idforPwd").val(), email:$("#emailforPwd").val()},
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			success : function(result) {
				//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
				//result - 응답데이터
				//$('#result').text(result);
				if(result.id != $("#idforPwd").val()){
					alert("정보가 일치하지 않습니다.");
				}else{
					alert($("#emailforPwd").val() + "로 임시비밀번호를 전송했습니다.");
				}
			},
			error : function() {
				alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
			}
		})
	}
	
	
	function showMyInfo() {
		$.ajax({
			type : "get", //요청 메소드 방식
			url : "${pageContext.request.contextPath}/showDetails.do",
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			success : function(result) {
				//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
				//result - 응답데이터
				//$('#result').text(result);
				$("#myId").text(result.id);
				$("#myPwd").text(result.pwd);
				$("#myName").text(result.name);
				$("#myEmail").text(result.email);
				//if(result.sido == null || result.sido.trim() == "")
				//	$("#myInterest").text("설정안함");
				//else $("#myInterest").text(result.sido+" "+result.gugun+" "+result.dong);
			},
			error : function() {
				alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
			}
		});
	}
	
	function editInfo() {
		$.ajax({
			type : "get", //요청 메소드 방식
			url : "${pageContext.request.contextPath}/showDetails.do",
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			success : function(result) {
				//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
				//result - 응답데이터
				//$('#result').text(result);
				$("#modifyId").val(result.id);
				$("#modifyPwd").val(result.pwd);
				$("#modifyName").val(result.name);
				$("#modifyEmail").val(result.email);
				$("#modifySido").val(result.sido);
				$("#modifyGugun").val(result.gugun);
				$("#modifyDong").val(result.dong);
			},
			error : function() {
				alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
			}
		});
	}
	
</script>
<div class="jumbotron text-center bg-primary" style="margin-bottom: 0">
	<h1 class="text-warning">Happy House</h1>
	<p class="text-light">나만의 주택 검색 플랫폼</p>

	<div align="right">
		<c:choose>
			<c:when test="${sessionScope.id != null}">
				<button type="button" class="btn btn-info memberInfo"
					data-toggle="modal" data-target="#memberInfo"
					onclick="showMyInfo();">회원정보</button>
				<button type="button" class="btn btn-info memberInfo"
					data-toggle="modal" data-target="#logOut">로그아웃</button>
				<c:if test="${useage==100}">
					<button type="button" class="btn btn-info memberInfo"
						data-toggle="modal" data-target="#userList"
						onclick="location.href='userlist.do'">회원목록</button>
				</c:if>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-info visiterInfo loadData"
					data-toggle="modal" data-target="#signUp">회원가입</button>
				<button type="button" class="btn btn-info visiterInfo"
					data-toggle="modal" data-target="#logIn">로그인</button>
			</c:otherwise>
		</c:choose>
	</div>
</div>

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
				<!--<div class="form-group form-inline justify-content-between">
					<label for="preferLocation">대표관심지역</label><label id="myInterest">설정안함</label>
				</div>  -->
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">확인</button>
				<button type="button" class="btn btn-primary loadData" data-toggle="modal"
					data-target="#modifyInfo" onclick="editInfo()">수정</button>
				<button type="button" class="btn btn-danger exit"
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
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">확인</button>
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
				<form id="updateform" method="post" action="update.do">
					<div class="form-group form-inline justify-content-between">
						<label for="makeId">아이디</label> 
						<input type="text" class="form-control" name="id" id="modifyId" placeholder="아이디" readonly>
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="makePwd">비밀번호</label>
						<input type="password" class="form-control" name="pwd" id="modifyPwd" placeholder="비밀번호">
					</div>

					<div class="form-group form-inline justify-content-between">
						<label for="makeName">이름</label> 
						<input type="text" class="form-control" name="name" id="modifyName" placeholder="아이디">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="makeEmail">이메일</label> 
						<input type="text" class="form-control" name="email" id="modifyEmail" placeholder="아이디">
					</div>
					<!--  <div class="form-group form-inline justify-content-between">
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
					</div>-->
					<input type="hidden" name="sidoName" id="modifySidoName" />
					<input type="hidden" name="gugunName" id="modifyGugunName" />
					<input type="hidden" name="dongName" id="modifyDongName" /> <!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer" style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="doUpdate()">수정</button>
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
				<form id="signUpForm" method="post" action="${root}/user/register.do">
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
						<label for="preferLocation">대표관심지역</label>
							<select id="makeSido" class="form-control sido" name="sido">
								<option selected value="">선택</option>
							</select>
							<select id="makeGugun" class="form-control gugun" name="gugun">
								<option selected value="">선택</option>
							</select>
							<select id="makeDong" class="form-control dong" name="dong">
								<option selected value="">선택</option>
							</select>
					</div>
					<input type="hidden" name="sidoName" id="makeSidoName" />
					<input type="hidden" name="gugunName" id="makeGugunName" />
					<input type="hidden" name="dongName" id="makeDongName" /> <!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal"
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
					<div class="container form-group center-block" style="display: inline-block; text-align: center;">
						<h5>비밀번호를 잊어버리셨나요?</h5>
						<h6>기존에 가입하신 이메일을 입력하시면 비밀번호 변경메일을 발송해드립니다.</h6>
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="idforPwd">아이디</label> 
						<input name="id" type="text" class="form-control" id="idforPwd" placeholder="아이디">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="emailforPwd">이메일</label> 
						<input name="email" type="email" class="form-control" id="emailforPwd" placeholder="이메일">
					</div>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="btn btn-primary" onclick="findPassword();" data-dismiss="modal">비밀번호 변경 메일 받기</button>
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
				<form action="${root }/user/logout.do" method="get" id="logoutForm">
					<div class="form-group form-inline justify-content-between">
						<label for="log" style="display: contents;">정말 로그아웃
							하시겠습니까? </label>
					</div>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">아니요</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					onClick="doLogout();">네</button>
			</div>

		</div>
	</div>
</div>

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
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">취소</button>
				<button onClick="doLogin();" type="button" class="btn btn-primary"
					data-dismiss="modal">로그인</button>
			</div>

		</div>
	</div>
</div>

<nav class="navbar navbar-expand-sm bg-warning navbar-dark">
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link text-body"
				href="${root}/searchPage.do">실거래가 조회</a></li>
			<li class="nav-item"><a class="nav-link text-body"
				href="${root}/surround.do">안심병원/선별진료소</a></li>
			<li class="nav-item"><a class="nav-link text-body"
				href="${root}/user/getInterest.do">관심지역</a></li> <!-- ${root}/03_interest/interest.jsp -->
			<li class="nav-item"><a class="nav-link text-body"
				href="${root}/notice.do">공지사항</a></li>
				<li class="nav-item"><a class="nav-link text-body"
				href="${root}/sitemap.do">사이트맵</a></li>
		</ul>
	</div>
</nav>