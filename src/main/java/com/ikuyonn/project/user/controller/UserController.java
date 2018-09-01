package com.ikuyonn.project.user.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ikuyonn.project.socket.vo.User;
import com.ikuyonn.project.user.mapper.UserMapper;
import com.ikuyonn.project.user.util.FileManager;

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
		if(ur.getOriginalFileName() == null) {
			String path = "./resources/images/default.jpg";
			hs.setAttribute("userProfilePath", path);
		}
		else {
			String path = "./image/"+ur.getOriginalFileName();
			hs.setAttribute("userProfilePath", path);
		}
		
		return "insertNameCard";
	}
	
	@RequestMapping(value = "/loginUserCheck", method = RequestMethod.POST)
	public @ResponseBody String loginUserCheck(User u){
		UserMapper um = session.getMapper(UserMapper.class);
		User ur = um.loginUser(u);
		if(ur != null) {
			return 1+"";
		}
		return 0+"";
	}
	
	@RequestMapping(value = "/ProfilefileUplodeAction", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String ProfilefileUplodeAction(HttpSession hSession, HttpServletRequest req, MultipartFile fileUplode){
		UserMapper um = session.getMapper(UserMapper.class);
		ServletContext cotx = req.getSession().getServletContext();
		String path = cotx.getRealPath("/resources/userProfileImage");
		FileManager fm = new FileManager(path);
		
		User ur = new User();
		ur.setUserID(hSession.getAttribute("userID")+"");
		ur = um.loginUser(ur);
		fm.DeleteFile(ur.getOriginalFileName());
		int re = um.deleteUserProfile(ur);		
		String result[] =fm.uploadFile(fileUplode);
		ur.setOriginalFileName(result[1]);
		re = um.updateUser(ur);
		
		return "./image/"+result[1];
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
