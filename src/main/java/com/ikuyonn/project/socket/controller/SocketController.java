package com.ikuyonn.project.socket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.socket.mapper.Repo;
import com.ikuyonn.project.socket.vo.Message;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SocketController {
	@Autowired Repo repo;
	private static final Logger logger = LoggerFactory.getLogger(SocketController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> insert(HttpSession session, Model model, Message table) {
		System.out.println(table);
		int result = repo.insertContent(table);
		ArrayList<Message> list = repo.getProjectContent(table.getProjectName());
		ArrayList<String> messageList = new ArrayList<String>();
		for(Message a : list) {
			messageList.add(a.sendMessage());
		}
		return messageList;
	}
	
	@RequestMapping(value = "/refresh", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> refresh(HttpSession session, Model model, String projectName) {
		ArrayList<Message> list = repo.getProjectContent(projectName);
		ArrayList<String> messageList = new ArrayList<String>();
		String message = "";
		for(Message a : list) {
			messageList.add(a.sendMessage());
		}
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
	public @ResponseBody ArrayList<Message> getUserByProjectName(HttpSession session, Model model, String projectName) {
		ArrayList<Message> list = repo.getUserByProjectName(projectName);
		return list;
	}
	@RequestMapping(value = "/setSocket", method = RequestMethod.POST)
	public @ResponseBody String setSocket(HttpSession session, Model model, String socketID) {
		//set sessionID
		session.setAttribute("socketID", socketID);
		return socketID;
	}
}
