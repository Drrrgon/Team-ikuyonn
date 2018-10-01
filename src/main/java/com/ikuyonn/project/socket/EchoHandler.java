package com.ikuyonn.project.socket;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ikuyonn.project.controller.HomeController;

public class EchoHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
	private ArrayList<String> connectedUsersID = new ArrayList<String>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {	
		//HttpSession 세션 값 가져오기
		Map<String, Object> map;
		map = session.getAttributes();
		String userID = (String) map.get("userID");
		//연결 설정 알림
		logger.info(session.getId() + " 연결 됨!!");		
		connectedUsers.add(session);
		connectedUsersID.add(userID);
		for(WebSocketSession sess : connectedUsers) {			
			sess.sendMessage(new TextMessage("#connect:|"+connectedUsersID));						
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//전체 메시지를 받아옴		
		for(WebSocketSession sess : connectedUsers) {			
				sess.sendMessage(new TextMessage(message.getPayload()));						
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		//HttpSession 세션 값 가져오기
		Map<String, Object> map;
		map = session.getAttributes();
		String userID = (String) map.get("userID");
		connectedUsers.remove(session);
		connectedUsersID.remove(userID);
		for(WebSocketSession sess : connectedUsers) {			
			sess.sendMessage(new TextMessage("#disconnect:|"+connectedUsersID));						
		}
		logger.info(session.getId() + " 연결 종료됨");
	}
	
	@Override

	public void handleTransportError(
			WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}
	
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
}
