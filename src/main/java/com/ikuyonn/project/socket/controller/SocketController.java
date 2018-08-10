package com.ikuyonn.project.socket.controller;

import java.util.ArrayList;

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
import com.ikuyonn.project.socket.vo.Table;

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
	public @ResponseBody ArrayList<String> insert(HttpSession session, Model model, Table table) {
		table.setRoomnum(1+"");
		table.setId("a");
		System.out.println(table);
		int result = repo.insertContent(table);
		ArrayList<Table> list = repo.getRoomContent(1+"");
		ArrayList<String> messageList = new ArrayList<>();
		for(Table a : list) {
			messageList.add(a.toString());
		}
		return messageList;
	}
	
	@RequestMapping(value = "/refresh", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> refresh(HttpSession session, Model model) {
		ArrayList<Table> list = repo.getRoomContent(1+"");
		ArrayList<String> messageList = new ArrayList<>();
		for(Table a : list) {
			messageList.add(a.toString());
		}
		return messageList;
	}
}
