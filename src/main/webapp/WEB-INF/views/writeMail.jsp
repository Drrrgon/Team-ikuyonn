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
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/loadFirst-js.jsp" %>
</head>
<body class="h-100">
	<!-- sidebar -->
	<%@ include file="parts/sidebar.jsp" %>
	<input type="hidden" value="${sessionScope.userID}" id="userID"	name="userID" />
	<div class="main-content-container container-fluid px-4">
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="col-md-12">
					<br/>
					<h3>메일 쓰기</h3>
				</div>
				<!-- /. ROW  -->
				<hr/>
				<div class="row">
					<div class="col-md-12">
						<div class="panel-body">
							<form role="form" action="sendEmail" method="post" id="sendEmail"
								onsubmit="naming()" enctype="multipart/form-data">
								<div class="form-group">
									<a>보내는 사람 : </a> 
									<select class="form-control" name="from" id="from"></select>
								</div>
								<div class="form-group">
									<a>받는 사람 :</a>
									<a><주소록></a>
									<div class="custom-control custom-checkbox mb-1">
									<input type="checkbox" class="custom-control-input"
											id="formsCheckboxChecked"> <label
											class="custom-control-label" for="formsCheckboxChecked">내게
											쓰기</label>
									</div>
									<div class="tags-input" id="to" onblur="tag()"></div>
									<input type="hidden" id="to2" name="to" value="" />
									<!-- <input type ="hidden" id = "tar" name="tar"value="text"/> -->
								</div>
								<div class="form-group">
									<label>첨부파일</label> <input type="file" id="file" name="file" />

								</div>
								<div class="form-group">
									<label>제목 : </label> <input class="form-control" name="subject"
										id="subject" />
								</div>
								<div class="form-group">
									<label>내용</label>
									<textarea class="form-control" rows="10" name="content"></textarea>
								</div>
								<button type="submit" class="btn btn-default" width="500px"
									id="submit">전송</button>
								<button type="reset" class="btn btn-primary" id="reset">다시쓰기</button>
							</form>
						</div>
					</div>
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
	<script src="./resources/mail/index.js"></script>
	<script type="text/javascript">
	function naming() {
		var aa = $("#to");
		var temp = "";
		for (var i = 0; i < aa.length + 1; i++) {
			if (!(typeof aa.children().eq(i).html() == "undefined")) {
				temp += aa.children().eq(i).html();
				temp += " ";
			}
		}
		$("#to2").val(temp);
		$("#filename").val($("#file").val());
		return true;
	}
	function tag() {
		var event = document.createEvent("Events");
		event.initEvent('keydown', true, true);
		event.keyCode = 32;
		document.getElementById('to').dispatchEvent(event);
	}
	$(function() {
		// 아이콘 설정
		setLeftSideIcon();

		var userID = $("#userID").val();
		$.ajax({
			url : "mailList",
			type : "post",
			data : {
				"userID" : userID
			},
			success : function(data) {
				var from = document.getElementById("from");
				for ( var index in data) {
					var option = document.createElement("option");
					option.text = data[index].emailAddress;
					from.add(option);
				}
			},
			error : function() {
				alert("통신실패");
			}
		});

		$("#formsCheckboxChecked").change(function() {
			if ($("input:checkbox[id='formsCheckboxChecked']").is(":checked")) {
				var mail = "<span contenteditable=\"false\">";
				mail += $("#from").val() + "</span>&#\8203\;";
				$('#to').html(mail);
			}
		});

		$("#reset").on('click', function() {
			$("#to").html("");
		});

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
			$('#navbar').children().eq(1).children().eq(0).addClass('active');
		}
	});
</script>
<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/footer.jsp" %>
</body>
</html>