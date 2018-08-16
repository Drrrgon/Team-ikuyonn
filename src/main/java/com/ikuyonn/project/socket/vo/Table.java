package com.ikuyonn.project.socket.vo;

public class Table {
	private String messageSeq;
	private String message;
	private String userName;
	private String projectName;
	private String messageDate;
	public Table() {}
	public Table(String messageSeq, String message, String userName, String projectName, String messageDate) {
		super();
		this.messageSeq = messageSeq;
		this.message = message;
		this.userName = userName;
		this.projectName = projectName;
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
	public String getMessageDate() {
		return messageDate;
	}
	public void setMessageDate(String messageDate) {
		this.messageDate = messageDate;
	}	
	public String sendMessage() {
		return userName+" : "+message+"&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"+"보낸 시각 : "+ messageDate;
	}
	@Override
	public String toString() {
		return "Table [messageSeq=" + messageSeq + ", message=" + message + ", userName=" + userName + ", projectName="
				+ projectName + ", messageDate=" + messageDate + "]";
	}
	

	
	
}
