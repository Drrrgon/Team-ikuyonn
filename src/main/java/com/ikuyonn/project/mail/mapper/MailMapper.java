package com.ikuyonn.project.mail.mapper;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.mail.vo.Project;
import com.ikuyonn.project.mail.vo.email;
import com.ikuyonn.project.mail.vo.fileVO;
import com.ikuyonn.project.mail.vo.inbox;
import com.ikuyonn.project.socket.vo.User;



public interface MailMapper {

	public int signin(User user);
	
	public User checkid(String userID);
	
	public User login(User user);
	
	public email getAddress(String emailAddress);
	
	public ArrayList<email> mailList(String userID);
	
	public void addAddress(email email);
	
	public int checkEmail(email email);
	
	public void delAddress(email email);
	
	public void addInbox(inbox inbox);
	
	public void clearInbox();
	
	public ArrayList<inbox> getInbox(inbox inbox);
	
	public inbox getmail(inbox inbox);
	
	public ArrayList<Project> getProject(String userID);
	
	public void addFile(fileVO file);
	
	public ArrayList<fileVO> getFileList(int proSeq);
	
	public fileVO getFile(int fileSeq);
	
	public void delInbox(email email);
	
	public void delFile(int fileSeq);
}
