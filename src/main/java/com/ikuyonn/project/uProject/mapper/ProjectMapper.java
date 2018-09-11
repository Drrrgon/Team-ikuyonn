package com.ikuyonn.project.uProject.mapper;

import java.util.ArrayList;
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

	public HashMap<String, Object> getCountOfProjectMember(int projectSeq);

	public void updateCountOfProjectMember(HashMap<String, Object> userMap);

	public int updateProjectName(HashMap<String, Object> map);

	public ArrayList<HashMap<String, Object>> getProjectMemeber(int projectSeq);

	/*이민석추가*/
	
}
