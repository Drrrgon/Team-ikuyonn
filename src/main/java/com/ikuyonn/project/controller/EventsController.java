package com.ikuyonn.project.controller;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.events.mapper.EventsMapper;
import com.ikuyonn.project.events.vo.Events;
import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.Project;

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
	public @ResponseBody ArrayList<Events> privateEvents(String userID) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		MailMapper mm = session.getMapper(MailMapper.class);
		
		ArrayList<Events> ae = em.privateEvents(userID);
		/*ArrayList<Project> ap = mm.getProject(userID);
		
		for(int i = 0; i < ap.size() ; i++) {
			String sp = Integer.toString(ap.get(i).getProjectSeq());
			ae = em.privateEvents(sp);
		}*/
		
		return ae;
	}
	
	@RequestMapping(value = "/oneEvents", method = RequestMethod.POST)
	public @ResponseBody Events oneEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		Events es = em.oneEvents(e);	
		
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
	
/*	@RequestMapping(value = "/projectEvents", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Events> projectEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.projectEvents(e);
		
		return ae;
	}*/
}
