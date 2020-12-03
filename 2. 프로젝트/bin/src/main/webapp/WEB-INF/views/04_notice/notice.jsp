<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>공지사항</title>
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
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>				
	$(document).ready(function(){
		$.get("${root}/notice",function(data, status){
			$("#searchResult").empty();
			$.each(data, function(index, vo) {
				let str = "<tr>"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.writer + "</td>"
						+ "<td>" + vo.title + "</td>"
						+ "<td>" + vo.content + "</td>"
						+ "<td>" + vo.regtime + "</td>"
						+ "</tr>"
				$("#searchResult").append(str);
			});//each
		}//function
			, "json"
		);//get
		
		$(document).on('click','#searchResult tr',function(){
			var no = $(this).children().eq(0).text();
			location.href="${root}/noticeDetail.do?no="+no;
		})
	});//ready			
</script>
<style type="text/css">

#add-btn {
	float: right;
	color:white;
	background-color: #b5aca3;
   	border: 1px solid #b5aca3;
   	font-weight: 600;
}

input {
	border: 0px;
}
</style>

</head>
<body>

	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<div id="content" class="container">
		<p class="m-4"></p>
		<p
			style="font-size: 15px; display: inline-block; background-color: #d7ebc2;">
		</p>
		<c:if test="${user_state eq 100}">
			<button type="button" id="add-btn" class="btn m-3"
					data-toggle="dropdown" onClick="location.href='noticeWrite.do'">
					글작성</button>
		</c:if> 
		
			<br><br>

	<div class="row">
		<table id="notice-table" class="table table-hover">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">작성자</th>
					<th scope="col">제목</th>
					<th scope="col">내용</th>
					<th scope="col">작성 날짜</th>
				</tr>
			</thead>
			<tbody id="searchResult"> </tbody>
		</table>


	</div>

	<jsp:include page="../common/bottombar.jsp"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
