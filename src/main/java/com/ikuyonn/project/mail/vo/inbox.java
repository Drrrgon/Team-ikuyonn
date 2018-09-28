package com.ikuyonn.project.mail.vo;

public class inbox {

	private String emailAddress;
	private int msgNum;
	private String title;
	private String content;
	private String sentdate;
	private String sentaddress;
	public inbox() {
		super();
	}
	public inbox(String emailAddress, int msgNum, String title, String content, String sentdate, String sentaddress) {
		super();
		this.emailAddress = emailAddress;
		this.msgNum = msgNum;
		this.title = title;
		this.content = content;
		this.sentdate = sentdate;
		this.sentaddress = sentaddress;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
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
	public String getSentaddress() {
		return sentaddress;
	}
	public void setSentaddress(String sentaddress) {
		this.sentaddress = sentaddress;
	}
	@Override
	public String toString() {
		return "inbox [emailAddress=" + emailAddress + ", msgNum=" + msgNum + ", title=" + title + ", content="
				+ content + ", sentdate=" + sentdate + ", sentaddress=" + sentaddress + "]";
	}
	
}
