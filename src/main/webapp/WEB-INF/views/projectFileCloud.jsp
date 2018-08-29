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

				<ul class="list-group list-group-flush">
					<li class="list-group-item p-3">
						<div class="row">
							<div class="col">
								<form action="fileUplodeAction" method="post" enctype="multipart/form-data" >
									<div>
										<input type="file" name="fileUplode" id="fileUplode"> 

									</div>
									<div>
										<input class="mb-2 btn btn-outline-primary mr-2" type="button" id="fileUplodeSubmit" value="택스트추출">

										<input type="button" id="fileUplodeSubmit" value="택스트추출">				

									</div>
								</form>

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
							<button type="button" class="btn btn-accent">등록</button>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
<script>
	$(function (){
		projectCloudInit();
	});

	function setLeftSideIcon(){
			$('#navbar').children().eq(0).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(1).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(2).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(3).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(4).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(5).children().eq(0).attr('class','nav-link ');
			$('#navbar').children().eq(5).children().eq(0).addClass('active');
	}
	function projectCloudInit(){
		console.log('pj init');
		setLeftSideIcon();
	}
</script>
</body>
</html>