package com.ikuyonn.project.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.events.mapper.EventsMapper;
import com.ikuyonn.project.events.vo.Events;

@Controller
public class EventsController {
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/insertEvents", method = RequestMethod.POST)
	public @ResponseBody int insertEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		int result = em.insertEvents(e);
		
		return result;
	}
	
	@RequestMapping(value = "/privateEvents", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Events> privateEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.privateEvents(e);		
		
		return ae;
	}
	
	@RequestMapping(value = "/oneEvents", method = RequestMethod.POST)
	public @ResponseBody Events oneEvents(HttpSession hs, Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		Events es = em.oneEvents(e);
		hs.setAttribute("projectSeq", es.getProjectSeq());
		
		return es;
	}
	
	@RequestMapping(value = "/updateEvents", method = RequestMethod.POST)
	public @ResponseBody int updateEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		int result = em.updateEvents(e);
		
		return result;
	}
	
	@RequestMapping(value = "/deleteEvents", method = RequestMethod.GET)
	public @ResponseBody int deleteEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		int result = em.deleteEvents(e);
		
		return result;
	}
	
	@RequestMapping(value = "/projectEventsList", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Events> projectEventsList(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.projectEventsList(e);
		
		return ae;
	}
}
