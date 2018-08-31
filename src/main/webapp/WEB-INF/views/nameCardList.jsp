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
<link rel="stylesheet" href="./resources/mail/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="./resources/mail/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script type="text/javascript">
	$(function(){
		init();
	});
	
	var i;
	var t;
	
	function init(i,t){
		console.log(i+' '+t);
		$.ajax({
			url : 'selectNameCardList',
			type : 'get',
			data : {
				'page' : i,
				'searchText' : t
			},
			success : outPut
		});
	};
	
	function outPut(datas){
		console.log(datas.nameCardList[0].ncName);
		console.log(datas.pageNavigator.countPerPage);
		$('#nameCardTable').html(''); 
		var line = '';
		
		if(datas.length == 0){
			line += '<p>데이터가 없습니다.</p>';
			$("#nameCardTable").append(line);				
			return;
		};
		
		for(var i in datas.nameCardList){
			if(i != datas.nameCardList.length-1){
				line += '<div style="padding: 10px;border-bottom: 1px solid #eef0f4;">';
			}else{
				line += '<div style="padding: 10px;">';
			};	
			line += '<span>'+datas.nameCardList[i].ncName+'</span><br>';
			line += '<span>'+datas.nameCardList[i].ncEmail+'</span><br>';
			line += '<span>'+datas.nameCardList[i].ncCompany+'</span><br>';
			line += '</div>';
		};
		$('#nameCardTable').append(line);
		line = '';
		
		console.log(datas.pageNavigator.startPageGroup+'  '+datas.pageNavigator.endPageGroup)
		for(var i=datas.pageNavigator.startPageGroup; i<=datas.pageNavigator.endPageGroup; i++){
			if(i != datas.pageNavigator.currentGroup){
				line += '<a href="" onclick="init('+i+','+datas.pageNavigator.searchText+')">'+i+'</a>';
			}else{
				line += '<a href="" onclick="init('+i+','+datas.pageNavigator.searchText+')" style="color:#f00;">'+i+'</a>';
			};
		};
		$('.card-footer').append(line);
		line = '';
		
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
		<div class="col-lg-4">
			<div class="card card-small">		
				<div class="card-header border-bottom">
					<div class="row" >
						<div class="input-group col-md-8">
							<input type="text" name="searchText" class="input-sm form-control" id="searchText">
							<div class="input-group-append">
								<button type="button" class="btn btn-sm btn-white">검색</button>								
							</div>
						</div>
						<div class="col-md-4">
							<select id="inputState" class="form-control">
								<option selected="">Choose</option>
								<option>...</option>
                        	</select>
						</div>
					</div>
				</div>
				<div class="card-body p-0" id="nameCardTable">
					
				</div>
				<div class="card-footer border-top">
					
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>