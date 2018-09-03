<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta -->
<%@ include file="parts/meta.jsp" %> 
<title>메이시</title>
<!-- header -->
<%@ include file="parts/header.jsp" %>
<link rel="stylesheet" href="./resources/mail/jquery.dataTables.min.css">
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/loadFirst-js.jsp" %>
</head>
<body class="h-100">
	<!-- sidebar -->
	<%@ include file="parts/sidebar.jsp" %>

	<input type="hidden" value="${sessionScope.userID}" id="userID" />
	<div class="row">
		<div class="col-md-12">
			<br />
			<h3>메일 확인</h3>
		</div>
	</div>
	<!-- /. ROW  -->
	<hr />
	<div class="panel-heading">
		<button type="button" class="btn btn-sm btn-outline-accent"
			id="reload">새로고침</button>
		<button type="button" class="btn btn-sm btn-outline-accent" id="list">목록보기</button>

	</div>
	<br />
	<div class="tab" id="pills"></div>

	<br />
	<div id="content"></div>
	<div id="mailList"></div>


<script>
	function refresh() {
		var userID = $("#userID").val();
		var temp;
		$
				.ajax({
					url : "mailList",
					type : "post",
					data : {
						"userID" : userID
					},
					success : function(data) {
						var ext = "";
						var temp = "";
						if (data.length != 0 && data != null) {
							for ( var index in data) {

								ext += "<button class = 'btn btn-sm btn-outline-accent' onclick=\"setlist(event,\'"
										+ data[index].emailAddress
										+ "')\">"
										+ data[index].emailAddress
										+ "</button>";
							}
							$('#pills').html(ext);
						}

					},
					error : function() {
						alert("통신실패");
					}
				});
	}
	function setlist(evt, address) {
		var tablinks = document
				.getElementsByClassName("btn btn-sm btn-outline-accent");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		evt.currentTarget.className += " active";
		$
				.ajax({
					url : "getInbox",
					type : "post",
					data : {
						"emailAddress" : address
					},
					success : function(data) {
						var ext = "";
						ext += "<table class=\"display\"String id=\"example\"String style=\"width: 100%;\"String>";
						ext += "<thead><tr><th>번호</th><th>보낸사람</th><th>제목</th><th>받은 날짜</th></tr></thead><tbody>";

						if (data.length != 0 && data != null) {
							for ( var index in data) {
								ext += "<tr>";
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
						}
						$('#mailList').html(ext);
						$('#example').DataTable({
							"order" : [ [ 0, "desc" ] ]
						});
						$("#content").html("");
					},
					error : function() {
						alert("통신실패");
					}
				});
	}
	function getContent(msgNum, address) {
		var userID = $("#userID").val();
		var sentaddress = "";
		var sentdate = "";
		var title = "";

		$.ajax({
			url : "getmail",
			type : "post",
			data : {
				"userID" : userID,
				"emailAddress" : address,
				"msgNum" : msgNum
			},
			success : function(data) {
				var ext = "";
				ext += "<table><tr><th>보낸 사람 : &nbsp</th><td>"
						+ data.sentaddress
						+ "</td></tr><tr><th>보낸 날짜 : &nbsp</th><td>"
						+ data.sentdate + "</td></tr>";
				ext += "<tr><th>제목 : &nbsp</th><td>" + data.title
						+ "</td></table><br/><br/>"
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
				"emailAddress" : address,
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
		$('#navbar').children().eq(2).children().eq(0).addClass('active');
	}
	$(function() {
		setLeftSideIcon();
		refresh();
		$("#list").on('click', function() {
			$("#content").html("");
		});
		$("#reload").on('click', function() {
			location.href = "reload";
		});
	})
</script>
<script src="/.resources/mail/jquery.dataTables.min.js/"></script>
	<script src="/.resources/mail/jquery-3.3.1.js/"></script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/footer.jsp" %>
</body>
</html>