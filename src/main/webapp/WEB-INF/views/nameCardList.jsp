<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript">
	$(function(){
		load();
	});
	
	function load(){
		$.ajax({
			url : 'selectNameCardList',
			type : 'post',
			success : outPut
		});
	};
	
	function outPut(datas){
		$('.row').html('');
		var menubar = '';
		
		if(datas.length == 0){
			menubar += '<p>데이터가 없습니다.</p>';
			$('.row').append(menubar);	
			
			return;
		};
		
		for(var i in datas){
			menubar += '<div style="float: left;margin: 0 25px;">';
			menubar += '<div>';
			menubar += '<a href="detailNote?noteNum='+datas[i].noteNum+'"><img src="'+datas[i].titleImg+'" style="width:125px;"></a>';
			menubar += '</div>';
			menubar += '<div>';
			menubar += '<span>'+datas[i].noteName+'</span>';
			menubar += '</div>';
			menubar += '<div>';
			menubar += '<a class="deb" href="" noteNum='+datas[i].noteNum+'>삭제 </a>';
			menubar += '<a href="insertPage?noteNum='+datas[i].noteNum+'">페이지추가</a>';
			menubar += '</div>';
			menubar += '</div>';
		};
		
		$('.card-body').append(menubar);
		$('.deb').click(deletecheck);
	};
</script>
</head>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			<h3 class="page-title">명함함</h3>
		</div>
	</div>	
	<div class="row" >
		<div class="col-lg-3">
			<div class="nameCardView2">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;">
				</div>
				<div class="rightNameCard">
				</div>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="nameCardView2">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;">
				</div>
				<div class="rightNameCard">
				</div>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="nameCardView2">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;">
				</div>
				<div class="rightNameCard">
				</div>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="nameCardView2">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;">
				</div>
				<div class="rightNameCard">
				</div>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="nameCardView2">
				<div class="leftNameCard" style="background:url(./resources/images/nameCard/namecard_sem1.jpg); background-size: cover;">
				</div>
				<div class="rightNameCard">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>