package com.ikuyonn.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.UIDFolder;
import javax.mail.URLName;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.interceptor.CacheOperationInvoker.ThrowableWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.email;
import com.ikuyonn.project.mail.vo.inbox;
import com.ikuyonn.project.socket.vo.User;
import com.sun.mail.pop3.POP3SSLStore;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MailController {
@Autowired
SqlSession session;
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {

		return "login";
	}*/

	@RequestMapping(value = "/sign", method = RequestMethod.GET)
	public String sign() {

		return "sign";
	}
	@RequestMapping(value = "/mailMain", method = RequestMethod.GET)
	public String mailMain() {
		return "mailMain";
	}
	@RequestMapping(value = "/logMain", method = RequestMethod.GET)
	public String logMain(HttpSession sess) {
		User user = (User)sess.getAttribute("user");
		loadMail(user);
		return "mailMain";
	}
	@RequestMapping(value = "/reload", method = RequestMethod.GET)
	public String reload(HttpSession sess) {
		User user = (User)sess.getAttribute("user");
		loadMail(user);
		return "inbox";
	}
	public void loadMail(User user) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.clearInbox();
		ArrayList<email> email = addressList(user.getUserName());
		for(email e:email) {
			getMail(e.getId(),e.getPassword(),e.getHost(),user,e);
		}
	}
	public ArrayList<email> addressList(String userName){
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<email> email = mapper.mailList(userName);
		return email;
	}
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String signin(User user) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		int result = mapper.signin(user);
		return "login";
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "login";
	}
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		
		return "write";
	}
	@RequestMapping(value = "/goInbox", method = RequestMethod.GET)
	public String goInbox() {
		return "inbox";
	}
	@RequestMapping(value = "/addAddress", method = RequestMethod.POST)
	public @ResponseBody int addAddress(email email) {
		MailMapper mapper =session.getMapper(MailMapper.class);
		int result = mapper.checkEmail(email);
		if(result ==0) {
		mapper.addAddress(email);
		}
		return result;
	}
	@RequestMapping(value = "/getInbox", method = RequestMethod.POST)
	public @ResponseBody ArrayList<inbox> getInbox(inbox inbox) {
		MailMapper mapper =session.getMapper(MailMapper.class);
		ArrayList<inbox> result = mapper.getInbox(inbox);
		return result;
	}
	@RequestMapping(value = "/delAddress", method = RequestMethod.POST)
	public @ResponseBody String delAddress(email email) {
		MailMapper mapper =session.getMapper(MailMapper.class);
		mapper.delAddress(email);
		return "";
	}
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public @ResponseBody User check(String userName) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		User result = mapper.checkid(userName);
		return result;
	}
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody String login(User user,HttpSession session2) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		User user2 = mapper.login(user);
		String result ="";
		if(user2!=null) {
			result = user2.getUserName();
			session2.setAttribute("user", user2);
		}
		
		return result;
	}
	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	public String sendEmail(HttpServletRequest request) {

		String subject = request.getParameter("subject") == null ? "" : request.getParameter("subject");

		String content = request.getParameter("content") == null ? "" : request.getParameter("content");

		String from = request.getParameter("from") == null ? "" : request.getParameter("from"); 

		String to = request.getParameter("to") == null ? "" : request.getParameter("to"); 

		if (from.equals("") || to.equals("") || content.equals("") || subject.equals("")) {

			System.out.println("메일 전송 실패");

		} else {

			Properties props = System.getProperties();

			Session sess = Session.getDefaultInstance(props, null);

			Message msg = new MimeMessage(sess);
			try {
				msg.setFrom(new InternetAddress(from));

				InternetAddress address = new InternetAddress(to);

				msg.setRecipient(Message.RecipientType.TO, address);

				msg.setSubject(MimeUtility.encodeText(subject, "utf-8", "B"));

				msg.setSentDate(new java.util.Date());

				msg.setContent(content, "text/html;charset=UTF-8"); 
			
				Transport.send(msg);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return "mailMain";
	}
	@RequestMapping(value = "/mailList", method = RequestMethod.POST)
	public @ResponseBody ArrayList<email> mailList(String userName) {
		ArrayList<email> email = addressList(userName);
		return email;
	}
	@RequestMapping(value = "/getmail", method = RequestMethod.POST)
	public @ResponseBody inbox getmail(inbox inbox) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		inbox temp = mapper.getmail(inbox);
		return temp;
	}
	
	public void getMail(String id,String password,String host,User user,email email){
		MailMapper mapper = session.getMapper(MailMapper.class);
		IMAPAgent mailagent = new IMAPAgent(host,id,password);
		ArrayList<inbox> inbox = null;
		Message[] msg=null;
		try {	
			mailagent.open();
			Folder folder = mailagent.getFolder("inbox");
			String filePath = "c:/inbox/";
			msg = mailagent.getMessage();
			for(Message m : msg) {
				String content = "";
				String fileName = "" + System.currentTimeMillis();
				inbox temp = new inbox();
				temp.setMsgNum(m.getMessageNumber());
				temp.setTitle(MimeUtility.decodeText(m.getSubject()));
				if(m.isMimeType("multipart/*")){
					MimeMultipart mmp = (MimeMultipart) m.getContent();
					int check = 0;
					for (int i=0; i<mmp.getCount(); i++) {
						MimeBodyPart mbp = (MimeBodyPart)mmp.getBodyPart(i);
						if(mbp.getFileName()!=null) {
							check = 1;
						}
					}
					
					for (int i=0; i<mmp.getCount(); i++) {
				    MimeBodyPart mbp = (MimeBodyPart)mmp.getBodyPart(i);
				    if(mbp.getFileName()!=null) {
				    	content+="<div>-첨부파일-<br/><a href ='' onclick=\"down('"+m.getMessageNumber()
				    	+"','"+email.getAddress()+"')\">"
				    			+MimeUtility.decodeText(mbp.getFileName())+"</a></div><div>다운로드 기능은 제공하지 않습니다.(클릭하면 에러남)</div>";
				    }
				    if(check==0) {
				    content+= mbp.getContent();
				    }
				}
				temp.setContent(content);
				}else {
					temp.setContent(m.getContent().toString());
				}
				temp.setSentdate(m.getSentDate().toString());
				String address = MimeUtility.decodeText(m.getFrom()[0].toString());
				if(address.split("<").length>1) {
				address = address.split("<")[0]+" "+address.split("<")[1].split(">")[0];
				}
				temp.setsentaddress(address);
				temp.setUserName(email.getUserName());
				temp.setAddress(email.getAddress());
				mapper.addInbox(temp);
			}
			mailagent.close();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/downfile", method = RequestMethod.GET)
	public @ResponseBody String downfile(int msgNum,String userName,String address) {
		ArrayList<email> e = addressList(userName);
		String host = "";
		String id = "";
		String password="";
		for(email email : e) {
			if(email.getAddress()==address) {
				host = email.getHost();
				id = email.getId();
				password = email.getPassword();
			}
		}
		IMAPAgent mailagent = new IMAPAgent(host,id,password);
		try {
			mailagent.open();
			Message m = mailagent.getMessage(msgNum);
			MimeMultipart mmp = (MimeMultipart) m.getContent();
			for (int i=0; i<mmp.getCount(); i++) {
			    MimeBodyPart mbp = (MimeBodyPart)mmp.getBodyPart(i);
			    String path = "c:/download/";
			    File file = new File(path);
			    if(mbp.getFileName()!=null) {
			    	mbp.saveFile(file);
			    	}
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return "";
	}
	}

