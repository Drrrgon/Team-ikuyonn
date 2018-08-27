package com.ikuyonn.project.socket.vo;

import java.util.Date;

public class User {
	private String userID;
	private String userPW;
	private String userName;
	private Date userBirth;
	private String userPhone;
	
	public User() {
		super();
	}
	
	public User(String userID, String userPW, String userName, Date userBirth, String userPhone) {
		super();
		this.userID = userID;
		this.userPW = userPW;
		this.userName = userName;
		this.userBirth = userBirth;
		this.userPhone = userPhone;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPW() {
		return userPW;
	}

	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(Date userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", userPW=" + userPW + ", userName=" + userName + ", userBirth=" + userBirth
				+ ", userPhone=" + userPhone + "]";
	}
	
}
