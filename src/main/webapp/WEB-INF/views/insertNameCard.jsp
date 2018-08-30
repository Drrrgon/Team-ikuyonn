<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.1/assets/owl.carousel.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.1/owl.carousel.min.js"></script>

<script type="text/javascript">
	$(function() {
		//메뉴 포커스
		$('.nav-item').children().eq(1).addClass('active');
		
		//썸네일리스트
		$('.carousel-main').owlCarousel({
			items: 5,
			loop: true,
			margin: 10,
			nav: true,
			dots: false,
			navText: ['<span class="fas fa-chevron-left fa-2x"></span>','<span class="fas fa-chevron-right fa-2x"></span>'],
		});
		
		//썸네일 클릭효과
		$('.owl-list').on('click',function(){
			var imgNumber = $(this).children('img').attr('src');
			var imgPt = /se.*[0-9]/gi;
			var imgNumber = imgPt.exec(imgNumber);
			$('.owl-list').removeClass('imgActive');
			$(this).addClass('imgActive');
			$('.leftNameCard').css('background','url(./resources/images/nameCard/namecard_'+imgNumber+'.jpg)');
			$('.leftNameCard').css('background-size','cover');
		});
		
		$('#row2').css('display','none');
		
		//드래그앤드롭 파일업로드
		var file = document.querySelector('#fileUplode');
		file.onchange = function() {
		    var fileList = file.files ;
		    
		    // 읽기
		    var reader = new FileReader();
		    reader.readAsDataURL(fileList [0]);
		    

		    //로드 한 후
		    reader.onload = function(e) {
		    	if ($("#fileUplode").val() != "") {
					var ext = $('#fileUplode').val().split('.').pop().toLowerCase();
					if ($.inArray(ext, [ 'gif', 'png', 'jpg','jpeg' ]) == -1) {
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
					processData : false,
					contentType : false,
					success : output,
					beforeSend : function() {
						$('#uploadBox').css('display','none');
						$('#imgIcon').css('display','block');
						$('#imgIcon>img').attr('src',e.target.result);
						console.log('로딩중...');
					},
					complete : function() {
						$('#row1').css('display','none');
						$('#row2').css('display','');
						console.log('완료');
					},
					error : function() {
						console.log('통신실패');
					}
				});
		    };
		};
		
		//명함등록
		$('#nameCardSubmit').on('click',function(){
			var ncCheck = '1';
			var ncName = $('#ncName').val();
			var ncMobile = $('#ncMobile').val();
			var ncPhone = $('#ncPhone').val();
			var ncFax = $('#ncFax').val();
			var ncEmail = $('#ncEmail').val();
			var ncCompany = $('#ncCompany').val();
			var ncDepartment = $('#ncDepartment').val();
			var ncTitle = $('#ncTitle').val();
			var ncWebsite = $('#ncWebsite').val();
			var ncAddress = $('#ncAddress').val();
			var imgPt = /re.*jpg/g;
			var backgroundUrl = imgPt.exec($('.leftNameCard').css('background'));		
			var nameCardUrl = './'+backgroundUrl;
			
			//체크체크
			if(ncName == ''){
				
			}
			
			$.ajax({
				url : "nameCardUplodeAction",
				type : "post",
				data : {
					'ncCheck' : ncCheck,
					'ncName' : ncName,
					'ncMobile' : ncMobile,
					'ncPhone' : ncPhone,
					'ncFax' : ncFax,
					'ncEmail' : ncEmail,
					'ncCompany' : ncCompany,
					'ncDepartment' : ncDepartment,
					'ncTitle' : ncTitle,
					'ncWebsite' : ncWebsite,
					'ncAddress' : ncAddress,
					'nameCardUrl' : nameCardUrl
				},
				success : function(data){
					console.log(data);
				},
				error : function() {
					console.log('통신실패');
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
			data = data.replace(mobileTest2, '');
			$('#ncMobile').val(phoneNumber);
			$('#mobile').text('M ' + phoneNumber);
			
			$('#ncMobile').keyup(function(){
				$("#mobile").text('M ' + $(this).val());
				if($("#ncMobile").val().length < 1){
					$("#mobile").text('');
				};
			});
			
			console.log('phone : ' + phoneNumber);
			console.log('data1 : ' + data);

			//팩스번호
			var faxNumberList = faxTest1.exec(data);
			var faxNumber = '';
			if (faxNumberList != null) {
				faxNumber = faxNumberList[1];
				data = data.replace(faxTest1, "");
				$('#ncFax').val(faxNumber);
				$('#fax').html('F ' + faxNumber);
			};
			
			$('#ncFax').keyup(function(){
				$("#fax").text('F ' + $(this).val());
				if($("#ncFax").val().length < 1){
					$("#fax").text('');
				}
			});
			
			console.log('faxNumber : ' + faxNumber);
			console.log('data2 : ' + data);

			//전화번호
			var tellNumber = tellTest1.exec(data);
			data = data.replace(tellTest2, '');
			if(tellNumber != null){
				$('#ncPhone').val(tellNumber);
				$('#phone').text('P ' + tellNumber);
			};
			
			$('#ncPhone').keyup(function(){
				$("#phone").text('P ' + $(this).val());
				if($("#ncPhone").val().length < 1){
					$("#phone").text('');
				}
			});
			
			console.log('tellNumber : ' + tellNumber);
			console.log('data3 : ' + data);

			//이메일
			var emailNumberList = emailTest1.exec(data);
			var emailNumber = '';
			if (emailNumberList != null) {
				emailNumber = emailNumberList[0];
				data = data.replace(emailTest2, "");
				$('#ncEmail').val(emailNumber);
				$('#email').html('E ' + emailNumber);
			};
			
			$('#ncEmail').keyup(function(){
				$("#email").text('E ' + $(this).val());
				if($("#ncEmail").val().length < 1){
					$("#email").text('');
				}
			});
			
			console.log('emailNumber : ' + emailNumber);
			console.log('data4 : ' + data);

			//주소
			var address = addressTest1.exec(data);
			data = data.replace(addressTest1, "");
			$('#ncAddress').val(address);
			$('#address').html(address);
			
			$('#ncAddress').keyup(function(){
				$("#address").text( $(this).val());
			});
			
			console.log('addressNumber : ' + address);
			console.log('data4 : ' + data);

			//홈페이지
			var website = webSiteTest1.exec(data);
			data = data.replace(webSiteTest1, "");
			$('#ncWebsite').val(website);
			$('#website').html(website);
			
			$('#ncWebsite').keyup(function(){
				$("#website").text( $(this).val());
			});
			
			console.log('addressNumber : ' + website);
			console.log('data5 : ' + data);

			//직책
			var title = positionTest1.exec(data);
			data = data.replace(positionTest1, "");
			$('#ncTitle').val(title);
			$('#title').html(title);
			
			$('#ncTitle').keyup(function(){
				$("#title").text( $(this).val());
			});
			
			console.log('positionNumber : ' + title);
			console.log('data6 : ' + data);

			//이름
			var name = userNameTest1.exec(data);
			data = data.replace(userNameTest1, "");
			$('#ncName').val(name);
			$('#name').html(name);
			
			$('#ncName').keyup(function(){
				$("#name").text( $(this).val());
			});
			
			console.log('userName : ' + name);
			console.log('data7 : ' + data);

			//회사명
			var company = /[0-9a-z가-힣].*/gi.exec(data);
			data = data.replace(/[0-9a-z가-힣].*/gi, "");
			$('#ncCompany').val(company);
			$('#company').html(company);
			
			$('#ncCompany').keyup(function(){
				$("#company").text( $(this).val());
			});
			
			console.log('companyName : ' + company);
			console.log('data8 : ' + data);
		};
	});
</script>
</head>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			<h3 class="page-title">명함등록</h3>
		</div>
	</div>
	<div class="row" id="row1">
		<div class="col-lg-12">
			<div class="card card-small mb-4">
				<div class="center col-md-8">
					<form action="fileUplodeAction" method="post" enctype="multipart/form-data" >
						<div id="uploadBox">
							<span>이미지를 드래그하거나 선택하세요.</span>
							<img id="image" alt="" src="">
							<input type="file" name="fileUplode" id="fileUplode" accept="img/*" multiple> 
						</div>
						<div id="imgIcon">
							<img src="">
							<div id="ajaxLoading">
								<img src="./resources/images/loading.gif">
							</div>
						</div>
					</form>
				</div>	
			</div>
		</div>
	</div>
	<div class="row" id="row2">
		<div class="col-lg-7">
			<div class="card card-small mb-4">
				<div class="carousel-wrap">
					<div class="owl-carousel carousel-main">
						<div class="owl-list imgActive">
							<img src="./resources/images/nameCard/sem1.jpg">
						</div>
						<div class="owl-list">
							<img src="./resources/images/nameCard/sem2.jpg">
						</div>
						<div class="owl-list">
							<img src="./resources/images/nameCard/sem3.jpg">
						</div>
						<div class="owl-list">
							<img src="./resources/images/nameCard/sem4.jpg">
						</div>
						<div class="owl-list">
							<img src="./resources/images/nameCard/sem5.jpg">
						</div>
						<div class="owl-list">
							<img src="./resources/images/nameCard/sem1.jpg">
						</div>
					</div>
				</div>
			</div>
			<div class="nameCardView">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;"></div>
				<div class="rightNameCard">
					<div class="r-wrap">
						<div id="r-t-wrap">
							<div>
								<span id="company"></span>
							</div>
							<div>
								<span id="website"></span>
							</div>
						</div>
						<div id="r-b-wrap">
							<div>
								<span id="name"></span>
								<span id="department"></span>
								<span id="title"></span>
							</div>
							<div>
								<span id="address"></span>
							</div>
							<div>
								<span id="email"></span>
							</div>
							<div>
								<span id="mobile"></span>
							</div>
							<div>
								<span id="phone"></span>
							</div>
							<div>
								<span id="fax"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-5">
			<div class="card card-small mb-4">
				<div class="col-md-12">
					<div id="formBox">
						<div class="form-group">
							<input class="form-control" type="text" id="ncName" name="ncName" placeholder="이름">
						</div>
						<div class="form-group">
							<input class="form-control" type="text" id="ncMobile" name="ncMobile" placeholder="휴대전화">
						</div>
						<div class="form-group">
							<input class="form-control" type="text" id="ncPhone" name="ncPhone" placeholder="직장전화">
						</div>
						<div class="form-group">
							<input class="form-control" type="text" id="ncFax" name="ncFax" placeholder="펙스번호">
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
						<div class="form-group">
							<button type="button" id="nameCardSubmit" class="btn btn-accent">등록</button>
							<button type="button" class="btn btn-accent cancel">취소</button>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>