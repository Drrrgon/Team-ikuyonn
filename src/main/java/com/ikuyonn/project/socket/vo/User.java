package com.ikuyonn.project.socket.vo;

public class User {
	public String userName;
	
	public User() {}
	
	
	
	public User(String userName) {
		super();
		this.userName = userName;
	}



	@Override
	public String toString() {
		return "User [userName=" + userName + "]";
	}



	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
