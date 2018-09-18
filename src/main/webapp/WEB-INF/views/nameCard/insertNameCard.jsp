<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="../parts/meta.jsp" %> 
<title>메이시</title>
<!-- header -->
<%@ include file="../parts/header.jsp" %>
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp" %>
</head>
<body class="h-100">
<!-- sidebar -->
<%@ include file="../parts/sidebar.jsp" %>
<div class="main-content-container container-fluid px-4">
	<div class="row" id="row1">
		<div class="col-lg-12">
			<div class="card card-small mt-5">
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
	<div class="row mt-5" id="row2">
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
							<img src="./resources/images/nameCard/sem6.jpg">
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
							<label>이름</label>
							<input class="form-control" type="text" id="ncName" name="ncName" placeholder="이름">
						</div>
						<div class="form-group">
							<label>휴대전화</label>
							<input class="form-control" type="text" id="ncMobile" name="ncMobile" placeholder="휴대전화">
						</div>
						<div class="form-group">
							<label>직장정화</label>
							<input class="form-control" type="text" id="ncPhone" name="ncPhone" placeholder="직장전화">
						</div>
						<div class="form-group">
							<label>팩스번호</label>
							<input class="form-control" type="text" id="ncFax" name="ncFax" placeholder="팩스번호">
						</div>
						<div class="form-group">
							<label>이메일</label>
							<input class="form-control" type="text" id="ncEmail" name="ncEmail" placeholder="이메일">
						</div>
						<div class="form-row">
							<div class="form-group col-md-4">
								<label>회사명</label>
								<input class="form-control" type="text" id="ncCompany" name="ncCompany" placeholder="회사명"> 
							</div>
							<div class="form-group col-md-4">	
								<label>부서명</label>				
								<input class="form-control" type="text" id="ncDepartment"name="ncDepartment" placeholder="부서명"> 
							</div>
							<div class="form-group col-md-4">
								<label>직책</label>
								<input class="form-control" type="text" id="ncTitle" name="ncTitle" placeholder="직책">
							</div>
						</div>
						<div class="form-group">
							<label>웹사이트</label>
							<input class="form-control" type="text" id="ncWebsite" name="ncWebsite" placeholder="웹사이트">
						</div>
						<div class="form-group">
							<label>주소</label>
							<input class="form-control" type="text" id="ncAddress" name="ncAddress" placeholder="주소">
						</div>
						<div class="form-group">
							<button type="button" id="nameCardCancel" class="btn btn-default">취소</button>
							<button type="button" id="nameCardSubmit" class="btn btn-primary">등록</button>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/footer.jsp" %>
<script type="text/javascript">
	$(function() {
		//메뉴 포커스
		setLeftSideIcon();
		
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
		
		//이메일 등록 체크
		function emailCheck(){
			var ncEmail = $('#ncEmail').val();
			$.ajax({
				url : "selectNameCard",
				type : "post",
				data : {
					'ncEmail' : $('#ncEmail').val()
				},
				success : function(data){
					if(data == 1){
						$('#ncEmail').attr('class','form-control is-invalid');
					}else{
						$('#ncEmail').attr('class','form-control');
					}
				}
			});
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
			
			//유효성 이메일
			$.ajax({
				url : "selectNameCard",
				type : "post",
				data : {
					'ncEmail' : $('#ncEmail').val()
				},
				success : function(data){
					if(data == 1){
						alert('등록된 이메일 입니다.');
						$('#ncEmail').focus();
						return false;
					}else{
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
								location.href = 'nameCardList';
							}
						});
					}
				}
			});	
		});
		
		//취소버튼
		$('#nameCardCancel').on('click',function(){
			location.href = 'nameCardList';
		});
		
		//읽어온 자료 input에 분류
		function output(data) {
			
			var testdata = '\nf 02-4541-5481\nt 02-4541-5481\nPlatSys\nwww.platsys.net\n박지현대리\n경기도 용인시 수지구 신수로 767(동천동, 분당·수지U-TOWER) B동 1340호\nMobile 010-3806-8944\nE-mail asdfwsafe@naver.com';

			var mobileTest1 = /01[0-9][-|.|/\s/g]?[0-9]{3,4}[-|.|/\s/g]?[0-9]{3,4}/gi;
			var mobileTest2 = /[m|p]?.*01[0-9][-|.|/\s/g]?[0-9]{3,4}[-|.|/\s/g]?[0-9]{3,4}.*/gi;

			var faxTest1 = /f.*(\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{3,4}).*/gi;

			var tellTest1 = /\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{3,4}.*/gi;
			var tellTest2 = /t?.*\d{2,3}[-|.|/\s/g]?\d{3,4}[-|.|/\s/g]?\d{3,4}.*/gi;

			var emailTest1 = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}.*/gi;
			var emailTest2 = /e?.*[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}.*/gi;

			var addressTest1 = /[0-9가-힣].*[울|도|시].*[구|군].*[면|동|로].*/gi;

			var webSiteTest1 = /www.*[asia|info|name|mobi|com|net|org|biz|tel|xxx|kr|co|so|me|eu|cc|or|pe|ne|re|tv|jp|tw]/i;

			var positionTest1 = /[선|주|대|과|차|부|이|상|전|부|사|부|회|디][임|리|장|사|무|회|자][장|이]{0,1}[너]{0,1}/g;
			
			var DepartmentTest1 = /[가-힣]*[팀|부|서|실|계|과]/g;
			
			var userNameTest1 = /[가-힣]{2,4}/i;

			//휴대전화
			var ncMobile = mobileTest1.exec(data);
			data = data.replace(mobileTest2, '');
			$('#ncMobile').val(ncMobile);
			$('#mobile').text('M ' + ncMobile);
			
			$('#ncMobile').keyup(function(){
				$("#mobile").text('M ' + $(this).val());
				if($("#ncMobile").val().length < 1){
					$("#mobile").text('');
				};
			});
			
			console.log('ncMobile : ' + ncMobile);
			console.log('data1 : ' + data);

			//팩스번호
			var ncFaxList = faxTest1.exec(data);
			var ncFax = '';
			if (ncFaxList != null) {
				ncFax = ncFaxList[1];
				data = data.replace(faxTest1, "");
				$('#ncFax').val(ncFax);
				$('#fax').text('F ' + ncFax);
			};
			
			$('#ncFax').keyup(function(){
				$("#fax").text('F ' + $(this).val());
				if($("#ncFax").val().length < 1){
					$("#fax").text('');
				}
			});
			
			console.log('ncFax : ' + ncFax);
			console.log('data2 : ' + data);

			//전화번호
			var ncPhone = tellTest1.exec(data);
			data = data.replace(tellTest2, '');
			if(ncPhone != null){
				$('#ncPhone').val(ncPhone);
				$('#phone').text('P ' + ncPhone);
			};
			
			$('#ncPhone').keyup(function(){
				$("#phone").text('P ' + $(this).val());
				if($("#ncPhone").val().length < 1){
					$("#phone").text('');
				}
			});
			
			console.log('ncPhone : ' + ncPhone);
			console.log('data3 : ' + data);

			//이메일
			var ncEmailList = emailTest1.exec(data);
			var ncEmail = '';
			if (ncEmailList != null) {
				ncEmail = ncEmailList[0];
				data = data.replace(emailTest2, "");
				$('#ncEmail').val(ncEmail);
				$('#email').text('E ' + ncEmail);
			};
			
			$('#ncEmail').keyup(function(){
				$("#email").text('E ' + $(this).val());
				if($("#ncEmail").val().length < 1){
					$("#email").text('');
				}
			});
			
			console.log('ncEmail : ' + ncEmail);
			console.log('data4 : ' + data);

			//주소
			var ncAddress = addressTest1.exec(data);
			data = data.replace(addressTest1, "");
			$('#ncAddress').val(ncAddress);
			$('#address').text(ncAddress);
			
			$('#ncAddress').keyup(function(){
				$("#address").text( $(this).val());
			});
			
			console.log('ncAddress : ' + ncAddress);
			console.log('data4 : ' + data);

			//홈페이지
			var ncWebsite = webSiteTest1.exec(data);
			data = data.replace(webSiteTest1, "");
			$('#ncWebsite').val(ncWebsite);
			$('#website').text(ncWebsite);
			
			$('#ncWebsite').keyup(function(){
				$("#website").text( $(this).val());
			});
			
			console.log('ncWebsite : ' + ncWebsite);
			console.log('data5 : ' + data);

			//직책
			var ncTitle = positionTest1.exec(data);
			data = data.replace(positionTest1, "");
			$('#ncTitle').val(ncTitle);
			$('#title').text(ncTitle);
			
			$('#ncTitle').keyup(function(){
				$("#title").text( $(this).val());
			});
			
			console.log('ncTitle : ' + ncTitle);
			console.log('data6 : ' + data);
			
			//부서
			var ncDepartment = DepartmentTest1.exec(data);
			data = data.replace(DepartmentTest1, "");
			if(ncDepartment != null){
				$('#ncDepartment').val(ncDepartment);
				$('#department').text(ncDepartment + ' | ');
			}	
			
			$('#ncDepartment').keyup(function(){
				$("#department").text($(this).val() + ' | ');
				if($("#ncDepartment").val().length < 1){
					$("#department").text('');
				}
			});
			
			console.log('ncDepartment : ' + ncDepartment);
			console.log('data7 : ' + data);
			
			//이름
			var ncName = userNameTest1.exec(data);
			data = data.replace(userNameTest1, "");
			$('#ncName').val(ncName);
			$('#name').text(ncName);
			
			$('#ncName').keyup(function(){
				$("#name").text( $(this).val());
			});
			
			console.log('userName : ' + name);
			console.log('data8 : ' + data);

			//회사명
			var company = /[0-9a-z가-힣].*/gi.exec(data);
			data = data.replace(/[0-9a-z가-힣].*/gi, "");
			$('#ncCompany').val(company);
			$('#company').html(company);
			
			$('#ncCompany').keyup(function(){
				$("#company").text( $(this).val());
			});
			
			console.log('companyName : ' + company);
			console.log('data9 : ' + data);
			
			emailCheck();
			$('#ncEmail').keyup(emailCheck);
		};
		
		function setLeftSideIcon(){
			$('#navbar').children().eq(0).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(1).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(2).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(3).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(4).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(5).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(1).children().eq(0).addClass('active');
		}
	});
</script>
</body>
</html>