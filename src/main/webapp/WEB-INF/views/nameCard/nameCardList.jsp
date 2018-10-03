<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div id="insertModal" class="modal">
	<div class="modal-content">
		<h4 class="modal-title">
			명함등록<span id="close1" class="close"></span>
		</h4>
		<div class="nameCardPlus">
			<div id="insertNameCard">
				<span>
					<i class="far fa-images"></i>
				</span>
				<span>컴퓨터에 있는 사진으로 명함을 등록할 수 있습니다.</span>
			</div>
			<div id="insertNameCard2">
				<span>
					<i class="far fa-edit"></i>
				</span>
				<span>사진없이 직접 입력하여 명함을 등록할 수 있습니다.</span>
			</div>
		</div>
	</div>
</div>
<div class="main-content-container container-fluid px-4">
	<div class="row">
		<div class=" col-lg-12">
			<div class="btn-group btn-group-toggle mt-4 mb-3"id="ebuttons" data-toggle="buttons">
				<label class="btn btn-white active"> 
					<input type="radio"name="options" value="2" autocomplete="off" checked="">전체
				</label> 
				<label class="btn btn-white"> 
					<input type="radio"name="options" value="1" autocomplete="off">회원
				</label> 
				<label class="btn btn-white"> 
					<input type="radio" name="options" value="0" autocomplete="off">비회원
				</label> 
			</div>
			<div class="namecardPlus mt-4">
				<a href="javascript:void(0);">
					<i class="fas fa-user-plus"></i>
				</a>
			</div>
		</div>
	</div>	
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
							<select class="form-control" id="selectGroup">
                                <option value="ncName" selected="">이름</option>
                                <option value="ncEmail">이메일</option>
                                <option value="ncCompany">회사명</option>
                        	</select>
                        	<button type="button" class="btn btn-sm btn-white" id="deleteList" style="display:none;">선택삭제</button>
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
							<div class="leftNameCard"></div>
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

<%@ include file="../parts/footer.jsp" %>
</body>
<script type="text/javascript">
function setLeftSideIcon() {
	$('#navbar').children().eq(0).children().eq(0).attr('class',
			'nav-link ');
	$('#navbar').children().eq(1).children().eq(0).attr('class',
			'nav-link ');
	$('#navbar').children().eq(2).children().eq(0).attr('class',
			'nav-link ');
	$('#navbar').children().eq(3).children().eq(0).attr('class',
			'nav-link ');
	$('#navbar').children().eq(1).children().eq(0).addClass('active');
}
	$(function(){
		init();	
		setLeftSideIcon();
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
		$('#nameCardTableWrap').html(''); 
		$('.pagingWrap').html(''); 
		$('.r-wrap').css('display',''); 
		$('#delete').removeClass('disabled');
		$('#update').removeClass('disabled');
		var line = '';
		
		if(nameCardList.length == 0){
			line += '<p style="text-align: center;margin-top: 5%;">데이터가 없습니다.<br>명함을추가하세요.</p>';
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
			
			$('.leftNameCard').removeAttr('style'); 
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
			line += '<a href="hrefMail?emailAddress='+datas.nameCardList[i].ncEmail+'">'+datas.nameCardList[i].ncEmail+'</a>';
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
			line += '<input type="checkbox" name="nameCardGroup" style="width: 20px;height: 20px;" value="'+i+'">';
			/* <button type="button" class="btn btn-sm btn-white">파트너요청</button> */
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
		
		$('input:checkbox[name=nameCardGroup]').change(checkBoxClick);
		$('.paging > li > a').click(pageMove);
		$('.nameCardTable').click(nameCardMove);
	};
	
	$('input:radio[name=options]').change(function(){
		var emailCheck = $('input:radio[name=options]:checked').val();
		if(emailCheck == 2){
			init();
		}else{
			$.ajax({
				url : 'selectNameCardList',
				data : {
					'emailCheck' : emailCheck
				},
				type : 'get',
				success : outPut
			});		
		};
	});

	function checkBoxClick(){
		$('#selectGroup').css('display','');
		$('#deleteList').css('display','none');	
		$('#update').removeAttr('disabled');
		$('#delete').removeAttr('disabled');
		var checkBoxGroup = $('input:checkbox[name=nameCardGroup]:checked').length;
		if(checkBoxGroup > 0){
			$('#selectGroup').css('display','none');
			$('#deleteList').css('display','');	
			$('#update').attr('disabled','true');
			$('#delete').attr('disabled','true');
		}
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
		var ncEmail = nameCard.ncEmail;
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				url : 'selectNameCardList',
				type : 'get',
				data : {
					'ncEmail' : ncEmail,
					'page' : page
				},
				success : outPut
			});
		} else {

		};
	});
	
	$('#deleteList').on('click',function(){
		var emails = [];
		jQuery.ajaxSettings.traditional = true;

		var page = $('.paging > .active > a').attr('page');
		var rows = $('input:checkbox[name=nameCardGroup]:checked');	
		for(var i = 0; i < rows.length; i++){
			emails.push(nameCardList[rows[i].value].ncEmail);
		};
	
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				url : 'selectNameCardList',
				type : 'get',
				data : {
					'emails' : emails,
					'page' : page
				},
				success : outPut
			});
		} else {

		};
	});
	
	$('#searchBtn').on('click',function(){
		var emailCheck = $('input:radio[name=options]:checked').val();
		var page = $('.paging > .active > a').attr('page');
		var type = $('.form-control option:selected').val();
		var searchText = $('#searchText').val();
		$.ajax({
			url : 'selectNameCardList',
			type : 'get',
			data : {
				'page' : page,
				'searchText' : searchText,
				'emailCheck' : emailCheck,
				'type' : type
			},
			success : function(a){
				console.log(a);
				outPut(a);
			}
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
	
	 //등록창 열기
	$(".namecardPlus").on('click',function(){
		$("#insertModal").show();
	});
	 
	//modal cancle button
    $(".close").on('click',function() {
    	$("#insertModal").css("display","none");
	});
	
	$('#insertNameCard').on('click',function(){
		location.href = 'insertNameCard';
	});
	
	$('#insertNameCard2').on('click',function(){
		location.href = 'insertNameCard2';
	});
</script>
</html>