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
	
	@RequestMapping(value = "/userprofilelite", method = RequestMethod.GET)
	public String userprofilelite() {
		return "/profile/userprofilelite";
	}
	@RequestMapping(value = "/insertNameCard", method = RequestMethod.GET)
	public String insertNameCard() {
		return "/nameCard/insertNameCard";
	}
	@RequestMapping(value = "/insertNameCard2", method = RequestMethod.GET)
	public String insertNameCard2() {
		return "/nameCard/insertNameCard2";
	}
	@RequestMapping(value = "/writeMail", method = RequestMethod.GET)
	public String writeMail() {
		return "/mail/writeMail";
	}
	@RequestMapping(value = "/schedule", method = RequestMethod.GET)
	public String schedule() {
		return "/events/schedule";
	}
	@RequestMapping(value = "/projectFileCloud", method = RequestMethod.GET)
	public String projectFileCloud() {
		return "/uProject/projectFileCloud";
	}
	@RequestMapping(value = "/cloud", method = RequestMethod.GET)
	public String cloud() {
		return "/uProject/cloud";
	}
	@RequestMapping(value = "/nameCardList", method = RequestMethod.GET)
	public String nameCardList() {
		return "/nameCard/nameCardList";
	}
}
