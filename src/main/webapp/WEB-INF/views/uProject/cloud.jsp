<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="../parts/meta.jsp"%>
<title>메이시</title>
<!-- header -->
<%@ include file="../parts/header.jsp"%>
<link rel="stylesheet" href="./resources/mail/jquery.dataTables.min.css">
<style>
#file {
	width: 0;
	height: 0;
	opacity: 0;
	position: relative;
}

#cloudBody {
	display: none;
}

.td {
	width: 70;
}

.projectAddBtnTd {
	text-align: right;
}

div.aa:hover {
	background-color: #e6e6e6;
}

div#create_project_div {
	display: none;
}

.page1 {
	width: 50%;
	float: left;
}

.page2 {
	width: 50%;
	float: left;
}

.inline {
	display: flow-root;
}

.createbtn {
	float: right;
}

.projectHeader {
	display: inline;
	cursor: pointer;
	margin: 20px;
}

.all_project_div {
	display: none;
}
/* 탭페이지 */
div.hidden {
	display: none;
}

body {
	margin: 0;
	padding: 0;
	font-size: 14px;
}

#top, #calendar.fc-unthemed {
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}

#top {
	background: #eee;
	border-bottom: 1px solid #ddd;
	padding: 0 10px;
	line-height: 40px;
	font-size: 12px;
	color: #000;
}

#top .selector {
	display: inline-block;
	margin-right: 10px;
}

#top select {
	font: inherit; /* mock what Boostrap does, don't compete  */
}

.left {
	float: left
}

.right {
	float: right
}

.clear {
	clear: both
}

#calendar {
	max-width: 900px;
	margin: 40px auto;
	padding: 0 10px;
}

.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1070; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    margin-top: 10%;
    padding: 20px;
    border: 1px solid #888;
    width: 50%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
    color: #aaa;
    float: right;
    font-size: 21px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

</style>
<link href='./resources/styles/fullcalendar.min.css' rel='stylesheet' />
<link href='./resources/styles/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='./resources/styles/scheduler.min.css' rel='stylesheet' />
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp"%>
</head>
<!-- <html>
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>메이시</title>
<meta name="description"
	content="A high-quality &amp; free Bootstrap admin dashboard template pack that comes with lots of templates and components.">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" id="main-stylesheet" data-version="1.0.0"
	href="./resources/styles/shards-dashboards.1.0.0.min.css">
<link rel="stylesheet" href="./resources/styles/extras.1.0.0.min.css">
<script async defer src="https://buttons.github.io/buttons.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/styles/custom.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.1/assets/owl.carousel.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.1/owl.carousel.min.js"></script> -->

<body class="h-100">
	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp"%>


	<input type="hidden" value="${sessionScope.userID}" id="userID" />
	<div class="main-content-container container-fluid px-4">
		<div class="row mt-5">
			<div id="joinedProjectDiv" class="col">
				<div class="card card-small mb-4">
					<div class="card-header border-bottom">
						<h6 id="joinedProjectListHeader" class="projectHeader m-0">참여중인
							프로젝트</h6>
						&nbsp;&nbsp;&nbsp;
						<h6 id="allProjectListHeader" class="projectHeader m-0">전체
							프로젝트</h6>
					</div>
					<div id="joinedProjectList" class="card-body p-0 pb-3 text-center">

					</div>
					<div id="allProjectList" class="card-body p-0 pb-3 text-center">
					</div>
				</div>

				<div id="cloudDiv" class="card card-small mb-4 hidden"
					display="none">
					<div class="card-header border-bottom">
						<div class="btn-group btn-group-toggle mb-3" id="ebuttons"
							data-toggle="buttons">
							<label class="btn btn-white active"> <input type="radio"
								name="options" value="1" autocomplete="off" checked="">일정
							</label> <label class="btn btn-white"> <input type="radio"
								name="options" value="2" autocomplete="off">클라우드
							</label>
						</div>
						<div id="proName"></div>
						<div class="hidden" id="cloudTab">
							<div align="right">
								<form id="FILE_FORM" method="post" enctype="multipart/form-data"
									action="">
									<input type='file' id='file' name='file' />
								</form>
								<button type="button" class="btn btn-white" id="upload">파일
									등록</button>
								<button type="button" class="btn btn-white" id="delete">삭&nbsp;제</button>
							</div>


							<div>
								<div class="card-body p-0 pb-3 text-center" id="cloudBody">
									
									<input type="hidden" value="" id="proSeq" />
									<table class="table mb-0" id="fileTable">
										
									</table>
								</div>
							</div>
						</div>
					</div>
					<div id="scheduleTab">
					<div id='calendar'></div>

				</div>

				<div>
					<a><button id="modifyProjectBtn" class="btn btn-accent">프로젝트관리</button></a>
				</div>
			</div>
			<div id="create_project_div" class="col">
				<div class="inline card card-large mb-4">
					<div class="card-header border-bottom">
						<h6 class="m-0">프로젝트 생성</h6>
					</div>
					<div class="page1">
						<div class="card-header border-bottom">
							<div class="row">
								<div class="input-group col-md-8">
									<input type="text" name="searchText"
										class="input-sm form-control" id="searchText"
										onkeyup="searchfunc()" placeholder="검색"> <select
										class="form-control" id="selectGroup">
										<option value="0" selected="">이름</option>
										<option value="1" style="backgroun: red">이메일</option>
										<option value="2">회사명</option>
									</select>
								</div>
								<div class="col-md-4" style="text-align: right;">
									<button type="button" class="btn btn-sm btn-white"
										id="setAddress">선택</button>
								</div>
							</div>
						</div>
						<div class="card-body p-0" style="overflow: scroll"
							id="nameCardTableWrap">
							<!-- 명함리스트 -->

						</div>
					</div>
					<div class="page2">
						<input type="text" id="inputProjectName" class="form-control"
							placeholder="Project Name"><br /> <input type="date"
							id="inputProjectDate" class="form-control"><br />
						<button id="createProjectBtn" class="createbtn btn btn-accent">생성</button>
						<button id="backBtn" class="createbtn btn btn-accent">뒤로가기</button>
					</div>
				</div>
			</div>
			<!-- <div id="all_project_div" class="col">
			<div class="inline card card-large mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0">프로젝트 리스트</h6>
				</div> 
				<div class="page1">userList</div>
				<div class="page2">
					<input type="text" id="inputProjectName" class="form-control" placeholder="Project Name"><br/>
					<input type="date" id="inputProjectDate" class="form-control"><br/>
					<button id="createProjectBtn" class="createbtn btn btn-accent">생성</button>
					<button id="backBtn" class="createbtn btn btn-accent">뒤로가기</button>
				</div> 
			</div>
		</div> -->
		</div>
	</div>
	</div>
<!--  일정 관련 모달  -->	
<div id="insertModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정을 입력해주세요<span id="close1" class="close"></span></h4>
    <form id="insertForm">
    	<!-- <span>기간 반복</span><input type="radio" id="repeatTerm" name="repeatCode" value="repeatTerm">
    	<span>매일 반복</span><input type="radio" id="repeatDaily" name="repeatCode" value="repeatDaily"> -->
		<input type="hidden" id="projectSeq1" name="projectSeq1"/>
		<label>제목</label><input type="text" id="summary1" name="summary1" /><br />
		<label>내용</label><input type="text" id="description1" name="description1"/><br />

		<br/><span>색깔지정</span>
		<button class="jscolor {valueElement:null,value:'66ccff'}" style="width:50px; height:20px;" id="color1">
		</button><br/>

		<!-- <select name='color1' id='color1'></select>색깔 지정&nbsp;<br> -->

		<label>시작</label><input type="hidden" id="startDate1" name="startDate1"/>
    	<select name='year1' id='year1' onChange='setDate()'></select>년&nbsp;
    	<select name='month1' id='month1' onChange='setDate()'></select>월&nbsp;
    	<select name='day1' id='day1'></select>일&nbsp;
		<select name='hour1' id='hour1'></select>시&nbsp;
		<select name='minute1' id='minute1'></select>분&nbsp;<br>           
		<label>마감</label><input type="hidden" id="endDate2" name="endDate2"/>
    	<select name='year2' id='year2' onChange='setDate()'></select>년&nbsp;
    	<select name='month2' id='month2' onChange='setDate()'></select>월&nbsp;
    	<select name='day2' id='day2'></select>일&nbsp;
		<select name='hour2' id='hour2'></select>시&nbsp;
		<select name='minute2' id='minute2'></select>분&nbsp; 
	</form>
	<button type="button" id="insertEvents" onclick="location.reload()">일정 입력</button>
	<button type="button" id="cancelButton1">취소</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정입니다<span id="close3" class="close"></span></h4>
    <form id="eventDetail">
    <label>제목</label><input type="text" id="summary3" name="summary3"/><br/>
	<label>내용</label><input type="text" id="description3" name="description3"/><br/>
	<br/><span>색깔지정</span>
	<button class="jscolor {valueElement:null, value:'66ccff'}" style="width:50px; height:20px;" id="color3">
	</button><br/>
	<label>시작</label><input type="hidden" id="startDate3" name="startDate3"/>
	<select name="year3" id="year3" onChange="setDate()"></select>년&nbsp;
	<select name="month3" id="month3" onChange="setDate()"></select>월&nbsp;
	<select name="day3" id="day3"></select>일&nbsp;
	<select name="hour3" id="hour3"></select>시&nbsp;
	<select name="minute3" id="minute3"></select>분&nbsp;
	<label>마감</label><input type="hidden" id="endDate4" name="endDate4" value=""/>
	<select name="year4" id="year4" onChange="setDate()"></select>년&nbsp;
	<select name="month4" id="month4" onChange="setDate()"></select>월&nbsp;
	<select name="day4" id="day4"></select>일&nbsp;
	<select name="hour4" id="hour4"></select>시&nbsp;
	<select name="minute4" id="minute4"></select>분&nbsp;
	<input data-uno="updateEvents" type="button" id="updateEvents" value="수정"/>
	<input data-dno="deleteEvents" type="button" id="deleteEvents" value="삭제"/>
    </form>
    
	<button type="button" id="cancelButton3">취소</button>
</div>
</div>
	
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
	<script src="./resources/scripts/extras.1.0.0.min.js"></script>
<script src='./resources/scripts/moment.min.js'></script>
<script src='./resources/scripts/fullcalendar.min.js'></script>
<script src='./resources/scripts/scheduler.min.js'></script>
<script src='./resources/scripts/theme-chooser.js'></script>
<script src="./resources/js/jscolor.js"></script>
	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="../parts/footer.jsp"%>
</body>
<script>
	var checkJoinedP;
	function setLeftSideIcon() {
		$('#navbar').children().eq(0).children().eq(0).attr('class',
				'nav-link ');
		$('#navbar').children().eq(1).children().eq(0).attr('class',
				'nav-link ');
		$('#navbar').children().eq(2).children().eq(0).attr('class',
				'nav-link ');
		$('#navbar').children().eq(3).children().eq(0).attr('class',
				'nav-link ');
		$('#navbar').children().eq(3).children().eq(0).addClass('active');
	}
	function getJoinedProject() {
		var userID = $("#userID").val();
		$.ajax({
			url : "getProjectInfo",
			type : "post",
			data : {
				"userID" : userID
			},
			success : function(data) {
				initJoinedProjectList();
				printJoinedProjectList(data);
			},
			error : function() {
				alert("통신실패");
			}
		});
	}
	
	function openInputForm() {
		$('#create_project_div').css('display', 'block');
		$('#joinedProjectDiv').css('display', 'none');

	}
	// function createProject() {
	// 	var projectName = $('#inputProjectName').val();
	// 	var due = $('#inputProjectDate').val();
	// 	if (projectName.length == 0) {
	// 		alert('프로젝트 명을 입력해 주세요!');
	// 		$('#inputProjectName').focus();
	// 		$('#inputProjectName').select();
	// 		return false;
	// 	}
	// 	if (projectName.length > 15) {
	// 		alert('프로젝트 명을 15자 이하로입력해 주세요!');
	// 		$('#inputProjectName').focus();
	// 		$('#inputProjectName').select();
	// 		return false;
	// 	}
	// }
		function getAllProject(){
			$.ajax({
				url : "getProjectInfo",
				type : "post",
				success : function(data) {
					initAllProjectList();
					printAllProjectList(data);
				},
				error : function() {
					alert("통신실패");
				}
			});
		}
		function openInputForm(){
			$('#create_project_div').css('display', 'block');
			$('#joinedProjectDiv').css('display', 'none');
			namecardload();	
		}
		function createProject(){
			var projectName = $('#inputProjectName').val();
			var due = $('#inputProjectDate').val();
			
			//이메일로 아이디 검색 by 민석
			jQuery.ajaxSettings.traditional = true;
			var emails = [];
			var emailCheck = $('input:checkbox[name=nameCardGroup]:checked');
			if(emailCheck == null){
				alert('프로젝트 참가자를 선택해 주세요.');
				return false;
			};
			for(var i = 0; i < emailCheck.length; i++){
				emails.push(emailCheck[i].value);
				console.log(emails);
			};

			if(projectName.length == 0){
				alert('프로젝트 명을 입력해 주세요!');
				$('#inputProjectName').focus();
				$('#inputProjectName').select();
				return false;
			}
			if(projectName.length > 15){
				alert('프로젝트 명을 15자 이하로입력해 주세요!');
				$('#inputProjectName').focus();
				$('#inputProjectName').select();
				return false;
			}
			
			var sessionID = "${sessionScope.userID}";
			$.ajax({
				url: 'createProject',
				type: 'post',
				data: {
					'userID': sessionID, 'projectName': projectName, 'due':due, 'emails' : emails
				},
				success: function(list){
					getJoinedProject();
					$('#inputProjectName').val('');
					closeCreateProject();
				}
			});
			
			
    	}
		function closeCreateProject(){
		$('#create_project_div').css('display', 'none');
		$('#joinedProjectDiv').css('display', 'block');
	}
	function checkJoinedProject(allProjectList, temp) {
		var userID = '${sessionScope.userID}';
		
				$.ajax({
					url : 'getProjectInfo',
					type : 'post',
					data : {
						'userID' : userID
					},
					sync:false,
					success : function(joinedProjectList) {
						for (let i = 0; i < joinedProjectList.length; i++) {

					for (var j = 0; j < allProjectList.length; j++) {
						console.log(allProjectList[j]);
						console.log(allProjectList[i].projectName);
						if (allProjectList[j] == joinedProjectList[i].projectName) {
							temp += '<td><button class="secessionProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">탈퇴</button></td>';
							console.log('1');
							$("#allTbody").append(temp);
							return;
						} else {
							temp += '<td><button class="joinProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">참가</button></td>';
							console.log('2');
							$("#allTbody").append(temp);
							return;
						}
					}
				}

			}
		});

	}
	/* function printJoinedProjectList(joinedProjectList) {
		var userID = "${sessionScope.userID}"
		var temp = "";
		for ( var i in joinedProjectList) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + joinedProjectList[i].projectName + "</td>";
			temp += "<td>" + joinedProjectList[i].due + "</td>";
			temp += "<td>" + joinedProjectList[i].memberNum + "</td>";
			temp += "<td><button data-seq='"+joinedProjectList[i].projectSeq+"' onclick='fileList("
					+ joinedProjectList[i].projectSeq
					+","+i+")'>열기</button></td></tr>";
		}

	} */
	function printJoinedProjectList(joinedProjectList){
		var userID = "${sessionScope.userID}"
		var temp = "";
		for ( var i in joinedProjectList) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + joinedProjectList[i].projectName + "</td>";
			temp += "<td>" + joinedProjectList[i].due + "</td>";
			temp += "<td>" + joinedProjectList[i].memberNum + "</td>";
			temp += "<td><button data-seq='"+joinedProjectList[i].projectSeq+"' onclick='fileList("
					+ joinedProjectList[i].projectSeq
					+","+i+")'>열기</button></td></tr>";
		}
		temp += '<tr><td class="projectAddBtnTd" colspan="4"></td>';
		temp +='<td><button id="openInputFormBtn" class="btn btn-accent"><i class="zmdi zmdi-plus"></i></button></td>';
							
		$("#joinedTbody").append(temp);
		$('#openInputFormBtn').on('click', openInputForm);
	}
	function initJoinedProjectList(){
		$('#joinedProjectList').text('');
		var printHtml ='<table class="table mb-0">';
		printHtml += '<thead class="bg-light">';
		printHtml += '<tr>';
		printHtml += '<th scope="col" class="border-0">#</th>';
		printHtml += '<th scope="col" class="border-0">프로젝트 명</th>';
		printHtml += '<th scope="col" class="border-0">기간</th>';
		printHtml += '<th scope="col" class="border-0">참여인원</th>';
		printHtml += '</tr>';
		printHtml += '</thead>';
		printHtml += '<tbody id="joinedTbody">';
		printHtml += '</tbody>';
		printHtml += '</table>';
		$('#joinedProjectList').html(printHtml);		
	}
	function printAllProjectList(allProjectList) {
		var temp = "";
		var userID = '${sessionScope.userID}';
		var joinedProjectList = [];
				$.ajax({
					url : 'getProjectInfo',
					type : 'post',
					data : {
						'userID' : userID
					},
					async:false,
					success : function(list) {
						joinedProjectList =  list;
					}
				});
		console.log(joinedProjectList);
		console.log(allProjectList);
		for (let i = 0; i < allProjectList.length; i++) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + allProjectList[i].projectName + "</td>";
			temp += "<td>" + allProjectList[i].due + "</td>";
			temp += "<td>" + allProjectList[i].memberNum + "</td>";
			if (userID == allProjectList[i].projectMaster) {
				temp += '<td><button class="deleteProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">삭제</button></td>';
			} else {
				for (let j = 0; j < joinedProjectList.length; j++) {
					if(allProjectList[i].projectMaster == joinedProjectList[j].projectMaster){
						temp += '<td><button class="joinProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">참가</button></td>';
						console.log('2');
					}
					
				}
			}

		}
		temp += '<tr><td class="projectAddBtnTd" colspan="4"></td>';
		$("#allTbody").append(temp);
		$('.deleteProjectBtn').on('click', deleteProject);
		$('.joinProjectBtn').on('click', joinProject);
		$('.secessionProjectBtn').on('click', secessionProject);
		// $('#openInputFormBtn').on('click', openInputForm);
	}
	function joinProject() {

	}
	function secessionProject() {

	}
	function deleteProject() {
		var sessionID = "${sessionScope.userID}";
		var projectSeq = $(this).attr('data-project-seq');
		console.log(projectSeq);
		var flag = confirm('정말로 삭제하시겠습니까?');
		if (flag) {
			$.ajax({
				url : 'deleteProject',
				type : 'post',
				data : {
					'userID' : sessionID,
					'projectSeq' : projectSeq
				},
				success : function(allProjectList) {
					initAllProjectList();
					printAllProjectList(allProjectList);
				}
			});
		}
	};
	function initAllProjectList() {
		// $.ajax({
		// 	url: 'getProjectInfo',
		// 	type: 'post',
		// 	success: 

		// });
		$('#allProjectList').text('');
		var printHtml = '<table class="table mb-0">';
		printHtml += '<thead class="bg-light">';
		printHtml += '<tr>';
		printHtml += '<th scope="col" class="border-0">#</th>';
		printHtml += '<th scope="col" class="border-0">프로젝트 명</th>';
		printHtml += '<th scope="col" class="border-0">기간</th>';
		printHtml += '<th scope="col" class="border-0">참여인원</th>';
		printHtml += '</tr>';
		printHtml += '</thead>';
		printHtml += '<tbody id="allTbody">';
		printHtml += '</tbody>';
		printHtml += '</table>';
		$('#allProjectList').html(printHtml);
	}
	function fileList(projectSeq,i) {
		$("#cloudDiv").css("display","block");
		var pName= $("#joinedTbody").children().eq(i).children().eq(1).html();
		$("#proName").html(pName);
		var temp = document.getElementById("cloudBody");
		temp.style.display = "block";
		$("#proSeq").val(projectSeq);
		$.ajax({
			url : "fileList",
			data : {
				"projectSeq" : projectSeq
			},
			type : 'POST',
			success : function(result) {
				makeFile(result);
			},
			error : function() {
				alert("통신실패");
			}
		});
		
		document.getElementById("projectSeq1").value = projectSeq;
		
		initThemeChooser;
	}
	function btnFunction() {
		$('#createProjectBtn').on('click', createProject);
		$('#modifyProjectBtn').on("click", openProjectWindow);
		$('#backBtn').on('click', closeCreateProject);
		$('#joinedProjectListHeader').on('click', function() {
			$('#allProjectList').css('display', 'none');
			$('#joinedProjectList').css('display', 'block');
			$('#cloudDiv').css('display', 'block');
		});
		$('#allProjectListHeader').on('click', function() {
			$('#allProjectList').css('display', 'block');
			$('#joinedProjectList').css('display', 'none');
			$('#cloudDiv').css('display', 'none');
			getAllProject();
		});
	}
	$(function() {
		btnFunction();
		setLeftSideIcon();
		getJoinedProject();

		$('input:radio[name=options]').change(function(){
			var tab = $('input:radio[name=options]:checked').val();
			if(tab==1){
				$("#cloudTab").addClass('hidden');
				$("#scheduleTab").removeClass('hidden');
			}else{
				$("#scheduleTab").addClass('hidden');
				$("#cloudTab").removeClass('hidden');
			}
		});
		
		var projectSeq = "";
		$("#upload").click(function(e) {
			e.preventDefault();
			$("#file").click();
		});

		$("#delete").click(function() {
			$.ajax({
				url : "delFile",
				data : {
					"fileSeq" : $("#delSeq").val(),
					"proSeq" : $("#proSeq").val()
				},
				type : 'POST',
				success : function(result) {
					makeFile(result);
				},
				error : function() {
					alert("통신실패");
				}
			});
		});
	});

		$("#file").change(function() {
			var formData = new FormData();
			formData.append("file", $("#file")[0].files[0]);
			formData.append("proSeq", $("#proSeq").val());
			if ($("#file")[0].files[0] != null) {
				$.ajax({
					url : "addFile",
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						makeFile(result);
					},
					error : function() {
						alert("통신실패");
					}
				});
			}
		});

	function openProjectWindow() {
		var projectWindow = window
				.open(
						"openProjectInfo",
						"WindowName",
						"width=460, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no");
		projectWindow.resizeTo(460, 800);
		projectWindow.resizeBy(-10, -10);

		projectWindow.focus();
	};

	function makeFile(result) {
		var temp = "<tr><input type='hidden' value='' id='delSeq'/>"
		for ( var i in result) {
			if (i != 0 && i % 6 == 0) {
				temp += "</tr><tr>"
			}
			temp += "<td width='10px' style='word-break:break-all' onclick='select("
					+ i
					+ ","
					+ result[i].fileSeq
					+ ")'><div class='aa'><img src='./resources/images/fileIcon/"+result[i].fileType+".jpg' height='42' width='42' onerror=\"this.src='./resources/images/fileIcon/ccc.jpg'\"><br />"
			temp += "<a href='downFile?fileSeq=" + result[i].fileSeq + "'>"
					+ result[i].fileName + "</a></div></td>"
		}

		$("#fileTable").html(temp);
	}
		function select(i,fileSeq){
			$('.aa').css('background-color','');
			$(".aa").eq(i).css('background-color','#e6e6e6');
			$("#delSeq").val(fileSeq);
		}
		
		function downFile(fileSeq) {
			$.ajax({
				url : "downFile",
				type : "post",
				data : {
					"fileSeq" : fileSeq
				},
				success : function(result) {
					alert("success");
				},
				error : function() {
					alert("통신실패");
				}
			});
		}
		
		/* 네임카드리스트(회원만) 가져오기 by 민석 */
		function namecardload() {
			var emailCheck = 1;
			$.ajax({
				url : 'getMember',
				data : {
					'emailCheck' : emailCheck
				},
				type : 'post',
				success : namecardOutput,
				error : function(){
					alert("통신 실패");
				}
			});
		};
		
		/* 네임카드리스트(회원만) 출력 by 민석 */
		var nameCardList;
		function namecardOutput(datas) {
			var line = '';
			nameCardList = datas;
			for ( var i in datas) {
				line += '<div class="nameCardTable" id="nct'+i+'">';
				line += '<div class="nec">';
				line += '<ul>';
				line += '<li>';
				line += '<span>' + datas[i].ncName + '</span>';
				line += '</li>';
				line += '<li>';
				line += '<span>' + datas[i].ncEmail + '</span>';
				line += '</li>';
				line += '<li>';
				if (datas[i].ncCompany == null) {
					line += '<span>없음</span>';
				} else {
					line += '<span>' + datas[i].ncCompany + '</span>';
				}
				;
				line += '</li>';
				line += '</ul>';
				line += '</div>';
				line += '<div class="nbg">';
				line += '<div>';
				line += '<input type="checkbox" name="nameCardGroup" style="width: 20px;height: 20px;" value="'+datas[i].ncEmail+'">';
				line += '</div>';
				line += '</div>';
				line += '</div>';
			}
			;
			$('#nameCardTableWrap').append(line);
			
			$('.nameCardTable').click(nameCardMove);
		};
		
		//네임카드 항목이동 by 민석
		function nameCardMove(){
			$('.nameCardTable').attr('class','nameCardTable');
			$(this).attr('class','nameCardTable active');	
		};
		
		$('#searchBtn').on('click',function(){
			var emailCheck = $('input:radio[name=options]:checked').val();
			console.log(emailCheck);
			var page = $('.paging > .active > a').attr('page');
			var type = $('.form-control option:selected').val();
			console.log(type);
			var searchText = $('#searchText').val();
			console.log(searchText)
			$.ajax({
				url : 'selectNameCardList',
				type : 'get',
				data : {
					'searchText' : searchText,
					'emailCheck' : emailCheck,
					'type' : type
				},
				success : outPut
			});
		});

		
		//테이블 검색
		function searchfunc(){
		  	var input, filter, table, nec, span, i,j;
		  	input = document.getElementById("searchText");
		  	filter = input.value.toUpperCase();
		  	table = document.getElementById("nameCardTable");
		  	nec = document.getElementsByClassName("nec");
		  	for (i = 0; i < nec.length; i++) {
		  		span = nec[i].getElementsByTagName("span");
		  		var index = $("#selectGroup").val();
		  		     if (span[index].innerHTML.toUpperCase().indexOf(filter) > -1) {
		  		    	$('#nameCardTableWrap').children().eq(i).css("display", "block");
		  		     } else {
		  		    	$('#nameCardTableWrap').children().eq(i).css("display", "none");
		  		     }
			};
		}
	
		initThemeChooser({			
			init : function(themeSystem) {
		        $('#calendar').fullCalendar({
					themeSystem : themeSystem,
					lang : 'ko',
					eventStartEditable : false, // enable draggable events
					eventDurationEditable : true,
					aspectRatio : 1.8,
					scrollTime : '00:00', // undo default 6am scrollTime
					header : {
						left : 'today prev,next',
						center : 'title',
						right : 'month,agendaWeek,timelineDay,listWeek'
					},
					defaultView : 'month',
					events : function(start, end, timezone, callback){
						var events = [];
						var projectSeq = $('#projectSeq1').val();
						$.ajax({
							type : 'post',
							url : 'projectEventsList',
							data : {
								'projectSeq' : projectSeq
							},
							success : function(data) {				
								$(data).each(function(index, item) {	
									events.push({
										id : item.projectSeq,
										title : item.summary,
										start : item.startDate,
										end : item.endDate,
										num : item.eventSeq,
										color : item.color
									});
								});
								callback(events);
							},
							error : function() {
								alert("수신실패");
							}
						});
					},
					dayClick : function(date, jsEvent, view){
						var dateC = date.format();
						var yearC = dateC.substring(0, 4);
						var monthC = dateC.substring(5, 7);
						var dayC = dateC.substring(8, 10);
						if(monthC<10)
							monthC = dateC.substring(6, 7);
						if(dayC<10)
							dayC = dateC.substring(9, 10);
						
						var modal = document.getElementById('insertModal');
						var span = document.getElementById('close1');
						var cancel = document.getElementById('cancelButton1');
						
						modal.style.display = 'block';
						
						span.onclick = function() {
							$('#summary1').val('');
					    	$('#startDate1').val('');
					    	$('#endDate2').val('');
							modal.style.display = 'none';
						}
						
						cancel.onclick = function() {
							$('#summary1').val('');
					    	$('#startDate1').val('');
					    	$('#endDate2').val('');
							modal.style.display = 'none';
						}
						
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#summary1').val('');
						    	$('#startDate1').val('');
						    	$('#endDate2').val('');
						        modal.style.display = 'none';
						    }
						}
						
						var insertForm = document.getElementById('insertForm');
						
							    var year = yearC;
							    var month = monthC;
							    var day = dayC;
							    var hour = new Date().getHours();
							    var minute = new Date().getMinutes();
							    var color = $('#color1').val();
							    
							    var startYear = year - 80;
							    for(var i=0; i<100; i++) {
							    	insertForm['year1'].options[i] = new Option(startYear+i, startYear+i);
							    	insertForm['year2'].options[i] = new Option(startYear+i, startYear+i);
							    }

							    for (var i=0; i<12; i++) {
							    	insertForm['month1'].options[i] = new Option(i+1, i+1);
							    	insertForm['month2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    for (var i=0; i<24; i++) {
							    	insertForm['hour1'].options[i] = new Option(i+1, i+1);
							    	insertForm['hour2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    for (var i=0; i<60; i++) {
							    	insertForm['minute1'].options[i] = new Option(i+1, i+1);
							    	insertForm['minute2'].options[i] = new Option(i+1, i+1);
							    }
							    
							    insertForm['year1'].value = year;
							    insertForm['year2'].value = year;
							    insertForm['month1'].value = month;
							    insertForm['month2'].value = month;
							    setDate();
							    insertForm['day1'].value = day;
							    setDate();
							    insertForm['day2'].value = day;
							    insertForm['hour1'].value = hour;
							    insertForm['hour2'].value = hour;
							    insertForm['minute1'].value = minute;
							    insertForm['minute2'].value = minute;
						
				 		function setDate() {
							var insertForm = document.getElementById('insertForm');
							
							var year = insertForm['year1'].value;
						    var month = insertForm['month1'].value;
						    var day = insertForm['day1'].value;
						    var dayInsert1 = insertForm['day1'];
						    var dayInsert2 = insertForm['day2'];
						    
						    var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

						    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
						        arrayMonth[1] = 29;
						    }

						    for(var i = dayInsert1.length; i>0; i--) {
						    	dayInsert1.remove(dayInsert1.selectedIndex);
						    }
						        
						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsert1.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsert1.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsert1.options.selectedIndex = day-1;
						        }
						    }
						    
						    for(var i = dayInsert2.length; i>0; i--) {
						    	dayInsert2.remove(dayInsert2.selectedIndex);
						    }
						        
						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsert2.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsert2.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsert2.options.selectedIndex = day-1;
						        }
						    }
					}
					},
					eventClick : function(event, jsEvent, view){
						var eventSeq = event.num;
						
						$.ajax({
							type : 'post',
							url : 'oneEvents',
							data : {
								'eventSeq' : eventSeq
							},
							success : function(data) {
								var newStart = new Date(data.startDate);
								var newEnd = new Date(data.endDate);
					
								$("#summary3").val(data.summary);
								$("#description3").val(data.description);
								$("#startDate3").val(newStart);
								$("#year3").val(startYear);
								$("#endDate4").val(newEnd);
								$("#updateEvents").attr('data-uno', data.eventSeq);
								$("#deleteEvents").attr('data-dno', data.eventSeq);
									
								var eventDetail = document.getElementById('eventDetail');
								var startDate3 = new Date(document.getElementById('startDate3').value);
								var endDate4 = new Date(document.getElementById('endDate4').value);
								var year = new Date().getFullYear();
								var year3 = startDate3.getFullYear();
								var month3 = startDate3.getMonth() + 1;
								var day3 = startDate3.getDate();
								var hour3 = startDate3.getHours();
								var minute3 = startDate3.getMinutes();
								var year4 = endDate4.getFullYear();
								var month4 = endDate4.getMonth() + 1;
								var day4 = endDate4.getDate();
								var hour4 = endDate4.getHours();
								var minute4 = endDate4.getMinutes();
									    
								var startYear = year - 80;
								for(var i=0; i<100; i++) {
									eventDetail['year3'].options[i] = new Option(startYear+i, startYear+i);
									eventDetail['year4'].options[i] = new Option(startYear+i, startYear+i);
								}

								for (var i=0; i<12; i++) {
									 eventDetail['month3'].options[i] = new Option(i+1, i+1);
									 eventDetail['month4'].options[i] = new Option(i+1, i+1);
								}
									    
								for (var i=0; i<24; i++) {
									 eventDetail['hour3'].options[i] = new Option(i+1, i+1);
									 eventDetail['hour4'].options[i] = new Option(i+1, i+1);
								}
									    
								for (var i=0; i<60; i++) {
									 eventDetail['minute3'].options[i] = new Option(i+1, i+1);
									 eventDetail['minute4'].options[i] = new Option(i+1, i+1);
								}
								
								setDate0();
								eventDetail['year3'].value = year3;
								setDate0();
								eventDetail['year4'].value = year4;
								setDate0();
								eventDetail['month3'].value = month3;
								setDate0();
								eventDetail['month4'].value = month4;
								setDate0();
								eventDetail['day3'].value = day3;
								setDate0();
								eventDetail['day4'].value = day4;
								eventDetail['hour3'].value = hour3;
								eventDetail['hour4'].value = hour4;
								eventDetail['minute3'].value = minute3;
								eventDetail['minute4'].value = minute4;

								function setDate0() {
									var eventDetail = document.getElementById('eventDetail');
										
									var year = eventDetail['year3'].value;
									var month = eventDetail['month3'].value;
									var day = eventDetail['day3'].value;
									var dayInsert3 = eventDetail['day3'];
									var dayInsert4 = eventDetail['day4'];
									    
									var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

									if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
									   arrayMonth[1] = 29;
									}
									
									for(var i = dayInsert3.length; i>0; i--) {
								    	dayInsert3.remove(dayInsert3.selectedIndex);
								    }
								        
								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayInsert3.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayInsert3.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayInsert3.options.selectedIndex = day-1;
								        }
								    }
								    
								    for(var i = dayInsert4.length; i>0; i--) {
								    	dayInsert4.remove(dayInsert4.selectedIndex);
								    }
								        
								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayInsert4.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayInsert4.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayInsert4.options.selectedIndex = day-1;
								        }
								    }
								}

							},
							error : function() {
								alert("수신실패");
							}
						});
						
						var modal = document.getElementById('eventModal');
						var span = document.getElementById('close3');
						var cancel = document.getElementById('cancelButton3');
						
						// When the user clicks on the button, open the modal 
						modal.style.display = 'block';
						

						span.onclick = function() {
							modal.style.display = 'none';
						}
						
						cancel.onclick = function() {
							$('#summary3').val('');
					    	$('#startDate3').val('');
					    	$('#endDate4').val('');
							modal.style.display = 'none';
						}
						
							// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#summary3').val('');
						    	$('#startDate3').val('');
						    	$('#endDate4').val('');
						        modal.style.display = 'none';
						    }
						}
					}
				});
			},

			change : function(themeSystem) {
				$('#calendar').fullCalendar('option', 'themeSystem', themeSystem);
			}
		});
		
		$('#insertEvents').on('click', insertEvents);
		$('#updateEvents').on('click', updateEvents);
		$('#deleteEvents').on('click', deleteEvents);
		
		function insertEvents(){
			var projectSeq = $('#projectSeq1').val();
			startDate1.value = new Date(year1.value, month1.value-1, day1.value, hour1.value, minute1.value);	
	    	endDate2.value = new Date(year2.value, month2.value-1, day2.value, hour2.value, minute2.value);
	    	// alert(startDate1.value + '\n' + endDate2.value);
	    	/* if(endDate2.value < startDate1.value){
	    		alert('날짜 입력이 잘못되었습니다!');
	    		return false;
	    	} */
	 
	    	var eventData = {
	    			'projectSeq' : projectSeq,
					'summary' : $('#summary1').val(),
					'description' : $('#description1').val(),
					'startDate' : $('#startDate1').val(),
					'endDate' : $('#endDate2').val(),
					'color' : $('#color1').css("background-color")
	    	}
	    	
			$.ajax({
				type : 'post',
				url : 'insertEvents',
				data : eventData, 
				success : function(data){
					if(data == 'success'){
					var modal1 = document.getElementById('insertModal');
					modal1.style.display = 'none';
					$("#insertModal").css({'overflow': 'hidden', 'height': '100%'});
					}
				},
				error : function() {
					// alert("송신실패");
				}
			});
		}

		function updateEvents(){
			var eventSeq = $(this).attr("data-uno");
			var summary3 = $('#summary3').val();
			var description3 = $('#description3').val();
			var color3 = $('#color3').css("background-color");
			startDate3.value = new Date(year3.value, month3.value-1, day3.value, hour3.value, minute3.value);
	    	endDate4.value = new Date(year4.value, month4.value-1, day4.value, hour4.value, minute4.value);
	    	// alert(startDate3.value + '\n' + endDate4.value);
	    	/* if(endDate4.value < startDate3.value){
	    		alert('날짜 입력이 잘못되었습니다!');
	    		return false;
	    	} */
	    	
			$.ajax({
				type : 'post',
				url : 'updateEvents',
				data : {'eventSeq' : eventSeq, 'summary' : summary3, 'description' : description3,
						'startDate' : startDate3.value, 'endDate' : endDate4.value, 'color' : color3},
				success : function(data){
					if(data == 'success'){
					var modal2 = document.getElementById('eventModal');
					modal2.style.display = 'none';}
					location.reload();
				},
				error : function() {
					// alert("송신실패");
				}
			});
		}

	function deleteEvents(){
		var eventSeq = $(this).attr("data-dno");	
			$.ajax({
				type : 'get',
				url : 'deleteEvents',
				data : {'eventSeq' : eventSeq},
				success : function(data){
					if(data == 'success'){
					var modal3 = document.getElementById('eventModal');
					modal3.style.display = 'none';}
					location.reload();
				},	
				error : function() {
					// alert("송신실패");
				}
			});
		}
	</script>

</html>