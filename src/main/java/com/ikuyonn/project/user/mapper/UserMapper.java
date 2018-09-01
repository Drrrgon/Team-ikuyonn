package com.ikuyonn.project.user.mapper;

import com.ikuyonn.project.socket.vo.User;

public interface UserMapper {
	public int insertUser(User u);
	
	public User loginUser(User u);
	
	public User selectUser(User u);
	
	public int updateUser(User u);
	
	public void deleteUser(User u);

	public int deleteUserProfile(User ur);
}
