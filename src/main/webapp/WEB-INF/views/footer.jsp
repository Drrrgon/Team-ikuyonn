<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script src="./resources/js/chat2.js"></script>
	<script src="./resources/js/sockjs.min.js"></script>
	<script>
	var projectName ="";
	var currentProject ="";
	var checkReduplicated = [];
	var sock = new SockJS('/project/echo');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	console.log("<c:url value='/echo'/>");

	function init(){
		currentProject = $(this).attr("data-pjName");		
		$('#chat_converse').css('display', 'none');
		$('#chat_body').css('display', 'none');
		$('#chat_form').css('display', 'none');
		$('.chat_login').css('display', 'none');
		$('.chat_fullscreen_loader').css('display', 'block');
		$('#chat_fullscreen').css('display', 'block');
		$('.chat_backspace').css('display', 'block');
		$('.onlineBtn').css('display', 'block');
		refresh();
		getUserByProjectName();
	}
	
	function getCurrentProject(){
	}

	$(function(){
		$('#fab_send').bind("enterKey",function(e){
			 //do stuff here 
		});

		$('#chatSend').keyup(function(e) {
	    if (e.keyCode == 13){
		    console.log('send message...');
				sendMessage();
		  }  
		});
		
		$("#fab_send").click(function(){			
			sendMessage();
		});
		
	  $("#searchByDate").click(function(){			
		  searchByDate();
		});

		// getUserByProjectName();

		// refresh();
		$('.nav-item').children().eq(0).addClass('active');

	});

	function searchByDate(){
	  var date = $('#date').val();
	  if(date.length == 0){
	    return false;
	  }
	  // var projectName = $("input:radio[name=chatRoom]:checked").val();
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
		var message = $("#chatSend").val();
		var userID = "${sessionScope.userID}";
	  if(userName == null){
	    return false;
	  }
	  if(message.length == 0){
	    return false;
	  }
	  console.log(currentProject);
	  var dataForm = { "userID": userID , "userName":userName , "message": message, "projectName":currentProject };		
		$.ajax({
			url: "insert",
			type: "post",
			data: dataForm ,
			success: function(message){
				sock.send(message);
				$('#chatSend').val("");
			},
			error: function(){
				console.log('insert error');
			}
		});	
	}

	function onMessage(evt){//evt 파라메터는 웹소켓이 보내준 데이터
		var data = evt.data;
		console.log(data);  	 
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
	    // refresh();
			// getUserByProjectName();
			var messages = data.split(':#$');      
			var cutDate = messages[3].substr(0,messages[3].indexOf('#%9745332'));        
			var printHTML ="";
			var userID =  "${sessionScope.userID}";
			var check = 0;
			for (let i = 0; i < checkReduplicated.length; i++) {
				if(checkReduplicated[i] == messages[0]){
					check++;
				}				
			}
			if(check > 0 ){
				if(messages[0] == userID){
						printHTML += "<span class='chat_msg_item chat_msg_item_user'>";
						printHTML += messages[1]+"<br/>";          
						printHTML += messages[2];
						printHTML += "&nbsp;<a class='status'>";
	          printHTML += cutDate;
	          printHTML += "</a>";
	          printHTML += "</span>";	          
	          printHTML += "</div>";  
						$("#chat_fullscreen").append(printHTML);						
	        }     
	        else{	
	            printHTML += "<span class='chat_msg_item chat_msg_item_admin'>";
	            printHTML += "<div class='chat_avatar'>";
	            printHTML += "<img src='http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg'/ alt='x'>";
							printHTML += "</div>";
							printHTML += messages[1]+"<br/>";
							printHTML += messages[2];
							printHTML += "&nbsp;<a class='status'>";
	            printHTML += cutDate;
	            printHTML += "</a>";
	            printHTML += "</span>";	          
	            printHTML += "</div>";            
	            $("#chat_fullscreen").append(printHTML);
	        }          
				}
				$("#chat_fullscreen").scrollTop($("#chat_fullscreen")[0].scrollHeight);  
			}	            
	  }
	

	function onClose(evt){
		/* $('#data').append("채팅 연결이 끊어졌어요 다시 접속 해 주세요 ㅜㅜ"); */
	}

	function refresh(){
	// var projectName = $("input:radio[name=chatRoom]:checked").val();
	  $.ajax({
	    url:"refresh"
	    , type:'post'
	    , data: {"projectName":currentProject}    
	    , success: function(list){      
	      var userID = "${sessionScope.userID}";

	      $("#chat_fullscreen").text("");
	      for (let index = 0; index < list.length; index++) {
	        var messages = list[index].split(':#$');      
	        var cutDate = messages[3].substr(0,messages[3].indexOf('#%9745332'));        
	        var printHTML ="";
	        var userID =  "${sessionScope.userID}";
	        if(messages[0] == userID){
						printHTML += "<span class='chat_msg_item chat_msg_item_user'>";
						printHTML += messages[1]+"<br/>";          
						printHTML += messages[2];
						printHTML += "&nbsp;<a class='status'>";
	          printHTML += cutDate;
	          printHTML += "</a>";
	          printHTML += "</span>";	          
	          printHTML += "</div>";  
						$("#chat_fullscreen").append(printHTML);						
	        }     
	        else{	
	            printHTML += "<span class='chat_msg_item chat_msg_item_admin'>";
	            printHTML += "<div class='chat_avatar'>";
	            printHTML += "<img src='http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg'/ alt='x'>";
							printHTML += "</div>";
							printHTML += messages[1]+"<br/>";
							printHTML += messages[2];
							printHTML += "&nbsp;<a class='status'>";
	            printHTML += cutDate;
	            printHTML += "</a>";
	            printHTML += "</span>";	          
	            printHTML += "</div>";            
	            $("#chat_fullscreen").append(printHTML);
	        }          
				}
				$("#chat_fullscreen").scrollTop($("#chat_fullscreen")[0].scrollHeight);
	    }
	    , error: function(){
	      console.log('refresh error');
	    } 
	  });	
	}	

	function getUserByProjectName(){
		// var projectName = $("input:radio[name=chatRoom]:checked").val();
	  $.ajax({
	    url: "getUserByProjectName"
	    , type: "post"
	    , data: {"projectName":currentProject}
	    , success: function(list){
	      var totalUsers = list[0];
	      var onlineUsers = list[1];
	      checkReduplicated = [];
	      for (let i = 0; i < onlineUsers.length; i++) {
	        for (let j = 0; j < totalUsers.length; j++) {
	          if(onlineUsers[i] == totalUsers[j]){
	            checkReduplicated.push(onlineUsers[i]);
	          }
	        }
	      }
				$('#onlineList').text("");
				var userText = "";
				userText += '<div><h2 id="connectedUser"><p class="bg-primary">현재 접속중인 유저</p></h2></div><br/><br/>';
				$('#onlineList').append(userText);
	      for (let k = 0; k < checkReduplicated.length; k++) {
	        userText = "";
	        userText += "<span class='user-space'>";
	        userText += "<img class='user-avatar rounded-circle mr-2'";
	        userText += "src='./resources/images/avatars/0.jpg'";
	        userText += "alt='User Avatar' width='30px' height='30px'>";
	        userText += "<span class='d-none d-md-inline-block'>";
	        userText += checkReduplicated[k];
	        userText += "</span>";
	        userText += "</span><br/><br/>";      
	        $('#onlineList').append(userText);
				}
	    }
	    , error: function(){

	    }
	  });
	}
	</script>
	 <!-- <script src="./resources/js/chatFunction.js"></script> -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<footer class="main-footer d-flex p-2 px-3 bg-white border-top">
		<ul class="nav">
			<li class="nav-item"><a class="nav-link" href="#">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Services</a></li>
			<li class="nav-item"><a class="nav-link" href="#">About</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Products</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Blog</a></li>
		</ul>
		<span class="copyright ml-auto my-auto mr-2">Copyright Â© 2018 <a
			href="https://designrevision.com" rel="nofollow">DesignRevision</a>
		</span>
	</footer>
</main>
</div>
</div>
<!-- <div class="promo-popup animated">
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
</div> -->
</body>
</html>