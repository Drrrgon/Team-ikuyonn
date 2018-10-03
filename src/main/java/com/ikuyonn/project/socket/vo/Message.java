package com.ikuyonn.project.socket.vo;

public class Message {
	private String messageSeq;
	private String message;
	private String userID;
	private String userName;
	private String projectName;
	private String projectSeq;
	private String messageDate;

	

	public Message() {
		super();
	}
	


	public Message(String messageSeq, String message, String userID, String userName, String projectName,
			String projectSeq, String messageDate) {
		super();
		this.messageSeq = messageSeq;
		this.message = message;
		this.userID = userID;
		this.userName = userName;
		this.projectName = projectName;
		this.projectSeq = projectSeq;
		this.messageDate = messageDate;
	}

	

	public String getMessageSeq() {
		return messageSeq;
	}



	public void setMessageSeq(String messageSeq) {
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



	public void setUserID(String userID) {
		this.userID = userID;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getProjectName() {
		return projectName;
	}



	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}



	public String getProjectSeq() {
		return projectSeq;
	}



	public void setProjectSeq(String projectSeq) {
		this.projectSeq = projectSeq;
	}



	public String getMessageDate() {
		return messageDate;
	}



	public void setMessageDate(String messageDate) {
		this.messageDate = messageDate;
	}



	@Override
	public String toString() {
		return "Message [messageSeq=" + messageSeq + ", message=" + message + ", userID=" + userID + ", userName="
				+ userName + ", projectName=" + projectName + ", projectSeq=" + projectSeq + ", messageDate="
				+ messageDate + "]";
	}



	public String sendMessage() {
		return userID + ":#$" + userName + ":#$" + message + ":#$" + messageDate + "#%9745332";
	}

}
