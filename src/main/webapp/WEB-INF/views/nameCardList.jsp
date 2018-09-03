<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<!-- meta -->
<%@ include file="parts/meta.jsp" %> 
<title>메이시</title>
<!-- header -->
<%@ include file="parts/header.jsp" %>
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/loadFirst-js.jsp" %>
</head>
<body class="h-100">
<!-- sidebar -->
<%@ include file="parts/sidebar.jsp" %>
<div class="main-content-container container-fluid px-4">
	<div class="page-header row no-gutters py-4">
		<div class="col-12 col-sm-4 text-center text-sm-left mb-0">
			<h3 class="page-title">명함첩</h3>
		</div>
	</div>	
	<a href="insertNameCard">사진으로 등록</a>
	<a href="insertNameCard2">직접 등록</a>
	<div class="row" >
		<div class="col-lg-4">
			<div class="card card-small mb-4">		
				<div class="card-header border-bottom">
					<div class="row" >
						<div class="input-group col-md-8">
							<input type="text" name="searchText" class="input-sm form-control" id="searchText">
							<div class="input-group-append">
								<button type="button" class="btn btn-sm btn-white" id="searchBtn">검색</button>								
							</div>
						</div>
						<div class="col-md-4" style="text-align: right;">
							<select class="form-control">
                                <option value="ncName" selected="">이름</option>
                                <option value="ncEmail">이메일</option>
                                <option value="ncCompany">회사명</option>
                        	</select>
						</div>
					</div>
				</div>
				<div class="card-body p-0" id="nameCardTableWrap">
					<!-- 명함리스트 -->
					
				</div>
				<div class="card-footer border-top">
					<div class="pagingWrap">
						<!-- 페이징 -->
			    	</div>
				</div>
			</div>	
		</div>
		<div class="col-lg-8">
			<div class="card card-small mb-4">		
				<div class="card-header border-bottom">
					<div class="debtn">
						<button type="button" class="btn btn-sm btn-white" id="update">수정</button>
						<button type="button" class="btn btn-sm btn-white" id="delete">삭제</button>
					</div>
				</div>
				<div class="card-body p-0" id="nameCardDeWrap">
					<!-- 명함디테일 -->
					<div class="col-lg-10" id="nameCardSum">
						<div class="nameCardView2">
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
				</div>
				<div class="card-footer border-top">
					<div class="nameCardDetail">
						<!-- 명함상세 -->
			    	</div>
				</div>
			</div>
		</div>	
	</div>
</div>
<%@ include file="parts/footer.jsp" %>
<script type="text/javascript">
	
	$(function(){
		init();	
	});

	function init(){
		$.ajax({
			url : 'selectNameCardList',
			type : 'get',
			success : outPut
		});	
	};
	
	var nameCardList;

	function outPut(datas){
		nameCardList = datas.nameCardList;
		console.log(datas);
		$('#nameCardTableWrap').html(''); 
		$('.pagingWrap').html(''); 
		$('.r-wrap').css('display',''); 
		$('#delete').removeClass('disabled');
		$('#update').removeClass('disabled');
		var line = '';
		
		if(nameCardList.length == 0){
			line += '<p style="text-align: center;">데이터가 없습니다.<br>명함을<a href="#">추가</a>하세요</p>';
			$("#nameCardTableWrap").append(line);	
			line = '';
			
			line += '<ul class="paging">';
			line += '<li class="asi">';
			line += '<a href="javascript:void(0)" page="">';
			line += '<i class="fas fa-angle-double-left"></i>';
			line += '</a>';
			line += '</li>';
			line += '<li class="asi">';
			line += '<a href="javascript:void(0)" page="">';
			line += '<i class="fas fa-angle-left"></i>';
			line += '</a>';
			line += '</li>';
			line +='<li>';
			line +='<a href="javascript:void(0)" page="1">1</a>';
			line +='</li>';
			line += '<li class="asi">';
			line += '<a href="javascript:void(0)" page="">';
			line += '<i class="fas fa-angle-right"></i>';
			line += '</a>';
			line += '</li>';
			line += '<li class="asi">';
			line += '<a href="javascript:void(0)" page="">';
			line += '<i class="fas fa-angle-double-right"></i>';
			line += '</a>';
			line += '</li>';
			line += '</ul>';			
			$('.pagingWrap').append(line);
			line = '';
			$('#delete').addClass('disabled');
			$('#update').addClass('disabled');
			$('.r-wrap').css('display','none'); 
			return;
		};
		
		for(var i in datas.nameCardList){
			if(i == 0){
				line += '<div class="nameCardTable active" data-rownum="'+i+'">';
			}else{
				line += '<div class="nameCardTable" data-rownum="'+i+'">';
			}
			line += '<div class="nec">';
			line += '<ul>';
			line += '<li>';
			line += '<span>'+datas.nameCardList[i].ncName+'</span>';
			line += '</li>';
			line += '<li>';
			line += '<span>'+datas.nameCardList[i].ncEmail+'</span>';
			line += '</li>';
			line += '<li>';
			if(datas.nameCardList[i].ncCompany == null){
				line += '<span>없음</span>';
			}else{
				line += '<span>'+datas.nameCardList[i].ncCompany+'</span>';
			};		
			line += '</li>';
			line += '</ul>';
			line += '</div>';
			line += '<div class="nbg">';
			line += '<div>';
			line += '<button type="button" class="btn btn-sm btn-white">파트너요청</button>';
			line += '</div>';
			line += '</div>';
			line += '</div>';
		};
		$('#nameCardTableWrap').append(line);
		line = '';
		$('.leftNameCard').attr('style','background:url('+datas.nameCardList[0].nameCardUrl+'); background-size: cover;');
		$('#company').text(datas.nameCardList[0].ncCompany);
		$('#website').text(datas.nameCardList[0].ncWebsite);
		$('#name').text(datas.nameCardList[0].ncName);
		$('#title').text(datas.nameCardList[0].ncTitle);
		$('#department').text(datas.nameCardList[0].ncDepartment);
		$('#address').text(datas.nameCardList[0].ncAddress);
		$('#email').text('E ' + datas.nameCardList[0].ncEmail);
		if(datas.nameCardList[0].ncMobile != null){
			$('#mobile').text('M ' + datas.nameCardList[0].ncMobile);
		};
		if(datas.nameCardList[0].ncPhone != null){
			$('#phone').text('P ' + datas.nameCardList[0].ncPhone);
		};
		if(datas.nameCardList[0].ncFax != null){
			$('#fax').text('F ' + datas.nameCardList[0].ncFax);
		};
			
		line += '<ul class="paging">';
		line += '<li class="asi">';
		line += '<a href="javascript:void(0)" page="'+datas.pageNavigator.startPageGroup+'">';
		line += '<i class="fas fa-angle-double-left"></i>';
		line += '</a>';
		line += '</li>';
		line += '<li class="asi">';
		line += '<a href="javascript:void(0)" page="'+(datas.pageNavigator.currentPage-1)+'">';
		line += '<i class="fas fa-angle-left"></i>';
		line += '</a>';
		line += '</li>';
		for(var i=datas.pageNavigator.startPageGroup; i<=datas.pageNavigator.endPageGroup; i++){
			if(i != datas.pageNavigator.currentPage){
				line +='<li>';
				line +='<a href="javascript:void(0)" page="'+i+'">'+i+'</a>';
				line +='</li>';
			}else{
				line +='<li class="active">';
				line +='<a href="javascript:void(0)" page="'+i+'">'+i+'</a>';
				line +='</li>';
			};
		};
		line += '<li class="asi">';
		line += '<a href="javascript:void(0)" page="'+(datas.pageNavigator.currentPage+1)+'">';
		line += '<i class="fas fa-angle-right"></i>';
		line += '</a>';
		line += '</li>';
		line += '<li class="asi">';
		line += '<a href="javascript:void(0)" page="'+datas.pageNavigator.endPageGroup+'">';
		line += '<i class="fas fa-angle-double-right"></i>';
		line += '</a>';
		line += '</li>';
		line += '</ul>';
		
		$('.pagingWrap').append(line);
		line = '';
		
		$('.paging > li > a').click(pageMove);
		$('.nameCardTable').click(nameCardMove);
	};
	
	function nameCardMove(){
		$('.nameCardTable').attr('class','nameCardTable');
		$(this).attr('class','nameCardTable active');
		var nameCard = nameCardList[$(this).attr('data-rownum')];
		
		$('.leftNameCard').attr('style','background:url('+nameCard.nameCardUrl+'); background-size: cover;');
		$('#company').text(nameCard.ncCompany);
		$('#website').text(nameCard.ncWebsite);
		$('#name').text(nameCard.ncName);
		$('#title').text(nameCard.ncTitle);
		$('#department').text(nameCard.ncDepartment);
		$('#address').text(nameCard.ncAddress);
		$('#email').text('E ' + nameCard.ncEmail);
		if(nameCard.ncMobile != null){
			$('#mobile').text('M ' + nameCard.ncMobile);
		};
		if(nameCard.ncPhone != null){
			$('#phone').text('P ' + nameCard.ncPhone);
		};
		if(nameCard.ncFax != null){
			$('#fax').text('F ' + nameCard.ncFax);
		};
	};
	
	$('#delete').on('click',function(){
		var nameCard = nameCardList[$('#nameCardTableWrap > .active').attr('data-rownum')];
		var page = $('.paging > .active > a').attr('page');
		var email = nameCard.ncEmail;
		console.log(email);
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				url : 'selectNameCardList',
				type : 'get',
				data : {
					'email' : email,
					'page' : page
				},
				success : outPut
			});
		} else {

		};
	});
	
	$('#searchBtn').on('click',function(){
		var page = $('.paging > .active > a').attr('page');
		var type = $('.form-control option:selected').val();
		console.log(type);
		var searchText = $('#searchText').val();
		console.log(searchText)
		$.ajax({
			url : 'selectNameCardList',
			type : 'get',
			data : {
				'page' : page,
				'searchText' : searchText,
				'type' : type
			},
			success : outPut
		});
	});
	
	$('#update').on('click',function(){
		var nameCard = nameCardList[$('#nameCardTableWrap > .active').attr('data-rownum')];
		var page = $('.paging > .active > a').attr('page');
		var email = nameCard.ncEmail;
		location.href = 'updateNameCard?ncEmail='+email;
	});
	
	function pageMove(){
		var page = $(this).attr("page");
		$.ajax({
			url : 'selectNameCardList',
			type : 'get',
			data : {
				'page' : page
			},
			success : outPut
		});
	};
	
	
</script>
</body>
</html>