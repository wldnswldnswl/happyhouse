<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	
 <style type="text/css">
      .btnGroup {
        text-align: center;
      }
      .adm_btn {
		float: right;
	  }
	  .adm_btn > .btn{
	  	font-size:13px;
	  	background-color:white;
	  	color:#807979
	  }
</style>
    
</head>
<script>
	$(document).ready(function(){		
		//게시글 불럴오기
		$.get("${root}/notice/"+${no},function(data){
			$('input[name="title"]').val(data.title);
			$('textarea').val(data.content);
			//$('input[type="hidden"]').val(data.writer);
		})
	});//document
	
	//글수정
	function modifyArticle(){
		 $.ajax({
             url: '${root}/notice/'+${no},
             method: "put",
             data:{
            	 	 "no":"${no}",
	            	 "content":$('textarea').val(),
	            	 "title":$('input[name="title"]').val()
            	 },
             contentType: 'application/json',
             dataType: 'json'
             
         }).done(function(response){
        	 location.href='notice.do';
         });
	}
</script>
<body>
	<header class="masthead"></header>
	
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<form action="notice/new" method="post">
	<div id="content" class="container">
		<p class="m-4"></p>
		<p style="font-size: 15px; display: inline-block; background-color: #d7ebc2;"> </p>
		<table id="notice-write-table" class="table table-hover">
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td colspan="2">
					<input placeholder="제목" name ='title' style="width: 100%"/>
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="10">내용</th>
					<td colspan="2">
						<textarea placeholder="내용" name ='content' style="width: 100%" rows="15"></textarea>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="writer" value="${id}"/>
		<div class="container btnGroup">
			<button type="button"  class="btn btn-light" onClick="modifyArticle()">확인</button>
			<button type="button"  class="btn btn-light"
				data-toggle="dropdown" onClick="location.href='notice.do'">취소</button>	
		</div>
		<p class="m-4"></p>
		<p style="font-size: 15px; display: inline-block; background-color: #d7ebc2;"> </p>
	</div>
	</form>
	<jsp:include page="../common/bottombar.jsp"></jsp:include>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
		<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>