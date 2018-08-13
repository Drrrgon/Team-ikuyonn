// console.log("<c:url value='/echo'/>");
	 var sock =  new SockJS("<c:url value='/echo'/>"); 
	/* var sock =  new SockJS("https://app.pstorm.net/chat2/echo"); */
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	$(function(){
		$("#sendBtn").click(function(){			
			sendMessage();
		});
		
		$('input').keyup(function(e) {
		    if (e.keyCode == 13){
		    	console.log('send message...');
				sendMessage();
		    }  
		});
		
		refresh();
		
		$('.nav-item').children().eq(0).addClass('active');

    $('input[name="chatRoom"]').change(function(){
      refresh();
    });
	});
	
	function sendMessage(){//websocket으로 메세지 전송
		var userId = "${sessionScope.userId}";
		var message = $("#message").val();
    if(message.length == 0){
      return false;
    }
    var roomNo = $("input:radio[name=chatRoom]:checked").val();

		var dataForm = { "id":userId , "message": message, "roomnum":roomNo };		
		$.ajax({
			url: "insert",
			type: "post",
			data: dataForm ,
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
    var roomNo = $("input:radio[name=chatRoom]:checked").val();
		$.ajax({
			url:"refresh",
			type:'post',
      data: {"rommnum":roomNo},
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