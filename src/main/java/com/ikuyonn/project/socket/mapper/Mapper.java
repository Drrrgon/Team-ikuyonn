package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.ikuyonn.project.socket.vo.Table;

public interface Mapper {

	public ArrayList<Table> getProjectContent(String roomNo);

	public int insertContent(Table table);

	public ArrayList<Table> searchByDate(HashMap<String, Object> map);

}
