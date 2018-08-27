<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function(){
		var userName = '${sessionScope.userName}';
		$('#chat_head').text(userName);
		getUserProjectName();
	});
	
	function getUserProjectName(){
		var userID = "${sessionScope.userID}"
		$.ajax({
			url : 'searchUserProjectName',
			type : 'post',
			data : {
				'userID' : userID
			},
			success : function(proList){
				// <input type="radio" class="custom-control-input" id="category1" name="chatRoom" value="1" checked>
				// $('#selectProject').text('');
				console.log(proList);                          
                var printHtml ="";
				for(var i = 0 ; i< proList.length ; i++){
					printHtml ="";					
					printHtml += '<label class="custom-control-label">';
					printHtml += proList[i];
					printHtml += '</label>&nbsp;';                          
					printHtml += '<button class="btn btn-sm btn-outline-accent" data-pjName="'+proList[i]+'">';
					printHtml += '<i class="material-icons">save</i>입장</button>';
					printHtml += '</div>';
					printHtml += '</li>';
					printHtml += '<br/>';
					$('#selectProject').append(printHtml);
				}
				$("button.btn").click(init);
			}
			
		});
	}
</script>
<link rel="stylesheet" href="./resources/css/chat.css">
<link rel="stylesheet" href="./resources/css/chat2.css">
<body class="h-100">
	<!-- <div class="color-switcher animated">
		<h5>Accent Color</h5>
		<ul class="accent-colors">
			<li class="accent-primary active" data-color="primary"><i
				class="material-icons">check</i></li>
			<li class="accent-secondary" data-color="secondary"><i
				class="material-icons">check</i></li>
			<li class="accent-success" data-color="success"><i
				class="material-icons">check</i></li>
			<li class="accent-info" data-color="info"><i
				class="material-icons">check</i></li>
			<li class="accent-warning" data-color="warning"><i
				class="material-icons">check</i></li>
			<li class="accent-danger" data-color="danger"><i
				class="material-icons">check</i></li>
		</ul>
		<div class="actions mb-4">
			<a
				class="mb-2 btn btn-sm btn-primary w-100 d-table mx-auto extra-action"
				href="https://designrevision.com/downloads/shards-dashboard-lite/">
				<i class="material-icons">cloud</i> Download
			</a> <a
				class="mb-2 btn btn-sm btn-white w-100 d-table mx-auto extra-action"
				href="https://designrevision.com/docs/shards-dashboard-lite"> <i
				class="material-icons">book</i> Documentation
			</a>
		</div>
		<div class="social-wrapper">
			<div class="social-actions">
				<h5 class="my-2">Help us Grow</h5>
				<div class="inner-wrapper">
					<a class="github-button"
						href="https://github.com/DesignRevision/shards-dashboard"
						data-icon="octicon-star" data-show-count="true"
						aria-label="Star DesignRevision/shards-dashboard on GitHub">Star</a>
					<iframe style="width: 91px; height: 21px;"src="https://yvoschaap.com/producthunt/counter.html#href=https%3A%2F%2Fwww.producthunt.com%2Fr%2Fp%2F112998&layout=wide" width="56" height="65" scrolling="no" frameborder="0" allowtransparency="true"></iframe>
				</div>
			</div>
			<div id="social-share"
				data-url="https://designrevision.com/downloads/shards-dashboard-lite/"
				data-text="ð¥ Check out Shards Dashboard Lite, a free and beautiful Bootstrap 4 admin dashboard template!"
				data-title="share"></div>
			<div class="loading-overlay">
				<div class="spinner"></div>
			</div>
		</div>
		<div class="close">
			<i class="material-icons">close</i>
		</div>
	</div>
	<div class="color-switcher-toggle animated pulse infinite">
		<i class="material-icons">settings</i>
	</div> -->
	<div class="container-fluid">
		<div class="row">
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
			<div class="nav-wrapper">
				<ul id="navbar" class="nav flex-column">
					<!-- <li class="nav-item">
						<a class="nav-link" href="index">
							<i class="material-icons">edit</i> 
							<span>Blog Dashboard</span>
						</a>
					</li> -->
					<!-- <li class="nav-item">
						<a class="nav-link" href="components-blog-posts"> 
							<i class="material-icons">vertical_split</i>
							<span>Blog Posts</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="add-new-post">
							<i class="material-icons">note_add</i> 
							<span>Add New Post</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="form-components"> 
							<i class="material-icons">view_module</i>
							<span>Forms &amp; Components</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="tables"> 
							<i class="material-icons">table_chart</i> 
							<span>Tables</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="user-profile-lite"> 
							<i class="material-icons">person</i>
							<span>User Profile</span>
						</a>
					</li> -->
					<!-- <li class="nav-item">
						<a class="nav-link " href="errors"> 
							<i class="material-icons">error</i> 
							<span>Errors</span>
						</a>
					</li> -->
					<li class="nav-item">
						<a class="nav-link " href="chat"> 
							<i class="material-icons">error</i> 
							<span>Chat</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="insertNameCard"> 
							<i class="material-icons">error</i> 
							<span>명함등록</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="writeMail"> 
							<i class="material-icons">error</i> 
							<span>메일쓰기</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link " href="mailBox"> 
							<i class="material-icons">error</i> 
							<span>메일함</span>
						</a>
					</li>					
				</ul>
			</div>
			</aside>
			<!-- End Main Sidebar -->
			<main class="main-content col-lg-10 col-md-9 col-sm-12 p-0 offset-lg-2 offset-md-3">
			<div class="main-navbar sticky-top bg-white">
			

			<!-- 	<div class="chatBtn">
				</div>
				<div onclick="history.back();" class="page_cover"></div>
				<div id="chatMenu">					
				  <div onclick="history.back();" class="close"></div>
				  
				</div> -->
				
				
<!-- 				<head>
  <meta charset="UTF-8">
  <title>Chat</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

</head>

<body> -->
	
  <div class="fabs">
  <div class="chat">
    <div class="chat_header">
      <div class="chat_option">
      <div class="header_img">
         <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/> 
        </div>
		<span id="chat_head">Jane Doe</span> <br> <span class="agent">Agent</span> <span class="online">(Online)</span>		
       	<span id="chat_fullscreen_loader" class="chat_fullscreen_loader"><i class="fullscreen zmdi zmdi-window-maximize"></i></span>
		<span id="chat_backspace" class="chat_backspace"><i class="back zmdi zmdi-mail-send"></i></span>

      </div>
	</div>
	
     <div id ="selectProject" class="chat_body chat_login">
			  		  
         <!-- <a id="chat_fourth_screen" class="fab"><i class="zmdi zmdi-arrow-right"></i></a>  -->
    </div>
    <!-- <div id="chat_converse" class="chat_conversion chat_converse">
            <a id="chat_second_screen" class="fab"><i class="zmdi zmdi-arrow-right"></i></a>
      <span class="chat_msg_item chat_msg_item_admin">
            <div class="chat_avatar">
               <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
            </div>Hey there! Any question?</span>
      <span class="chat_msg_item chat_msg_item_user">
            Hello!</span>
            <span class="status">20m ago</span>
      <span class="chat_msg_item chat_msg_item_admin">
            <div class="chat_avatar">
               <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
            </div>Hey! Would you like to talk sales, support, or anyone?</span>
      <span class="chat_msg_item chat_msg_item_user">
            Lorem Ipsum is simply dummy text of the printing and typesetting industry.</span>
             <span class="status2">Just now. Not seen yet</span>
    </div>
    <div id="chat_body" class="chat_body">
        <div class="chat_category">
          <a id="chat_third_screen" class="fab"><i class="zmdi zmdi-arrow-right"></i></a>
        <p>What would you like to talk about?</p>
        <ul>
          <li>Tech</li>
          <li class="active">Sales</li>
          <li >Pricing</li>
          <li>other</li>
        </ul>
        </div>

    </div> 
    <div id="chat_form" class="chat_converse chat_form">
    <a id="chat_fourth_screen" class="fab"><i class="zmdi zmdi-arrow-right"></i></a>
      <span class="chat_msg_item chat_msg_item_admin">
            <div class="chat_avatar">
               <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
            </div>Hey there! Any question?</span>
      <span class="chat_msg_item chat_msg_item_user">
            Hello!</span>
            <span class="status">20m ago</span>
      <span class="chat_msg_item chat_msg_item_admin">
            <div class="chat_avatar">
               <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
            </div>Agent typically replies in a few hours. Don't miss their reply.
            <div>
              <br>
              <form class="get-notified">
                  <label for="chat_log_email">Get notified by email</label>
                  <input id="chat_log_email" placeholder="Enter your email"/>
                  <i class="zmdi zmdi-chevron-right"></i>
              </form>
            </div></span>

        <span class="chat_msg_item chat_msg_item_admin">
            <div class="chat_avatar">
               <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
            </div>Send message to agent.
            <div>
              <form class="message_form">
                  <input placeholder="Your email"/>
                  <input placeholder="Technical issue"/>
                  <textarea rows="4" placeholder="Your message"></textarea>
                  <button>Send</button> 
              </form>

        </div></span>   
	</div> -->
	
      <div id="chat_fullscreen" class="chat_conversion chat_converse">
      
      
    </div>
    <div class="fab_field">
      <a id="fab_camera" class="fab"><i class="zmdi zmdi-camera"></i></a>
      <a id="fab_send" class="fab"><i class="zmdi zmdi-mail-send"></i></a>
      <textarea id="chatSend" name="chat_message" placeholder="Send a message" class="chat_field chat_message"></textarea>
    </div>
  </div>
    <a id="prime" class="fab"><i class="prime zmdi zmdi-comment-outline"></i></a>
</div>
 <!--  <script src='http://code.jquery.com/jquery-1.11.3.min.js'></script>

    <script src="js/index.js"></script>

</body> -->
			
				<!-- Main Navbar -->
				<nav class="navbar align-items-stretch navbar-light flex-md-nowrap p-0">
					<form action="#" class="main-navbar__search w-100 d-none d-md-flex d-lg-flex">
						<div class="input-group input-group-seamless ml-3">
							<div class="input-group-prepend">
								<div class="input-group-text">
									<i class="fas fa-search"></i>
								</div>
							</div>
							<input class="navbar-search form-control" type="text" placeholder="Search for something..." aria-label="Search">
						</div>
					</form>
					<ul class="navbar-nav border-left flex-row ">
						<li class="nav-item border-right dropdown notifications">
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
										<span class="notification__category">Analytics</span>
										<p>
										Your websiteâs active users count increased by 
										<span class="text-success text-semibold">28%</span> 
										in the last week. Great job!
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
										<span class="notification__category">Sales</span>
										<p>
											Last week your storeâs sales count decreased by 
											<span class="text-danger text-semibold">5.52%</span>. It could have been worse!
										</p>
									</div>
								</a> 
								<a class="dropdown-item notification__all text-center" href="#">
									View all Notifications 
								</a>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle text-nowrap px-3" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> 
								<img class="user-avatar rounded-circle mr-2" src="./resources/images/avatars/0.jpg" alt="User Avatar"> 
								<span class="d-none d-md-inline-block">${sessionScope.userName}</span>
							</a>
							<div class="dropdown-menu dropdown-menu-small">
								<!-- <a class="dropdown-item" href="user-profile-lite"> 
									<i class="material-icons">&#xE7FD;</i> 
									Profile
								</a> 
								<a class="dropdown-item" href="components-blog-posts"> 
									<i class="material-icons">vertical_split</i> 
									Blog Posts
								</a> 
								<a class="dropdown-item" href="add-new-post"> 
									<i class="material-icons">note_add</i>
									 Add New Post
								</a> -->
								<div class="dropdown-divider">
								</div>
								<a class="dropdown-item text-danger" href="#"> 
									<i lass="material-icons text-danger">&#xE879;</i> 
									Logout
								</a>
							</div>
						</li>
					</ul>
					<nav class="nav"> 
						<a href="#" class="nav-link nav-link-icon toggle-sidebar d-md-inline d-lg-none text-center border-left"
							data-toggle="collapse" data-target=".header-navbar"
							aria-expanded="false" aria-controls="header-navbar"> 
							<i class="material-icons">&#xE5D2;</i>
						</a> 
					</nav> 
				</nav>
			</div>
			