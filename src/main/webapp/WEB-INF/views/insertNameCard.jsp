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
<link rel="stylesheet" href="./resources/styles/custom.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
		$('.nav-item').children().eq(1).addClass('active');
		 
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
			var testdata = '\nf 02-4541-5481\nt 02-4541-5481\nPlatSys\nwww.platsys.net\n박지현대리\n경기도 용인시 수지구 신수로 767(동천동, 분당·수지U-TOWER) B동 1340호\nMobile 010-3806-8944\nE-mail asdfwsafe@naver.com';

			var mobileTest1 = /01[0-9][-|.|/\s/g]?[0-9]{3,4}[-|.|/\s/g]?[0-9]{4}.*/gi;	
			var mobileTest2 = /[m|p]?.*01[0-9][-|.|/\s/g]?[0-9]{3,4}[-|.|/\s/g]?[0-9]{4}.*/gi;	
			
			var faxTest1 = /f.*(\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{4}).*/gi;
			
			var tellTest1 = /\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{4}.*/gi;
			var tellTest2 = /t?.*\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{4}.*/gi;
			
			var emailTest1 = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}.*/gi;
			var emailTest2 = /e.*[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}.*/gi;
			
			var addressTest1 = /[가-힣]*[도|시].*[구|군].*[면|동].*/gi;
			
			var webSiteTest1 = /www.*[asia|info|name|mobi|com|net|org|biz|tel|xxx|kr|co|so|me|eu|cc|or|pe|ne|re|tv|jp|tw]/i;
			
			var positionTest1 = /[선임|주임|대리|과장|차장|부장|이사|상무|전무|부사장|사장|부회장|회장].*/gi;
			
			var userNameTest1 = /[가-힣]{2,4}/i;
			
			//휴대전화
			var phoneNumber = mobileTest1.exec(data);
			data = data.replace(mobileTest2, "");
			
			console.log('phone : ' + phoneNumber);
			console.log('data1 : ' + data);
			
			//팩스번호
			var faxNumberList = faxTest1.exec(data);
			var faxNumber = ''; 
			if(faxNumberList != null){
				faxNumber = faxNumberList[1];
				data = data.replace(faxTest1, "");
			};
			
			console.log('faxNumber : ' + faxNumber);
			console.log('data2 : ' + data);
			
			//전화번호
			var tellNumber = tellTest1.exec(data);
			data = data.replace(tellTest2, "");
			
			console.log('tellNumber : ' + tellNumber);
			console.log('data3 : ' + data);
			
			//이메일
			var emailNumberList = emailTest1.exec(data);
			var emailNumber = '';
			if(emailNumberList != null){
				emailNumber = emailNumberList[0];
				data = data.replace(emailTest2, "");
			};
			
			console.log('emailNumber : ' + emailNumber);
			console.log('data4 : ' + data);
			
			//주소
			var addressNumber = addressTest1.exec(data);
			data = data.replace(addressTest1, "");
			
			console.log('addressNumber : ' + addressNumber);
			console.log('data4 : ' + data);
			
			//홈페이지
			var webSiteNumber = webSiteTest1.exec(data);
			data = data.replace(webSiteTest1, "");
			
			console.log('addressNumber : ' + webSiteNumber);
			console.log('data5 : ' + data);
			
			//직책
			var positionNumber = positionTest1.exec(data);
			data = data.replace(positionTest1, "");
			
			console.log('positionNumber : ' + positionNumber);
			console.log('data6 : ' + data);
			
			userNameTest1
			
			//이름
			var userName = userNameTest1.exec(data);
			data = data.replace(userNameTest1, "");
			
			console.log('userName : ' + userName);
			console.log('data7 : ' + data);
			
			//회사명
			var companyName = /[0-9a-z가-힣].*/gi.exec(data);
			data = data.replace(/[0-9a-z가-힣].*/gi, "");
			
			console.log('companyName : ' + companyName);
			console.log('data8 : ' + data);
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
										<input class="mb-2 btn btn-outline-primary mr-2" type="button" id="fileUplodeSubmit" value="택스트추출">				
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
			asdfasdf
			</div>
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<strong class="text-muted d-block mb-2">명함정보</strong>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item p-3">
						<div class="row">
							<div class="col">
								<div class="form-group">
									<input class="form-control" type="text" id="ncName" name="ncName" placeholder="이름">
								</div>
								<div class="form-row">
									<div class="form-group col-md-4">
										<select class="form-control" name="phoneCategory">
											<option value="ncMobile">휴대전화</option>
											<option value="ncPhone">직장전화</option>
											<option value="ncFax">직장전화</option>
										</select> 
									</div>
									<div class="form-group col-md-8">	
										<input class="form-control" type="text" id="phoneNumber" name="phoneNumber">
									</div>
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="ncEmail" name="ncEmail" placeholder="이메일">
								</div>
								<div class="form-row">
									<div class="form-group col-md-4">
										<input class="form-control" type="text" id="ncCompany" name="ncCompany" placeholder="회사명"> 
									</div>
									<div class="form-group col-md-4">					
										<input class="form-control" type="text" id="ncDepartment"name="ncDepartment" placeholder="부서명"> 
									</div>
									<div class="form-group col-md-4">
										<input class="form-control" type="text" id="ncTitle" name="ncTitle" placeholder="직책">
									</div>
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="ncWebsite" name="ncWebsite" placeholder="웹사이트">
								</div>
								<div class="form-group">
									<input class="form-control" type="text" id="ncAddress" name="ncAddress" placeholder="주소">
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