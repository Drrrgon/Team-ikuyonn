package com.ikuyonn.project.events.mapper;

import java.util.ArrayList;

import com.ikuyonn.project.events.vo.Events;


public interface EventsMapper {
	public int insertEvents(Events e);
	
	public ArrayList<Events> privateEvents(Events e);
	
	public Events oneEvents(Events e);
	
	public int updateEvents(Events e);
	
	public int deleteEvents(Events e);
}
