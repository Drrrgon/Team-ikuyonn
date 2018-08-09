package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;

import com.ikuyonn.project.socket.vo.Table;

public interface Mapper {

	public ArrayList<Table> getRoomContent(String roomNo);

	public int insertContent(Table table);

}
