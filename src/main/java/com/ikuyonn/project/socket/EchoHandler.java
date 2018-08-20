package com.ikuyonn.project.socket;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ikuyonn.project.controller.HomeController;

public class EchoHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	private Map<String, Map<String, WebSocketSession>> usersMap = new ConcurrentHashMap<String,Map<String, WebSocketSession>>();
	private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
	private List<Map<String, WebSocketSession>> userList = new ArrayList<Map<String, WebSocketSession>>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {	
		//HttpSession 세션 값 가져오기
		Map<String, Object> map;
		map = session.getAttributes();
		String userName = (String) map.get("userName");
		String userID = (String) map.get("userID");
		//연결 설정 알림
		session.sendMessage(new TextMessage("#connect:|"+session.getId()));
		
		logger.info(session.getId() + " 연결 됨!!");
		users.put(userName, session);
		usersMap.put(userID, users);
		connectedUsers.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		logger.info("{} 로부터 {}받음", session.getId(), message.getPayload());
		
		System.out.println(message.getPayload());
		//전체 메시지를 받아옴		
		for(WebSocketSession sess : connectedUsers) {			
				sess.sendMessage(new TextMessage(session.getId()+":%^&"+message.getPayload()));						
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		
		//HttpSession 세션 값 가져오기
		Map<String, Object> map;
		map = session.getAttributes();
		String userName = (String) map.get("userName");
		String userID = (String) map.get("userID");
		
		logger.info(session.getId() + " 연결 종료됨");
		connectedUsers.remove(session);
		users.remove(userName);
		usersMap.remove(userID);		
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
