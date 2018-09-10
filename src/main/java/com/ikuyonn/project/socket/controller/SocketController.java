package com.ikuyonn.project.socket.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.socket.mapper.Repo;
import com.ikuyonn.project.socket.vo.Message;
import com.ikuyonn.project.socket.vo.User;
import com.ikuyonn.project.user.mapper.UserMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SocketController {
	@Autowired Repo repo;
	@Autowired
	SqlSession sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(SocketController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/insertMessage", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String insert(HttpSession session, Model model, Message table) {
		int result = repo.insertContent(table);
		Message msg = repo.getLastOneProjectContent(table.getProjectName());
		String message = msg.sendMessage();
		return message;
	}
	
	@RequestMapping(value = "/refreshMessage", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> refresh(HttpSession session, Model model, String projectName) {
		ArrayList<Message> list = repo.getProjectContent(projectName);
		ArrayList<String> messageList = new ArrayList<String>();
		for(Message a : list) {
			messageList.add(a.sendMessage());
		}
		System.out.println(messageList);
		return messageList;
	}
	
	@RequestMapping(value = "/searchbydate", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> searchbydate(HttpSession session, Model model, String projectName, String date) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("projectName", projectName);
		map.put("date", date);
		ArrayList<Message> list = repo.searchByDate(map);
		ArrayList<String> messageList = new ArrayList<String>();
		for(Message a : list) {
			messageList.add(a.sendMessage());
		}
		return messageList;
	}
	@RequestMapping(value = "/getUserByProjectName", method = RequestMethod.POST)
	public @ResponseBody ArrayList<ArrayList<String>> getUserByProjectName(HttpSession session, Model model, String projectName) {
		//get users
		ArrayList<Message> list = repo.getUserByProjectName(projectName);
		//get userID
		ArrayList<String> temp2 = new ArrayList<>();
		for(Message a : list) {
			temp2.add(a.getUserID());
		}
		//get online users
		ArrayList<String> temp =(ArrayList<String>) session.getAttribute("socketIDList");
		ArrayList<ArrayList<String>> abc = new ArrayList<>();
		abc.add(temp2);
		abc.add(temp);
		
		return abc;
	}
	
	@RequestMapping(value = "/searchUserProjectName", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> searchUserProjectName(HttpSession session, String userID) {
		ArrayList<String> list = repo.searchUserProjectName(userID);
		return list;
	}
	
	@RequestMapping(value = "/setSocket", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> setSocket(HttpSession session, Model model, 
			@RequestParam(value="socketID") ArrayList<String> socketID) {	
		session.removeAttribute("socketIDList");
		HashSet<String> tempSet = new HashSet();
		ArrayList<String> tempList = new ArrayList();
		for(String a : socketID) {
			tempSet.add(a);
		}
		for(String a : tempSet) {
			tempList.add(a);
		}
		session.setAttribute("socketIDList", tempList);
		return tempList;
	}
	
	@RequestMapping(value = "/getUserProfile", method = RequestMethod.POST)
	public @ResponseBody String getUserProfile(HttpSession session, Model model, User ur) {
		UserMapper um = sqlSession.getMapper(UserMapper.class);
		User user = new User();
		user = um.loginUser(ur);
		String path= "";
		if(user.getOriginalFileName() == null) {
			path = "./resources/images/default.jpg";
		}
		else {
			path = "./cResources/images/userProfile/"+user.getOriginalFileName();
		}
		return path;
	}
}
