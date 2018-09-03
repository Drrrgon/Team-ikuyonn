<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<div></div>
				<!-- Default Light Table -->
				<div class="row">
					<div class="col-lg-4">
						<div class="card card-small mb-4 pt-3">
							<div class="card-header border-bottom text-center">
								<div class="mb-3 mx-auto">
									<img id ="userProfileScreen"class="rounded-circle"
										src=${sessionScope.userProfilePath} alt="User Avatar"
										width="110">
								</div>
								<h4 class="mb-0">${sessionScope.userID}</h4>
								<span class="text-muted d-block mb-2">Project Manager</span>
								<form action="ProfilefileUplodeAction" method="post" enctype="multipart/form-data" >
									<div id="uploadPicture">
										<img id="image" alt="" src="">
										<input type="file" name="fileUplode" id="fileUplode" accept="img/*" multiple> 
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
							<ul class="list-group list-group-flush">
								<li class="list-group-item px-4">
									<div class="progress-wrapper">
										<strong class="text-muted d-block mb-2">Workload</strong>
										<div class="progress progress-sm">
											<div class="progress-bar bg-primary" role="progressbar"
												aria-valuenow="74" aria-valuemin="0" aria-valuemax="100"
												style="width: 74%;">
												<span class="progress-value">74%</span>
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item p-4"><strong
									class="text-muted d-block mb-2">Description</strong> <span>Lorem
										ipsum dolor sit amet consectetur adipisicing elit. Odio eaque,
										quidem, commodi soluta qui quae minima obcaecati quod dolorum
										sint alias, possimus illum assumenda eligendi cumque?</span></li>
							</ul>
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
											<form action="updateUser" method="post">
												<div class="form-row">
													<div class="form-group col-md-6">
													<input type="hidden" name="userID" id="userID" value="${sessionScope.userID}">
														<label for="feFirstName">이름</label> <input type="text"
															class="form-control" name="userName" id="userName"
															value="${sessionScope.userID}" readonly="readonly">
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
															<label for="fePassword">생년월일</label> <input type="date"
																class="form-control" name="userBirth" id="userBirth" value="${sessionScope.ur.userBirth}">
														</div>
													</div>
													<div class="form-group">
														<label for="feInputAddress">전화번호</label> <input
															type="text" class="form-control" name="userPhone"
															value="${sessionScope.ur.userPhone}" id="userPhone">
													</div>
													<!--                             <div class="form-row">
                              <div class="form-group col-md-6">
                                <label for="feInputCity">City</label>
                                <input type="text" class="form-control" id="feInputCity"> </div>
                              <div class="form-group col-md-4">
                                <label for="feInputState">State</label>
                                <select id="feInputState" class="form-control">
                                  <option selected>Choose...</option>
                                  <option>...</option>
                                </select>
                              </div>
                              <div class="form-group col-md-2">
                                <label for="inputZip">Zip</label>
                                <input type="text" class="form-control" id="inputZip"> </div>
                            </div>
                            <div class="form-row">
                              <div class="form-group col-md-12">
                                <label for="feDescription">Description</label>
                                <textarea class="form-control" name="feDescription" rows="5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Odio eaque, quidem, commodi soluta qui quae minima obcaecati quod dolorum sint alias, possimus illum assumenda eligendi cumque?</textarea>
                              </div>
                            </div> -->
													<input type="submit" class="btn btn-accent" value="회원정보 수정">
												</form>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<a href="deleteUser?userID=${sessionScope.ur.userID}">
					<button class="btn btn-accent">회원탈퇴</button></a>
					<button id="modifyProject" class="btn btn-accent">프로젝트 관리</button>
	
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
	<script>
			$(function (){
				setLeftSideIcon();

				$('#row2').css('display','none');

				$('#modifyProject').on("click", openProjectWindow);
			
		//드래그앤드롭 파일업로드
		var file = document.querySelector('#fileUplode');
		
		file.onchange = function() {
		    var fileList = file.files ;
		    
		    // 읽기
		    var reader = new FileReader();
		    reader.readAsDataURL(fileList [0]);
		    

		    //로드 한 후
		    reader.onload = function(e) {
		    	if ($("#fileUplode").val() != "") {
					var ext = $('#fileUplode').val().split('.').pop().toLowerCase();
					if ($.inArray(ext, [ 'gif', 'png', 'jpg','jpeg' ]) == -1) {
						alert('이미지파일만 업로드 할수 있습니다.');
						return false;
					};
				};
				
				var formData = new FormData();
				formData.append("fileUplode", $("input[name=fileUplode]")[0].files[0]);
		
				$.ajax({
					url : "ProfilefileUplodeAction",
					type : "post",
					data : formData,
					processData : false,
					contentType : false,
					success : function(path){
						var tempPath = "<c:url value='"+path+"'/>";
						$('#userProfileScreen').attr('src',tempPath);
						$('#userProfileDropDown').attr('src',tempPath);
						$('#userProfileTopbar').attr('src',tempPath);						
					}	,
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
			});

			function openProjectWindow(){
				var projectWindow = window.open("openProjectInfo","WindowName","width=460, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no");
				projectWindow.resizeTo(460,800); //resize window to 500x500
				projectWindow.resizeBy(-10,-10); //make it smaller relatively => to 400x400	
				
				projectWindow.focus();
			};

			function setLeftSideIcon(){
					$('#navbar').children().eq(0).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(1).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(2).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(3).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(4).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(5).children().eq(0).attr('class','nav-link ');
					$('#navbar').children().eq(4).children().eq(0).addClass('active');
			}
		</script>
		<!-- footer 추가적인 js는 위쪽 ↑↑↑↑↑↑ 추가 요망 -->
<%@ include file="parts/footer.jsp" %>
</body>
</html>