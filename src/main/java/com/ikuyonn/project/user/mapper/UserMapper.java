package com.ikuyonn.project.user.mapper;

import java.util.HashMap;
import java.util.List;

import com.ikuyonn.project.mail.vo.Project;
import com.ikuyonn.project.socket.vo.User;

public interface UserMapper {
	public int insertUser(User u);
	
	public User loginUser(User u);
	
	public User selectUser(User u);
	
	public int updateUser(User u);
	
	public void deleteUser(User u);

	public int deleteUserProfile(User ur);

	public List<Project> getUserProjectList(HashMap<String, Object> userMap);

	public int deleteProject(int projectSeq);

	public int deleteJoinProject(HashMap<String, Object> map);

	public int joinProject(HashMap<String, Object> userMap);

	public Project getProjectList(HashMap<String, Object> userMap);

	public int createProject(Project pro);


}
