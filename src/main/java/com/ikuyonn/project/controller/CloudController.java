package com.ikuyonn.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.Project;

@Controller
public class CloudController {
	@Autowired
	SqlSession session;
	private static final String UPLOADPATH = "c:\\\\filerepo\\\\";
	
	@RequestMapping(value = "/getProject", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Project> getProject(String userID) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<Project> project = mapper.getProject(userID);
		return project;
	}
	@RequestMapping(value = "/addFile", method = RequestMethod.POST)
	public @ResponseBody String addFile(MultipartFile file) {
		System.out.println(file);
		String temp=fileService(file);
		System.out.println(temp);
		return temp;
	}
	
	public String fileService(MultipartFile uploadfile) {
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid+"_"+uploadfile.getOriginalFilename();
		File saveFile = new File(UPLOADPATH,saveFileName);
		if(!saveFile.exists()) {
			saveFile.mkdirs();
			}
		try {
			uploadfile.transferTo(saveFile);
			/*FileOutputStream fos = new FileOutputStream(file2); 
		    fos.write(file.getBytes());
		    fos.close(); */
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		return "success";
	}

}
