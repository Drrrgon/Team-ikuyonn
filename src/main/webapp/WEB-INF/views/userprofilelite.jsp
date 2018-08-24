<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js h-100" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Shards Dashboard Lite - Free Bootstrap Admin Template â
	DesignRevision</title>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
				<!-- Default Light Table -->
				<div class="row">
					<div class="col-lg-4">
						<div class="card card-small mb-4 pt-3">
							<div class="card-header border-bottom text-center">
								<div class="mb-3 mx-auto">
									<img class="rounded-circle"
										src="./resources/images/avatars/0.jpg" alt="User Avatar"
										width="110">
								</div>
								<h4 class="mb-0">${sessionScope.ur.userName}</h4>
								<span class="text-muted d-block mb-2">Project Manager</span>
								<button type="button"
									class="mb-2 btn btn-sm btn-pill btn-outline-primary mr-2">
									<i class="material-icons mr-1">person_add</i>Follow
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
													<input type="hidden" name="userID" id="userID" value="${sessionScope.ur.userID}">
														<label for="feFirstName">이름</label> <input type="text"
															class="form-control" name="userName" id="userName"
															value="${sessionScope.ur.userName}" readonly="readonly">
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
				<a href="logoutUser">
					<button class="btn btn-accent">로그아웃</button></a>
	<div class="promo-popup animated">
		<a href="http://bit.ly/shards-dashboard-pro"
			class="pp-cta extra-action"> <img
			src="https://dgc2qnsehk7ta.cloudfront.net/uploads/sd-blog-promo-2.jpg">
		</a>
		<div class="pp-intro-bar">
			Need More Templates? <span class="close"> <i
				class="material-icons">close</i>
			</span> <span class="up"> <i class="material-icons">keyboard_arrow_up</i>
			</span>
		</div>
		<div class="pp-inner-content">
			<h2>Shards Dashboard Pro</h2>
			<p>A premium & modern Bootstrap 4 admin dashboard template pack.</p>
			<a class="pp-cta extra-action"
				href="http://bit.ly/shards-dashboard-pro">Download</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
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
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>