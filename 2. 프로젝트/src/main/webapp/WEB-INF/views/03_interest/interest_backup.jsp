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

<script>
	var selected = null;
	$(document).ready(function() {
		
				//관심지역 리스트 보이기
				///interestarea/{id}/all
				$.get("/interestarea/${id}/all",function(data,status){
					$("#interestListView").empty();
					console.log("data: "+data);
					$.each(data,function(index,interest){
						let current_tag = $("<span>").attr("class","address m-4").appendTo("#interestListView");
						
						//관심지역 버튼
						$("<button>").attr("type","button")
									 .attr("class","btn btn-primary m-1 showBizInfo")
									 .attr("id",interest.dongName)
									 .text(interest.sidoName+" "+interest.gugunName+""+interest.dongName)
									 .appendTo(current_tag);
						
						// 이미지 태그
						let deleteImg = $("<img>")
										.attr("src","${root}/assets/img/delete_transparent.png")
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

				// 상가정보 api
				/* $.ajax({
						type:"GET",
						url:"http://apis.data.go.kr/B553077/api/open/sdsc/largeUpjongList?serviceKey=27q0dlxEWy1MC4qIUAzdHc5WMwJXbPRsZGiYjC4Agat9nZaM3W70ebOGbLmwvDBJHTdOT0ArTJ1EIAO%2Ff2M%2BTA%3D%3D",
						contentType : "application/json",
						dataType: 'xml',  // jsonp: cors정책 우회
						beforeSend:function(xhr){
							xhr.setRequestHeader("Access-Control-Allow-Origin", "*");
							xhr.setRequestHeader("Access-Control-Allow-Headers", "X-Requested-With");
							xhr.setRequestHeader('Ping-Other', 'pingpong');
							xhr.setRequestHeader('Content-Type', 'application/xml');
						},
						success:function (data){
							 //let myXML = data.responseText; // xml의 text 형식
						 	//	let JSON = $.xml2json(myXML); // convert format (xml to json)
				//
								console.log("data: "+data);
						}
					}); // get
				 */

				// 관심지역 주변 상가정보
				$(".showBizInfo").click(function() {
					selected = $(this).attr('id');
					$(".showBizInfo").css("background-color","#007bff").css("border-color","#007bff");
					$("#"+selected).css("background-color","#f39c12").css("border-color","#f39c12");
					showBizList(selected);
				});

				// 관심지역 삭제
				$(document).on("click",".interestBtn",function() {
					var text = $(this).prev().text();
					$("#deleteData").val(text);//전송데이터 설정
					$("#deleteInterest").modal();//삭제 확인 팝업창
				});

			});

	function addInterest() {
		const dongcode = $("#addDong option:selected").val();
		$.post("${root}/interestarea/"+dongcode, function(data, status) {
				//console.log("data: "+data);
				window.location.href = "${root}/interest.do";
			}
		, "json");//post
		//$("#addSidoName").val($("#addSido option:selected").text());
		//$("#addGugunName").val($("#addGugun option:selected").text());
		//$("#addDongName").val($("#addDong option:selected").text());
		//$("#addInterestForm").submit();
	}

	function deleteInterest() {
		$("#deleteInterestForm").submit();// deleteInterest.do로 form 전송
	}
	
	function showBizList(selected){
		console.log(selected == 0 ? ' ':selected);
		console.log($("#SmallStore").val() == 0 ? ' ':$("#SmallStore").val());
		$.get("${root}/biz/all", {
			dong_name : selected == 0 ? null:selected,
			small_code : $("#SmallStore").val() == 0 ? null:$("#SmallStore").val()
		}, function(data, status) {
			$("#searchResult").empty();
			$.each(data, function(index, vo) {
				console.log("vo: "+vo.biz_name);
				let str = "<tr class="+vo.biz_id+">"
				+ "<td>" + vo.biz_name+vo.branch_name+ "</td>"
				+ "<td>" + vo.std_name + "</td>"
				+ "<td>" + vo.dong_name + "</td>"
				+ "<td>" + vo.lng + "</td>"
				+ "<td>" + vo.lat
				+ "</td></tr>";
				$("#searchResult").append(str);
			});//each
			//geocode(data);
		}//function
		, "json");//get
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
			</div>
			
			<%-- side bar: 관심 지역 관리 --%>
			<div class="col-sm-9">
				<div id="interestListView">
				<button type='button' class='btn btn-primary m-3'>관심지역 없음</button>
			</div>
			<button type="button" class="btn loadData fw_6"
				data-toggle="modal" data-target="#addInfo">관심지역 추가</button>
			</div>
		</div>
	</div>
	<div class="form-group form-inline m-5">
		<div id="interestListView">
			<button type='button' class='btn btn-primary m-3'>관심지역 없음</button>
		</div>
		<button type="button" class="btn loadData fw_6"
			data-toggle="modal" data-target="#addInfo">관심지역 추가</button>
	</div>
	
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
				<th>위도</th>
				<th>경도</th>
			</tr>
		</thead>
		<tbody id="searchResult">
		</tbody>
	</table>
	
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
					<form id="deleteInterestForm" method="post"
						action="deleteInterest.do">
						<div class="form-group form-inline"
							style="display: inline-block; text-align: center; width: 400px;">
							<div class="form-group form-inline justify-content-between">
								<label for="preferLocation" style="width: 100%;">관심지역을
									삭제하시겠습니까?</label>
							</div>
						</div>
						<input type="hidden" name="interest" id="deleteData" />
					</form>
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