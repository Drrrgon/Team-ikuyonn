package com.ikuyonn.project.socket.vo;

public class Table {
	private String seq;
	private String message;
	private String id;
	private String roomnum;
	private String datetime;
	public Table() {}
	public Table(String seq, String message, String id, String roomnum, String datetime) {
		super();
		this.seq = seq;
		this.message = message;
		this.id = id;
		this.roomnum = roomnum;
		this.datetime = datetime;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRoomnum() {
		return roomnum;
	}
	public void setRoomnum(String roomnum) {
		this.roomnum = roomnum;
	}
	public String getdatetime() {
		return datetime;
	}
	public void setdatetime(String datetime) {
		this.datetime = datetime;
	}
	@Override
	public String toString() {
		return id+" : "+message+"&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"+"보낸 시각 : "+ datetime;
	}

	
	
}
