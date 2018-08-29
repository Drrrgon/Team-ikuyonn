package com.ikuyonn.project.nameCard.vo;

public class NameCard {
	private String userID;
	private String ncCheck;
	private String ncName;
	private String ncMobile;
	private String ncPhone;
	private String ncFax;
	private String ncEmail;
	private String ncCompany;
	private String ncDepartment;
	private String ncTitle;
	private String ncWebsite;
	private String ncAddress;
	private String nameCardUrl;
	private String ncGroup;
	public NameCard() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NameCard(String userID, String ncCheck, String ncName, String ncMobile, String ncPhone, String ncFax,
			String ncEmail, String ncCompany, String ncDepartment, String ncTitle, String ncWebsite, String ncAddress,
			String nameCardUrl, String ncGroup) {
		super();
		this.userID = userID;
		this.ncCheck = ncCheck;
		this.ncName = ncName;
		this.ncMobile = ncMobile;
		this.ncPhone = ncPhone;
		this.ncFax = ncFax;
		this.ncEmail = ncEmail;
		this.ncCompany = ncCompany;
		this.ncDepartment = ncDepartment;
		this.ncTitle = ncTitle;
		this.ncWebsite = ncWebsite;
		this.ncAddress = ncAddress;
		this.nameCardUrl = nameCardUrl;
		this.ncGroup = ncGroup;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getNcCheck() {
		return ncCheck;
	}
	public void setNcCheck(String ncCheck) {
		this.ncCheck = ncCheck;
	}
	public String getNcName() {
		return ncName;
	}
	public void setNcName(String ncName) {
		this.ncName = ncName;
	}
	public String getNcMobile() {
		return ncMobile;
	}
	public void setNcMobile(String ncMobile) {
		this.ncMobile = ncMobile;
	}
	public String getNcPhone() {
		return ncPhone;
	}
	public void setNcPhone(String ncPhone) {
		this.ncPhone = ncPhone;
	}
	public String getNcFax() {
		return ncFax;
	}
	public void setNcFax(String ncFax) {
		this.ncFax = ncFax;
	}
	public String getNcEmail() {
		return ncEmail;
	}
	public void setNcEmail(String ncEmail) {
		this.ncEmail = ncEmail;
	}
	public String getNcCompany() {
		return ncCompany;
	}
	public void setNcCompany(String ncCompany) {
		this.ncCompany = ncCompany;
	}
	public String getNcDepartment() {
		return ncDepartment;
	}
	public void setNcDepartment(String ncDepartment) {
		this.ncDepartment = ncDepartment;
	}
	public String getNcTitle() {
		return ncTitle;
	}
	public void setNcTitle(String ncTitle) {
		this.ncTitle = ncTitle;
	}
	public String getNcWebsite() {
		return ncWebsite;
	}
	public void setNcWebsite(String ncWebsite) {
		this.ncWebsite = ncWebsite;
	}
	public String getNcAddress() {
		return ncAddress;
	}
	public void setNcAddress(String ncAddress) {
		this.ncAddress = ncAddress;
	}
	public String getNameCardUrl() {
		return nameCardUrl;
	}
	public void setNameCardUrl(String nameCardUrl) {
		this.nameCardUrl = nameCardUrl;
	}
	public String getNcGroup() {
		return ncGroup;
	}
	public void setNcGroup(String ncGroup) {
		this.ncGroup = ncGroup;
	}
	@Override
	public String toString() {
		return "NameCard [userID=" + userID + ", ncCheck=" + ncCheck + ", ncName=" + ncName + ", ncMobile=" + ncMobile
				+ ", ncPhone=" + ncPhone + ", ncFax=" + ncFax + ", ncEmail=" + ncEmail + ", ncCompany=" + ncCompany
				+ ", ncDepartment=" + ncDepartment + ", ncTitle=" + ncTitle + ", ncWebsite=" + ncWebsite
				+ ", ncAddress=" + ncAddress + ", nameCardUrl=" + nameCardUrl + ", ncGroup=" + ncGroup + "]";
	}
}
