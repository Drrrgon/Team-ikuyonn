package com.ikuyonn.project.mail.vo;

public class fileVO {

	private int fileSeq;
	private String fileName;
	private String saveFileName;
	private String fileType;
	private int projectSeq;
	public fileVO(int fileSeq, String fileName, String saveFileName, String fileType, int projectSeq) {
		super();
		this.fileSeq = fileSeq;
		this.fileName = fileName;
		this.saveFileName = saveFileName;
		this.fileType = fileType;
		this.projectSeq = projectSeq;
	}
	public fileVO() {
		super();
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public int getProjectSeq() {
		return projectSeq;
	}
	public void setProjectSeq(int projectSeq) {
		this.projectSeq = projectSeq;
	}
	@Override
	public String toString() {
		return "fileVO [fileSeq=" + fileSeq + ", fileName=" + fileName + ", saveFileName=" + saveFileName
				+ ", fileType=" + fileType + ", projectSeq=" + projectSeq + "]";
	}
	
	
}
