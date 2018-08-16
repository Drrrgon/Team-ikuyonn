package com.ikuyonn.project.user.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String joinPage(HttpSession hs) {
		hs.invalidate();
		
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
		hs.setAttribute("ur", ur);
		return "insertNameCard";
	}

	@RequestMapping(value = "/joinUser", method = RequestMethod.POST)
	public String joinUser(User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.insertUser(u);
		
		return "redirect:/";
	}
	
/*	@RequestMapping(value = "/upM", method = RequestMethod.GET)
	public String upM(Model model, User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		User em = um.selectUser(u);
		model.addAttribute("up", em);

		return "information";
	}
	
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public @ResponseBody String updateUser(User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.updateUser(u);
		
		return "success";
	}*/
	
	@RequestMapping(value = "/deleteUser", method = RequestMethod.GET)
	public String deleteUser(User u) {
		UserMapper um = session.getMapper(UserMapper.class);
		um.deleteUser(u);
		
		return "redirect:/";
	}
}
