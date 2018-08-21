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
import javax.activation.FileDataSource;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
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
	/*
	 * @RequestMapping(value = "/", method = RequestMethod.GET) public String home()
	 * {
	 * 
	 * return "login"; }
	 */

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
		User user = (User) sess.getAttribute("ur");
		loadMail(user);
		return "mailMain";
	}

	@RequestMapping(value = "/reload", method = RequestMethod.GET)
	public String reload(HttpSession sess) {
		User user = (User) sess.getAttribute("ur");
		loadMail(user);
		return "mailBox";
	}

	public void loadMail(User user) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.clearInbox();
		ArrayList<email> email = addressList(user.getUserID());
		for (email e : email) {
			getMail(e.getEmailId(), e.getEmailPassword(), e.getHost(), user, e);
		}
	}

	public ArrayList<email> addressList(String userID) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<email> email = mapper.mailList(userID);
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
		MailMapper mapper = session.getMapper(MailMapper.class);
		int result = mapper.checkEmail(email);
		if (result == 0) {
			mapper.addAddress(email);
		}
		return result;
	}

	@RequestMapping(value = "/getInbox", method = RequestMethod.POST)
	public @ResponseBody ArrayList<inbox> getInbox(inbox inbox) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<inbox> result = mapper.getInbox(inbox);
		return result;
	}

	@RequestMapping(value = "/delAddress", method = RequestMethod.POST)
	public @ResponseBody String delAddress(email email) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.delAddress(email);
		return "";
	}

	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public @ResponseBody User check(String userID) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		User result = mapper.checkid(userID);
		return result;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody String login(User user, HttpSession session2) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		User user2 = mapper.login(user);
		String result = "";
		if (user2 != null) {
			result = user2.getUserName();
			session2.setAttribute("user", user2);
		}

		return result;
	}

	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	public String sendmail(HttpServletRequest request) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		email email = new email();
		email.setEmailAddress(request.getParameter("from") == null ? "" : request.getParameter("from"));
		email = mapper.getAddress(email.getEmailAddress());
		final String username = email.getEmailId();
		final String password = email.getEmailPassword();
		final String content = request.getParameter("content") == null ? "" : request.getParameter("content");

		String[] to = request.getParameter("to").split(" ");
		for (int i = 0; i < to.length; i++) {
			System.out.println(to[i]);
		}
		String subject = request.getParameter("subject") == null ? "" : request.getParameter("subject");
		String filename = request.getParameter("filename") == null ? "" : request.getParameter("filename");
		System.out.println(filename);
		Properties props = new Properties();
		props.put("mail.smtp.user", username);
		props.put("mail.smtp.password", password);
		props.put("mail.smtp.host", email.getSmtp());
		props.put("mail.smtp.port", "587");
		props.put("mail.debug", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.EnableSSL.enable", "true");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {

			InternetAddress[] toAddr = new InternetAddress[to.length];

			Message message = new MimeMessage(session);
			if (to.length != 1) {
				for (int i = 0; i < to.length; i++) {
					toAddr[i] = new InternetAddress(to[i]);
				}
				message.setRecipients(Message.RecipientType.TO, toAddr);
			} else {
				String to2 = request.getParameter("to");
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to2));
			}
			message.setFrom(new InternetAddress(email.getEmailAddress()));//
			message.setSubject(subject);
			MimeBodyPart mbp = new MimeBodyPart();
			/*
			 * if(tar.equals("html")) { mbp.setContent(content.replaceAll(" "," "),
			 * "text/html;charset=utf-8"); }else {
			 */
			mbp.setText(content.replaceAll(" ", " "), "KSC5601");
			/* } */
			filename = fileSize(filename);
			MimeBodyPart mbp2 = new MimeBodyPart();
			FileDataSource fds = new FileDataSource(filename);
			mbp2.setDataHandler(new DataHandler(fds));
			mbp2.setFileName(MimeUtility.encodeText(fds.getName(), "KSC5601", "B"));
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp);
			if (!filename.equals("")) {
				mp.addBodyPart(mbp2);
			}
			message.setContent(mp);// 내용
			// message.setContent("내용","text/html; charset=utf-8");//글내용을 html타입 charset설정
			/* message.setText(content); */
			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "writeMail";
	}

	@RequestMapping(value = "/mailList", method = RequestMethod.POST)
	public @ResponseBody ArrayList<email> mailList(String userID) {
		ArrayList<email> email = addressList(userID);
		return email;
	}

	@RequestMapping(value = "/getmail", method = RequestMethod.POST)
	public @ResponseBody inbox getmail(inbox inbox) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		inbox temp = mapper.getmail(inbox);
		return temp;
	}

	public void getMail(String emailID, String emailPassword, String host, User user, email email) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		IMAPAgent mailagent = new IMAPAgent(host, emailID, emailPassword);
		ArrayList<inbox> inbox = null;
		Message[] msg = null;
		try {
			mailagent.open();
			Folder folder = mailagent.getFolder("inbox");
			String filePath = "c:/inbox/";
			msg = mailagent.getMessage();
			for (Message m : msg) {
				String content = "";
				String fileName = "" + System.currentTimeMillis();
				inbox temp = new inbox();
				temp.setMsgNum(m.getMessageNumber());
				temp.setTitle(MimeUtility.decodeText(m.getSubject()));
				if (m.isMimeType("multipart/*")) {
					MimeMultipart mmp = (MimeMultipart) m.getContent();
					/*int check = 0;
					for (int i = 0; i < mmp.getCount(); i++) {
						MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
						if (mbp.getFileName() != null) {
							check = 1;
						}
					}*/
					for (int i = 0; i < mmp.getCount(); i++) {
						MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
							if (mbp.getFileName() != null) {
								content += "<div>-첨부파일-<br/><a href ='' onclick=\"down('" + m.getMessageNumber() + "','"
										+ email.getEmailAddress() + "')\">" + MimeUtility.decodeText(mbp.getFileName())
										+ "</a></div><div>다운로드 기능은 제공하지 않습니다.(클릭하면 에러남)</div>";
							}
					}
					content+=saveParts(mmp);
					temp.setContent(content);
				} else {
					temp.setContent(m.getContent().toString());
				}
				temp.setSentdate(m.getSentDate().toString());
				String address = MimeUtility.decodeText(m.getFrom()[0].toString());
				if (address.split("<").length > 1) {
					address = address.split("<")[0] + " " + address.split("<")[1].split(">")[0];
				}
				temp.setSentaddress(address);
				temp.setUserID(email.getUserID());
				temp.setEmailAddress(email.getEmailAddress());
				mapper.addInbox(temp);
			}
			mailagent.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String saveParts(MimeMultipart mmp) {
		int check = 0;
		String content = "";
		
		try {
			for (int i = 0; i < mmp.getCount(); i++) {
				MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
				if (mbp.getContent() instanceof Multipart) {
					MimeMultipart multi = (MimeMultipart) mbp.getContent();
					saveParts(multi);
				}else if(mbp.isMimeType("text/html")){
					content +=mbp.getContent();
				}
			}
		} catch (MessagingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return content;
	}
	
	@RequestMapping(value = "/downfile", method = RequestMethod.GET)
	public @ResponseBody String downfile(int msgNum, String userID, String emailAddress) {
		ArrayList<email> e = addressList(userID);
		String host = "";
		String emailID = "";
		String emailPassword = "";
		for (email email : e) {
			if (email.getEmailAddress() == emailAddress) {
				host = email.getHost();
				emailID = email.getEmailId();
				emailAddress = email.getEmailPassword();
			}
		}
		IMAPAgent mailagent = new IMAPAgent(host, emailID, emailAddress);
		try {
			mailagent.open();
			Message m = mailagent.getMessage(msgNum);
			MimeMultipart mmp = (MimeMultipart) m.getContent();
			for (int i = 0; i < mmp.getCount(); i++) {
				MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
				String path = "c:/download/";
				File file = new File(path);
				if (mbp.getFileName() != null) {
					mbp.saveFile(file);
				}
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return "";
	}

	private String fileSize(String name) {
		File file = new File(name);
		if (name.length() > (1024 * 1024 * 2.5)) {
			name = "";
		}
		return name;
	}
}
