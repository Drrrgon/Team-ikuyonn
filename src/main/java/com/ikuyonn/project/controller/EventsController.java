package com.ikuyonn.project.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
		System.out.println("1"+e.toString());
		EventsMapper em = session.getMapper(EventsMapper.class);
		int result = em.insertEvents(e);
		
		return result;
	}
	
	@RequestMapping(value = "/privateEvents", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Events> privateEvents() {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.privateEvents();
		System.out.println("2"+ae.toString());
		return ae;
	}
	
	@RequestMapping(value = "/updateEvents", method = RequestMethod.POST)
	public @ResponseBody void updateEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.privateEvents();

	}
	
	@RequestMapping(value = "/deleteEvents", method = RequestMethod.POST)
	public @ResponseBody void deleteEvents(Events e) {
		EventsMapper em = session.getMapper(EventsMapper.class);
		ArrayList<Events> ae = em.privateEvents();

	}
}
