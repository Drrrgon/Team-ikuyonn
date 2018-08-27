<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <style>
    	.user-space{
    		width: 100px;
    		height: 100px;
    	}
      .message{
        width : 500px;
      }
    </style>
    <title>Chat</title>
    <meta name="description" content="A high-quality &amp; free Bootstrap admin dashboard template pack that comes with lots of templates and components.">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" id="main-stylesheet" data-version="1.0.0" href="./resources/styles/shards-dashboards.1.0.0.min.css">
    <link rel="stylesheet" href="./resources/styles/extras.1.0.0.min.css">
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.6/quill.snow.css"> </head>
	<%-- <jsp:include page="../header.jsp" flush="true"></jsp:include> --%>
	<%@ include file="../header.jsp" %>
          <!-- / .main-navbar -->
          <div class="main-content-container container-fluid px-4">
            <!-- Page Header -->
            <div class="page-header row no-gutters py-4">
            	
              <div class="col-26 col-xs-4 text-center text-sm-left mb-0">
                <span class="text-uppercase page-subtitle">example</span><br/>
                <h3 class="page-title">채팅 룸</h3><br/>
                <DIV id="user"></DIV>
                 
                	<!-- <div class="user-space">
                		<img class="user-avatar rounded-circle mr-2" src="./resources/images/avatars/0.jpg" alt="User Avatar" width="50px" height="50px"> 
						        <span class="d-none d-md-inline-block">${sessionScope.ur.userName}</span>
                	</div> -->
                	
              </div>
            </div>
            <!-- End Page Header -->
            <div class="row">
              <div class="col-lg-9 col-md-12">
                <!-- Add New Post Form -->
                <div class="card card-small mb-3">
                  <div class="card-body">
                    <form class="add-new-post">
                    
                    	<!-- 채팅창 -->
                      <div class="col-12" style="margin-top: 20px; margin-bottom: 15px;">
						<div class="col-12" style="float: left">
						<textarea class="form-control" 
							style="border: 1px solid #01D1FE; height: 65px; float: left; width: 80%"
							placeholder="Enter ..." id = "message">
						</textarea>
						<span
							style="float: right; width: 18%; height: 65px; text-align: center; background-color: #01D1FE; border-radius: 5px;">
						<a
							style="margin-top: 30px; text-align: center; color: white; font-weight: bold;" id = "sendBtn"><br>전송</a>
						</span>
						</div>
						</div>
                     <!--  <input class="form-control form-control-lg mb-3" id="message2" type="text" placeholder="content">
                      <div id="editor-container" class="add-new-post__editor mb-1"></div>
                      <div style="height:650px; overflow:scroll;" id="sendMessage2" ></div> -->
                      <!-- 채팅 내용 -->
						<div class="col-12">
							<div class="col-11"
							style="margin: 0 auto; border: 1px solid #01D1FE; height: 400px; border-radius: 10px; overflow:scroll" id = "chatArea">

							<div id="sendMessage" style = "margin-top : 10px; margin-left:10px;"></div>
							</div>
							</div>
							
                      
                    </form>
                  </div>
                </div>
                <!-- / Add New Post Form -->
              </div>
              <div class="col-lg-3 col-md-12">
                <!-- Post Overview -->
                <div class='card card-small mb-3'>
                  <div class="card-header border-bottom">
                    <h6 class="m-0">챗</h6>
                  </div>
                  <div class='card-body p-0'>
                    <ul class="list-group list-group-flush">
                     <li class="list-group-item p-3">
                        <!-- <span class="d-flex mb-2">
                          <i class="material-icons mr-1">flag</i>
                          <strong class="mr-1">Status:</strong> Draft
                          <a class="ml-auto" href="#">Edit</a>
                        </span>
                        <span class="d-flex mb-2">
                          <i class="material-icons mr-1">visibility</i>
                          <strong class="mr-1">Visibility:</strong>
                          <strong class="text-success">Public</strong>
                          <a class="ml-auto" href="#">Edit</a>
                        </span>
                        <span class="d-flex mb-2">
                          <i class="material-icons mr-1">calendar_today</i>
                          <strong class="mr-1">Schedule:</strong> Now
                          <a class="ml-auto" href="#">Edit</a>
                        </span>
                        <span class="d-flex">
                          <i class="material-icons mr-1">score</i>
                          <strong class="mr-1">Readability:</strong>
                          <strong class="text-warning">Ok</strong>
                        </span> -->
                        날짜 <input type="date" id="date">
                      </li> 
                      <li class="list-group-item d-flex px-3">
                          <button class="btn btn-sm btn-outline-accent" id="searchByDate">
                          <i class="material-icons">save</i>검색</button>
                        <button class="btn btn-sm btn-accent ml-auto" id="sendBtn">
                          <i class="material-icons">file_copy</i> 보내기</button>
                      </li>
                    </ul>
                  </div>
                </div>
                <!-- / Post Overview -->
                <!-- Post Overview -->
                <div class='card card-small mb-3'>
                  <div class="card-header border-bottom">
                    <h6 class="m-0">채팅 그룹</h6>
                  </div>
                  <div class='card-body p-0'>
                    <ul class="list-group list-group-flush">
                      <li class="list-group-item px-3 pb-2">
                        <div class="custom-control custom-checkbox mb-1">
                          <input type="radio" class="custom-control-input" id="category1" name="chatRoom" value="1" checked>
                          <label class="custom-control-label" for="category1">1</label>
                        </div>
                        <div class="custom-control custom-checkbox mb-1">
                          <input type="radio" class="custom-control-input" name="chatRoom" value="2" id="category2">
                          <label class="custom-control-label" for="category2">2</label>
                        </div>
                        <div class="custom-control custom-checkbox mb-1">
                          <input type="radio" class="custom-control-input" name="chatRoom" value="3" id="category3">
                          <label class="custom-control-label" for="category3">3</label>
                        </div>
                        <div class="custom-control custom-checkbox mb-1">
                          <input type="radio" class="custom-control-input" name="chatRoom" value="4" id="category4">
                          <label class="custom-control-label" for="category4">4</label>
                        </div>
                        <div class="custom-control custom-checkbox mb-1">
                          <input type="radio" class="custom-control-input" name="chatRoom" value="5" id="category5">
                          <label class="custom-control-label" for="category5">5</label>
                        </div>
                      </li>
                      <!-- <li class="list-group-item d-flex px-3">
                        <div class="input-group">
                          <input type="text" class="form-control" placeholder="New category" aria-label="Add new category" aria-describedby="basic-addon2">
                          <div class="input-group-append">
                            <button class="btn btn-white px-2" type="button">
                              <i class="material-icons">add</i>
                            </button>
                          </div>
                        </div>
                      </li> -->
                    </ul>
                  </div>
                </div>
                <!-- / Post Overview -->
              </div>
            </div>
          </div>
         
<script src="./resources/js/sockjs.min.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="./resources/scripts/socket.js"></script> -->
<script>
console.log("<c:url value='/echo'/>");
 var sock =  new SockJS("<c:url value='/echo'/>"); 
// var sock =  new SockJS('/echo');  
/* var sock =  new SockJS("https://app.pstorm.net/chat2/echo"); */
sock.onmessage = onMessage;
sock.onclose = onClose;

$(function(){	
	$('#message').keyup(function(e) {
    if (e.keyCode == 13){
	    console.log('send message...');
			sendMessage();
	  }  
	});
	
	$("#sendBtn").click(function(){			
		sendMessage();
	});
	
  $("#searchByDate").click(function(){			
	  searchByDate();
	});
	getUserByProjectName();
	refresh();
	$('.nav-item').children().eq(0).addClass('active');

  $('input[name="chatRoom"]').change(function(){
   refresh();
   getUserByProjectName();
  });
});

function searchByDate(){
  var date = $('#date').val();
  if(date.length == 0){
    return false;
  }
  var projectName = $("input:radio[name=chatRoom]:checked").val();
  var sendData = {"projectName":projectName , "date":date};
  $.ajax({
    url: "searchbydate"
    , type: "post"
    , data: sendData
    , success: function(list){      
      var userID =  "${sessionScope.userID}";
      $("#sendMessage").text("");
      for (let index = 0; index < list.length; index++) {
        var messages = list[index].split(':#$');      
        var cutDate = messages[3].substr(0,messages[3].indexOf('#%9745332'));        
        var printHTML ="";
        if(messages[0] == userID){
          printHTML += "<input type='text' class='message' readonly='readonly'";
          printHTML += "value='"+messages[1]+" 님의 메세지 :"+messages[2]+"보낸 시각"+cutDate+"'/>";
          $("#sendMessage").append(printHTML);
        }     
        else{	
            printHTML += "<input type='text' class='form-control input-sm' readonly='readonly'";
            printHTML += "value='"+messages[1]+" 님의 메세지 :"+messages[2]+"보낸 시각"+cutDate+"'/>";
            $("#sendMessage").append(printHTML);
        }          
      }
    }
    , error: function(){
      console.log('refresh error');
    } 
  });
}

function sendMessage(){//websocket으로 메세지 전송
	var userName = "${sessionScope.userName}";
	var message = $("#message").val();
	var userID = "${sessionScope.userID}";
  if(userName == null){
    return false;
  }
  if(message.length == 0){
    return false;
  }
  var projectName = $("input:radio[name=chatRoom]:checked").val();
  var dataForm = { "userID": userID , "userName":userName , "message": message, "projectName":projectName };		
	$.ajax({
		url: "insert",
		type: "post",
		data: dataForm ,
		dataType: 'json',
		success: function(messageList){
			sock.send(messageList);
			$('#message').val("");
		},
		error: function(){
			console.log('insert error');
		}
	});	
}

function onMessage(evt){//evt 파라메터는 웹소켓이 보내준 데이터
	var data = evt.data;  	 
	var strArray = data.split(':|');
	var checkConnection = strArray[0].substr(0,12);
	if(checkConnection == "#connect" || checkConnection == "#disconnect"){
		var abc = strArray[1].substr(1,strArray[1].length-2);
		var sendData = abc.split(', ');
		if(strArray[0] == "#connect"){
			$.ajax({
        url: 'setSocket',
        type: 'post',
        traditional: true,
        data: {
          'socketID':sendData
        },
        success: function(socketID){
          getUserByProjectName();
        },
        error:function(request,status,error){
          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
      });
    }
    else if(strArray[0] == "#disconnect"){
      $.ajax({
        url: 'setSocket',
        type: 'post',
        traditional: true,
        data: {
          'socketID':sendData
        },
        success: function(socketID){
          getUserByProjectName();
        },
        error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
      }); 
    }
	}
  else{
    refresh();
    getUserByProjectName();      
  }
}

function onClose(evt){
	/* $('#data').append("채팅 연결이 끊어졌어요 다시 접속 해 주세요 ㅜㅜ"); */
}

function refresh(){
var projectName = $("input:radio[name=chatRoom]:checked").val();
  $.ajax({
    url:"refresh"
    , type:'post'
    , data: {"projectName":projectName}    
    , success: function(list){      
      var userID =  "${sessionScope.userID}";
      $("#sendMessage").text("");
      for (let index = 0; index < list.length; index++) {
        var messages = list[index].split(':#$');      
        var cutDate = messages[3].substr(0,messages[3].indexOf('#%9745332'));        
        var printHTML ="";
        if(messages[0] == userID){
          printHTML += "<input type='text' class='message' readonly='readonly'";
          printHTML += "value='"+messages[1]+" 님의 메세지 :"+messages[2]+"보낸 시각"+cutDate+"'/>";
          $("#sendMessage").append(printHTML);
        }     
        else{	
            printHTML += "<input type='text' class='form-control input-sm' readonly='readonly'";
            printHTML += "value='"+messages[1]+" 님의 메세지 :"+messages[2]+"보낸 시각"+cutDate+"'/>";
            $("#sendMessage").append(printHTML);
        }          
      }
    }
    , error: function(){
      console.log('refresh error');
    } 
  });	
}	

function getUserByProjectName(){
	var projectName = $("input:radio[name=chatRoom]:checked").val();
  $.ajax({
    url: "getUserByProjectName"
    , type: "post"
    , data: {"projectName":projectName}
    , success: function(list){
      var totalUsers = list[0];
      var onlineUsers = list[1];
      var checkReduplicated = [];
      for (let i = 0; i < onlineUsers.length; i++) {
        for (let j = 0; j < totalUsers.length; j++) {
          if(onlineUsers[i] == totalUsers[j]){
            checkReduplicated.push(onlineUsers[i]);
          }
        }
      }
      $('#user').text("");
      for (let k = 0; k < checkReduplicated.length; k++) {
        var userText = "";
        userText += "<span class='user-space'>";
        userText += "<img class='user-avatar rounded-circle mr-2'";
        userText += "src='./resources/images/avatars/0.jpg'";
        userText += "alt='User Avatar' width='30px' height='30px'>";
        userText += "<span class='d-none d-md-inline-block'>";
        userText += checkReduplicated[k];
        userText += "</span>";
        userText += "</span>&nbsp;";      
        $('#user').append(userText);
      }                       	
    }
    , error: function(){

    }
  });
}
</script>
<%@ include file="../footer.jsp" %>
<%-- <jsp:include page="../footer.jsp" flush="true"></jsp:include> --%>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
    <script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
    <script src="./resources/scripts/extras.1.0.0.min.js"></script>
    <script src="./resources/scripts/shards-dashboards.1.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.6/quill.min.js"></script>
    <!-- <script src="./resources/scripts/app/app-blog-new-post.1.0.0.js"></script> -->
  </body>
</html>