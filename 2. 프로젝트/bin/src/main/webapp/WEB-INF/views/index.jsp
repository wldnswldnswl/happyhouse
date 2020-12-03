<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
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
<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4&callback=initMap"></script>

<script>
	var map;
	var multi = {lat: 37.5665734, lng: 126.978179};
			/* lat : 37.484235, lng : 126.930324}; */
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : multi,
			zoom : 14
		});
		var marker = new google.maps.Marker({
			position : multi,
			map : map
		});
		//infowindow = new google.maps.InfoWindow();
		//changeDong();
		//changeField();
	}
	function addMarker(tmpLat, tmpLng, aptName, dong) {
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
		});
		marker.setMap(map);
	}
	function delMarker()
	{
		marker.setMap(null);
	}
	
	function callHouseDealInfo(aptName, dong) {
		/* location.href = "${pageContext.request.contextPath}/map?act=detail&name="+aptName+"&dong="+dong; */
	}
	
	function showSide() {
		$(".aside").css("display", "inline-block");
	}

	$(document).ready(function() {
		var infowindow;
		$(".aside").css("display", "none");
	});
</script>
<body id="page-top">
	<jsp:include page="common/topbar.jsp"></jsp:include> 
	<!-- Masthead-->
	<header class="mastheadMain">
		<div class="container h-100">
			<div
				class="row h-100 align-items-center justify-content-center text-center">
				<div class="col-lg-10 align-self-end">
					<h1 class="text-uppercase text-white font-weight-bold">
						Woong's House
					</h1>
					<hr class="divider my-4" />
				</div>
				<div class="col-lg-8 align-self-baseline">
					<%--<p class="text-white-75 font-weight-light mb-5">
						
					</p> --%>
					<a class="btn btn-primary btn-xl js-scroll-trigger" 
							href="${root}/searchPage.do">Start</a>
				</div>
			</div>
		</div>
	</header>
	<!-- Map-->
	<div class="container-fluid" style="margin-top: 100px">
		<div class="row" style="height: 900px;">
			<div class="col-sm-12">
				
				<section id="index_section" class="form-inline center">
				<script>
				let colorArr = ['table-primary','table-success','table-danger'];
				
				$(document).ready(function(){
					$.get("${root}/localcode/sido/default",function(data, status){
						$.each(data, function(index, vo) {
							//console.log(vo);
							$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});//each
						}//function
						, "json"
					);//get
				});//ready
				
				$(document).ready(function(){
					
					$("#sido").change(function() {
						
						$.get("${root}/localcode/gugun/"+$("#sido").val(),function(data, status){
									$("#gugun").empty();
									$("#gugun").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										//console.log(vo);
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
										//console.log(vo);
										$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
									});//each
								}//function
								, "json"
						);//get
					});//change
					$("#dong").change(function() {
						$.get("${root}/aptinfo/dong/"+$("#dong").val()					
								,function(data, status){
									$("#searchResult").empty();
									$.each(data, function(index, vo) {
										console.log(vo);
										let str = "<tr class="+colorArr[index%3]+">"
										+ "<td>" + vo.no + "</td>"
										+ "<td>" + vo.dong + "</td>"
										+ "<td>" + vo.aptName + "</td>"
										+ "<td>" + vo.jibun + "</td>"
										+ "<td>" + vo.code
										+ "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
										$("tbody").append(str);
										$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
									});//each
									geocode(data);
								}//function
								, "json"
						);//get
					});//change
				});//ready
				
				function searchByName() {
					$.get("${root}/aptinfo/name/"+$("#aptName").val()		
							,function(data, status){
								$("#searchResult").empty();
								$.each(data, function(index, vo) {
									let str = "<tr class="+colorArr[index%3]+">"
									+ "<td>" + vo.no + "</td>"
									+ "<td>" + vo.dong + "</td>"
									+ "<td>" + vo.aptName + "</td>"
									+ "<td>" + vo.jibun + "</td>"
									+ "<td>" + vo.code
									+ "<td>" + vo.dealAmount + "</td>"
									+ "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
									$("tbody").append(str);
									$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
								});//each
								geocode(data);
							}//function
							, "json"
					);//get
				} //click
				
				
				
				function geocode(jsonData) {
					let idx = 0;
					$.each(jsonData, function(index, vo) {
						let tmpLat;
						let tmpLng;
						$.get("https://maps.googleapis.com/maps/api/geocode/json"
								,{	key:'AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4'
									, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
								}
								, function(data, status) {
									//setMapOnAll(null);
									//delMarker();
									initMap();
									//alert(data.results[0].geometry.location.lat);
									tmpLat = data.results[0].geometry.location.lat;
									tmpLng = data.results[0].geometry.location.lng;
									$("#lat_"+index).text(tmpLat);
									$("#lng_"+index).text(tmpLng);
									addMarker(tmpLat, tmpLng, vo.aptName, vo.dong);
								}
								, "json"
						);//get
					});//each
				}
			
				</script>
				    <%-- 검색창 (inline form) --%>
					<select id="sido" name="region" class="form-control">
						<option value="0">선택</option>
					</select>
					<select id="gugun" name="dong" class="form-control dropdown dong">
						<option value="0">선택</option>
					</select>
					<select id="dong" name="dong" class="form-control dong">
						<option value="0">선택</option>
					</select>
					
					<input type="text" placeholder="아파트이름" id="aptName" name="aptName" class="form-control">
					<input type="button" id="aptNameBtn" class="form-control" value="검색" onclick="searchByName()">
				</section>
				<div id="map" class="map container-fluid"></div>
			</div>
		</div>
	</div>
	<!-- Footer-->
	<%-- <footer class="bg-light py-5">--%>
		<jsp:include page="common/bottombar.jsp"></jsp:include>
	<%-- </footer>--%>
	<!-- Third party plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
	
	<!-- Core theme JS-->

	<script src="js/scripts.js"></script>
</body>
</html>
