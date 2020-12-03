<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>실물후기</title>
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
<style>
	@font-face {font-family:MalgunGothic; src:url(assets/font/MalgunGothic.eot);}
</style>
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
		
		// 전체 게시글 조회
		pageClick(1,"board");
		// 관심 게시글 조회
		pageClick(1,"interest");
		
		 // 전체 게시글 이벤트 리스너
		clickEventListener("board");
		 // 관심 게시글 이벤트 리스너
		clickEventListener("interest");
		
	});//ready	
	
	
	//페이지 클릭: no번째 페이지 조회, section(board- 전체 게시글, interest-관심 게시글)
	function pageClick(no,section){
		let pageTag = "#"+section+"-paginations";
		let resultTag = "#"+section+"-reviewResult";
		
		$.get("${root}/dealReview/"+section+"/"+no,function(data, status){
			console.log(data);
			$(resultTag).empty();
			$.each(data.review, function(index, vo) {
				let str = "<tr class='text-center'>"
						+ "<td id="+vo.no+">" + (index+1) + "</td>"
						+ "<td id="+vo.dong_code+">" + vo.dong_name + "</td>"
						+ "<td>" + vo.writer + "</td>"
						+ "<td>" + vo.title + "</td>"
						+ "<td>" + vo.content + "</td>"
						+ "<td style='display:none;'>" + vo.regtime + "</td>"
						+ "</tr>"
				$(resultTag).append(str);
		});//each
		
		$(pageTag).empty();
		start = data.pagenation.startPage;
		end = data.pagenation.endPage;
		cur = data.pagenation.currentPage;
		pageCount = data.pagenation.pageCount;
		last = data.pagenation.lastPage;
		
		let st;
		if(start-1 != 0)
			{
				st = "<li class='prev "+pageTag+" page-item'><a href='#' class='page-link'>"+String("&laquo;")+"</a></li>";				
			}
			$(pageTag).append(st);	
		for(var i = start;i<=end;i++)
			{
			if(i==cur)
				{
					let temp = "<li class='no page-item active' ><a class='page-link' id="+i+">" +i+ "</a></li>";
					$(pageTag).append(temp);	
				}
			else{
					let temp = "<li class='no page-item'><a class='page-link' id="+i+">" +i+ "</a></li>";
					$(pageTag).append(temp);	
				}
			}
		let en;
		if(end%pageCount==0 && last>end)
			{
				en = "<li class= 'next page-item'><a class='page-link' href='#'>"+String("&raquo;")+"</a></li>";	
			}
		
		
		$(pageTag).append(en);	
		
	},"json");}//get
	
	
	// 클릭 이벤트 리스너 함수
	function clickEventListener(tag){
		let pageTag = "#"+tag+"-paginations";
		let searchTag = "#"+tag+"-reviewResult";
		
		// << 클릭
		$(document).on('click',pageTag+' li.prev',function(){
			pageClick(start-1,tag);
		})
		
		// << 클릭
		$(document).on('click',pageTag+' li.next',function(){
			pageClick(end+1,tag);
		})
		
		$(document).on('click',pageTag+' li.no',function(){
			var no = $(this).children().eq(0).attr("id");
			pageClick(no,tag);
		})
		
		$(document).on('click',searchTag+' tr',function(){
			var no = $(this).children().eq(0).attr("id");
			location.href="${root}/dealReviewDetail.do?no="+no;
		})
	}
	
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
					<button type="button" id="add-btn" class="btn m-3"
							data-toggle="dropdown" onClick="location.href='${root}/dealReviewWrite.do'">
							글작성</button>
					<div id="content" class="container">
							<br/>
							<h3 style="margin-bottom:2%;">관심지역 후기</h3>
							<div class="row">
								<table id="interest-review-table" class="table table-hover">
									<thead class='text-center'>
										<tr>
											<th scope="col" width="8%">번호</th>
											<th scope="col" width="15%">지역</th>
											<th scope="col" width="10%">작성자</th>
											<th scope="col" width="20%">제목</th>
											<th scope="col" width="26%">내용</th>
											<th scope="col" width="21%" style="display:none;">작성 날짜</th>
										</tr>
									</thead>
									<tbody id="interest-reviewResult"> 
									</tbody>
								</table>
							</div>
							<div class="align-center">
								<ul class="pagination" id="interest-paginations"> </ul>
							</div>
								
							<h3 style="margin-bottom:2%;">모든 지역 후기</h3>	
							<div class="row">
								<table id="board-review-table" class="table table-hover">
									<thead class='text-center'>
										<tr class="text-center">
											<th scope="col" width="8%">번호</th>
											<th scope="col" width="15%">지역</th>
											<th scope="col" width="10%">작성자</th>
											<th scope="col" width="20%">제목</th>
											<th scope="col" width="26%">내용</th>
											<th scope="col" width="21%" style="display:none;">작성 날짜</th>
										</tr>
									</thead>
									<tbody id="board-reviewResult"> 
									</tbody>
								</table>
							</div>
							<div class="align-center">
								<ul class="pagination" id="board-paginations"> </ul>
							</div>
					</div>
					
		<div id="map" class="map container-fluid"></div>
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
