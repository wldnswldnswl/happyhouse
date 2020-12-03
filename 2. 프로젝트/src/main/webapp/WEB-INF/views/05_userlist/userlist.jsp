<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원목록</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic"
	rel="stylesheet" type="text/css" />
<!-- Third party plugin CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/styles.css" rel="stylesheet" />
<style>
	.search{
		display: inline-block;
  		width: auto;
  	}
</style>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		
		showAllUsers();
		
 		$("#t-userList").on("click", "tr",getUserDetail); 

		$(".delete").click(function() {
			$.ajax({
				type : "post", //요청 메소드 방식
				url : "${root}/user/info",
				dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				data : {
					id : $("#adminMemberInfo .userId").text()
				}
			});
			$("#adminWithdraw").modal();
		});
		
		$(".delete_confirm").click(function(){
			showAllUsers();
		});
		
		$(".showInfo").click(function(id) {
			$.ajax({
				type : "get", //요청 메소드 방식
				url : "${root}/user/info",
				data:{
					id:$('#adminMemberInfo .userId').text()
				},
				dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				success : function(result) {
					let user = result["user"];
					$("#mid").val(user.id);
					$("#mname").val(user.name);
					$("#memail").val(user.email);
				},
				error : function() {
					alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
				}
			});
		});
		
		
		// 회원 정보 수정 (지역 추가해야 함)
		$(".adminUpdate").click(function() {
			$.ajax({
				type : "put", //요청 메소드 방식
				url : "${root}/user/info/admin",
				dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				data:{
					id:$("#adminModifyInfo .userId").val(),
					name:$("#adminModifyInfo .userName").val(),
					email:$("#adminModifyInfo .userEmail").val()
				},
				success:function(){
				}
			});
			$("#adminModifyInfo .modifySidoName").val($(".modifySido option:selected").text());
			$("#adminModifyInfo .modifyGugunName").val($(".modifyGugun option:selected").text());
			$("#adminModifyInfo .modifyDongName").val($(".modifyDong option:selected").text());
			
		});
	});
	
	function getUserDetail(){
		console.log(this);
		var tr = $(this); // 현재 클릭된 Row(<tr>)
		var td = tr.children();
		var userid = td.eq(1).text();
		var name = td.eq(2).text();
		var email = td.eq(3).text();

		$('#adminMemberInfo .userId').text(userid);
		$('#adminMemberInfo .userName').text(name);
		$('#adminMemberInfo .userEmail').text(email);

		//modal open
		$('#adminMemberInfo').modal();
	}
	
	// 사용자 등록
	function register() {
		$("#adminRegister").modal();
	}
	
	//이름으로 사용자 검색
	function searchByName(){
		$.ajax({
			type : "get", //요청 메소드 방식
			url : "${root}/user/search",
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			data:{
				name:$("#searchVal").val()
			},
			success: displayUserList
		});
	}
	
	function displayUserList(result){
		$("#t-userList").empty();
		$.each(result,function(index){
			const user = result[index]["user"];
			const region = result[index]["address"];
			
			$("<tr>")
				.append("<td>"+(index+1)+"</td>")
				.append("<td>"+user.id+"</td>")
				.append("<td>"+user.name+"</td>")
				.append("<td>"+user.email+"</td>")
				.append("<td>"+region.sidoName+" "+region.gugunName+" "+region.dongName+"</td>")
				//.click(getUserDetail)
				.appendTo("#t-userList");
				

		});// for
	}
	
	function showAllUsers(){
		// 전체 사용자 조회
		$.ajax({
			type : "get", //요청 메소드 방식
			url : "${root}/user/all",
			dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
			success :displayUserList,
			error : function() {
				alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
			}
		});
	}
</script>
</head>
<body>
	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<div class="container">
		<div class="m-5">
			<div class="list mb-4">
				<button class="btn add-btn loadData" onClick="register();">회원 추가</button>
				 <%-- <form method="get" action="${root}/user/search">--%>
					이름: <input type="text" id="searchVal" name="name" class="form-control search" /> 
					<input type="button" class ="form-control search" value="검색" onClick="searchByName()"/>
				  <%-- </form> --%>
			</div>
			<table class="table table-hover" id="user_list">
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>대표관심지역</th>
					</tr>
				</thead>
				<tbody id="t-userList">
					<c:set var="totalUser" value="0" />
				</tbody>
			</table>
			<div class="align-center">
			<ul class="pagination" style="margin:0px;" id="paginations"> </ul>
		</div>
		</div>
	</div>
	
	<jsp:include page="../common/bottombar.jsp"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	<!-- Core theme JS-->
	<script src="${root}/js/scripts.js"></script>
</body>
</html>

<div class="modal" id="adminMemberInfo">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 정보 확인</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group form-inline justify-content-between">
					<label for='sid'>아이디 :</label> <label id='sid' class="userId"></label>
				</div>
				<div class="form-group form-inline justify-content-between">
					<label for='sPwd'>비밀번호 :</label> <label id='sPwd' class="userPwd"></label>
				</div>
				<div class="form-group form-inline justify-content-between">
					<label for='sname'>이름 :</label> <label id='sname' class="userName"></label>
				</div>
				<div class="form-group form-inline justify-content-between">
					<label for="semail">E-Mail :</label> <label id ="semail" class="userEmail"></label>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">확인</button>
				<button type="button" class="btn btn-primary showInfo" data-toggle="modal"
					data-target="#adminModifyInfo" data-dismiss="modal">수정</button>
				<button type="button" class="btn btn-danger delete"
					data-toggle="modal" data-dismiss="modal">삭제</button>
			</div>

		</div>
	</div>
</div>


<div class="modal" id="adminWithdraw">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 삭제</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h5>회원이 삭제되었습니다.</h5>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn delete_confirm"
					data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>


<div class="modal" id="adminRegister">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원등록</h4>
				<c:if test="${requestScope.errorMsg != null}">
					<div style="color: red">${requestScope.errorMsg}</div>
				</c:if>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form id="registerForm" method="post" action="${user}/user/register/admin">
					<div class="form-group form-inline justify-content-between">
						<label for="userMakeId">아이디</label> <input name="id" type="text"
							class="form-control userId" id="userMakeId" placeholder="아이디">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="userMakePwd">비밀번호</label> <input name="pwd"
							type="password" class="form-control userPwd" id="userMakePwd"
							placeholder="비밀번호">
					</div>

					<div class="form-group form-inline justify-content-between">
						<label for="userMakeName">이름</label> <input name="name" type="text"
							class="form-control userName" id="userMakeName" placeholder="아이디">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="userMakeEmail">이메일</label> <input name="email" type="text"
							class="form-control userEmail" id="userMakeEmail" placeholder="이메일">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="preferLocation">대표관심지역</label> <select id="amdinMakeSido"
							class="form-control sido" name="sido">
							<option selected value="">선택</option>
						</select> <select id="amdinMakeGugun" class="form-control gugun" name="gugun">
							<option selected value="">선택</option>
						</select> <select id="amdinMakeDong" class="form-control dong" name="dong">
							<option selected value="">선택</option>
						</select>
					</div>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn"
					data-dismiss="modal">취소</button>
				<button type="button" class="btn" data-dismiss="modal"
					onClick="$('#registerForm').submit();">등록</button>
			</div>

		</div>
	</div>
</div>

<%-- 수정 모달창 --%>>
<div class="modal" id="adminModifyInfo">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 정보 수정</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form id="adminUpdateform" method="put" action="${root}/user">
					<div class="form-group form-inline justify-content-between">
						<label for="mid">아이디</label> 
						<input type="text" id="mid" class="userId form-control" name="id" class="modifyId" placeholder="아이디" readonly>
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="mname">이름</label> 
						<input type="text" id="mname" class="userName form-control" name="name" class="modifyName" placeholder="이름">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="memail">이메일</label> 
						<input type="text" id="memail"  class="userEmail form-control" name="email" class="modifyEmail" placeholder="이메일">
					</div>
					<%-- <div class="form-group form-inline justify-content-between">
						<label for="preferLocation">관심지역</label>
						<div class="dropdown" id="modifyPreferLocation">
							<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">지역</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="#">용산구</a> <a class="dropdown-item" href="#">종로구</a> <a class="dropdown-item" href="#">관악구</a>
							</div>
						</div>
					</div> --%>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer" style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn" data-dismiss="modal">취소</button>
				<button type="button" class="btn adminUpdate" data-dismiss="modal">수정</button>
			</div>

		</div>
	</div>
</div>