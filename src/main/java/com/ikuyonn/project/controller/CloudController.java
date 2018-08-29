package com.ikuyonn.project.controller;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.Project;

@Controller
public class CloudController {
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/getProject", method = RequestMethod.POST)
	public @ResponseBody String getProject(String userID) {
		System.out.println(userID);
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<Project> project = mapper.getProject(userID);
		System.out.println(project);
		return "project";
	}
}
