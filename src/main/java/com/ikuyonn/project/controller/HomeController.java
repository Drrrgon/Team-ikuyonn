package com.ikuyonn.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public void index() {
	}	
	@RequestMapping(value = "/components-blog-posts", method = RequestMethod.GET)
	public void componentsblogposts() {
	}	
	@RequestMapping(value = "/add-new-post", method = RequestMethod.GET)
	public void addnewpost() {
	}
	@RequestMapping(value = "/form-components", method = RequestMethod.GET)
	public void formcomponents() {
	}
	@RequestMapping(value = "/tables", method = RequestMethod.GET)
	public void tables() {
	}
	@RequestMapping(value = "/user-profile-lite", method = RequestMethod.GET)
	public void userprofilelite() {
	}
	@RequestMapping(value = "/errors", method = RequestMethod.GET)
	public void errors() {
	}
	@RequestMapping(value = "/insertNameCard", method = RequestMethod.GET)
	public void insertNameCard() {
	}
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chat() {
		return "/chat/chat";
	}
	@RequestMapping(value = "/writeMail", method = RequestMethod.GET)
	public void writeMail() {
	}
	@RequestMapping(value = "/mailBox", method = RequestMethod.GET)
	public void mailBox() {
	}
}
