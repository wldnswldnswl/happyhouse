<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style>
.category {
	margin-right: 20px;
}

.title{
	font-family: "Merriweather Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
    font-weight: 700;
    color: #212529;
}

</style>
<meta charset="UTF-8">
<title>관심지역</title>
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
	var selected = null;
	$(document).ready(function() {
		
				// 전체 상권 정보 조회
				showBizList(null);
		
				// map 변수
				var map;
				var multi = {lat: 37.5665734, lng: 126.978179};
				initMap(map,multi);
				
				//관심지역 리스트 보이기
				///interestarea/{id}/all
				$.get("/interestarea/${id}/all",function(data,status){
					$("#interestListView").empty();
					console.log("data: "+data);
					$.each(data,function(index,interest){
						let current_tag = $("<div>").attr("class","text-center").appendTo("#interestListView");
						
						//관심지역 버튼
						$("<button>").attr("type","button")
									 .attr("class","btn btn-primary m-1 showBizInfo")
									 .attr("id",interest.dongCode)
									 .css("width","250px")
									 .text(interest.sidoName+" "+interest.gugunName+""+interest.dongName)
									 .appendTo(current_tag);
						
						// 이미지 태그
						let deleteImg = $("<img>")
										.attr("src","${root}/assets/img/delete.png")
						 			 	.attr("alt","deleteImage")
						 			 	.attr("class","btnImages")
						 			 	.css("width","38px");
						
						// 관심지역 삭제 버튼
						$("<button>").attr("type","button")
						 			 .attr("class","interestBtn")
						 			 .css("border","none")
						 			 .append(deleteImg)
						 			 .appendTo(current_tag);
					})
				});

				$.get("${root}/biz/large", function(data, status) {
					$.each(data, function(index, vo) {
						$("#BigStore").append(
								"<option value='"+vo.largeCode+"'>"
										+ vo.largeName + "</option>");
					});//each
				}//function
				, "json");//get

				$("#BigStore").change(
						function() {
							$.get("${root}/biz/mid", {
								large_code : $("#BigStore").val()
							}, function(data, status) {
								$("#MidStore").empty();
								$("#MidStore").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#MidStore")
											.append(
													"<option value='"+vo.midCode+"'>"
															+ vo.midName
															+ "</option>");
								});//each
							}//function
							, "json");//get
						});//change

				$("#MidStore").change(
						function() {
							$.get("${root}/biz/small", {
								mid_code : $("#MidStore").val()
							}, function(data, status) {
								$("#SmallStore").empty();
								$("#SmallStore").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									console.log("vo: " + vo.smallName);
									$("#SmallStore").append(
											"<option value='"+vo.smallCode+"'>"
													+ vo.smallName
													+ "</option>");
								});//each
							}//function
							, "json");//get
						});//change
				$("#SmallStore").change(function() {
					showBizList(selected);
				});//change

				// 관심지역 주변 상가정보
				$(document).on("click",".showBizInfo",function() {
					selected = $(this).attr('id');
					$(".showBizInfo").css("background-color","#b5aca3").css("border-color","#b5aca3");
					$("#"+selected).css("background-color","#f4623a").css("border-color","#f4623a");
					showBizList(selected);
				});

				// 관심지역 삭제
				$(document).on("click",".interestBtn",function() {
					var id = $(this).prev().attr("id");
					$("#deleteData").val(id);// 파라미터: 삭제할 지역의 동코드
					$("#deleteInterest").modal();//삭제 확인 팝업창
				});

	});

	function addInterest() {
		const dongcode = $("#addDong option:selected").val();
		$.post("${root}/interestarea/"+dongcode, function(data, status) {
				window.location.href = "${root}/interest.do";
			}
		, "json");//post
		//$("#addSidoName").val($("#addSido option:selected").text());
		//$("#addGugunName").val($("#addGugun option:selected").text());
		//$("#addDongName").val($("#addDong option:selected").text());
		//$("#addInterestForm").submit();
	}

	// 관심지역 삭제 action 
	function deleteInterest() {
		$.ajax({
		    url : "${root}/interestarea/"+$("#deleteData").val(),
		    type : "delete",
		    success: function(result) {
				console.log(result);
		    	window.location.href = "${root}/interest.do";
		    }
		});
	}
	
	function showBizList(selected){
		$.get("${root}/biz/all", {
			dong_code : selected == 0 ? null:selected,
			small_code : $("#SmallStore").val() == 0 ? null:$("#SmallStore").val()
		}, function(data, status) {
			$("#searchResult").empty();
			$.each(data, function(index, vo) {
				console.log("vo: "+vo.biz_name);
				let str = "<tr class="+vo.biz_id+">"
				+ "<td>" + vo.biz_name+vo.branch_name+ "</td>"
				+ "<td>" + vo.std_name + "</td>"
				+ "<td>" + vo.dong_name + "</td>"
				<%--+ "<td>" + vo.lng + "</td>"
				+ "<td>" + vo.lat +"</td>" --%>
				+ "</tr>";
				$("#searchResult").append(str);
			});//each
			console.log("bizList: ",data);
			geocode(data);//지도에 마킹
		}//function
		, "json");//get
	}
	
	
	//map관련
	function initMap(map,multi) {
		map = new google.maps.Map(document.getElementById('map'), {
				center : multi,
				zoom : 12
			});
		var marker = new google.maps.Marker({
					 position : multi,
					 map : map
			});
	}
	
	function setMapCenter(lat,lng){	
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
		});
		marker.setMap(map);
	}
	
	function geocode(jsonData) {
			let idx = 0;
			if(jsonData.length==0) //예외 처리
				setMapCenter(37.5665734,126.978179);
			else{
				var tmpLat = Number(jsonData[0].lat);
				var tmpLng = Number(jsonData[0].lng);
		
				setMapCenter(tmpLat,tmpLng);
				
				$.each(jsonData,function(index, vo){
					let lat = vo.lat;
					let lng = vo.lng;

					$.get("https://maps.googleapis.com/maps/api/geocode/json"
							,{	key:'AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4'
								, address:vo.biz_name+vo.branch_name
							}
							, function(data, status) {
								$("#lat_"+index).text(lat);
								$("#lng_"+index).text(lng);
								addMarker(lat, lng, vo.biz_name+vo.branch_name, vo.std_name);
							}
							, "json"
					);//get
				});
			}
	}
</script>
</head>
<body>
	<header class="masthead"></header>
	<jsp:include page="../common/topbar.jsp"></jsp:include>
	<div class="container-fluid" style="margin-top: 50px">
		<div class="row" style="height: 900px;">
			<%-- article:  상권 정보 조회 --%>
			<div class="col-sm-9">
					<div class="form-group form-inline m-3">
						<div class="category">
							<select type="button" class="form-control m-3" id="BigStore"
								style="width: 100%">
								<option value="0">대분류</option>
							</select>
						</div>
						<div class="category">
							<select type="button" class="form-control m-3" id="MidStore"
								style="width: 100%">
								<option value="0">중분류</option>
							</select>
						</div>
						<div class="category">
							<select type="button" class="form-control m-3" id="SmallStore"
								style="width: 100%">
								<option value="0">소분류</option>
							</select>
						</div>
					</div>
				
					<table id="resultTable"
						class="table table-bordered table-hover text-center">
						<thead>
							<tr>
								<th>상호명</th> <!--  상호명 + 지점명 -->
								<th>업종</th>
								<th>위치</th> 
								<%-- <th>위도</th>
								<th>경도</th>--%>
							</tr>
						</thead>
						<tbody id="searchResult">
						</tbody>
					</table>
					
					<div id="map" class="map container-fluid"></div>
			</div>
			
			<%-- side bar: 관심 지역 관리 --%>
			<div class="col-sm-3">
				<h3>관심지역</h3>
				<div id="interestListView">
					<button type='button' class='btn btn-primary m-3'>관심지역 없음</button>
				</div>
				<div class="text-center">
					<button type="button" class="btn loadData fw_6 m-1"
					data-toggle="modal" data-target="#addInfo">+</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="addInfo">
		<div class="modal-dialog" style="position: relative;">
			<div class="modal-content" style="width: fit-content;">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">관심지역 추가</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="addInterestForm" method="post" action="insertInterest.do">
						<div class="form-group form-inline"
							style="display: inline-block; text-align: center;">
							<div class="form-group form-inline justify-content-between">
								<label for="preferLocation">관심지역</label> <select id="addSido"
									class="form-control sido" name="sido">
									<option selected value="">선택</option>
								</select> <select id="addGugun" class="form-control gugun" name="gugun">
									<option selected value="">선택</option>
								</select> <select id="addDong" class="form-control dong" name="dong">
									<option selected value="">선택</option>
								</select>
							</div>
						</div>
						<input type="hidden" name="sidoName" id="addSidoName" /> 
						<input type="hidden" name="gugunName" id="addGugunName" /> 
						<input type="hidden" name="dongName" id="addDongName" />
						<!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer"
					style="display: inline-block; text-align: center;">
					<button type="button" class="center-block btn btn-warning"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onClick="addInterest();">확인</button>
				</div>

			</div>
		</div>
	</div>



	<div class="modal" id="deleteInterest">
		<div class="modal-dialog" style="position: relative; width: 500px;">
			<div class="modal-content" style="width: fit-content;">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">관심지역 삭제</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
						<div class="form-group form-inline"
							style="display: inline-block; text-align: center; width: 400px;">
							<div class="form-group form-inline justify-content-between">
								<label for="preferLocation" style="width: 100%;">관심지역을
									삭제하시겠습니까?</label>
							</div>
						</div>
						<input type="hidden" name="interest" id="deleteData" />
				</div>

				<!-- Modal footer -->
				<div class="modal-footer"
					style="display: inline-block; text-align: center;">
					<button type="button" class="center-block btn btn-warning"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onClick="deleteInterest();">확인</button>
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
