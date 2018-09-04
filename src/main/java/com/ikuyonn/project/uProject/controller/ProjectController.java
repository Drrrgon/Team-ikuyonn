package com.ikuyonn.project.uProject.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ikuyonn.project.mail.vo.Project;
import com.ikuyonn.project.socket.vo.User;
import com.ikuyonn.project.uProject.mapper.ProjectMapper;

@Controller
public class ProjectController {
	
	@Autowired
	SqlSession session;
	
	
	@RequestMapping(value = "/openProjectInfo", method = RequestMethod.GET)
	public String getProjectInfo() {		
		return "profile/projectInfo";
	}
	
	@RequestMapping(value = "/getprojectInfo", method = RequestMethod.POST)
	public @ResponseBody List<Project> getprojectInfo(User u){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		HashMap<String, Object> map = new HashMap<>();		
			map.put("userID", u.getUserID());
		List<Project> projectList= um.getUserProjectList(map);
		return projectList;
	}
	
	@RequestMapping(value = "/deleteProject", method = RequestMethod.POST)
	public @ResponseBody List<Project> deleteProject(User u, String projectSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		HashMap<String, Object> map = new HashMap<>();		
		// project 값이 null 이 아닌 경우 삭제
		int pjSeq = Integer.parseInt(projectSeq);
		map.put("userID", u.getUserID());
		map.put("projectSeq", pjSeq);
		int res = um.deleteJoinProject(map);
		int re = um.deleteProject(pjSeq);
		List<Project> projectList= um.getUserProjectList(map);
		return projectList;
	}
	
	@RequestMapping(value = "/createProject", method = RequestMethod.POST)
	public @ResponseBody List<Project> createProject(User u, String projectName){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		Project pro = new Project();
		pro.setProjectName(projectName);
		HashMap <String, Object> userMap = new HashMap<String, Object>();
		userMap.put("userID", u.getUserID());
		userMap.put("projectName", projectName);
		int re = um.createProject(pro);
		userMap.put("projectSeq", pro.getProjectSeq());
		int res = um.joinProject(userMap);
		List<Project> project = um.getUserProjectList(userMap);
		
		return project;
	}
	
}
