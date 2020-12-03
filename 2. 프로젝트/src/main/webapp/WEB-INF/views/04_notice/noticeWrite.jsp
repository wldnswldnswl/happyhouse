<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
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

<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>
 <style type="text/css">
      .btnGroup {
        text-align: center;
      }
    </style>
</head>
<body>
	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<script type="text/javascript">
		
		function hing()
		{

			var data = {
			title : $("#title").val(),
			writer : $("#writer").val(),
			content: $("#Content").val()
			};
			
			$.ajax({
				type:'post',
				url:"/notice/new",
				dataType:'text',
				contentType:'application/json; charset=utf-8',
				data:JSON.stringify(data)
			}).success(function(){
				window.location.assign('notice.do');
				alert("글이 등록되었습니다.");
			}).fail(function(error)
			{
				alert(JSON.stringify(error));
			});
		}
				
		</script>
	<div id="content" class="container">
	<h1 align="center">게시글 등록</h1>
	<form>
		<p class="m-4"></p>
		<p style="font-size: 15px; display: inline-block; background-color: #d7ebc2;"> </p>
		
		<table id="notice-write-table" class="table table-hover">
			<tbody>
			<tr>
					<th scope="row">작성자</th>
					<td colspan="2">
					<input placeholder="작성자"  id="writer" style="width: 100%" />
					</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td colspan="2">
					<input placeholder="제목"  id="title" style="width: 100%" />
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="10">내용</th>
					<td colspan="2">
					<textarea placeholder="내용" id="Content" style="width: 100%" rows="14"></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="writer" id="${writer}" value="${writer}"/>
		</form>
		<div class="container btnGroup">
			<input type="button" id="okay-btn" class="btn btn-light" value="확인" onclick="hing()"/>
			<button type="button"  class="btn btn-light"
				data-toggle="dropdown" onClick="location.href='notice.do'">취소</button>
		</div>
		<p class="m-4"></p>
		<p style="font-size: 15px; display: inline-block; background-color: #d7ebc2;"> </p>
	
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