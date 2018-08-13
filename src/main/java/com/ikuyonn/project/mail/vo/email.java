package com.ikuyonn.project.mail.vo;

public class email {
private String userName;
private String address;
private String id;
private String password;
private String host;
public email(String userName, String address, String id, String password, String host) {
	super();
	this.userName = userName;
	this.address = address;
	this.id = id;
	this.password = password;
	this.host = host;
}
public email() {
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
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getHost() {
	return host;
}
public void setHost(String host) {
	this.host = host;
}
@Override
public String toString() {
	return "email [userName=" + userName + ", address=" + address + ", id=" + id + ", password=" + password + ", host="
			+ host + "]";
}

}
