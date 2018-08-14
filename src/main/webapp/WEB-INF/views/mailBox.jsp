<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<script>
	function refresh() {
		var userid = $("#userid").val();
		var temp;
		$.ajax({
			url : "mailList",
			type : "post",
			data : {
				"userid" : userid
			},
			success : function(data) {
				var ext = "";
				var temp = "";
				if (data.length != 0 && data != null) {
					for ( var index in data) {
						if (index == 0) {
							setlist(data[index].address);
							ext += "<li class=\"active\">";
						} else {
							ext += "<li class=\"\">";
						}
						ext += "<a href=\"#\" onclick=\"setlist(\'"
								+ data[index].address
								+ "')\" data-toggle=\"tab\">"
								+ data[index].address + "</a></li>";
					}
					$('#pills').html(ext);
				}

			},
			error : function() {
				alert("통신실패");
			}
		});
	}
	function setlist(address) {
		var userid = $("#userid").val();
		$
				.ajax({
					url : "getInbox",
					type : "post",
					data : {
						"userid" : userid,
						"address" : address
					},
					success : function(data) {
						var ext = "";
						ext += "<table class=\"table table-striped table-bordered table-hover\" id=\"dataTables-example\">";
						ext += "<thead><tr><th>번호</th><th>보낸사람</th><th>제목</th><th>받은 날짜</th></tr></thead><tbody>";

						if (data.length != 0 && data != null) {
							for ( var index in data) {
								ext += "<tr class=\"gradeA\">";
								ext += "<td>" + data[index].msgNum + "</td>";
								ext += "<td>" + data[index].sentaddress
										+ "</td>";
								ext += "<td><a href=\"#\" onclick=\"getContent(\'"
										+ data[index].msgNum
										+ "','"
										+ address
										+ "')\">"
										+ data[index].title
										+ "</a></td>";
								ext += "<td>" + data[index].sentdate + "</td>";
								ext += "</tr>";
							}
							ext += "</tbody></table>";
							$('#mailList').html(ext);
							$('#dataTables-example').dataTable();
							$("#content").html("");
						}
					},
					error : function() {
						alert("통신실패");
					}
				});
	}
	function getContent(msgNum, address) {
		var userid = $("#userid").val();
		var sentaddress = "";
		var sentdate = "";
		var title = "";

		$.ajax({
			url : "getmail",
			type : "post",
			data : {
				"userid" : userid,
				"address" : address,
				"msgNum" : msgNum
			},
			success : function(data) {
				var ext = "";
				ext += "<table><tr><th>보낸 사람 : &nbsp</th><td>"
						+ data.sentaddress
						+ "</td></tr><tr><th>보낸 날짜 : &nbsp</th><td>"
						+ data.sentdate + "</td></tr>";
				ext += "<tr><th>제목 : &nbsp</th><td>" + data.title
						+ "</td></table><br/>"
				$("#content").html(ext);
				$("#content").append(data.content);
				$("#content").append("</br></br></br>");
			},
			error : function() {
				alert("통신실패");
			}
		});
	}
	function down(msgNum, address) {
		$.ajax({
			url : "downfile",
			type : "post",
			data : {
				"userid" : userid,
				"address" : address,
				"msgNum" : msgNum
			},
			success : function(data) {
				alert("다운로드가 완료되었습니다.");
			},
			error : function() {
				alert("통신실패");
			}
		});
	}
	$(function() {
		$('.nav-item').children().eq(3).addClass('active');
		refresh();
		$("#list").on('click', function() {
			$("#content").html("");
		});
		$("#reload").on('click', function() {
			location.href = "reload";
		});
	})
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div class="main-content-container container-fluid px-4">
		<input type="hidden" value="${sessionScope.user.userName}"
			id="userName" />
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<h2>메일 확인</h2>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />

				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Advanced Tables</div>
							<div class="panel-body">
								<div class="panel panel-default">
									<div class="panel-heading">
										<button type="button" id="reload">새로고침</button>
										<button type="button" id="list">목록보기</button>
									</div>
									<div class="panel-body">
										<ul class="nav nav-pills" id="pills">
										</ul>

										<div class="tab-content">
											<div class="tab-pane fade active in">
												<br />
												<div id="content"></div>
												<div class="table-responsive" id="mailList"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	 <script src="./resources/dataTables/jquery.dataTables.js" id = "1"></script>
    <script src="./resources/dataTables/dataTables.bootstrap.js" id = "2"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
	<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
	<script src="./resources/scripts/extras.1.0.0.min.js"></script>
	<script src="./resources/scripts/shards-dashboards.1.0.0.min.js"></script>
	<script src="./resources/scripts/app/app-blog-overview.1.0.0.js"></script>
</body>
</html>