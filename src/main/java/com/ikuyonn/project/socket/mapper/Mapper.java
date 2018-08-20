package com.ikuyonn.project.socket.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.ikuyonn.project.socket.vo.Message;

public interface Mapper {

	public ArrayList<Message> getProjectContent(String roomNo);

	public int insertContent(Message table);

	public ArrayList<Message> searchByDate(HashMap<String, Object> map);

	public ArrayList<Message> getUserByProjectName(String projectName);

}
