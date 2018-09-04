package com.ikuyonn.project.uProject.mapper;

import java.util.HashMap;
import java.util.List;

import com.ikuyonn.project.mail.vo.Project;

public interface ProjectMapper {
	
	public List<Project> getUserProjectList(HashMap<String, Object> userMap);

	public int deleteProject(int projectSeq);

	public int deleteJoinProject(HashMap<String, Object> map);

	public int joinProject(HashMap<String, Object> userMap);

	public Project getProjectList(HashMap<String, Object> userMap);

	public int createProject(Project pro);


}
