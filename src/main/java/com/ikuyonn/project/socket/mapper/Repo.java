package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ikuyonn.project.socket.mapper.Mapper;
import com.ikuyonn.project.socket.vo.Message;

@Repository
public class Repo {
	@Autowired SqlSession session;

	public ArrayList<Message> getProjectContent(String projectName) {
		ArrayList<Message> list = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			list = map.getProjectContent(projectName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public Message getLastOneProjectContent(String projectName) {
		Message msg = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			msg = map.getLastOneProjectContent(projectName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return msg;
	}
	
	public int insertContent(Message table) {
		Mapper map = null;
		int re = 0;
		try {
			map = session.getMapper(Mapper.class);
			re = map.insertContent(table);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return re;
	}

	public ArrayList<Message> searchByDate(HashMap<String, Object> map) {
		ArrayList<Message> list = null;
		Mapper tempMap = null;
		try {
			tempMap = session.getMapper(Mapper.class);
			list = tempMap.searchByDate(map);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}

	public ArrayList<Message> getUserByProjectName(String projectName) {
		ArrayList<Message> list = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			list = map.getUserByProjectName(projectName);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}

	public ArrayList<String> searchUserProjectName(String userID) {
		ArrayList<String> list = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			list = map.searchUserProjectName(userID);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}

	
	
	
}
