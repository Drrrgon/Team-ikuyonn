<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
			<!-- Main Sidebar -->
			<aside class="main-sidebar col-12 col-md-3 col-lg-2 px-0">
			<div class="main-navbar">
				<nav
					class="navbar align-items-stretch navbar-light bg-white flex-md-nowrap border-bottom p-0">
				<a class="navbar-brand w-100 mr-0" href="#"
					style="line-height: 25px;">
					<div class="d-table m-auto">
						<img id="main-logo" class="d-inline-block align-top mr-1"
							style="max-width: 25px;"
							src="./resources/images/shards-dashboards-logo.svg"
							alt="Shards Dashboard"> <span
							class="d-none d-md-inline ml-1">Ikuyonn Project</span>
					</div>
				</a> <a class="toggle-sidebar d-sm-inline d-md-none d-lg-none"> <i
					class="material-icons">&#xE5C4;</i>
				</a> </nav>
			</div>
			<form action="#"
				class="main-sidebar__search w-100 border-right d-sm-flex d-md-none d-lg-none">
				<div class="input-group input-group-seamless ml-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<i class="fas fa-search"></i>
						</div>
					</div>
					<input class="navbar-search form-control" type="text"
						placeholder="Search for something..." aria-label="Search">
				</div>
			</form>

			<!-- 왼쪽 사이드 바 -->
			<div class="nav-wrapper">
				<ul id="navbar" class="nav flex-column">
					<li class="nav-item">
						<a class="nav-link " href="schedule"> 
							<i class="material-icons">today</i> 
							<span>일정표</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="nameCardList"> 
							<i class="material-icons">tab</i> 
							<span>명함첩</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="writeMail">
							<i class="material-icons">mail</i> 
							<span>메일</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="cloud"> 
							<i class="material-icons">error</i> 
							<span>프로젝트</span>
						</a>
					</li>						
				</ul>
			</div>
			</aside>
			<!-- End Main Sidebar -->
			<main class="main-content col-lg-10 col-md-9 col-sm-12 p-0 offset-lg-2 offset-md-3">
			<div class="main-navbar sticky-top bg-white">
				<!-- 온라인 접속 유저 -->
				<div onclick="history.back();" class="page_cover"></div>
					<div id="onlineList">					
				 		<div onclick="history.back();" class="close"></div>				  
					</div>  
				<div class="fabs">
					<div class="chat">
						<div class="chat_header">
							<div class="chat_option">
								<div class="header_img">
									<img id="userProfileTopbar"src=${sessionScope.userProfilePath}/> 
								</div>
								<!-- 채팅 인적사항 -->
								<span id="chat_head">이름</span> <br> <span class="agent">아이디</span> <span class="online">(Online)</span>		
								<span id="chat_fullscreen_loader" class="chat_fullscreen_loader"><i class="fullscreen zmdi zmdi-window-maximize"></i></span>
								<span class="onlineBtn"><i class="back zmdi zmdi-accounts-alt"></i></span>
								<span id="chat_backspace" class="chat_backspace"><i class="back zmdi zmdi-arrow-left-bottom"></i></span>
							</div>
						</div>

						<!-- chat area -->
						<div id ="selectProject" class="chat_body chat_login">
						</div>
	
      					<div id="chat_fullscreen" class="chat_conversion chat_converse">
						</div>
							<!-- 채팅방 최하단 -->
							<div class="fab_field">
								<!-- <a id="fab_camera" class="fab"><i class="zmdi zmdi-camera"></i></a> -->
								<a id="fab_send" class="fab"><i class="zmdi zmdi-mail-send"></i></a>
								<textarea id="chatSend" name="chat_message" placeholder="Send a message" class="chat_field chat_message"></textarea>
							</div>
					</div>
							<a id="prime" class="fab"><i class="prime zmdi zmdi-comment-outline"></i></a>
				</div>
				<!-- Main Navbar -->
				<nav class="navbar align-items-stretch navbar-light flex-md-nowrap p-0">
					<form action="#" class="main-navbar__search w-100 d-none d-md-flex d-lg-flex">
						<!-- <div class="input-group input-group-seamless ml-3">
							<div class="input-group-prepend">
								<div class="input-group-text">
									<i class="fas fa-search"></i>
								</div>
							</div>
							<input class="navbar-search form-control" type="text" placeholder="Search for something..." aria-label="Search">
						</div> -->
					</form>
					<ul class="navbar-nav border-left flex-row ">
						<!-- <li class="nav-item border-right dropdown notifications">
							<a class="nav-link nav-link-icon text-center" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<div class="nav-link-icon__wrapper">
									<i class="material-icons">&#xE7F4;</i> 
									<span class="badge badge-pill badge-danger">2</span>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-small" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="#">
									<div class="notification__icon-wrapper">
										<div class="notification__icon">
											<i class="material-icons">&#xE6E1;</i>
										</div>
									</div>
									<div class="notification__content">
										<span class="notification__category">1</span>
										<p>
										
										<span class="text-success text-semibold">2</span> 
										
										</p>
									</div>
								</a> 
								<a class="dropdown-item" href="#">
									<div class="notification__icon-wrapper">
										<div class="notification__icon">
											<i class="material-icons">&#xE8D1;</i>
										</div>
									</div>
									<div class="notification__content">
										<span class="notification__category">3</span>
										<p>
											<span class="text-danger text-semibold">4</span>
										</p>
									</div>
								</a> 
								<a class="dropdown-item notification__all text-center" href="#">
									View all Notifications 
								</a>
							</div>
						</li> -->

						<!-- 드롭다운메뉴 로그아웃 회원정보 수정 등 -->
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle text-nowrap px-3" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> 
								<img id="userProfileDropDown"class="user-avatar rounded-circle mr-2" src=${sessionScope.userProfilePath} alt="User Avatar"> 
								<span class="d-none d-md-inline-block">${sessionScope.userName}</span>
							</a>
							<div class="dropdown-menu dropdown-menu-small">
								<a class="dropdown-item" href="userprofilelite"> 
									<i class="material-icons">&#xE7FD;</i> 
									Profile
								</a> 
								<!-- <a class="dropdown-item" href="components-blog-posts"> 
									<i class="material-icons">vertical_split</i> 
									Blog Posts
								</a> 
								<a class="dropdown-item" href="add-new-post"> 
									<i class="material-icons">note_add</i>
									 Add New Post
								</a> -->
								<div class="dropdown-divider">
								</div>
								<!-- <a class="dropdown-item text-danger" href="userprofilelite"> 
									<i lass="material-icons text-danger">&#xE879;</i> 
									회원정보
								</a> -->
								<a class="dropdown-item text-danger" href="logoutUser"> 
									<i class="material-icons text-danger">&#xE879;</i> 
									Logout
								</a>
							</div>
						</li>
					</ul>
					<nav class="nav"> 
						<!-- <a href="#" class="nav-link nav-link-icon toggle-sidebar d-md-inline d-lg-none text-center border-left"
							data-toggle="collapse" data-target=".header-navbar"
							aria-expanded="false" aria-controls="header-navbar"> 
							<i class="material-icons">&#xE5D2;</i>
						</a>  -->
					</nav> 
				</nav>
			</div>
			