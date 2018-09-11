package com.ikuyonn.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.Project;
import com.ikuyonn.project.mail.vo.fileVO;

@Controller
public class CloudController {
	@Autowired
	SqlSession session;
	private static  String UPLOADPATH = "";
	
//	@RequestMapping(value = "/getProject", method = RequestMethod.POST)
//	public @ResponseBody ArrayList<Project> getProject(String userID) {
//		MailMapper mapper = session.getMapper(MailMapper.class);
//		ArrayList<Project> project = mapper.getProject(userID);
//		return project;
//	}
	@RequestMapping(value = "/addFile", method = RequestMethod.POST)
	public @ResponseBody ArrayList<fileVO> addFile(MultipartFile file,int proSeq, HttpServletRequest request) {
		ServletContext cotx = request.getSession().getServletContext();
		UPLOADPATH = cotx.getRealPath("/resources/cloud/");
		System.out.println(UPLOADPATH);
		fileVO f = new fileVO();
		f.setFileName(file.getOriginalFilename());
		f.setSaveFileName(fileService(file));
		f.setProjectSeq(proSeq);
		String fileName= file.getOriginalFilename();
		int pos = fileName.lastIndexOf( "." );
		String ext = fileName.substring( pos + 1 );
		f.setFileType(ext);
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.addFile(f);
		ArrayList<fileVO> fList = getFileList(proSeq);
		return fList;
	}
	
	@RequestMapping(value = "/delFile", method = RequestMethod.POST)
	public @ResponseBody ArrayList<fileVO> delFile(int fileSeq,int proSeq,HttpServletRequest request) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		fileVO vo = mapper.getFile(fileSeq);
		ServletContext cotx = request.getSession().getServletContext();
		UPLOADPATH = cotx.getRealPath("/resources/cloud/");	
		String fullPath = UPLOADPATH+vo.getSaveFileName();
		File file = new File(fullPath);
		file.delete();
		mapper.delFile(fileSeq);
		ArrayList<fileVO> fList = getFileList(proSeq);
		return fList;
	}
	@RequestMapping(value = "/fileList", method = RequestMethod.POST)
	public @ResponseBody ArrayList<fileVO> fileList(fileVO f) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<fileVO> fList = getFileList(f.getProjectSeq());
		return fList;
	}
	@RequestMapping(value = "/downFile", method = RequestMethod.GET)
	public void downFile(fileVO f,HttpServletResponse response, HttpServletRequest request) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ServletContext cotx = request.getSession().getServletContext();
		UPLOADPATH = cotx.getRealPath("/resources/cloud/");		
		fileVO vo = mapper.getFile(f.getFileSeq());
		try {
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; fileName=" 
			+ URLEncoder.encode(vo.getFileName(), "UTF-8"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		FileInputStream fis = null;
		ServletOutputStream sos = null;
		
		String fullPath = UPLOADPATH+vo.getSaveFileName();
		try {
			fis = new FileInputStream(fullPath);
			sos = response.getOutputStream();
			FileCopyUtils.copy(fis, sos);
			fis.close();
			/*
			sos.close();*/
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ArrayList<fileVO> getFileList(int proSeq){
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<fileVO> fileList = mapper.getFileList(proSeq);
		return fileList;
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
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		return saveFileName;
	}

}
