<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="parts/meta.jsp"%>
<title>메이시</title>
<!-- header -->
<%@ include file="parts/header.jsp"%>
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
</style>
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/loadFirst-js.jsp"%>
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
	<%@ include file="parts/sidebar.jsp"%>


	<input type="hidden" value="${sessionScope.userID}" id="userID" />
	<div class="row">
		<div class="col">
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<h6 class="m-0">참여중인 프로젝트</h6>
				</div>
				<div class="card-body p-0 pb-3 text-center">
					<table class="table mb-0">
						<thead class="bg-light">
							<tr>
								<th scope="col" class="border-0">#</th>
								<th scope="col" class="border-0">프로젝트 명</th>
								<th scope="col" class="border-0">기간</th>
								<th scope="col" class="border-0">참여인원</th>
								<th scope="col" class="border-0">클라우드</th>
							</tr>
						</thead>
						<tbody id="tbody">

						</tbody>
					</table>

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
						<button type="button" class="btn btn-white" id="delete">삭&nbsg;제</button>
					</div>
				</div>
				<div class="card-body p-0 pb-3 text-center" id="cloudBody">
					<div>
						프로젝트명<input type="hidden" value="" id="proSeq" />
					</div>
					<table class="table mb-0" id="fileTable">
						<tr>
							<!-- <td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td>
							<td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td>
							<td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td>
							<td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td>
							<td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td>
							<td><img src="./resources/images/aaa.png" height="42"
								width="42" id="1"><br />
							<a>aaa.pdf</a></td> -->
						</tr>
					</table>
				</div>
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
			$('#navbar').children().eq(6).children().eq(0).addClass('active');
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
					var temp = "";
					for ( var i in data) {
						temp += "<tr><td>" + i + "</td>";
						temp += "<td>" + data[i].projectName + "</td>";
						temp += "<td>" + data[i].due + "</td>";
						temp += "<td>" + data[i].memberNum + "</td>";
						temp += "<td><button onclick='fileList("
								+ data[i].projectSeq
								+ ")'>열기</button></td></tr>";
					}
					$("#tbody").append(temp);
				},
				error : function() {
					alert("통신실패");
				}
			});
		}
		function fileList(projectSeq) {
			var temp = document.getElementById("cloudBody");
			temp.style.display = "block";
			$("#proSeq").val(projectSeq);
			$.ajax({
				url : "fileList",
				processData : false,
				contentType : false,
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
			setLeftSideIcon();
			getProject();
			var projectSeq = "";
			$("#upload").click(function(e) {
				e.preventDefault();
				$("#file").click();
			});
			$("#file").change(function() {
				var formData = new FormData();
				formData.append("file", $("#file")[0].files[0]);
				formData.append("proSeq", $("#proSeq").val());
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
			});
		});
		function makeFile(result) {
			var temp = "<tr>"
			for ( var i in result) {
				temp += "<td width='60'><img src='./resources/images/aaa.png' height='42' width='42' id='1'><br />"
				temp += "<a href='downFile?fileSeq=" + result[i].fileSeq
						+ "'>" + result[i].fileName + "</a></td>"
			}
			temp += "</tr>"
			$("#fileTable").html(temp);
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
	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="parts/footer.jsp"%>
</body>
</html>