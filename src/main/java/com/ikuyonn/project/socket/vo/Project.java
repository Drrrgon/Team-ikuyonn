package com.ikuyonn.project.socket.vo;

public class Project {
	private int projectSeq;
	private String projectName;
	private String due;
	private int number;
	public Project() {
		super();
	}
	
	public Project(int projectSeq, String projectName, String due, int number) {
		super();
		this.projectSeq = projectSeq;
		this.projectName = projectName;
		this.due = due;
		this.number = number;
	}

	
	public int getProjectSeq() {
		return projectSeq;
	}

	public void setProjectSeq(int projectSeq) {
		this.projectSeq = projectSeq;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getDue() {
		return due;
	}

	public void setDue(String due) {
		this.due = due;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	@Override
	public String toString() {
		return "Project [projectSeq=" + projectSeq + ", projectName=" + projectName + ", due=" + due + ", number="
				+ number + "]";
	}
	
	
}
