package com.ikuyonn.project.uProject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.Project;
import com.ikuyonn.project.mail.vo.email;
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
	
	@RequestMapping(value = "/accept", method = RequestMethod.POST)
	public @ResponseBody void accept(String userID, String pjSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		HashMap<String, Object> map = new HashMap<>();		
			map.put("userID", userID);
			map.put("projectSeq",pjSeq);
		um.accept(map);
		map = um.getCountOfProjectMember(Integer.parseInt(pjSeq));
		map.put("projectSeq", Integer.parseInt(pjSeq));
		um.updateCountOfProjectMember(map);
	}
	
	@RequestMapping(value = "/reject", method = RequestMethod.POST)
	public @ResponseBody void reject(String userID, String pjSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		HashMap<String, Object> map = new HashMap<>();		
			map.put("userID", userID);
			map.put("projectSeq",pjSeq);
		um.reject(map);
		map = um.getCountOfProjectMember(Integer.parseInt(pjSeq));
		map.put("projectSeq", Integer.parseInt(pjSeq));
		um.updateCountOfProjectMember(map);
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
	public @ResponseBody List<Project> createProject(User u, String projectName, String due,String[] emails, String color){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		Project pro = new Project();
		pro.setColor(color);
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
		System.out.println(userMap);
		
		/*이민석 추가*/
		System.out.println("emails[0] : " + emails[0]);
		MailMapper mailMapper = session.getMapper(MailMapper.class);
		userMap.put("status", 1);
		um.joinProject(userMap);
		HashMap<String, Object> parameters = new HashMap<>();	
		for(String s : emails) {
			parameters.put("userID", mailMapper.selectUserID(s));
			parameters.put("projectSeq",pro.getProjectSeq());
			parameters.put("status",0);
			System.out.println("userid : "+parameters.get("userID")+" projectSEQ : "+parameters.get("projectSEQ"));
			int res = um.joinProject(parameters);
		}
		userMap = um.getCountOfProjectMember(pro.getProjectSeq());
		userMap.put("projectSeq", pro.getProjectSeq());
		um.updateCountOfProjectMember(userMap);
		List<Project> project = um.getUserProjectList(userMap);		
		
		return project;
	}
	
	@RequestMapping(value = "/modifyProjectName", method = RequestMethod.POST)
	public @ResponseBody int modifyProjectName(String newName, String projectSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		HashMap<String, Object> map = new HashMap<>();		
		// project 값이 null 이 아닌 경우 삭제
		int pjSeq = Integer.parseInt(projectSeq);
		map.put("projectName", newName);
		map.put("projectSeq", pjSeq);
		int re = um.updateProjectName(map);
		return re;
	}
	
	@RequestMapping(value = "/getProjectMemeber", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> getProjectMemeber(String projectSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		int pjSeq = Integer.parseInt(projectSeq);
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		list = um.getProjectMemeber(pjSeq);
		ArrayList<String> returnList = new ArrayList<>();
		for (HashMap<String, Object> temp : list) {
			returnList.add((String) temp.get("userID"));//for maria
//			returnList.add((String) temp.get("USERID"));//for oracle
		}
		return returnList;
	}
	
	@RequestMapping(value = "/secessionProjectMember", method = RequestMethod.POST)
	public @ResponseBody int secessionProjectMember(String projectSeq, String userID){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		int pjSeq = Integer.parseInt(projectSeq);
		HashMap<String, Object> map = new HashMap<>();
		map.put("projectSeq", pjSeq);
		map.put("userID", userID);
		int re = um.secessionProjectMember(map);
		map = um.getCountOfProjectMember(pjSeq);
		map.put("projectSeq", pjSeq);
		um.updateCountOfProjectMember(map);
		return re;
	}
	
	@RequestMapping(value = "/checkProjectMaster", method = RequestMethod.POST)
	public @ResponseBody String checkProjectMaster(String projectSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		int pjSeq = Integer.parseInt(projectSeq);
		HashMap<String, Object> map = new HashMap<>();
		map.put("projectSeq", pjSeq);
		String re = um.checkProjectMaster(map);
		return re;
	}
	
	@RequestMapping(value = "/getNotJoinedProjectID", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> getNotJoinedProjectID(String projectSeq, String userID){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		int pjSeq = Integer.parseInt(projectSeq);
		HashMap<String, Object> map = new HashMap<>();
		map.put("projectSeq", pjSeq);
		String re = um.checkProjectMaster(map);
		ArrayList<String> list = null;
		if(re.equals(userID)) {
			map.put("userID",userID);
			list = um.getNotJoinedProjectID(map);
		}
		return list;
	}
	@RequestMapping(value = "/getEmailAddress", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> getEamilAddress(String userID){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		MailMapper mailMapper = session.getMapper(MailMapper.class);
		ArrayList<email> tempMail = mailMapper.mailList(userID);
		ArrayList<String> list = new ArrayList<>();
		for(email each : tempMail) {
			list.add(each.getEmailAddress());
		}
		return list;
	}
	
	@RequestMapping(value = "/joinProject", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> joinProject(String email, String projectSeq){
		ProjectMapper um = session.getMapper(ProjectMapper.class);
		MailMapper mailMapper = session.getMapper(MailMapper.class);
		int projectSeqC = Integer.parseInt(projectSeq);
		HashMap<String, Object> parameters = new HashMap<>();	
		parameters.put("userID", mailMapper.selectUserID(email));
		parameters.put("projectSeq",projectSeqC);
		parameters.put("status",0);
		System.out.println("userid : "+parameters.get("userID")+" projectSEQ : "+parameters.get("projectSEQ"));
		int res = um.joinProject(parameters);
		HashMap <String, Object> userMap = new HashMap<String, Object>();
		
		userMap = um.getCountOfProjectMember(projectSeqC);
		userMap.put("projectSeq", projectSeqC);
		um.updateCountOfProjectMember(userMap);
		
		return null;
	}
}
