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
<link href="css/map.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>	
	$(document).ready(function(){
		
		var start;
		var end ;
		var cur ;
		var pageCount ;
		var last ;
		
		$.get("${root}/notice/board/default",function(data, status){
			$("#searchResult").empty();
			$.each(data.notice, function(index, vo) {
				let str = "<tr>"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.writer + "</td>"
						+ "<td>" + vo.title + "</td>"
						+ "<td>" + vo.content + "</td>"
						+ "<td>" + vo.regtime + "</td>"
						+ "</tr>"
				$("#searchResult").append(str);
			});
			pageClick(1);
			},"json");
		
				
		function pageClick(no){
		$.get("${root}/notice/board/"+no,function(data, status){
			$("#searchResult").empty();
			console.log("삐용삐용");
			console.log(data);
			$.each(data.notice, function(index, vo) {
				let str = "<tr>"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.writer + "</td>"
						+ "<td>" + vo.title + "</td>"
						+ "<td>" + vo.content + "</td>"
						+ "<td>" + vo.regtime + "</td>"
						+ "</tr>"
				$("#searchResult").append(str);
			});
			
			$("#paginations").empty();
			start = data.pagenation.startPage;
			end = data.pagenation.endPage;
			cur = data.pagenation.currentPage;
			pageCount = data.pagenation.pageCount;
			last = data.pagenation.lastPage;
			
			let st;
			if(start-1 != 0)
				{
					st = "<li class='prev page-item'><a href='#' class='page-link'>"+String("&laquo;")+"</a></li>";				
				}
				$("#paginations").append(st);	
			for(var i = start;i<=end;i++)
				{
				if(i==cur)
					{
						let temp = "<li class='no page-item active' ><a class='page-link' id="+i+">" +i+ "</a></li>";
						$("#paginations").append(temp);	
					}
				else{
						let temp = "<li class='no page-item'><a class='page-link' id="+i+">" +i+ "</a></li>";
						$("#paginations").append(temp);	
					}
				}
			let en;
			if(end%pageCount==0 && last>end)
				{
					en = "<li class= 'next page-item'><a class='page-link' href='#'>"+String("&raquo;")+"</a></li>";	
				}
			
			
			$("#paginations").append(en);	
			
		},"json");}
	
		// << 클릭
		$(document).on('click','#paginations li.prev',function(){
			pageClick(start-1);
		})
		
		// << 클릭
		$(document).on('click','#paginations li.next',function(){
			pageClick(end+1);
		})
		
		$(document).on('click','#paginations li.no',function(){
			var no = $(this).children().eq(0).text();
			pageClick(no);
		})
		
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
					<th scope="col" width="10%">번호</th>
					<th scope="col" width="10%">작성자</th>
					<th scope="col" width="20%">제목</th>
					<th scope="col" width="25%">내용</th>
					<th scope="col" width="40%">작성 날짜</th>
				</tr>
			</thead>
			<tbody id="searchResult"> </tbody>
		</table>
	</div>
	<div class="align-center">
		<ul class="pagination" id="paginations"> </ul>
		</div>
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
