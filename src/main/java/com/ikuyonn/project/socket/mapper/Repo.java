package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ikuyonn.project.socket.mapper.Mapper;
import com.ikuyonn.project.socket.vo.Table;

@Repository
public class Repo {
	@Autowired SqlSession session;

	public ArrayList<Table> getRoomContent(String roomNo) {
		ArrayList<Table> list = null;
		Mapper map = null;
		try {
			map = session.getMapper(Mapper.class);
			list = map.getRoomContent(roomNo);
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
	
	
}
