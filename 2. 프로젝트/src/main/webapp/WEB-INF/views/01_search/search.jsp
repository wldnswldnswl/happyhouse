<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>실거래가 조회</title>
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
<!-- for Chart.js -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link href="css/styles.css" rel="stylesheet" />
<link href="css/map.css" rel="stylesheet" />
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
	src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4&callback=initMap"></script>
<script>
	var map;
	var multi = {lat: 37.5665734, lng: 126.978179};
			/* lat : 37.484235, lng : 126.930324}; */
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : multi,
			zoom : 12
		});
		var marker = new google.maps.Marker({
			position : multi,
			map : map
		});
		console.log(map);
		//infowindow = new google.maps.InfoWindow();
		//changeDong();
		//changeField();
	}
	
	function setMapCenter(lat,lng)
	{	
		lat=Number(lat);
		lng=Number(lng);
		
		map = new google.maps.Map(document.getElementById('map'), {
			center : {lat,lng},
			zoom : 15
		});
		var marker = new google.maps.Marker({
			position : {lat,lng},
			map : map
		});
	}
	function addMarker(tmpLat, tmpLng, aptName, dong, flag) {
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
			label: aptName,
			title: aptName,
			address: dong
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(marker.getPosition());
			callHouseDealInfo(marker.title, marker.address);
			callHouseDealGraph(marker.title, marker.address);
		});
		marker.setMap(map);
	}
	var globalAptName,globalDong;
	var start,end,cur,pageCount,last;
	function callHouseDealInfo(aptName, dong) {
		globalAptName=aptName;
		globalDong=dong;
		console.log("aptName: "+globalAptName+" dong: "+globalDong);
		
		$.get("${root}/aptdeal/"+globalAptName+"/"+globalDong+"/1"
				,function(data, status){
					pageDealClick(1);
				}//function
				, "json"
		);//get
	}
	function pageDealClick(no){
		console.log("aptName: "+globalAptName+" dong: "+globalDong);
		$.get("${root}/aptdeal/"+globalAptName+"/"+globalDong+"/"+no
				,function(data, status){
			$("#detailResult").empty();
			var idx = data.pagenation.displayRow*(data.pagenation.currentPage-1)+1;
			$.each(data.houseDeal, function(index, vo) {
				let str = "<tr class="+colorArr[index%3]+">"
				+ "<td>" + idx++ + "</td>"
				+ "<td>" + vo.dong + "</td>"
				+ "<td>" + vo.aptName + "</td>"
				+ "<td>" + vo.dealAmount + "</td>"
				$("#detailResult").append(str);
			});
			
			$("#paginationDeal").empty();
			
			start = data.pagenation.startPage;
			end = data.pagenation.endPage;
			cur = data.pagenation.currentPage;
			pageCount = data.pagenation.pageCount;
			last = data.pagenation.lastPage;
			
			
			if(start-1 != 0)
				{
					let st;
					st = "<li class='page-item' id='prevDeal'><a href='#' class='page-link'>"+String("&laquo;")+"</a></li>";				
					$("#paginationDeal").append(st);
				}
					
			for(var i = start;i<=end;i++)
				{
				if(i==cur)
					{
						let temp = "<li class='deal page-item active' id='dealNum'><a class='page-link' id="+i+">" +i+ "</a></li>";
						$("#paginationDeal").append(temp);	
					}
				else{
						let temp = "<li class='deal page-item' id='dealNum'><a class='page-link' id="+i+">" +i+ "</a></li>";
						$("#paginationDeal").append(temp);	
					}
				}
			
			if(end%pageCount==0 && last>end)
				{
					let en;
					en = "<li class= 'page-item' id='nextDeal'><a class='page-link' href='#'>"+String("&raquo;")+"</a></li>";	
					$("#paginationDeal").append(en);	
				}
			//좌표 찍기
			//geocode(data);
		},"json");}
	
	var chartLabels = [];
	var chartData = [];
	var lineChartData;
	function createChart(){
		var ctx = document.getElementById("canvas").getContext("2d");
		LineChartDemo = Chart.Line(ctx,{
			data : lineChartData,
			options :{
				scales : {
					yAxes : [{
						ticks :{
							beginAtZero : true
						}
					}]
				}
			}
		})
	}
	function callHouseDealGraph(aptName, dong) {
		globalAptName=aptName;
		globalDong=dong;
		console.log("aptName: "+globalAptName+" dong: "+globalDong);
		chartLabels = [];
		chartData = [];
		$('#canvas').remove();
		$('#graph-container').append('<canvas id="canvas" height="300px" width="700px"></canvas>');
		$.getJSON("${root}/graph/"+globalAptName+"/"+globalDong, function(data){
			$.each(data, function(inx, obj){
				chartLabels.push(obj.dealYear);
				chartData.push(obj.dealAmount);
			});
			lineChartData = {
					labels : chartLabels,
					datasets : [
						{
							label : "년도별 실거래가",
							fillColor : "rbga(151,187,205,0.2)",
							strokeColor : "rbga(151,187,205,1)",
							pointColor : "rbga(151,187,205,1)",
							pointStrokeColor : "#fff",
							pointHighlightFill : "#fff",
							pointHighlightStroke : "rbga(151,187,205,1)",
							data : chartData
							}
						]
			}
			createChart();
			console.log("create Chart");
			console.log(chartLabels);
			console.log(chartData);
		});
	}
	//실거래가 검색 관련
	$(document).on('click','#dealNum',function(){
		var no = $(this).children().eq(0).text();
		pageDealClick(no);
	})

	$(document).on('click','#prevDeal',function(){
		pageDealClick(start-1);
	})
	
	$(document).on('click','#nextDeal',function(){
		pageDealClick(end+1);
	})
	
	function showSide() {
		$(".aside").css("display", "inline-block");
	}

	function goToInterest() {
		location.href = "${root}/03_interest/interest.jsp";
	}
	
	$(document).ready(function() {
		var infowindow;
		$(".aside").css("display", "none");
	});
	
	$(document.body).delegate("#resultTabl tr", "click", function() {
		console.log("tlqkf");
	});
	function signUp() {
		console.log("clicked");
		$("#makeSidoName").val($("#makeSido option:selected").text());
		$("#makeGugunName").val($("#makeGugun option:selected").text());
		$("#makeDongName").val($("#makeDong option:selected").text());
		$("#signUpForm").submit();
	}
	
</script>
<title>실거래가 조회</title>
</head>
<body>
	<!-- Masthead-->
	<header class="masthead"> </header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<!-- Map-->
	<div class="container-fluid" style="margin-top: 50px">
		<div class="row" style="height: 900px; width: 95%; margin: 0 auto">
			<div style="width: 100%">
				<section id="index_section" class="form-inline"
					style="margin: 0 auto">
					<%-- <form action="${pageContext.request.contextPath}/map" class="form-inline" style="margin-left: 30%;"> --%>
					<script>
//				let colorArr = ['table-primary','table-success','table-danger'];
				let colorArr = ['#F0F2F3',"#FFF"];
				$(document).ready(function(){
					$.get("${root}/localcode/sido/default"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});//each
						}//function
						, "json"
					);//get
				});//ready
				
				var dongName,start,end,cur,pageCount,last,aptName;
				
				$(document).ready(function(){
									
					$("#sido").change(function() {
						$.get("${root}/localcode/gugun/"+$("#sido").val()
								,function(data, status){
									$("#gugun").empty();
									$("#gugun").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
									});//each
								}//function
								, "json"
						);//get
					});//change
					$("#gugun").change(function() {
						$.get("${root}/localcode/dong/"+$("#gugun").val()							
								,function(data, status){
									$("#dong").empty();
									$("#dong").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
									});//each
								}//function
								, "json"
						);//get
					});//change
					$("#dong").change(function() {
						$.get("${root}/aptinfo/dong/"+$("#dong").val()+"/1"
								,function(data, status){
									dongName=$("#dong").val();
									console.log(data);
									$("#searchResult").empty();
									var idx = data.pagenation.displayRow*(data.pagenation.currentPage-1)+1;
									$.each(data.houseInfo, function(index, vo) {
										let str = "<tr style = 'background-color: "+colorArr[index%2]+";'>"
										+ "<td>" + idx++ + "</td>"
										+ "<td>" + vo.dong + "</td>"
										+ "<td>" + vo.aptName + "</td>"
										+ "<td>" + vo.buildYear + "</td>"
										+"</tr>"
										$("#searchResult").append(str);
									});//each
									pageClick("dong",1);															
								}//function
								, "json"
						);//get
						
					});//change
						
				});//ready
				
				function pageClick(dongOrName,no){
					var Name;
					console.log(dongOrName);
					if(dongOrName=="dong") 
						{
							Name = dongName;
						}
					else if(dongOrName=="name")
						{
							Name=aptName;
							console.log(Name);
						}
					
					$.get("${root}/aptinfo/"+dongOrName+"/"+Name+"/"+no
							,function(data, status){
						$("#searchResult").empty();
						var idx = data.pagenation.displayRow*(data.pagenation.currentPage-1)+1;
						$.each(data.houseInfo, function(index, vo) {
							let str = "<tr style = 'background-color: "+colorArr[index%2]+";'>"
							+ "<td>" + idx++ + "</td>"
							+ "<td>" + vo.dong + "</td>"
							+ "<td>" + vo.aptName + "</td>"
							+ "<td>" + vo.buildYear + "</td>"
							$("#searchResult").append(str);
						});
						
						$("#paginations").empty();
						
						start = data.pagenation.startPage;
						end = data.pagenation.endPage;
						cur = data.pagenation.currentPage;
						pageCount = data.pagenation.pageCount;
						last = data.pagenation.lastPage;
						
						
						if(start-1 != 0)
							{
								let st;
								st = "<li class='page-item' id='prev"+dongOrName+"'><a href='#' class='page-link'>"+String("&laquo;")+"</a></li>";				
								$("#paginations").append(st);
							}
								
						for(var i = start;i<=end;i++)
							{
							if(i==cur)
								{
									let temp = "<li class='"+dongOrName+" page-item active' ><a class='page-link' id="+i+">" +i+ "</a></li>";
									$("#paginations").append(temp);	
								}
							else{
									let temp = "<li class='"+dongOrName+" page-item'><a class='page-link' id="+i+">" +i+ "</a></li>";
									$("#paginations").append(temp);	
								}
							}
						
						if(end%pageCount==0 && last>end)
							{
								let en;
								en = "<li class= 'page-item' id='next"+dongOrName+"'><a class='page-link' href='#'>"+String("&raquo;")+"</a></li>";	
								$("#paginations").append(en);	
							}
						//좌표 찍기
						geocode(data);
					},"json");}
				
				function searchByName() {
									aptName=$("#aptName").val();
						$.get("${root}/aptinfo/name/"+aptName+"/1"		
								,function(data, status){
									var idx = data.pagenation.displayRow*(data.pagenation.currentPage-1)+1;
									$("#searchResult").empty();
									$.each(data.houseInfo, function(index, vo) {
										let str = "<tr class="+colorArr[index%3]+">"
										+ "<td>" + idx++ + "</td>"
										+ "<td>" + vo.dong + "</td>"
										+ "<td>" + vo.aptName + "</td>"
										+ "<td>" + vo.buildYear + "</td>"
										$("tbody").append(str);
									});//each
									pageClick("name",1);	
									geocode(data);
								}//function
								, "json"
						);//get
					} //click

				
						
				//동으로 검색하는 경우 관련
				$(document).on('click','#paginations li.dong',function(){
					var no = $(this).children().eq(0).text();
					console.log(no);
					pageClick("dong",no);
				})

				$(document).on('click','#prevdong',function(){
					pageClick("dong",start-1);
				})
				
				$(document).on('click','#nextdong',function(){
					pageClick("dong",end+1);
				})
				
				//이름으로 검색하는 경우 관련
				$(document).on('click','#paginations li.name',function(){
					var no = $(this).children().eq(0).text();
					pageClick("name",no);
				})
				
				$(document).on('click','#prevname',function(){
					pageClick("name",start-1);
				})
				
				
				$(document).on('click','#nextname',function(){
					pageClick("name",end+1);
				})
				
				$(document).on('click','#searchResult tr',function(){
				var dong = $(this).children().eq(1).text();
				var aptname = $(this).children().eq(2).text();
				console.log("dong: "+dong+" aptname: "+aptname);
				callHouseDealInfo(aptname,dong);
				callHouseDealGraph(aptname,dong);
				})
				
				function geocode(jsonData) {
					let idx = 0;
						var a = jsonData.houseInfo[0].lat;
						var b = jsonData.houseInfo[0].lng;
						setMapCenter(a,b);
					$.each(jsonData.houseInfo, function(index, vo) {
						let tmpLat;
						let tmpLng;
						$.get("https://maps.googleapis.com/maps/api/geocode/json"
								,{	key:'AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4'
									, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
								}
								, function(data, status) {
									tmpLat = data.results[0].geometry.location.lat;
									tmpLng = data.results[0].geometry.location.lng;
									$("#lat_"+index).text(tmpLat);
									$("#lng_"+index).text(tmpLng);
									console.log("Apt:"+ vo.aptName+"dong: "+vo.dong+"Lat: "+tmpLat+"Lng: "+tmpLng);
									addMarker(tmpLat, tmpLng, vo.aptName, vo.dong);
								}
								, "json"
						);//get
					});//each
				}
				</script>
					<section class="align-center">
						<select id="sido" name="region" class="form-control">
							<option value="0">선택</option>
						</select> <select id="gugun" name="dong" class="form-control dropdown dong">
							<option value="0">선택</option>
						</select> <select id="dong" name="dong" class="form-control dong">
							<option value="0">선택</option>
						</select> <input type="text" placeholder="아파트이름" id="aptName"
							name="aptName" class="form-control"> <input type="button"
							id="aptNameBtn" class="form-control" value="검색"
							onclick="searchByName()">
					</section>
					<div style="width: 100%">
						<div style="width: 50%; float: left">
							<br>
								<h3>행복주택</h3>
							<hr>
							<table id="resultTable"
								class="table table-bordered table-hover text-center">
								<thead>
									<tr>
										<th>번호</th>
										<th>법정동</th>
										<th>아파트이름</th>
										<th>건축 년도</th>
									</tr>
								</thead>
								<tbody id="searchResult">
								</tbody>
							</table>

							<%-- 페이지  --%>
							<div class="align-center">
								<ul class="pagination" style="margin: 0px;" id="paginations">
								</ul>
							</div>
							<br>
							<div class="col-sm3">
								<br>
								<h3>실거래가</h3>
								<hr>
								<table class="table mt-2"
									style="text-align: center; border-collapse: collapse;">
									<thead>
										<tr>
											<th>번호</th>
											<th>법정동</th>
											<th>아파트이름</th>
											<th>거래가</th>
										</tr>
									</thead>
									<tbody id="detailResult">
									</tbody>
								</table>
								<div class="align-center">
									<ul class="pagination" style="margin: 0px;" id="paginationDeal">
									</ul>
								</div>
							</div>
						</div>
						<div style="width: 50%; float: left">
							<div id="map" class="map container-fluid" style="height:450px"></div>
							<br>
							<div class="align-center" id="graph-container">
								<canvas id="canvas" height="300px" width="700px"></canvas>
							</div>
						</div>
					</div>

				</section>


				<div class="modal" id="house_details">
					<div class="modal-dialog" style="position: relative;">
						<div class="modal-content"
							style="width: fit-content; width: 800px;">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">아파트 검색 상세</h4>

							</div>

							<!-- Modal body -->
							<div class="modal-body row">
								<div class="col-sm-6" style="background-color: lavenderblush;">
									<div class="form-group form-inline justify-content-between">
										<label for="makeId">주택명</label> <label class="form-control"
											id="hName">행복주택 </label>
									</div>
									<div class="form-group form-inline justify-content-between">
										<label for="makePwd">거래금액</label> <label class="form-control"
											id="hPrice">2,000 </label>
									</div>

									<div class="form-group form-inline justify-content-between">
										<label for="makeName">월세금액</label> <label class="form-control"
											id="hMPrice">없음 </label>
									</div>
									<div class="form-group form-inline justify-content-between">
										<label for="makeName">거래일</label> <label class="form-control"
											id="hDate">2019.09.28</label>
									</div>

								</div>

								<!-- Modal footer -->
								<div class="modal-footer"
									style="display: inline-block; text-align: center;">
									<button type="button" class="center-block btn btn-warning"
										data-dismiss="modal">주변정보 확인</button>
									<button type="button" class="btn btn-primary"
										data-dismiss="modal" onClick="goToInterest()">관심장소 등록</button>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
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
