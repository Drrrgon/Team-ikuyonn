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

.form-control {
	display:inline-block;
}

.birthWord{
	margin-left:2px;
	margin-right:25px;
	margin-top:10px;
}
.mailbtn{
	width:200px;
	float:center;
}
#addBtn{
text-align:center;
}
#mailList{
	margin-top:2%;
}
#mailList > li{
	margin:1%;
	padding-left:o;
}
#add{
	padding-top: 1%;
    padding-bottom: 1%;
    padding-left: 2%;
    padding-right: 2%;
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
			<div class="col-lg-12">
				<div class="card card-small mb-4">
					<div class="card-header border-bottom">
						<h6 class="m-0">Account Details</h6>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item p-3">
							<div class="center row col-md-10">
							<div class="col-md-6">
								<form action="updateUser" method="post" id="updateForm">
									<div class="formBox">
										<div class="form-group">
											<input type="hidden" name="userID" id="userID"
												value="${sessionScope.userID}"> <label
												for="feFirstName">이름</label> <input type="text"
												class="form-control" name="userName" id="userName"
												value="${sessionScope.userName}" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="feEmailAddress">비밀번호</label>
											<input type="password" class="form-control" name="userPW" id="userPW">
										</div>
										<div class="form-group">
										<label for="feInputAddress">전화번호</label> <input type="text"
											class="form-control" id="userPhone" name="userPhone"
											size="12" maxlength="11" value="${sessionScope.userPhone}" />
										</div>
										<div class="form-group">
											<label for="fePassword">생년월일</label><br>
											<div class="row">
												<input type="hidden" class="input" id="userBirth" name="userBirth" value="${sessionScope.userBirth}" /> 
												<div class="form-group col-md-4">
													<select	class="form-control" name='birthYear' id='birthYear' onChange='setDate()'></select> 
												</div>
												<div class="form-group col-md-4">
													<select class="form-control" name='birthMonth' id='birthMonth' onChange='setDate()'></select> 
												</div>
												<div class="form-group col-md-4">
													<select class="form-control" name='birthDay' id='birthDay'></select>
												</div>	
											</div>
										</div>
									</div>
									<div>
										<div>등록된 이메일&emsp;<button type='button' class = 'btn btn-primary' id ='add'>추가</button></div>
										<ul id="mailList">
										</ul>
										<br />
									</div>
								</form>
							</div>
							<div class="col-md-6">
								<div class="card card-small pt-5 pb-4">
									<div class="text-center">
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
							</div>
							<div style="text-align: center;">
								<button type="submit" class="btn btn-primary" id="userUpdateButton" onclick="return updateForm()" style="width:123px;">회원정보 수정</button>
								<a href="deleteUser?userID=${sessionScope.userID}">
									<button id="userDeleteButton" class="btn btn-default" style="width: 123px;">회원탈퇴</button>
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="insertModal" class="modal">
		<div class="modal-content">
			<h4 class="modal-title">
				메일 등록<span id="close1" class="close"></span>
			</h4>
			<form id="mailForm" action="addAddress" method="post">
				<input type="hidden" class="form-control" id="userID1" value="${sessionScope.userID}"
					name="userID" /> <a>메일 주소</a><br />
				<input type="text" class="form-control" id="emailAddress" name="emailAddress" />
				<div id="mailCheck"></div>
				<a>메일 계정(ID)</a><br />
				<input type="text" class="form-control" id="emailId" name="emailId" /><br /> <a>메일
					비밀번호</a><br />
				<input type="password" class="form-control" id="emailPassword" name="emailPassword" /><br />
				<a>IMAP주소</a><br />
				<input type="text" class="form-control" id="host" name="host" /> <br /> <a>SMTP주소</a><br />
				<input type="text" class="form-control" id="smtp" name="smtp" /> <br /> <span>※IMAP/SMTP주소는
					해당 계정 메일->외부 메일 설정에서 확인하실 수 있습니다.</span>
			</form>
			<br/>
			<div id="addBtn">
			<button type="button" width="150px" class ="mailbtn btn btn-primary" id="addMail" onclick="addMail()">메일 등록</button>
			<button type="button" width="150px" class ="mailbtn btn btn-default" id="cancelButton1">취소</button>
			</div>
		</div>
	</div>
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
		if($("#userID1").val()!=""&&$("#emailAddress").val()!=""&&$("#emailId").val()!=""&&$("#emailPassword").val()!=""&&$("#host").val()!=""&&$("#smtp").val()!="")
		{
			$("#mailForm").submit();
		}else{
			alert("입력하지 않은 항목이 있습니다.");
		}
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
										+ "<button class='ex' type ='button' onclick=\"delMail('"
										+ data[index].emailAddress
										+ "')\"><img class='btn-img' src='./resources/images/x.png'></button></li>";
							}
						}
						$('#mailList').html(ext);
						$(".ex").css('border','none');
						$(".ex").css('background-color','white');
						$(".ex").css('cursor','pointer');
						$(".btn-img").css('border','1');
						$(".btn-img").css('width','21');
						$(".btn-img").css('height','19');
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
							$("#userID1").val("");
							$("#emailAddress").val("");
							$("#emailId").val("");
							$("#emailPassword").val("");
							$("#host").val("");
							$("#smtp").val("");
							$("#mailCheck").html("");
							$("#emailAddress").removeClass(" is-invalid");
							$("#insertModal").css("display", "none");
						});
						$("#close1").on('click', function() {
							$("#userID1").val("");
							$("#emailAddress").val("");
							$("#emailId").val("");
							$("#emailPassword").val("");
							$("#host").val("");
							$("#smtp").val("");
							$("#mailCheck").html("");
							$("#emailAddress").removeClass(" is-invalid");
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
				$("#emailAddress").addClass(" is-invalid");
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
							$("#emailAddress").removeClass(" is-invalid");
						} else {
							var temp = "이미 등록된 주소입니다.";
							$("#mailCheck").html(temp);
							$("#addMail").attr('disabled', true);
							$("#emailAddress").addClass(" is-invalid");
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
		if ($('#userPhone').val() == "") {
			alert("전화번호를 입력하지 않았습니다.");
			return false;
		}
		if (isNaN($('#userPhone').val())) {
			alert('전화번호 입력이 잘못되었습니다!');
			return false;
		}
		
		var userBirth = $('#userBirth').val('');
		var birthYear = $('#birthYear').val();
		var birthMonth = $('#birthMonth').val();
		var birthDay = $('#birthDay').val();

		userBirth = new Date(birthYear, birthMonth - 1, birthDay);
		$("#userBirth").val(userBirth);
		$('#updateForm').submit();
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
	
	$('#userUpdateButton').on('click', function() {
		alert('회원정보가 수정되었습니다'+'\n'+'다시 로그인 하세요');
	});
	
	$('#userDeleteButton').on('click', function() {
		var deleteCheck = confirm('회원탈퇴 하시겠습니까?');
		if(deleteCheck == true){
			return true;
		} else{
			return false;
		}
	});
</script>
</html>