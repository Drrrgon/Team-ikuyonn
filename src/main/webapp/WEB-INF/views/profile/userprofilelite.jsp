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
<!-- load first js 
	스타일 시트 추가가 필요하면 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="../parts/loadFirst-js.jsp"%>
<style type="text/css">
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
	margin: 15% auto; /* 15% from the top and centered */
	margin-top: 10%;
	padding: 20px;
	border: 1px solid #888;
	width: 50%; /* Could be more or less, depending on screen size */
	top:0; 
}
</style>
</head>
<body class="h-100">
	<!-- sidebar -->
	<%@ include file="../parts/sidebar.jsp"%>
	<div></div>
	<!-- Default Light Table -->
	<div class="main-content-container container-fluid px-4">
		<div class="row mt-5">
			<div class="col-lg-4">
				<div class="card card-small mb-4 pt-3">
					<div class="card-header border-bottom text-center">
						<div class="mb-3 mx-auto">
							<img id="userProfileScreen" class="rounded-circle"
								src=${sessionScope.userProfilePath } alt="User Avatar"
								width="110">
						</div>
						<h4 class="mb-0">${sessionScope.userID}</h4>
						<span class="text-muted d-block mb-2">Project Manager</span>
						<form action="ProfilefileUplodeAction" method="post"
							enctype="multipart/form-data">
							<div id="uploadPicture">
								<img id="image" alt="" src=""> <input type="file"
									name="fileUplode" id="fileUplode" accept="img/*" multiple>
							</div>
							<div id="imgIcon">
								<img src="">
								<div id="ajaxLoading">
									<img src="./resources/images/loading.gif">
								</div>
							</div>
						</form>
						<button type="button"
							class="mb-2 btn btn-sm btn-pill btn-outline-primary mr-2">
							<i class="zmdi zmdi-camera"></i>Upload Picture
						</button>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card card-small mb-4">
					<div class="card-header border-bottom">
						<h6 class="m-0">Account Details</h6>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item p-3">
							<div class="row">
								<div class="col">
									<form action="updateUser" method="post" id="updateForm">
										<div class="form-row">
											<div class="form-group col-md-6">
												<input type="hidden" name="userID" id="userID"
													value="${sessionScope.userID}"> <label
													for="feFirstName">이름</label> <input type="text"
													class="form-control" name="userName" id="userName"
													value="${sessionScope.userName}" readonly="readonly">
											</div>
											<!--    <div class="form-group col-md-6">
                                <label for="feLastName">Last Name</label>
                                <input type="text" class="form-control" id="feLastName" placeholder="Last Name" value="Brooks"> </div>
                            </div> -->
											<div class="form-row">
												<div class="form-group col-md-6">
													<label for="feEmailAddress">비밀번호</label> <input
														type="password" class="form-control" name="userPW"
														id="userPW">
												</div>
												<div class="form-group col-md-6">
													<label for="fePassword">생년월일</label> <input type="hidden"
														class="input" id="userBirth" name="userBirth"
														value="${sessionScope.userBirth}" /> <select
														class="form-control" name='birthYear' id='birthYear'
														onChange='setDate()'></select>년&nbsp; <select
														class="form-control" name='birthMonth' id='birthMonth'
														onChange='setDate()'></select>월&nbsp; <select
														class="form-control" name='birthDay' id='birthDay'></select>일&nbsp;
												</div>
											</div>
											<div class="form-group">
												<label for="feInputAddress">전화번호</label> <input type="text"
													class="form-control" id="userPhone" name="userPhone"
													size="11" maxlength="11" value="${sessionScope.userPhone}" />
											</div>
										</div>
										<div>
											<div>등록된 이메일</div>
											<ul id="mailList">
											</ul>
											<br />
										</div>
										<input type="submit" class="btn btn-accent" value="회원정보 수정"
											onclick="return updateForm()">
									</form>
								</div>

							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<a href="deleteUser?userID=${sessionScope.userID}">
			<button class="btn btn-accent">회원탈퇴</button>
		</a>
	</div>
	<div id="insertModal" class="modal">
		<div class="modal-content">
			<h4 class="modal-title">
				메일 등록<span id="close1" class="close"></span>
			</h4>
			<form id="mailForm" action="addAddress" method="post">
				<input type="hidden" id="userID1" value="${sessionScope.userID}"
					name="userID" /> <a>메일 주소</a><br />
				<input type="text" id="emailAddress" name="emailAddress" />
				<div id="mailCheck"></div>
				<a>메일 계정(ID)</a><br />
				<input type="text" id="emailId" name="emailId" /><br /> <a>메일
					비밀번호</a><br />
				<input type="password" id="emailPassword" name="emailPassword" /><br />
				<a>IMAP주소</a><br />
				<input type="text" id="host" name="host" /> <br /> <a>SMTP주소</a><br />
				<input type="text" id="smtp" name="smtp" /> <br /> <span>※IMAP/SMTP주소는
					해당 계정 메일->외부 메일 설정에서 확인하실 수 있습니다.</span>
			</form>
			<button type="button" id="addMail" onclick="addMail()">메일 등록</button>
			<button type="button" id="cancelButton1">취소</button>
		</div>
	</div>

	<!-- <script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script> -->
	<!-- <script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script> -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
	<script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>

	<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
	<%@ include file="../parts/footer.jsp"%>
</body>
<script>
	//메일 등록
	function addMail() {
		$("#mailForm").submit();
		/* $("#emailAddress").val("");
		$("#emailId").val("");
		$("#emailPassword").val("");
		$("#host").val("");
		$("#smtp").val("");
		$("#insertModal").css("display","none");
		getList(); */
	}
	//등록된 이메일 출력
	function getList() {
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
								ext += "<li>"
										+ data[index].emailAddress
										+ "&emsp;<button type ='button' onclick=\"delMail('"
										+ data[index].emailAddress
										+ "')\">삭제</button></li>";
							}
						}
						ext += "<button type='button' class = 'btn btn-sm btn-outline-accent' id ='add'>메일 등록</button>"
						$('#mailList').html(ext);
						//메일 등록창 열기
						$("#add").on('click', function() {
							$("#insertModal").show();
							$("#insertModal").css({
								'overflow' : 'hidden',
								'height' : '100%'
							});
						});
						//modal cancle button
						$("#cancelButton1").on('click', function() {
							$("#insertModal").css("display", "none");
						});
						$("#close1").on('click', function() {
							$("#insertModal").css("display", "none");
						});
					},
					error : function() {
						alert("통신실패");
					}
				});
	};

	//메일 삭제
	function delMail(emailAddress) {
		var userID = $("#userID").val();
		var temp;
		$.ajax({
			url : "delAddress",
			type : "post",
			data : {
				"userID" : userID,
				"emailAddress" : emailAddress
			},
			success : function(data) {
				getList();
				alert("삭제되었습니다.");
			},
			error : function() {
				alert("통신실패");
			}
		});
	}
	$(function() {
		setLeftSideIcon();

		$('#row2').css('display', 'none');

		getList();

		$('.modal').css('z-index', 99999);
		//emailAddress중복체크 key up
		$("#emailAddress").keyup(function() {
			var email = $("#emailAddress").val();
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if (exptext.test(email) == false) {
				var temp = "잘못된 이메일 형식입니다.";
				$("#mailCheck").html(temp);
				$("#addMail").attr('disabled', true);
			} else {
				$.ajax({
					url : "mailCheck",
					type : "post",
					data : {
						"emailAddress" : $("#emailAddress").val()
					},
					success : function(data) {
						if (data == 0) {
							var temp = "등록가능한 주소입니다.";
							$("#mailCheck").html(temp);
							$("#addMail").attr('disabled', false);
						} else {
							var temp = "이미 등록된 주소입니다.";
							$("#mailCheck").html(temp);
							$("#addMail").attr('disabled', true);
						}
					},
					error : function() {
						alert("통신실패");
					}
				});
			}
		});
		//드래그앤드롭 파일업로드
		var file = document.querySelector('#fileUplode');

		file.onchange = function() {
			var fileList = file.files;

			// 읽기
			var reader = new FileReader();
			reader.readAsDataURL(fileList[0]);

			//로드 한 후
			reader.onload = function(e) {
				if ($("#fileUplode").val() != "") {
					var ext = $('#fileUplode').val().split('.').pop()
							.toLowerCase();
					if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
						alert('이미지파일만 업로드 할수 있습니다.');
						return false;
					}
					;
				}
				;

				var formData = new FormData();
				formData.append("fileUplode",
						$("input[name=fileUplode]")[0].files[0]);

				$.ajax({
					url : "ProfilefileUplodeAction",
					type : "post",
					data : formData,
					processData : false,
					contentType : false,
					success : function(path) {
						var tempPath = "<c:url value='"+path+"'/>";
						$('#userProfileScreen').attr('src', tempPath);
						$('#userProfileDropDown').attr('src', tempPath);
						$('#userProfileTopbar').attr('src', tempPath);
					},
					// beforeSend : function() {
					// 	// $('#uploadBox').css('display','none');
					// 	// $('#imgIcon').css('display','block');
					// 	// $('#userProfileScreen').attr('src',e.target.result);
					// 	// console.log('로딩중...');
					// },
					// complete : function(path) {
					// 	$('#userProfileScreen').attr('src',path);
					// 	// $('#row1').css('display','none');
					// 	// $('#row2').css('display','');
					// 	// console.log('완료');
					// },
					error : function() {
						console.log('통신실패');
					}
				});
			};
		};

		var userForm = document.getElementById('updateForm');

		var userBirth = $('#userBirth').val();
		var yearBirth;
		var monthBirth;
		var dayBirth;
		yearBirth = userBirth.substring(0, 4);
		monthBirth = userBirth.substring(5, 7);
		dayBirth = userBirth.substring(8, 10);

		$('#birthYear').val(yearBirth);
		if (monthBirth < 10)
			monthBirth = userBirth.substring(6, 7);
		$('#birthMonth').val(monthBirth);
		if (dayBirth < 10)
			dayBirth = userBirth.substring(9, 10);
		$('#birthDay').val(dayBirth);

		var startYear = yearBirth - 99;
		for (var i = 0; i < 100; i++) {
			userForm['birthYear'].options[i] = new Option(startYear + i,
					startYear + i);
		}

		for (var i = 0; i < 12; i++) {
			userForm['birthMonth'].options[i] = new Option(i + 1, i + 1);
		}

		userForm['birthYear'].value = yearBirth;
		userForm['birthMonth'].value = monthBirth;
		setDate();
		userForm['birthDay'].value = dayBirth;
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
		/* $('#navbar').children().eq(4).children().eq(0).addClass('active'); */
	}

	function updateForm() {
		var userBirth = $('#userBirth').val('');
		var birthYear = $('#birthYear').val();
		var birthMonth = $('#birthMonth').val();
		var birthDay = $('#birthDay').val();

		if ($('#userPhone').val() == "") {
			alert("전화번호를 입력하지 않았습니다.");
			return false;
		}
		if (isNaN($('#userPhone').val())) {
			alert('전화번호 입력이 잘못되었습니다!');
			return false;
		}

		userBirth = new Date(birthYear, birthMonth - 1, birthDay);
		$("#userBirth").val(userBirth);
	}

	function setDate() {
		var userForm = document.getElementById('updateForm');

		var year = userForm['birthYear'].value;
		var month = userForm['birthMonth'].value;
		var day = userForm['birthDay'].value;
		var dayBirth = userForm['birthDay'];

		var arrayMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

		if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
			arrayMonth[1] = 29;
		}

		for (var i = dayBirth.length; i > 0; i--) {
			dayBirth.remove(dayBirth.selectedIndex);
		}

		for (var i = 1; i <= arrayMonth[month - 1]; i++) {
			dayBirth.options[i - 1] = new Option(i, i);
		}

		if (day != null || day != '') {
			if (day > arrayMonth[month - 1]) {
				dayBirth.options.selectedIndex = arrayMonth[month - 1] - 1;
			} else {
				dayBirth.options.selectedIndex = day - 1;
			}
		}
	}
</script>
</html>