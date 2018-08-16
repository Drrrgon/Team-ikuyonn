package com.ikuyonn.project.mail.vo;

public class email {
private String userID;
private String emailAddress;
private String emailId;
private String emailPassword;
private String host;
private String smtp;
public email(String userID, String emailAddress, String emailId, String emailPassword, String host, String smtp) {
	super();
	this.userID = userID;
	this.emailAddress = emailAddress;
	this.emailId = emailId;
	this.emailPassword = emailPassword;
	this.host = host;
	this.smtp = smtp;
}
public email() {
	super();
}
public String getUserID() {
	return userID;
}
public void setUserID(String userID) {
	this.userID = userID;
}
public String getEmailAddress() {
	return emailAddress;
}
public void setEmailAddress(String emailAddress) {
	this.emailAddress = emailAddress;
}
public String getEmailId() {
	return emailId;
}
public void setEmailId(String emailId) {
	this.emailId = emailId;
}
public String getEmailPassword() {
	return emailPassword;
}
public void setEmailPassword(String emailPassword) {
	this.emailPassword = emailPassword;
}
public String getHost() {
	return host;
}
public void setHost(String host) {
	this.host = host;
}
public String getSmtp() {
	return smtp;
}
public void setSmtp(String smtp) {
	this.smtp = smtp;
}
@Override
public String toString() {
	return "email [userID=" + userID + ", emailAddress=" + emailAddress + ", emailId=" + emailId + ", emailPassword="
			+ emailPassword + ", host=" + host + ", smtp=" + smtp + "]";
}


}
