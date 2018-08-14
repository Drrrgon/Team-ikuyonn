<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>메이시</title>
<meta name="description" content="A high-quality &amp; free Bootstrap admin dashboard template pack that comes with lots of templates and components.">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" id="main-stylesheet" data-version="1.0.0" href="./resources/styles/shards-dashboards.1.0.0.min.css">
<link rel="stylesheet" href="./resources/styles/extras.1.0.0.min.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
		 $('.nav-item').children().eq(1).addClass('active');
		 
			var test = 'safd 010-6474-6786'
			var phoneTest = /^(.*)01([0|1|6|7|8|9]?)(.*)([0-9]{3,4})(.*)([0-9]{4})$/;
				
				
			alert(phoneTest.test(test));
		 
		 
		 //사진업로드
		 $('#fileUplodeSubmit').on('click',function(){
				if( $("#fileUplode").val() != "" ){
					var ext = $('#fileUplode').val().split('.').pop().toLowerCase();
					if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
						alert('이미지파일만 업로드 할수 있습니다.');
						return false;
					};
				};
				
				var formData = new FormData();
				formData.append("fileUplode", $("input[name=fileUplode]")[0].files[0]);
				
				$.ajax({
					url : "fileUplodeAction",
					type : "post",
					data : formData,
					processData: false, 
					contentType: false,
					success : output,
					error : function() {
						alert("통신실패");
					}
				});
		 });
		 
		//읽어온 자료 input에 분류
		function output(data) {
			var dataList = data.split('\n');
			var phoneTest = /^(.*)01([0|1|6|7|8|9]?)([.|-]?)([0-9]{3,4})([.|-]?)([0-9]{4})$/;
			var phoneTest2 = /^01([0|1|6|7|8|9]?)([.|-]?)([0-9]{3,4})([.|-]?)([0-9]{4})$/;

			for(var i in dataList) {
				if(phoneTest.test(dataList[i])){
					
					alert(dataList[i].sprit(phoneTest2));
				};
			}; 
		};
	});
</script>
</head>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			
			<h3 class="page-title">명함만들기</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-4">
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0">사진등록</h6> 
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item p-3">
						<div class="row">
							<div class="col">
								<form action="fileUplodeAction" method="post" enctype="multipart/form-data" >
									<div>
										<input type="file" name="fileUplode" id="fileUplode"> 
										<input type="button" id="fileUplodeSubmit" value="택스트추출">				
									</div>
								</form>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-lg-8">
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0">명함정보</h6> 
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item p-3">
						<div class="row">
							<div class="col">
								<div>
									<h6>이름</h6>
									<input type="text" id="userName" name="userName">
								</div>
								<div>
									<h6>전화</h6>
									<select name="phoneCategory">
										<option value="휴대전화">휴대전화</option>
										<option value="직장전화">직장전화</option>
									</select> <input type="text" id="phoneNumber" name="phoneNumber">
								</div>
								<div>
									<h6>	</h6>
									<input type="text" id="email" name="email">
								</div>
								<div>
									<h6>회사</h6>
									<input type="text" id="companyName" name="companyName"
										placeholder="회사명"> <input type="text" id="department"
										name="department" placeholder="부서명"> <input
										type="text" id="position" name="position" placeholder="직책">
								</div>
								<div>
									<h6>웹사이트</h6>
									<input type="text" id="webSite" name="webSite">
								</div>
								<div>
									<h6>주소</h6>
									<input type="text" id="address" name="address">
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
<script src="./resources/scripts/extras.1.0.0.min.js"></script>
<script src="./resources/scripts/shards-dashboards.1.0.0.min.js"></script>
<script src="./resources/scripts/app/app-blog-overview.1.0.0.js"></script> -->
</body>
</html>