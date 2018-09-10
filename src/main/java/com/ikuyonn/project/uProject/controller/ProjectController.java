package com.ikuyonn.project.uProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.ikuyonn.project.mail.mapper.MailMapper;
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
	
	@RequestMapping(value = "/getProjectInfo", method = RequestMethod.POST)
	public @ResponseBody List<Project> getProjectInfo(User u){
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
		map.put("userID", null);
		List<Project> projectList= um.getUserProjectList(map);
		return projectList;
	}
	
	@RequestMapping(value = "/createProject", method = RequestMethod.POST)
	public @ResponseBody List<Project> createProject(User u, String projectName, String due,String[] emails){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		Project pro = new Project();
		pro.setProjectMaster(u.getUserID());
		pro.setProjectName(projectName);
		HashMap <String, Object> userMap = new HashMap<String, Object>();
		userMap.put("userID", u.getUserID());
		userMap.put("projectName", projectName);
		if(due.contains("-")) {
			pro.setDue(due);
		}
		pro.setDue("기간 미정");
		int re = um.createProject(pro);
		userMap.put("projectSeq", pro.getProjectSeq());
		
		/*이민석 추가*/
		System.out.println("emails[0] : " + emails[0]);
		MailMapper mailMapper = session.getMapper(MailMapper.class);
		um.joinProject(userMap);
		HashMap<String, Object> parameters = new HashMap<>();	
		for(String s : emails) {
			parameters.put("userID", mailMapper.selectUserID(s));
			parameters.put("projectSeq",pro.getProjectSeq());
			System.out.println("userid : "+parameters.get("userID")+" projectSEQ : "+parameters.get("projectSEQ"));
			int res = um.joinProject(parameters);
		}
		userMap = um.getCountOfProjectMember(pro.getProjectSeq());
		userMap.put("PROJECTSEQ", pro.getProjectSeq());
		um.updateCountOfProjectMember(userMap);
		List<Project> project = um.getUserProjectList(userMap);		
		
		
		return project;
	}
	
}
