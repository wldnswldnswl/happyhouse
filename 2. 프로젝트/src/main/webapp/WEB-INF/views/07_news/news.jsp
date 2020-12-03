<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>오늘의 뉴스</title>
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
		
		$.get("${root}/news/default",function(data, status){
			$("#searchResult").empty();
			$.each(data.news, function(index, vo) {
				let str = "<li><dl>"
					+ "<dt><a href=" + vo.url + ">" + vo.title + "</a></dt>"
					+ "<dd>" + vo.content + "</dd>"
					+ "<dd>" + vo.writer + "</dd>"
					+ "</dl></li>"
				$("#searchResult").append(str);
			});
			pageClick(1);
			},"json");
		
				
		function pageClick(no){
		$.get("${root}/news/"+no,function(data, status){
			$("#searchResult").empty();
			$.each(data.news, function(index, vo) {
				let str = "<li><dl>"
						+ "<dt><a href=" + vo.url + ">" + vo.title + "</a></dt>"
						+ "<dd>" + vo.content + "</dd>"
						+ "<dd>" + vo.writer + "</dd>"
						+ "</dl></li>"
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
						let temp = "<li class='no active page-item' ><a class='page-link' id="+i+">" +i+ "</a></li>";
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
					en = "<li class= 'next page-item'><a href='#' class='page-link'>"+String("&raquo;")+"</a></li>";	
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
ul{
   list-style:none;
}
</style>

</head>

<body>

	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<div id="content" class="container">
	<br>
	<h3>오늘의 뉴스</h3>
	<hr>
	<div class="row">
		<ul id="searchResult"></ul>
	</div>
	<div class="align-center">
		<ul class="pagination" style="margin:0px;" id="paginations"> </ul>
	</div>
	</div>
	<br>
	<jsp:include page="../common/bottombar.jsp"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
