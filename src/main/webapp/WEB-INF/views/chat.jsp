<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
          <!-- / .main-navbar -->
          <div class="main-content-container container-fluid px-4">
            <!-- Page Header -->
            <div class="page-header row no-gutters py-4">
              <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
                <span class="text-uppercase page-subtitle">example</span>
                <h3 class="page-title">채팅 룸</h3>
              </div>
            </div>
            <!-- End Page Header -->
            <div class="row">
              <div class="col-lg-9 col-md-12">
                <!-- Add New Post Form -->
                <div class="card card-small mb-3">
                  <div class="card-body">
                    <form class="add-new-post">
                      <input class="form-control form-control-lg mb-3" id="message" type="text" placeholder="content">
                      <!-- <div id="editor-container" class="add-new-post__editor mb-1"></div> -->
                      <div style="height:650px; overflow:scroll;" id="sendMessage" ></div>
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
         
 <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="./resources/scripts/socket.js"></script> -->
<script>
//console.log("<c:url value='/echo'/>");
var sock =  new SockJS("<c:url value='/echo'/>"); 
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

	
	
	refresh();
	
	$('.nav-item').children().eq(0).addClass('active');

$('input[name="chatRoom"]').change(function(){
 refresh();
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
      $("#sendMessage").text("");
			for (var i = 0; i < list.length; i++) {
				var printHTML = "<input type='text' class='form-control input-sm' readonly='readonly'";
				printHTML += "value='"+list[i]+"'/>";
				$("#sendMessage").append(printHTML);			
			}
    }
  });
}

function sendMessage(){//websocket으로 메세지 전송
	var userId = "${sessionScope.ur.userName}";
	console.log(userId);
	var message = $("#message").val();
if(message.length == 0){
 return false;
}
var projectName = $("input:radio[name=chatRoom]:checked").val();

	var dataForm = { "userID":userId , "message": message, "projectName":projectName };		
	$.ajax({
		url: "insert",
		type: "post",
		data: dataForm ,
		dataType: 'json',
		success: function(a){
			/* sock.send($("#message").val()); */
			sock.send(a);
			$('#message').val("");
		},
		error: function(){
			console.log('insert error');
		}
	});
	
	
}

function onMessage(evt){//evt 파라메터는 웹소켓이 보내준 데이터
	var data = evt.data;
	var sessionid = null;
	var message = null;
	
	var strArray =data.split('|');
	
	
	/* var currentuser_session =$('#sessionuserid').val(); */
	var currentuser_session = "${sessionScope.userId}";
	
	
	sessionid = strArray[0];//메세지 보낸사람 세션저장
	message = strArray[1];//현재 메세지 저장
	
	var strArray2 = message.split(',');
	$("#sendMessage").text("");
	for (var i = 0; i < strArray2.length; i++) {
		var printHTML = "<input type='text' class='form-control input-sm' readonly='readonly'";
		printHTML += "value='"+strArray2[i]+"'/>";
		$("#sendMessage").append(printHTML);	
			
	}
	
}

function onClose(evt){
	/* $('#data').append("채팅 연결이 끊어졌어요 다시 접속 해 주세요 ㅜㅜ"); */
}

function refresh(){
var projectName = $("input:radio[name=chatRoom]:checked").val();
	$.ajax({
		url:"refresh",
		type:'post',
 data: {"projectName":projectName},
		success: function(list){
			$("#sendMessage").text("");
			for (var i = 0; i < list.length; i++) {
				var printHTML = "<input type='text' class='form-control input-sm' readonly='readonly'";
				printHTML += "value='"+list[i]+"'/>";
				$("#sendMessage").append(printHTML);			
			}
		},
		error: function(){
			console.log('refresh error');
		}
	});
}	
</script>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
    <script src="https://unpkg.com/shards-ui@latest/dist/js/shards.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sharrre/2.0.1/jquery.sharrre.min.js"></script>
    <script src="./resources/scripts/extras.1.0.0.min.js"></script>
    <script src="./resources/scripts/shards-dashboards.1.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/quill/1.3.6/quill.min.js"></script>
    <script src="./resources/scripts/app/app-blog-new-post.1.0.0.js"></script>
  </body>
</html>