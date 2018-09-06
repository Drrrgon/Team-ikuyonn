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
.projectAddBtnTd{
	text-align: right;
}
div.aa:hover {
    background-color: #e6e6e6;
}
div#create_project_div{
	display: none;

}
.page1{
	width: 50%;
	float: left;
}
.page2{
	width: 50%;
	float: left;
}
.inline{
	display: flow-root;
}
.createbtn{
	float: right;
}
.projectHeader{
	display:inline;
	cursor: pointer;
	margin: 20px;
}
.all_project_div{
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
	<div class="row">
		<div id="joinedProjectDiv" class="col">
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 id="joinedProjectListHeader" class="projectHeader m-0">참여중인 프로젝트</h6>&nbsp;&nbsp;&nbsp;<h6 id="allProjectListHeader" class="projectHeader m-0">전체 프로젝트</h6>
				</div>
				<div id="joinedProjectList" class="card-body p-0 pb-3 text-center">
					
				</div>
				<div id="allProjectList" class="card-body p-0 pb-3 text-center">
					
				</div>

			</div>
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0">클라우드</h6>
					<div align="right">
						<form id="FILE_FORM" method="post" enctype="multipart/form-data"
							action="">
							<input type='file' id='file' name='file' />
						</form>
						<button type="button" class="btn btn-white" id="upload">파일
							등록</button>
						<button type="button" class="btn btn-white" id="delete">삭&nbsp;제</button>
					</div>
				</div>
				<div class="card-body p-0 pb-3 text-center" id="cloudBody">
					<div>
						프로젝트명<input type="hidden" value="" id="proSeq" />
					</div>
					<table class="table mb-0" id="fileTable">
						<tr>
							
						</tr>
					</table>
					
					
				</div>
			</div>
			<div><a><button id="modifyProjectBtn" class="btn btn-accent">프로젝트관리</button></a></div>
		</div>
		<div id="create_project_div" class="col">
				<div class="inline card card-large mb-4">
						<div class="card-header border-bottom">
								<h6 class="m-0">프로젝트 생성</h6>
							</div>
					
							<div class="page1">userList</div>
							<div class="page2">
								<input type="text" id="inputProjectName" class="form-control" placeholder="Project Name"><br/>
								<input type="date" id="inputProjectDate" class="form-control"><br/>
								<button id="createProjectBtn" class="createbtn btn btn-accent">생성</button>
								<button id="backBtn" class="createbtn btn btn-accent">뒤로가기</button>
							</div>
				</div>
				
		</div>
		<!-- <div id="all_project_div" class="col">
				<div class="inline card card-large mb-4">
						<div class="card-header border-bottom">
								<h6 class="m-0">프로젝트 리스트</h6>
							</div> -->
					
							<!-- <div class="page1">userList</div>
							<div class="page2">
								<input type="text" id="inputProjectName" class="form-control" placeholder="Project Name"><br/>
								<input type="date" id="inputProjectDate" class="form-control"><br/>
								<button id="createProjectBtn" class="createbtn btn btn-accent">생성</button>
								<button id="backBtn" class="createbtn btn btn-accent">뒤로가기</button>
							</div> -->
				</div>
				
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
		function setLeftSideIcon() {
			$('#navbar').children().eq(0).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(1).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(2).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(3).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(4).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(5).children().eq(0).attr('class',
					'nav-link ');
			$('#navbar').children().eq(4).children().eq(0).addClass('active');
		}
		function getProject() {
			var userID = $("#userID").val();
			$.ajax({
				url : "getProject",
				type : "post",
				data : {
					"userID" : userID
				},
				success : function(data) {
					initProjectList();
					printJoinedProjectList(data);
				},
				error : function() {
					alert("통신실패");
				}
			});
		}
		function openInputForm(){
			$('#create_project_div').css('display', 'block');
			$('#joinedProjectDiv').css('display', 'none');
			
		}
		function createProject(){
        var projectName = $('#inputProjectName').val();
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
                'userID': sessionID, 'projectName': projectName
            },
            success: function(list){
				getProject();
                $('#inputProjectName').val('');
                closeCreateProject();
            }
        });
    }
	function closeCreateProject(){
		$('#create_project_div').css('display', 'none');
		$('#joinedProjectDiv').css('display', 'block');
	}
		function printJoinedProjectList(joinedProjectList){
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
			temp += '<tr><td class="projectAddBtnTd" colspan="4"></td>';
			temp +='<td><button id="openInputFormBtn" class="btn btn-accent"><i class="zmdi zmdi-plus"></i></button></td>';
								
			$("#tbody").append(temp);
			$('#openInputFormBtn').on('click', openInputForm);
		}
		function initProjectList(){
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
			printHtml += '<tbody id="tbody">';
			printHtml += '</tbody>';
			printHtml += '</table>';
			$('#joinedProjectList').html(printHtml);		
		}
		function fileList(projectSeq) {
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
		$(function() {
			$('#createProjectBtn').on('click', createProject);
			$('#modifyProjectBtn').on("click", openProjectWindow);
			$('#backBtn').on('click', closeCreateProject);
			$('#joinedProjectListHeader').on('click', function(){
				$('#allProjectList').css('display', 'none');
				$('#joinedProjectList').css('display', 'block');
			});
			$('#allProjectListHeader').on('click', function(){
				$('#allProjectList').css('display', 'block');
				$('#joinedProjectList').css('display', 'none');
			});
			setLeftSideIcon();
			getProject();
			var projectSeq = "";
			$("#upload").click(function(e) {
				e.preventDefault();
				$("#file").click();
			});
			
			$("#delete").click(function(){
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
				if($("#file")[0].files[0]!=null){
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
				if(i!=0&&i%6==0){
					temp+="</tr><tr>"
				}
				temp += "<td width='10px' style='word-break:break-all' onclick='select("+i+","+result[i].fileSeq+")'><div class='aa'><img src='./resources/images/fileIcon/"+result[i].fileType+".jpg' height='42' width='42' onerror=\"this.src='./resources/images/fileIcon/ccc.jpg'\"><br />"
				temp += "<a href='downFile?fileSeq=" + result[i].fileSeq
						+ "'>" + result[i].fileName + "</a></div></td>"
			}
			temp += "</tr>"
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
		
	</script>
</html>