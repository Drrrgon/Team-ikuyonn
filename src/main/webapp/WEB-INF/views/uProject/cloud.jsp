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
</style>
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
									<div id="proName"></div>
									<input type="hidden" value="" id="proSeq" />
									<table class="table mb-0" id="fileTable">
										<tr>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div id="scheduleTab">
						<h1>aaaa</h1>
					</div>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
	<script src="./resources/scripts/extras.1.0.0.min.js"></script>

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
	function getAllProject() {
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
	function openInputForm() {
		$('#create_project_div').css('display', 'block');
		$('#joinedProjectDiv').css('display', 'none');

	}
	function createProject() {
		var projectName = $('#inputProjectName').val();
		var due = $('#inputProjectDate').val();
		if (projectName.length == 0) {
			alert('프로젝트 명을 입력해 주세요!');
			$('#inputProjectName').focus();
			$('#inputProjectName').select();
			return false;
		}
		if (projectName.length > 15) {
			alert('프로젝트 명을 15자 이하로입력해 주세요!');
			$('#inputProjectName').focus();
			$('#inputProjectName').select();
			return false;
		}
	}
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
				emails.push(emailCheck.val());
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
			
			var sessionID = "${sessionScope.userID}";.
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
	function checkJoinedProject(allProjectList) {
		var userID = '${sessionScope.userID}';
		
				$.ajax({
					url : 'getProjectInfo',
					type : 'post',
					data : {
						'userID' : userID
					},
					success : function(joinedProjectList) {
						var temp = "";
						for (let i = 0; i < joinedProjectList.length; i++) {

							for (var j = 0; j < allProjectList.length; j++) {
								console.log(allProjectList[j]);
								console.log(allProjectList[i].projectName);
								if (allProjectList[j] == allProjectList[i].projectName) {
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
	function printJoinedProjectList(joinedProjectList) {
		var userID = "${sessionScope.userID}"
		var temp = "";
		for ( var i in joinedProjectList) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + joinedProjectList[i].projectName + "</td>";
			temp += "<td>" + joinedProjectList[i].due + "</td>";
			temp += "<td>" + joinedProjectList[i].memberNum + "</td>";
			temp += "<td><button onclick='fileList("
					+ joinedProjectList[i].projectSeq
					+ ")'>열기</button></td></tr>";
		}
	}
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
						+ ")'>열기</button></td></tr>";
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
		function printAllProjectList(allProjectList){
			var temp = "";
			

		$("#joinedTbody").append(temp);
		$('#openInputFormBtn').on('click', openInputForm);
	}
	function initJoinedProjectList() {
		$('#joinedProjectList').text('');
		var printHtml = '<table class="table mb-0">';
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

		for (let i = 0; i < allProjectList.length; i++) {
			temp += "<tr><td>" + i + "</td>";
			temp += "<td>" + allProjectList[i].projectName + "</td>";
			temp += "<td>" + allProjectList[i].due + "</td>";
			temp += "<td>" + allProjectList[i].memberNum + "</td>";
			if (userID == allProjectList[i].projectMaster) {
				temp += '<td><button class="deleteProjectBtn btn btn-accent" data-project-seq="'+allProjectList[i].projectSeq+'">삭제</button></td>';
			} else {

			}
			checkJoinedProject(allProjectList);

			console.log('-1');
			console.log(checkJoinedP);

			console.log('3');

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
	function fileList(projectSeq) {
		$("#cloudDiv").css("display","block");
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
	
	
	</script>
</html>