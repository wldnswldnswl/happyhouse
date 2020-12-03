<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안심병원</title>
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
<link href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css"
	  rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link href="css/map.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
<script>
	$(document).ready(
			function() {
				$.get("${root}/localcode/sido/default", function(data, status) {
					$.each(data, function(index, vo) {
						$("#sido").append(
								"<option value='"+vo.sidoCode+"'>"
										+ vo.sidoName + "</option>");
					});//each
				}//function
				, "json");//get
			});//ready
	$(document)
			.ready(
					function() {
						$("#sido")
								.change(
										function() {
											$
													.get(
															"${root}/localcode/gugun/"
																	+ $("#sido")
																			.val(),
															function(data,
																	status) {
																$("#gugun")
																		.empty();
																$("#gugun")
																		.append(
																				'<option value="0">선택</option>');
																$
																		.each(
																				data,
																				function(
																						index,
																						vo) {
																					$(
																							"#gugun")
																							.append(
																									"<option value='"+vo.gugunCode+"'>"
																											+ vo.gugunName
																											+ "</option>");
																				});//each
															}//function
															, "json");//get
										});//change

						$("#gugun").change(
								function() {
									$.get("${root}/screening/"
											+ $("#gugun").val(), function(data,
											status) {
										$("#searchResult2").empty();
										$.each(data, function(index, vo) {
											let str = "<tr>" + "<td>" + vo.name
													+ "</td>" + "<td>"
													+ vo.address + "</td>"
													+ "<td>" + vo.weektime
													+ "</td>"
													/* + "<td>" + vo.tel + "</td>" */
													+ "<td>" + vo.possible
													+ "</td>" + "</td></tr>";
											$("#searchResult2").append(str);
										}); // each
									}//function
									, "json");
									$.get("${root}/hospital/"
											+ $("#gugun").val(), function(data,
											status) {
										$("#searchResult").empty();
										$.each(data, function(index, vo) {
											let str = "<tr>" + "<td>" + vo.name
													+ "</td>" + "<td>"
													+ vo.address + "</td>"
													+ "<td>" + vo.tel + "</td>"
													+ "</td></tr>";
											$("#searchResult").append(str);
										}); // each
									}//function
									, "json");

								});//change
					});//ready
</script>
</head>
<body>
	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<div class="form-group form-inline m-4">
		<div class="category">
			<select type="button" class="form-control m-3" id="sido">
				<option value="0">시/도</option>
			</select>
		</div>
		<div class="category">
			<select type="button" class="form-control m-3" id="gugun"
				style="width: 100%">
				<option value="0">구/군</option>
			</select>
		</div>
	</div>

	<table id="resultTable"
		class="table table-bordered table-hover text-center">
		<thead>
			<tr>
				<th>병원명</th>
				<th>위치</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody id="searchResult">
		</tbody>
	</table>

	</br>
	</br>
	<table id="resultTable2"
		class="table table-bordered table-hover text-center">
		<thead>
			<tr>
				<th>병원명</th>
				<th>위치</th>
				<th>운영시간</th>
				<!-- <th>전화번호</th> -->
				<th>검체채취 가능여부</th>
			</tr>
		</thead>
		<tbody id="searchResult2">
		</tbody>
	</table>

	<jsp:include page="../common/bottombar.jsp"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	</body>
</html>