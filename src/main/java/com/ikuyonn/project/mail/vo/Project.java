package com.ikuyonn.project.mail.vo;

public class Project {

	private int projectSeq;
	private String projectMaster;
	private String projectName;
	private int memberNum;
	private String due;
	private String color;
	private int status;
	
	public Project() {
		super();
	}

	public Project(int projectSeq, String projectMaster, String projectName, int memberNum, String due, String color,
			int status) {
		super();
		this.projectSeq = projectSeq;
		this.projectMaster = projectMaster;
		this.projectName = projectName;
		this.memberNum = memberNum;
		this.due = due;
		this.color = color;
		this.status = status;
	}

	public int getProjectSeq() {
		return projectSeq;
	}


	public void setProjectSeq(int projectSeq) {
		this.projectSeq = projectSeq;
	}


	public String getProjectMaster() {
		return projectMaster;
	}


	public void setProjectMaster(String projectMaster) {
		this.projectMaster = projectMaster;
	}


	public String getProjectName() {
		return projectName;
	}


	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}


	public int getMemberNum() {
		return memberNum;
	}


	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}


	public String getDue() {
		return due;
	}


	public void setDue(String due) {
		this.due = due;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Project [projectSeq=" + projectSeq + ", projectMaster=" + projectMaster + ", projectName=" + projectName
				+ ", memberNum=" + memberNum + ", due=" + due + ", color=" + color + ", status=" + status + "]";
	}

	
		
}
