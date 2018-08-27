package com.ikuyonn.project.events.vo;

import java.util.Date;

public class Events {
	private String eventSeq;
	private String userID;
	private String summary;
	private String description;
	private Date startDate;
	private Date endDate;
	
	public Events() {
		super();
	}

	public Events(String eventSeq, String userID, String summary, String description, Date startDate, Date endDate) {
		super();
		this.eventSeq = eventSeq;
		this.userID = userID;
		this.summary = summary;
		this.description = description;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public String getEventSeq() {
		return eventSeq;
	}

	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "Events [eventSeq=" + eventSeq + ", userID=" + userID + ", summary=" + summary + ", description="
				+ description + ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

}
