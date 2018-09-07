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
<link rel="stylesheet" href="./resources/mail/tag_style.css" />
<link rel="stylesheet" href="./resources/mail/jquery.dataTables.min.css">
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp"%>
<style type="text/css">
dl {
	position: relative;
}

#tab_1 {
	height: 40px;
	float: left;
	width: 150px;
	z-index: 9;
	position: relative;
}

#tab_2 {
	height: 40px;
	float: left;
	width: 150px;
	z-index: 9;
	position: relative;
}

dd {
	position: absolute;
	padding-top: 70px;
	background-color: #f3f3f3;
	width: 100%;
	height: 100%;
}

dd.hidden {
	display: none;
}

.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 10% auto; /* 15% from the top and centered */
	margin-top: 6%;
	padding: 30px;
	border: 1px solid #888;
	width: 40%; /* Could be more or less, depending on screen size */
	height: 100%; /* Full height */
}
</style>
</head>
<body class="h-100">
	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp"%>
	<input type="hidden" value="${sessionScope.userID}" id="userID"
		name="userID" />
	<input type="hidden" value="${hrefMail}" id="hrefMail" />
	<div class="main-content-container container-fluid px-4">
		<div id="page-wrapper">
			<div id="page-inner">
				<dl>
					<button class="tab_button btn btn-sm btn-outline-accent" id="tab_1">메일 쓰기</button>
				
					<dd>
						<div class="row">
							<div class="col-md-12">
								<div class="panel-body">
									<form role="form" action="sendEmail" method="post"
										id="sendEmail" onsubmit="naming()"
										enctype="multipart/form-data">
										<div class="form-group">
											<a>보내는 사람 : </a> <select class="form-control" name="from"
												id="from"></select>
										</div>
										<div class="form-group">
											<a>받는 사람 :</a> <a id="list"><주소록></a>
											<div class="custom-control custom-checkbox mb-1">
												<input type="checkbox" class="custom-control-input"
													id="formsCheckboxChecked"> <label
													class="custom-control-label" for="formsCheckboxChecked">내게
													쓰기</label>
											</div>
											<div class="tags-input" id="to" onblur="tag()"></div>
											<input type="hidden" id="to2" name="to" value="" /> <input
												type="hidden" id="tar" name="tar" value="text" />
										</div>
										<div class="form-group">
											<label>첨부파일</label> <input type="file" id="file" name="file" />

										</div>
										<div class="form-group">
											<label>제목 : </label> <input class="form-control"
												name="subject" id="subject" />
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
					</dd>

					<button class="tab_button btn btn-sm btn-outline-accent" id="tab_2">메일함</button>
					<hr />
					<dd class="hidden">
						<div class="panel-heading">
							<button type="button" class="btn btn-sm btn-outline-accent"
								id="reload">새로고침</button>
							<button type="button" class="btn btn-sm btn-outline-accent"
								id="list">목록보기</button>

						</div>
						<br />
						<div class="tab" id="pills"></div>

						<br />
						<div id="content"></div>
						<div id="mailList"></div>
					</dd>
				</dl>
			</div>
		</div>
	</div>
	<div id="insertModal" class="modal">
		<div class="modal-content">
			<h4 class="modal-title">
				<주소록> <span id="close1" class="close"></span>
			</h4>
			<div class="card card-small mb-4">
				<div class="card-header border-bottom">
					<div class="btn-group btn-group-toggle mb-3" id="ebuttons"
						data-toggle="buttons">
						<label class="btn btn-white active"> <input type="radio"
							name="options" value="2" autocomplete="off" checked="">전체
						</label> <label class="btn btn-white"> <input type="radio"
							name="options" value="1" autocomplete="off">회원
						</label> <label class="btn btn-white"> <input type="radio"
							name="options" value="0" autocomplete="off">비회원
						</label>
					</div>
					<div class="row">
						<div class="input-group col-md-8">
							<input type="text" name="searchText"
								class="input-sm form-control" id="searchText">
							<div class="input-group-append">
								<button type="button" class="btn btn-sm btn-white"
									id="searchBtn">검색</button>
							</div>
						</div>
						<div class="col-md-4" style="text-align: right;">
							<select class="form-control" id="selectGroup">
								<option value="ncName" selected="">이름</option>
								<option value="ncEmail">이메일</option>
								<option value="ncCompany">회사명</option>
							</select>
							<button type="button" class="btn btn-sm btn-white"
								id="deleteList" style="display: none;">선택삭제</button>
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
	</div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />

	<script src="./resources/mail/index.js"></script>


	<script src="./resources/mail/jquery.dataTables.min.js"></script>

	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="../parts/footer.jsp"%>

</body>
<script type="text/javascript">
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
						+ "</td></tr><tr><th>받은 날짜 : &nbsp</th><td>"
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
		$('#navbar').children().eq(1).children().eq(0).addClass('active');
	}
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
		refresh();
		$('.modal').css('z-index', 9);

		//메일 등록창 열기
		$("#list").on('click', function() {
			$("#insertModal").show();
		});
		//modal cancle button
		$("#close1").on('click', function() {
			$("#insertModal").css("display", "none");
		});
		//메일 링크로 보내기 받는부분
		if ($("#hrefMail").val() != null && $("#hrefMail").val() != "") {
			var mail = "<span contenteditable=\"false\">";
			mail += $("#hrefMail").val() + "</span>&#\8203\;";
			$('#to').html(mail);
		}

		var $menuEle = $('.tab_button'); // 탭메뉴를 변수에 지정
		$menuEle.click(function() { // 탭메뉴 클릭 이벤트
			$('dd').addClass('hidden');
			$(this).next().removeClass('hidden');
		});

		$("#list").on('click', function() {
			$("#content").html("");
		});
		$("#reload").on('click', function() {
			$.ajax({
				url : "reload",
				type : "get",
				success : function() {
					var address = $('#pills').children().eq(0).html();
					alert("메일 불러오기가 완료되었습니다.");
					setlist(event, address);
				},
				error : function() {
					alert("통신 실패");
				}
			});
		});

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
</html>