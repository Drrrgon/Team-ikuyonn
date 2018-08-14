package com.ikuyonn.project.socket.vo;

public class Table {
	private String messageSeq;
	private String message;
	private String userID;
	private String projectName;
	private String messageDate;
	public Table() {}
	public Table(String messageSeq, String message, String userID, String projectName, String messageDate) {
		super();
		this.messageSeq = messageSeq;
		this.message = message;
		this.userID = userID;
		this.projectName = projectName;
		this.messageDate = messageDate;
	}
	public String getmessageSeq() {
		return messageSeq;
	}
	public void setmessageSeq(String messageSeq) {
		this.messageSeq = messageSeq;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUserID() {
		return userID;
	}
	public void setId(String userID) {
		this.userID = userID;
	}
	public String getprojectName() {
		return projectName;
	}
	public void setprojectName(String projectName) {
		this.projectName = projectName;
	}
	public String getmessageDate() {
		return messageDate;
	}
	public void setmessageDate(String messageDate) {
		this.messageDate = messageDate;
	}
	@Override
	public String toString() {
		return userID+" : "+message+"&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"+"보낸 시각 : "+ messageDate;
	}

	
	
}
