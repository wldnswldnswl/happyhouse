<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>Insert title here</title>
<style type="text/css">
table {
	color: black;
	margin: 30px;
	margin-right: 10%;
	border-collapse: separate;
	border-spacing: 30px 30px;
}

.movetitle {
	color: black;
	font-size: 15px;
}
</style>
</head>
<body>
	<%--<%@ include file="../common/topbar.jsp"%> --%>
	<jsp:include page="../common/topbar.jsp"></jsp:include>

	<div class="form-group form-inline">
		<table>
			<tbody>
				<tr>
					<th><button class="orange whiteFont" style="font-weight: bold; border-radius: 50px; color: white;" onclick="location.href='${root}/index.jsp'">메인화면</button></th>
					<td>
						<a class="movetitle" href="${root}/01_search/search.jsp">실거래가 조회</a>
					</td>
					<td>
						<a class="movetitle" href="${root}/02_surround/surround.jsp">관심지역</a>
					</td>
					<td>
						<a class="movetitle" href="${root}/03_interest/interest.jsp">주변탐방</a>
					</td>
					<td>
						<a class="movetitle" href="${root}/04_notice/notice.jsp">공지사항</a>
					</td>
				</tr>
				<tr>
					<th><button class="orange whiteFont" style="font-weight: bold; border-radius: 50px; color: white;" onclick="location.href='${root}/01_search/search.jsp'">실거래가 조회</button></th>
				</tr>
				<tr>
					<th><button class="orange whiteFont" style="font-weight: bold; border-radius: 50px; color: white;" onclick="location.href='${root}/02_surround/surround.jsp'">관심지역</button></th>
				</tr>
				<tr>
					<th><button class="orange whiteFont" style="font-weight: bold; border-radius: 50px; color: white;" onclick="location.href='${root}/03_interest/interest.jsp'">주변탐방</button></th>
				</tr>
				<tr>
					<th><button class="orange whiteFont" style="font-weight: bold; border-radius: 50px; color: white;" onclick="location.href='${root}/04_notice/notice.jsp'">공지사항</button></th>
				</tr>
			</tbody>
		</table>
	</div>
	 <jsp:include page="../common/bottombar.jsp"></jsp:include>
</body>
</html>