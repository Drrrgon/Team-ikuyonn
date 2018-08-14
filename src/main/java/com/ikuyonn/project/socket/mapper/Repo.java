package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ikuyonn.project.socket.mapper.Mapper;
import com.ikuyonn.project.socket.vo.Table;

@Repository
public class Repo {
	@Autowired SqlSession session;

	public ArrayList<Table> getProjectContent(String projectName) {
		ArrayList<Table> list = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			list = map.getProjectContent(projectName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public int insertContent(Table table) {
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

	public ArrayList<Table> searchByDate(HashMap<String, Object> map) {
		ArrayList<Table> list = null;
		Mapper tempMap = null;
		try {
			tempMap = session.getMapper(Mapper.class);
			list = tempMap.searchByDate(map);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}
	
	
}
