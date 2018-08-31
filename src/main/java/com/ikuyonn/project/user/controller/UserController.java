package com.ikuyonn.project.user.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.socket.vo.User;
import com.ikuyonn.project.user.mapper.UserMapper;

@Controller
public class UserController {
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/joinPage", method = RequestMethod.GET)
	public String joinPage() {
		
		return "join";
	}
	
	@RequestMapping(value = "/logoutUser", method = RequestMethod.GET)
	public String logoutUser(HttpSession hs) {
		hs.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/loginUser", method = RequestMethod.POST)
	public String loginUser(HttpSession hs, User u){
		UserMapper um = session.getMapper(UserMapper.class);
		User ur = um.loginUser(u);
		// hs.setAttribute("ur", ur);
		hs.setAttribute("userID", ur.getUserID());
		hs.setAttribute("userName", ur.getUserName());
		return "insertNameCard";
	}
	
	@RequestMapping(value = "/loginUserCheck", method = RequestMethod.POST)
	public @ResponseBody String loginUserCheck(User u){
		System.out.println(u);
		UserMapper um = session.getMapper(UserMapper.class);
		User ur = um.loginUser(u);
		if(ur != null) {
			return 1+"";
		}
		return 0+"";
	}

	@RequestMapping(value = "/joinUser", method = RequestMethod.POST)
	public String joinUser(User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.insertUser(u);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public String updateUser(HttpSession hs, User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.updateUser(u);
		hs.invalidate();	
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/deleteUser", method = RequestMethod.GET)
	public String deleteUser(User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.deleteUser(u);
		
		return "redirect:/";
	}
}
