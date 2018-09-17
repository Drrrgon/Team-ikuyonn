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
<link rel="stylesheet" href="./resources/css/cloud.css">
<link href='./resources/styles/fullcalendar.min.css' rel='stylesheet' />
<link href='./resources/styles/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='./resources/styles/scheduler.min.css' rel='stylesheet' />
<style>
#left{
    width: 49%;
    margin-left: 1%;
    display: inline-block;
    padding: 1%;
    margin-top: 1%;
}
#right{
    width: 48%;
    float: right;
    margin-right: 1%;
    display: inline-block;
    padding: 2%;
    margin-top: 1%;
}
</style>
<!-- load first js
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp"%>
</head>
<body class="h-100">
	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp"%>
	<div id="joinedProjectMemberBackground"></div>
	<input type="hidden" value="${sessionScope.userID}" id="userID" />
	<div class="main-content-container container-fluid px-4">
		<div class="row mt-5">
			<!-- 프로젝트 리스트 -->
			<div id="joinedProjectDiv" class="col-lg-12">
				<div class="card card-small mb-4">
					<div class="card-header border-bottom">
						<h6 id="joinedProjectListHeader" class="projectHeader m-0">참여중인프로젝트</h6>
						&nbsp;&nbsp;&nbsp;
						<h6 id="allProjectListHeader" class="projectHeader m-0">전체프로젝트</h6>
					</div>
					
					<div id="joinedProjectList" class="card-body p-0 pb-3 text-center">
						
					</div>
					<div id="allProjectList" class="card-body p-0 pb-3 text-center">
					</div>
					<div id="joinedProjectMember"></div>
					
				</div>
			</div>
			<!-- 일정/클라우드 -->
			<div id="cloudDiv" class="col-lg-12">
				<div class="card card-small">
					<div class="card-header border-bottom">
						<div class="btn-group btn-group-toggle mb-3" id="ebuttons" data-toggle="buttons">
							<label class="btn btn-white active"><input type="radio" name="options" value="1" autocomplete="off">일정</label>
							<label class="btn btn-white"><input type="radio" name="options" value="2" autocomplete="off">클라우드</label>
						</div>
						<div id="proName"></div>
						<div class="hidden" id="cloudTab">
							<div align="right">
								<form id="FILE_FORM" method="post" enctype="multipart/form-data" action="">
									<input type='file' id='file' name='file' />
								</form>
								<button type="button" class="btn btn-primary" id="upload">파일등록</button>
								<button type="button" class="btn btn-white" id="down">다운로드</button>
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
				</div>
			</div>
			<!-- 프로젝트등록 -->
			<div id="create_project_div" class="col">
				<div class="inline card card-large mb-4">
					
					<div id='left' class="inline card card-small mb-4">
						<div class="card-header border-bottom">
							<div class="row">
								<div class="input-group col-md-8">
									<input type="text" name="searchText"
										class="input-sm form-control" id="searchText"
										onkeyup="searchfunc()" placeholder="검색"> <select
										class="form-control" id="selectGroup">
										<option value="0">이름</option>
										<option value="1" style="backgroun: red">이메일</option>
										<option value="2">회사명</option>
									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									
								</div>
								<div class="col-md-4" style="text-align: right;">
									<button type="button" class="btn btn-sm btn-white" id="setAddress">선택</button>
								</div>
							</div>
						</div>
						<div class="card-body p-0" style="overflow: scroll" id="nameCardTableWrap">
							<!-- 명함리스트 생성 -->
						</div>
					</div>
					<div id='right' class="inline card card-small mb-4">
					<div class="card-header border-bottom">
						<h2 class="m-0">프로젝트 생성</h2>
					</div>
					<br/>
						<div>프로젝트 명:</div>
						<input type="text" id="inputProjectName" class="form-control" placeholder="Project Name"><br /> 
						<a>프로젝트 색깔:</a><button class="jscolor {valueElement:null,value:'66ccff'}" style="margin-left:2%; width:50px; height:20px;" id="color1">
						</button><br/><br/>
						<div>종료 일자:</div>
						<input type="date" id="inputProjectDate" class="form-control"><br />
						<button id="backBtn" class="createbtn btn btn-default">뒤로가기</button>
						<button id="createProjectBtn" class="createbtn btn btn-accent">생성</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
<!--  일정 관련 모달  -->
<div id="insertModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정을 입력해주세요<span id="insertClose" class="close"></span></h4><br>
    <form id="insertForm">
    	<!-- <span>기간 반복</span><input type="radio" id="repeatTerm" name="repeatCode" value="repeatTerm">
    	<span>매일 반복</span><input type="radio" id="repeatDaily" name="repeatCode" value="repeatDaily"> -->
		<input type="hidden" id="projectSeq1" name="projectSeq1"/>
		<input type="hidden" id="color"/>
		<label>제목</label><input type="text" id="insertSummary" name="insertSummary" class='form-control'/><br/>
		<label>내용</label><input type="text" id="insertDescription" name="insertDescription" class='form-control'/><br>

		<!-- <br/><span>색깔지정</span>
		<button class="jscolor {valueElement:null,value:'66ccff'}" style="width:50px; height:20px;" id="color1">
		</button><br/> -->

		<!-- <select name='color1' id='color1'></select>색깔 지정&nbsp;<br> -->

		<label>시작</label><input type="hidden" id="insertStartDate" name="insertStartDate"/>
    	<select name='insertStartYear' id='insertStartYear' onChange='setDate()'></select>년&nbsp;
    	<select name='insertStartMonth' id='insertStartMonth' onChange='setDate()'></select>월&nbsp;
    	<select name='insertStartDay' id='insertStartDay'></select>일&nbsp;
		<select name='insertStartHour' id='insertStartHour'></select>시&nbsp;
		<select name='insertStartMinute' id='insertStartMinute'></select>분&nbsp;<br>
		<label>마감</label><input type="hidden" id="insertEndDate" name="insertEndDate"/>
    	<select name='insertEndYear' id='insertEndYear' onChange='setDate()'></select>년&nbsp;
    	<select name='insertEndMonth' id='insertEndMonth' onChange='setDate()'></select>월&nbsp;
    	<select name='insertEndDay' id='insertEndDay'></select>일&nbsp;
		<select name='insertEndHour' id='insertEndHour'></select>시&nbsp;
		<select name='insertEndMinute' id='insertEndMinute'></select>분&nbsp;<br>
	</form>
	<button type="button" class="btn btn-primary" id="insertEvents" style="width:200px; margin:auto;">일정 입력</button>
</div>
</div>

<div id="eventModal" class="modal">
<div class="modal-content">
	<h4 class="modal-title">일정입니다<span id="updateClose" class="close"></span></h4><br>
    <form id="eventDetail">
    <label>제목</label><input type="text" id="updateSummary" name="updateSummary" class='form-control'/><br/>
	<label>내용</label><input type="text" id="updateDescription" name="updateDescription" class='form-control'/><br>
	<label>시작</label><input type="hidden" id="updateStartDate" name="updateStartDate"/>
	<select name="updateStartYear" id="updateStartYear" onChange="setDate()"></select>년&nbsp;
	<select name="updateStartMonth" id="updateStartMonth" onChange="setDate()"></select>월&nbsp;
	<select name="updateStartDay" id="updateStartDay"></select>일&nbsp;
	<select name="updateStartHour" id="updateStartHour"></select>시&nbsp;
	<select name="updateStartMinute" id="updateStartMinute"></select>분&nbsp;<br/>
	<label>마감</label><input type="hidden" id="updateEndDate" name="updateEndDate" value=""/>
	<select name="updateEndYear" id="updateEndYear" onChange="setDate()"></select>년&nbsp;
	<select name="updateEndMonth" id="updateEndMonth" onChange="setDate()"></select>월&nbsp;
	<select name="updateEndDay" id="updateEndDay"></select>일&nbsp;
	<select name="updateEndHour" id="updateEndHour"></select>시&nbsp;
	<select name="updateEndMinute" id="updateEndMinute"></select>분&nbsp;<br>
	<center>
	<input data-uno="updateEvents" class="btn btn-primary" type="button" style="width:200px" id="updateEvents" value="수정"/>
	<input data-dno="deleteEvents" class="btn btn-primary" type="button" style="width:200px" id="deleteEvents" value="삭제"/>
    </center>
    </form>

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
<script src="./resources/js/cloud.js"></script>
<script src="./resources/js/ja.js"></script>
	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="../parts/footer.jsp"%>
</body>
<script>
	var originalName;
	//참가한 프로젝트 리스트 를 얻어와서 초기화 및 화면 표기
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
	//모든 프로젝트를 가져와서 초기화 및 모든 프로젝트 div에 출력
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
	// 프로젝트 생성
	function createProject(){
			var projectName = $('#inputProjectName').val();
			var due = $('#inputProjectDate').val();
			$('#cloudDiv').css('display', 'none');
			//이메일로 아이디 검색 by 민석
			jQuery.ajaxSettings.traditional = true;
			var emails = [];
			var emailCheck = $('input:checkbox[name=nameCardGroup]:checked');
			console.log('asdf'+emailCheck);
			if(emailCheck[0] == null){
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
					'userID': sessionID, 'projectName': projectName, 'due':due, 'emails' : emails, 'color' : $('#color1').css('background-color')
				},
				success: function(list){
					getJoinedProject();
					$('#inputProjectName').val('');
					closeCreateProject();
				}
			});
		}
	// 참가되어있는 프로젝트의 리스트를 출력하는 기능
	function printJoinedProjectList(joinedProjectList){
		var userID = "${sessionScope.userID}"
		var temp = "";
		
		for ( var i in joinedProjectList) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td class='joinedProjectListName' data-seq='"+joinedProjectList[i].projectSeq+"'";
			temp += "data-pjName='"+joinedProjectList[i].projectName+"'>" + joinedProjectList[i].projectName + "</td>";
			temp += "<td class='joinedProjectListDue' data-seq='"+joinedProjectList[i].projectSeq+"'>" + joinedProjectList[i].due + "</td>";
			temp += "<td class='joinedProjectListMember' data-seq='"+joinedProjectList[i].projectSeq+"'>" + joinedProjectList[i].memberNum + "</td>";
			if(joinedProjectList[i].status==0){
				temp += "<td><button class='btn btn-accent' data-seq='"+joinedProjectList[i].projectSeq+"' onclick='accept("+ joinedProjectList[i].projectSeq+")'>수락</button><button class='btn btn-accent' data-seq='"+joinedProjectList[i].projectSeq+"' onclick='reject("+ joinedProjectList[i].projectSeq+")'>거절</button></td></tr>";
			}else{
			temp += "<td><button class='btn btn-accent' data-seq='"+joinedProjectList[i].projectSeq+"' onclick='fileList("+ joinedProjectList[i].projectSeq+","+i+",\""+joinedProjectList[i].color+"\")'>열기</button></td></tr>";
			}
		}
		
		temp += '<tr><td class="projectAddBtnTd" colspan="4"></td>';
		temp +='<td><button id="openInputFormBtn" class="btn btn-accent"><i class="zmdi zmdi-plus"></i></button></td>';

		$("#joinedTbody").append(temp);
		$('.joinedProjectListName').on('click', modifyProjectName);
		$('.joinedProjectListMember').on('click', clickProjectMemeber);
		$('.joinedProjectListDue').on('click', modifyProjectDue);
		$('#openInputFormBtn').on('click', openInputForm);
	}
	
	//프로젝트 수락
	function accept(projectSeq){
		var userID = "${sessionScope.userID}";
		$.ajax({
			url : 'accept',
			type : 'post',
			data : {
				'userID' : userID,
				'pjSeq':projectSeq
			},
			success : function() {
				alert("프로젝트를 시작합니다.");
				getJoinedProject();
			},
			error : function(){
				alert("통신실패");
			}
		});
	}
	
	//프로젝트 거절
	function reject(projectSeq){
		var userID = "${sessionScope.userID}";
		$.ajax({
			url : 'reject',
			type : 'post',
			data : {
				'userID' : userID,
				'pjSeq':projectSeq
			},
			success : function() {
				alert("프로젝트를 거절했습니다.");
				getJoinedProject();
			},
			error : function(){
				alert("통신실패");
			}
		});
	}
	
	// 프로젝트의 이름 변경 기능
	function modifyProjectName(){
		var userID = "${sessionScope.userID}";
		var pjSeq = $(this).attr('data-seq');
		var pjName = $(this).attr('data-pjName');
		var projectMasterArray = [];
		$.ajax({
			url : 'getProjectInfo',
			type : 'post',
			data : {
				'userID' : userID
			},
			async: false,
			success : function(list) {
				projectMasterArray = list;
			}
		});
		for (let i = 0; i < projectMasterArray.length; i++) {
			if(projectMasterArray[i].projectMaster == userID){
				if(pjName == projectMasterArray[i].projectName){
					var flag = 0;
					originalName = $(this).html();
					var print = '<input id="modifyProjectName" type="text" style="width:120px; height:30px;">';
					$(this).html(print);
					$('#modifyProjectName').focus();
					$('#modifyProjectName').keyup(function(e){
						if(e.keyCode == 13){
							var newName = $('#modifyProjectName').val();
							$('#modifyProjectName').closest('td').attr('data-pjName', newName);
							$('#modifyProjectName').closest('td').text(newName);
							$.ajax({
								url: 'modifyProjectName',
								type: 'post',
								data: {
									'projectSeq':pjSeq, 'newName':newName
								},
								success: function(result){
									if(result == 0 ){
										alert('변경실패');
									}else{
										alert('변경성공!');
									}
								}
							});
						};
					});
					$('#modifyProjectName').focusout(function(){
						if($('#modifyProjectName').val().length == 0 ){
							alert('이름이 부적절 합니다.');
							$('#modifyProjectName').closest('td').html(originalName);
						}else{
							var newName = $('#modifyProjectName').val();
							$('#modifyProjectName').closest('td').attr('data-pjName', newName);
							$('#modifyProjectName').closest('td').text(newName);
							$.ajax({
								url: 'modifyProjectName',
								type: 'post',
								data: {
									'projectSeq':pjSeq, 'newName':newName
								},
								success: function(result){
									if(result == 0 ){
										alert('변경실패');
									}else{
										alert('변경성공!');
									}
								}
							});
						}
					});
				}
			}
		}
	}
	function checkProjectMaster(userID, seq){
		// if flag == 1 is Master
		var flag = 0;
		$.ajax({
			url: 'checkProjectMaster',
			type: 'post',
			async: false,
			data: {
				'userID': userID, 'projectSeq':seq
			},
			success: function(result){
				console.log(result);
				if(userID == result){
					flag = 1;
				}
			}
		});
		return flag;
	}
	function refreshProjectMember(seq){
		var userID = "${sessionScope.userID}"
		var pjSeq = seq;
		var flag = checkProjectMaster(userID, pjSeq);
		var userList;
		var userListProfile = [];
		$.ajax({
			url: 'getProjectMemeber',
			type: 'post',
			data: {
				'projectSeq':pjSeq
			},
			async: false,
			success: function(list){
				userList = list;
			}
		});
		for (let i = 0; i < userList.length; i++) {
			$.ajax({
				url: 'getUserProfile',
				type: 'post',
				data: {
					'userID':userList[i]
				},
				async: false,
				success: function(path){
					userListProfile.push(path);
				}
			});
		}
		$('#joinedProjectMember').html();
		var printHtml = "";
		printHtml += '<table>';
		printHtml += '<tr>';
		printHtml += '<td colspan="3" width="160px">';
		printHtml += '참여중인 인원';
		printHtml += '</td><td></td><td></td>';
		printHtml += '</tr>';
		printHtml += '<tbody id="joinedProjectMemberTbody">';
		$('#joinedProjectMember').html(printHtml);
		printHtml = "";		
		for (let j = 0; j < userList.length; j++) {	
			if(userList[j] != userID){
				printHtml += '<tr>';			
				printHtml += '<td width="10px">';
				printHtml += '<img class="user-avatar rounded-circle mr-2" src="'+userListProfile[j][1]+'"  width="30px" height="30px">';
				printHtml += '</td>';
				printHtml += '<td width="160px">';
				printHtml += '이름 :'+userListProfile[j][0]+'('+userList[j]+')';
				printHtml += '</td>';
				printHtml += '<td>';
				if(flag == 1){
					printHtml += '<button class="secessionProjectBtn btn btn-accent" data-seq="'+pjSeq+'" data-userID="'+userList[j]+'"> 퇴장</button>';
				}				
				printHtml += '</td>';
				printHtml += '</tr>';
			}
		}
		$('#joinedProjectMemberTbody').append(printHtml);
		printHtml ='';
		printHtml += '<span id="addProjectMemberSpan"><button id="addProjectMemberBtn" class="btn btn-accent">인원</button></span>';
		$('#joinedProjectMember').append(printHtml);
		$('.secessionProjectBtn').on('click', secessionProject);
		$('#addProjectMemberBtn').on('click', function(){
			printAddProjectMemeberPlace(pjSeq);
		});
		$('#joinedProjectMember').css('display', 'block');
		$('#joinedProjectMemberBackground').css('display', 'block');
	}
	function clickProjectMemeber(){
		var userID = "${sessionScope.userID}"
		var pjSeq = $(this).attr('data-seq');
		var flag = checkProjectMaster(userID, pjSeq);
		console.log(pjSeq);
		var userList;
		var userListProfile = [];
		$.ajax({
			url: 'getProjectMemeber',
			type: 'post',
			data: {
				'projectSeq':pjSeq
			},
			async: false,
			success: function(list){
				userList = list;
			}
		});
		console.log(userList);
		for (let i = 0; i < userList.length; i++) {
			$.ajax({
				url: 'getUserProfile',
				type: 'post',
				data: {
					'userID':userList[i]
				},
				async: false,
				success: function(path){
					userListProfile.push(path);
				}
			});
		}
		$('#joinedProjectMember').html();
		var printHtml = "";
		printHtml += '<table>';
		printHtml += '<tr>';
		printHtml += '<td colspan="3" width="160px">';
		printHtml += '참여중인 인원';
		printHtml += '</td><td></td><td></td>';
		printHtml += '</tr>';
		printHtml += '<tbody id="joinedProjectMemberTbody">';
		$('#joinedProjectMember').html(printHtml);
		printHtml = "";		
		for (let j = 0; j < userList.length; j++) {
			if(userList[j] != userID){
				printHtml += '<tr>';			
				printHtml += '<td width="10px">';
				printHtml += '<img class="user-avatar rounded-circle mr-2" src="'+userListProfile[j][1]+'"  width="30px" height="30px">';
				printHtml += '</td>';
				printHtml += '<td width="160px">';
				printHtml += '이름 :'+userListProfile[j][0]+'('+userList[j]+')';
				printHtml += '</td>';
				printHtml += '<td>';
				if(flag == 1){
					printHtml += '<button class="secessionProjectBtn btn btn-accent" data-seq="'+pjSeq+'" data-userID="'+userList[j]+'"> 퇴장</button>';
				}
				printHtml += '</td>';
				printHtml += '</tr>';
			}	
		}
		$('#joinedProjectMemberTbody').append(printHtml);
		printHtml ='';
		printHtml += '<span id="addProjectMemberSpan"><button id="addProjectMemberBtn" class="btn btn-accent">인원</button></span>';
		$('#joinedProjectMember').append(printHtml);
		$('.secessionProjectBtn').on('click', secessionProject);
		$('#addProjectMemberBtn').on('click', function(){
			printAddProjectMemeberPlace(pjSeq);
		});
		$('#joinedProjectMember').css('display', 'block');
		$('#joinedProjectMemberBackground').css('display', 'block');
	}
	function printAddProjectMemeberPlace(seq){
		var pjSeq = seq;
		var emailCheck = 1;
		var userArray;
			$.ajax({
				url : 'getMember',
				async: false,
				data : {
					'emailCheck' : emailCheck
				},
				type : 'post',
				success : function(data){
					// ncName
					userArray = data;
				},
				error : function(){
					alert("통신 실패");
				}
			});
		console.log(userArray);
		var userList;
		var userListProfile = [];
		// $.ajax({
		// 	url: 'getProjectMemeber',
		// 	type: 'post',
		// 	data: {
		// 		'projectSeq':pjSeq
		// 	},
		// 	async: false,
		// 	success: function(list){
		// 		userList = list;
		// 	}
		// });
		for (let i = 0; i < userArray.length; i++) {
			$.ajax({
				url: 'getUserProfile',
				type: 'post',
				data: {
					'userID':userArray[i].userID
				},
				async: false,
				success: function(path){
					userListProfile.push(path);
				}
			});
		}
			//namecard
		$('#joinedProjectMember').html();
		var printHtml = "";
		printHtml += '<table>';
		printHtml += '<tr>';
		printHtml += '<td colspan="3" width="160px">';
		printHtml += '추가할 인원';
		printHtml += '</td><td></td><td></td>';
		printHtml += '</tr>';
		printHtml += '<tbody id="joinedProjectMemberTbody">';
		$('#joinedProjectMember').html(printHtml);
		printHtml = "";		
		for (let j = 0; j < userArray.length; j++) {
				printHtml += '<tr>';			
				printHtml += '<td width="10px">';
				printHtml += '<img class="user-avatar rounded-circle mr-2" src="'+userListProfile[j][1]+'"  width="30px" height="30px">';
				printHtml += '</td>';
				printHtml += '<td width="160px">';
				printHtml += '이름 :'+userListProfile[j][0]+'('+userArray[j].userID+')';
				printHtml += '</td>';
				printHtml += '<td>';
				printHtml += '<button class="addMemberProjectBtn btn btn-accent" data-seq="'+pjSeq+'" data-userID="'+userArray[j].userID+'"> 추가</button>';
				printHtml += '</td>';
				printHtml += '</tr>';
		}
		$('#joinedProjectMemberTbody').append(printHtml);
		printHtml ='';
		printHtml += '<span id="addProjectMemberSpan"><button id="addProjectMemberBackBtn" class="btn btn-accent">돌아가기</button></span>';
		$('#joinedProjectMember').append(printHtml);
		$('.addMemberProjectBtn').on('click', secessionProject);
		$('#addProjectMemberBackBtn').on('click', function(){
			addProjectMemberBack(pjSeq);
		});
	}
	function addProjectMemberBack(pjSeq){
		refreshProjectMember(pjSeq);
	}
	function modifyProjectDue(){

	}	
	// 모든 프로젝트의 리스트를 출력하는 기능
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
		for (let i = 0; i < joinedProjectList.length; i++) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + joinedProjectList[i].projectName + "</td>";
			temp += "<td>" + joinedProjectList[i].due + "</td>";
			temp += "<td>" + joinedProjectList[i].memberNum + "</td>";
			if (userID == joinedProjectList[i].projectMaster) {
				temp += '<td><button class="deleteProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">삭제</button></td>';
			} else {
				temp += '<td></td>';
			}

		}
		temp += '<tr><td class="projectAddBtnTd" colspan="4"></td>';
		$("#allTbody").append(temp);
		$('.deleteProjectBtn').on('click', deleteProject);
		$('.joinProjectBtn').on('click', joinProject);
		$('.secessionProjectBtn').on('click', secessionProject);
		// $('#openInputFormBtn').on('click', openInputForm);
	}
	// 프로젝트 참가
	function joinProject() {

	}
	
	// 프로젝트 탈퇴
	function secessionProject() {
		var pjSeq = $(this).attr('data-seq');
		var userID = $(this).attr('data-userID');
		var flag = confirm('本当によろしいでしょうか');
		
		if(flag == true){
			$.ajax({
				url: 'secessionProjectMember',
				type: 'post',
				data: {
					'projectSeq': pjSeq, 'userID':userID
				},
				success: function(flag){
					if(flag == 0){
						alert('失敗しました');
					}else{
						alert('完了');
						refreshProjectMember(pjSeq);
						getJoinedProject();
					}					
				}
			});
		}else{
			return;
		}
	}
	// 프로젝트 삭제
	function deleteProject() {
		var sessionID = "${sessionScope.userID}";
		// using projectseq
		var projectSeq = $(this).attr('data-project-seq');
		var flag = confirm('本当に削除してもよろしいでしょうか?');
		if (flag) {
			$.ajax({
				url : 'deleteProject',
				type : 'post',
				data : {
					'userID' : sessionID,
					'projectSeq' : projectSeq
				},
				success : function(allProjectList) {
					// init
					initAllProjectList();
					// print
					printAllProjectList(allProjectList);
				}
			});
		}
	};
	
	function fileList(projectSeq,i,color) {
		$("#cloudDiv").css("display","block");
		$('#color').val(color);
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
				aaa();
			},
			error : function() {
				alert("통신실패");
			}
		});

		document.getElementById("projectSeq1").value = projectSeq;

	}
	
	$(function() {
		btnFunction();// 버튼 펑션
		setLeftSideIcon(); // 왼쪽 사이드 아이콘 설정기능
		getJoinedProject();// 프로젝트 가져와서 초기화

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
			var seq=$("#delSeq").val();
			if(seq!=""){
			$.ajax({
				url : "delFile",
				data : {
					"fileSeq" : seq,
					"proSeq" : $("#proSeq").val()
				},
				type : 'POST',
				success : function(result) {
					$("#delSeq").val("");
					makeFile(result);
				},
				error : function() {
					alert("통신실패");
				}
			});
			}else{
				alert("파일을 선택해 주세요.");
			}
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

	function makeFile(result) {
		var temp = "<tr><input type='hidden' value='' id='delSeq'/>"
		for ( var i in result) {
			if (i != 0 && i % 6 == 0) {
				temp += "</tr><tr>"
			}
			temp += "<td id='fileName' width='10px' style='word-break:break-all' onclick='select("
					+ i
					+ ","
					+ result[i].fileSeq
					+ ")'><div class='aa' width='80px'><img src='./resources/images/fileIcon/"+result[i].fileType+".jpg' height='42' width='42' onerror=\"this.src='./resources/images/fileIcon/ccc.jpg'\"><br />"
			temp += "<a>"+ result[i].fileName + "</a></div></td>"
		}

		$("#fileTable").html(temp);
		$('.aa').css('width','90px');
		$("#fileName").css('cursor','pointer');
	}
	
		function select(i,fileSeq){
			$('.aa').css('background-color','');
			$(".aa").eq(i).css('background-color','#e6e6e6');
			$("#delSeq").val(fileSeq);
		}
	
		//다운로드
		$("#down").click(function() {
				var fileSeq=$("#delSeq").val();
				if(fileSeq!=''){
				location.href="downFile?fileSeq="+fileSeq+"";
				}else{
					alert("파일을 선택해 주세요.");
				}
		});
		
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
			$('#nameCardTableWrap').html(line);

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
	function aaa(){
		initThemeChooser({			
			init : function(themeSystem) {
		        $('#calendar').fullCalendar({
					themeSystem : themeSystem,
					eventStartEditable : false, // enable draggable events
					eventDurationEditable : true,
					aspectRatio : 1.8,
					scrollTime : '00:00', // undo default 6am scrollTime
					header : {
						left : 'today prev,next',
						center : 'title',
						right : 'month,listWeek'
					},
					defaultView : 'month',
					timezone : 'local',
					timeFormat: 'h(:mm)',
					eventLimit: 5,
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
						var span = document.getElementById('insertClose');

						modal.style.display = 'block';
						$("#insertModal").css({'overflow': 'hidden', 'height': '100%'});
						span.onclick = function() {
							$('#insertSummary').val('');
					    	$('#insertDescription').val('');
							modal.style.display = 'none';
						}

						window.onclick = function(event) {
						    if (event.target == modal) {
						    	$('#insertSummary').val('');
						    	$('#insertDescription').val('');
						        modal.style.display = 'none';
						    }
						}

						var insertForm = document.getElementById('insertForm');

							    var year = yearC;
							    var month = monthC;
							    var day = dayC;
							    var hour = new Date().getHours();
							    var minute = new Date().getMinutes();
							    var color = $('#color').val();

							    var startYear = year - 80;
							    for(var i=0; i<100; i++) {
							    	insertForm['insertStartYear'].options[i] = new Option(startYear+i, startYear+i);
							    	insertForm['insertEndYear'].options[i] = new Option(startYear+i, startYear+i);
							    }

							    for (var i=0; i<12; i++) {
							    	insertForm['insertStartMonth'].options[i] = new Option(i+1, i+1);
							    	insertForm['insertEndMonth'].options[i] = new Option(i+1, i+1);
							    }

							    for (var i=0; i<24; i++) {
							    	insertForm['insertStartHour'].options[i] = new Option(i, i);
							    	insertForm['insertEndHour'].options[i] = new Option(i, i);
							    }

							    for (var i=0; i<60; i++) {
							    	insertForm['insertStartMinute'].options[i] = new Option(i, i);
							    	insertForm['insertEndMinute'].options[i] = new Option(i, i);
							    }

							    insertForm['insertStartYear'].value = year;
							    insertForm['insertEndYear'].value = year;
							    insertForm['insertStartMonth'].value = month;
							    insertForm['insertEndMonth'].value = month;
							    setDate();
							    insertForm['insertStartDay'].value = day;
							    setDate();
							    insertForm['insertEndDay'].value = day;
							    insertForm['insertStartHour'].value = hour;
							    insertForm['insertEndHour'].value = hour;
							    insertForm['insertStartMinute'].value = minute;
							    insertForm['insertEndMinute'].value = minute;

				 		function setDate() {
							var insertForm = document.getElementById('insertForm');

							var year = insertForm['insertStartYear'].value;
						    var month = insertForm['insertStartMonth'].value;
						    var day = insertForm['insertStartDay'].value;
						    var dayInsertStart = insertForm['insertStartDay'];
						    var dayInsertEnd = insertForm['insertEndDay'];

						    var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

						    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
						        arrayMonth[1] = 29;
						    }

						    for(var i = dayInsertStart.length; i>0; i--) {
						    	dayInsertStart.remove(dayInsertStart.selectedIndex);
						    }

						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsertStart.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsertStart.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsertStart.options.selectedIndex = day-1;
						        }
						    }

						    for(var i = dayInsertEnd.length; i>0; i--) {
						    	dayInsertEnd.remove(dayInsertEnd.selectedIndex);
						    }

						    for (var i = 1; i<=arrayMonth[month-1]; i++) {
						    	dayInsertEnd.options[i-1] = new Option(i, i);
						    }

						    if(day != null || day != '') {
						        if(day > arrayMonth[month-1]) {
						        	dayInsertEnd.options.selectedIndex = arrayMonth[month-1]-1;
						        } else {
						        	dayInsertEnd.options.selectedIndex = day-1;
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

								$("#updateSummary").val(data.summary);
								$("#updateDescription").val(data.description);
								$("#updateStartDate").val(newStart);
								$("#updateStartYear").val(startYear);
								$("#updateEndDate").val(newEnd);
								$("#updateEvents").attr('data-uno', data.eventSeq);
								$("#deleteEvents").attr('data-dno', data.eventSeq);

								var eventDetail = document.getElementById('eventDetail');
								var updateStartDate = new Date(document.getElementById('updateStartDate').value);
								var updateEndDate = new Date(document.getElementById('updateEndDate').value);
								var year = new Date().getFullYear();
								var updateStartYear = updateStartDate.getFullYear();
								var updateStartMonth = updateStartDate.getMonth() + 1;
								var updateStartDay = updateStartDate.getDate();
								var updateStartHour = updateStartDate.getHours();
								var updateStartMinute = updateStartDate.getMinutes();
								var updateEndYear = updateEndDate.getFullYear();
								var updateEndMonth = updateEndDate.getMonth() + 1;
								var updateEndDay = updateEndDate.getDate();
								var updateEndHour = updateEndDate.getHours();
								var updateEndMinute = updateEndDate.getMinutes();

								var startYear = year - 80;
								for(var i=0; i<100; i++) {
									eventDetail['updateStartYear'].options[i] = new Option(startYear+i, startYear+i);
									eventDetail['updateEndYear'].options[i] = new Option(startYear+i, startYear+i);
								}

								for (var i=0; i<12; i++) {
									 eventDetail['updateStartMonth'].options[i] = new Option(i+1, i+1);
									 eventDetail['updateEndMonth'].options[i] = new Option(i+1, i+1);
								}

								for (var i=0; i<24; i++) {
									 eventDetail['updateStartHour'].options[i] = new Option(i, i);
									 eventDetail['updateEndHour'].options[i] = new Option(i, i);
								}

								for (var i=0; i<60; i++) {
									 eventDetail['updateStartMinute'].options[i] = new Option(i, i);
									 eventDetail['updateEndMinute'].options[i] = new Option(i, i);
								}

								setDate0();
								eventDetail['updateStartYear'].value = updateStartYear;
								setDate0();
								eventDetail['updateEndYear'].value = updateEndYear;
								setDate0();
								eventDetail['updateStartMonth'].value = updateStartMonth;
								setDate0();
								eventDetail['updateEndMonth'].value = updateEndMonth;
								setDate0();
								eventDetail['updateStartDay'].value = updateStartDay;
								setDate0();
								eventDetail['updateEndDay'].value = updateEndDay;
								eventDetail['updateStartHour'].value = updateStartHour;
								eventDetail['updateEndHour'].value = updateEndHour;
								eventDetail['updateStartMinute'].value = updateStartMinute;
								eventDetail['updateEndMinute'].value = updateEndMinute;

								function setDate0() {
									var eventDetail = document.getElementById('eventDetail');

									var year = eventDetail['updateStartYear'].value;
									var month = eventDetail['updateStartMonth'].value;
									var day = eventDetail['updateStartDay'].value;
									var dayUpdateStart = eventDetail['updateStartDay'];
									var dayUpdateEnd = eventDetail['updateEndDay'];

									var arrayMonth = [31,28,31,30,31,30,31,31,30,31,30,31];

									if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
									   arrayMonth[1] = 29;
									}

									for(var i = dayUpdateStart.length; i>0; i--) {
								    	dayUpdateStart.remove(dayUpdateStart.selectedIndex);
								    }

								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayUpdateStart.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayUpdateStart.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayUpdateStart.options.selectedIndex = day-1;
								        }
								    }

								    for(var i = dayUpdateEnd.length; i>0; i--) {
								    	dayUpdateEnd.remove(dayUpdateEnd.selectedIndex);
								    }

								    for (var i = 1; i<=arrayMonth[month-1]; i++) {
								    	dayUpdateEnd.options[i-1] = new Option(i, i);
								    }

								    if(day != null || day != '') {
								        if(day > arrayMonth[month-1]) {
								        	dayUpdateEnd.options.selectedIndex = arrayMonth[month-1]-1;
								        } else {
								        	dayUpdateEnd.options.selectedIndex = day-1;
								        }
								    }
								}

							},
							error : function() {
								alert("수신실패");
							}
						});

						var modal = document.getElementById('eventModal');
						var span = document.getElementById('updateClose');

						// When the user clicks on the button, open the modal
						modal.style.display = 'block';
						$("#eventModal").css({'overflow': 'hidden', 'height': '100%'});
						


						span.onclick = function() {
							modal.style.display = 'none';
						}

							// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
						    if (event.target == modal) {
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
	}
		$('#insertEvents').on('click', insertEvents);
		$('#updateEvents').on('click', updateEvents);
		$('#deleteEvents').on('click', deleteEvents);

		function insertEvents(){
			if($('#insertSummary').val() == '' || $('#insertDescription').val() == ''){
				alert('일정 입력이 잘못되었습니다!');
	    		return false;
			}
			
			var projectSeq = $('#projectSeq1').val();
			/* var insertStartDate = document.getElementById('insertStartDate');
			var insertEndDate = document.getElementById('insertEndDate'); */
			var checkInsertStart = new Date(insertStartYear.value, insertStartMonth.value-1, insertStartDay.value, insertStartHour.value, insertStartMinute.value);
			var checkInsertEnd = new Date(insertEndYear.value, insertEndMonth.value-1, insertEndDay.value, insertEndHour.value, insertEndMinute.value);
			if(checkInsertEnd < checkInsertStart){
	    		alert('날짜 입력이 잘못되었습니다!');
	    		return false;
	    	}

	    	var eventData = {
	    			'projectSeq' : projectSeq,
					'summary' : $('#insertSummary').val(),
					'description' : $('#insertDescription').val(),
					'startDate' : checkInsertStart,
					'endDate' : checkInsertEnd,
					'color' : $('#color').val()
	    	}
			$.ajax({
				type : 'post',
				url : 'insertEvents',
				data : eventData,
				success : function(data){
					if(data == '1'){
					var modal1 = document.getElementById('insertModal');
					modal1.style.display = 'none';
					$("#insertModal").css({'overflow': 'hidden', 'height': '100%'});}
					$("#calendar").fullCalendar('refetchEvents');
				},
				error : function() {
					// alert("송신실패");
				}
			});
		}

		function updateEvents(){
			var eventSeq = $(this).attr("data-uno");
			var updateSummary = $('#updateSummary').val();
			var updateDescription = $('#updateDescription').val();
			if(updateSummary == '' || updateDescription == ''){
				alert('일정 입력이 잘못되었습니다!');
	    		return false;
			}
			/* var updateStartDate = document.getElementById('updateStartDate');
			var updateEndDate = document.getElementById('updateEndDate'); */
			var checkUpdateStart = new Date(updateStartYear.value, updateStartMonth.value-1, updateStartDay.value, updateStartHour.value, updateStartMinute.value);
	    	var checkUpdateEnd = new Date(updateEndYear.value, updateEndMonth.value-1, updateEndDay.value, updateEndHour.value, updateEndMinute.value);
	    	if(checkUpdateEnd < checkUpdateStart){
	    		alert('날짜 입력이 잘못되었습니다!');
	    		return false;
	    	}

			$.ajax({
				type : 'post',
				url : 'updateEvents',
				data : {'eventSeq' : eventSeq, 'summary' : updateSummary, 'description' : updateDescription,
						'startDate' : checkUpdateStart, 'endDate' : checkUpdateEnd},
				success : function(data){
					if(data == '1'){
					var modal2 = document.getElementById('eventModal');
					modal2.style.display = 'none';}
					$("#calendar").fullCalendar('refetchEvents');
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
					if(data == '1'){
					var modal3 = document.getElementById('eventModal');
					modal3.style.display = 'none';}
					$("#calendar").fullCalendar('refetchEvents');
				},	
				error : function() {
					// alert("송신실패");
				}
			});
		}
	</script>

</html>