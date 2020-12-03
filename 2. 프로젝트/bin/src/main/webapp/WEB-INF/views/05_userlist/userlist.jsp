<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>회원목록</title>
<script>
	$(document).ready(function() {
		$("#user_list tr").click(function() {
			var tr = $(this); // 현재 클릭된 Row(<tr>)
			var td = tr.children();
			var userid = td.eq(1).text();
			var name = td.eq(2).text();
			var email = td.eq(3).text();

			console.log("클릭한 Row의 모든 데이터 : " + tr.text());
			$('#adminMemberInfo #myId').text(userid);
			$('#adminMemberInfo #myName').text(name);
			$('#adminMemberInfo #myEmail').text(email);

			//modal open
			$('#adminMemberInfo').modal();
		});

		$(".delete").click(function() {
			$.ajax({
				type : "post", //요청 메소드 방식
				url : "${pageContext.request.contextPath}/delete.do",
				dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				data : {
					id : $("#adminMemberInfo #myId").text()
				}
			});
			$("#adminWithdraw").modal();
		});
		
		$(".showInfo").click(function() {
			$.ajax({
				type : "get", //요청 메소드 방식
				url : "${pageContext.request.contextPath}/showDetails.do",
				dataType : "json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				data:{
					selectId:$("#adminMemberInfo #myId").text()
				},
				success : function(result) {
					//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
					//result - 응답데이터
					//$('#result').text(result);
					$("#adminModifyInfo #modifyId").val(result.id);
					//$("#adminMemberInfo #modifyPwd").val(result.pwd);
					$("#adminModifyInfo #modifyName").val(result.name);
					$("#adminModifyInfo #modifyEmail").val(result.email);
				},
				error : function() {
					alert("서버에 문제가 발생했습니다. 잠시후 시도해주세요.");
				}
			});
		});
		
		$(".adminUpdate").click(function() {
			$("#adminUpdateform").submit();
		});
	});
	function register() {
		$("#adminRegister").modal();
		//$("#registerForm").submit();
	}
</script>
</head>
<body>
	<%@ include file="../common/topbar.jsp"%>
	<div class="container" style="margin-top: 30px">
		<div class="list">
			<button class="blue whiteFont"
				style="font-weight: bold; border-radius: 50px; background-color: #00519e; color: white;">회원목록</button>
			<button class="orange whiteFont"
				style="font-weight: bold; background-color: #f39c12; color: white; float:right" onClick="register();">등록</button>
		</div>
		<div style="margin-top: 20px;">
			<form method="get" action="search.do">
				이름: <input type="text" name="username" /> <input type="submit"
					value="검색" />
			</form>
			<table class="table table-hover" id="user_list">
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="totalUser" value="0" />
					<c:forEach items="${userList}" var="user" varStatus="status">
						<%-- var: 받는 이름 --%>
						<tr>
							<td>${status.count}</td>
							<td>${pageScope.user.id}</td>
							<td>${user.name}</td>
							<!-- <a href="">showDetails.do?username=${user.name} </a>-->
							<td>${user.email}</td>
						</tr>
						<c:set var="totalUser" value="${totalUser+1}" />
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" aling="right">총 ${totalUser} 명</td>
					<tr>
				</tfoot>
			</table>

		</div>
	</div>
	<%@ include file="../common/bottombar.jsp"%>
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
					<label>아이디 :</label> <label id="myId"></label>
				</div>
				<div class="form-group form-inline justify-content-between">
					<label>이름 :</label> <label id="myName"></label>
				</div>
				<div class="form-group form-inline justify-content-between">
					<label>E-Mail :</label> <label id="myEmail"></label>
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
				<button type="button" class="center-block btn btn-warning"
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
				<form id="registerForm" method="post" action="adminRegister.do">
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
					<!--  <div class="form-group form-inline justify-content-between">
					<label for="preferLocation">관심지역</label>
					<div class="dropdown" id="preferLocation">
						<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">지역</button>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="#">용산구</a> <a class="dropdown-item" href="#">종로구</a> <a class="dropdown-item" href="#">관악구</a>
						</div>
					</div>
			</div>-->
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					onClick="$('#registerForm').submit();">등록</button>
			</div>

		</div>
	</div>
</div>

<div class="modal" id="adminModifyInfo">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 정보 수정</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form id="adminUpdateform" method="post" action="adminUpdate.do">
					<div class="form-group form-inline justify-content-between">
						<label for="makeId">아이디</label> 
						<input type="text" class="form-control" name="id" id="modifyId" placeholder="아이디" readonly>
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="makeName">이름</label> 
						<input type="text" class="form-control" name="name" id="modifyName" placeholder="아이디">
					</div>
					<div class="form-group form-inline justify-content-between">
						<label for="makeEmail">이메일</label> 
						<input type="text" class="form-control" name="email" id="modifyEmail" placeholder="아이디">
					</div>
					<!-- <div class="form-group form-inline justify-content-between">
						<label for="preferLocation">관심지역</label>
						<div class="dropdown" id="modifyPreferLocation">
							<button type="button" class="btn dropdown-toggle" data-toggle="dropdown">지역</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="#">용산구</a> <a class="dropdown-item" href="#">종로구</a> <a class="dropdown-item" href="#">관악구</a>
							</div>
						</div>
					</div> -->
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer" style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary adminUpdate" data-dismiss="modal">수정</button>
			</div>

		</div>
	</div>
</div>