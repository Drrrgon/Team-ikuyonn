package com.ikuyonn.project.mail.vo;

public class inbox {

	private String userName;
	private String address;
	private int msgNum;
	private String title;
	private String content;
	private String sentdate;
	private String sentaddress;
	public inbox(String userName, String address, int msgNum, String title, String content, String sentdate,
			String sentaddress) {
		super();
		this.userName = userName;
		this.address = address;
		this.msgNum = msgNum;
		this.title = title;
		this.content = content;
		this.sentdate = sentdate;
		this.sentaddress = sentaddress;
	}
	public inbox() {
		super();
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getMsgNum() {
		return msgNum;
	}
	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSentdate() {
		return sentdate;
	}
	public void setSentdate(String sentdate) {
		this.sentdate = sentdate;
	}
	public String getsentaddress() {
		return sentaddress;
	}
	public void setsentaddress(String sentaddress) {
		this.sentaddress = sentaddress;
	}
	@Override
	public String toString() {
		return "inbox [userName=" + userName + ", address=" + address + ", msgNum=" + msgNum + ", title=" + title
				+ ", content=" + content + ", sentdate=" + sentdate + ", sentaddress=" + sentaddress + "]";
	}
	
}
