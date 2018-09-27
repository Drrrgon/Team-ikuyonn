package com.ikuyonn.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ikuyonn.project.mail.mapper.MailMapper;
import com.ikuyonn.project.mail.vo.email;
import com.ikuyonn.project.mail.vo.inbox;
import com.ikuyonn.project.socket.vo.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MailController {
	@Autowired
	SqlSession session;
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);

	@RequestMapping(value = "/reload", method = RequestMethod.GET)
	public @ResponseBody void reload(HttpSession sess) {
		String userID =(String)sess.getAttribute("userID");
		loadMail(userID);
	}

	public void loadMail(String userID) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.clearInbox();
		ArrayList<email> email = addressList(userID);
		for (email e : email) {
			getMail(e.getEmailId(), e.getEmailPassword(), e.getHost(), e);
		}
	}

	public ArrayList<email> addressList(String emailAddress) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		ArrayList<email> email = mapper.mailList(emailAddress);
		return email;
	}

	@RequestMapping(value = "/addAddress", method = RequestMethod.POST)
	public String addAddress(email email) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		mapper.addAddress(email);
		mapper.fixNameCard1(email);
		return "profile/userprofilelite";
	}
	
	@RequestMapping(value = "/hrefMail", method = RequestMethod.GET)
	public String hrefMail(String emailAddress,Model model ) {
		System.out.println(emailAddress);
		model.addAttribute("hrefMail", emailAddress);
		System.out.println(model.containsAttribute("hrefMail"));
		return "mail/writeMail";
	}
	
	@RequestMapping(value = "/mailCheck", method = RequestMethod.POST)
	public @ResponseBody int mailCheck(email email) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		int result = mapper.checkEmail(email);
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
		mapper.delInbox(email);
		mapper.delAddress(email);
		mapper.fixNameCard0(email);
		return "";
	}

	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public @ResponseBody User check(String userID) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		User result = mapper.checkid(userID);
		return result;
	}

	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	public String sendmail(HttpServletRequest request,MultipartFile file) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		email email = new email();
		email.setEmailAddress(request.getParameter("from") == null ? "" : request.getParameter("from"));
		email = mapper.getAddress(email.getEmailAddress());
		final String username = email.getEmailId();
		final String password = email.getEmailPassword();
		final String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid+"_"+file.getOriginalFilename();
		File file2 = new File("/var/lib/tomcat8/ikuyonn",saveFileName);
		if(!file2.exists()) {
			   file2.mkdirs();
			}
		try {
			file.transferTo(file2);
			/*FileOutputStream fos = new FileOutputStream(file2); 
		    fos.write(file.getBytes());
		    fos.close(); */
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		String[] to = request.getParameter("to").split(" ");
		String subject = request.getParameter("subject") == null ? "" : request.getParameter("subject");
		String filename = (file == null) ? "" : file.getOriginalFilename();
		
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
			mbp.setText(content.replaceAll(" ", " "), "UTF-8");
			/* } */
			filename = fileSize(filename);
			MimeBodyPart mbp2 = new MimeBodyPart();
			DataSource fds = new FileDataSource(file2.getAbsolutePath());
			mbp2.setDataHandler(new DataHandler(fds));
			
			mbp2.setFileName(MimeUtility.encodeText(file.getOriginalFilename(), "UTF-8", "B"));
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp);
			if (!filename.equals("")) {
				mp.addBodyPart(mbp2);
			}
			
			message.setContent(mp);
			// 내용
			// message.setContent("내용","text/html; charset=utf-8");//글내용을 html타입 charset설정
			/* message.setText(content); */
			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		file2.delete();
		return "mail/mailFinish";
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

	public void getMail(String emailID, String emailPassword, String host, email email) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		IMAPAgent mailagent = new IMAPAgent(host, emailID, emailPassword);
		ArrayList<inbox> inbox = null;
		Message[] msg = null;
		try {
			mailagent.open();
			Folder folder = mailagent.getFolder("inbox");
			msg = mailagent.getMessage();
			for (Message m : msg) {
				String content = "";
				String fileName = "" + System.currentTimeMillis();
				inbox temp = new inbox();
				temp.setMsgNum(m.getMessageNumber());
				System.out.println(MimeUtility.decodeText(m.getSubject()));
				if(MimeUtility.decodeText(m.getSubject()).equals(null)||MimeUtility.decodeText(m.getSubject()).equals("")) {
					temp.setTitle("(제목 없음)");
				}else {
					temp.setTitle(MimeUtility.decodeText(m.getSubject()));
				}
				
				if (m.isMimeType("multipart/*")) {
					MimeMultipart mmp = (MimeMultipart) m.getContent();
					content+=saveParts(mmp);
					if(content.equals("")) {
						content+=saveText(mmp);
					}
					String content2 = "";
					for (int i = 0; i < mmp.getCount(); i++) {
						MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
							if (mbp.getFileName() != null) {
								content2 += "<div>-첨부파일-<br/><a href ='mailDown?msgNum="+m.getMessageNumber()+""
										+ "&emailAddress="+email.getEmailAddress()+"'>" + MimeUtility.decodeText(mbp.getFileName())
										+ "</a><div>(다운로드 파일은 C:\\\\download\\\\에 저장됩니다.)</div></div>";
							}
					}
					if(content!=null&&content!="") {
					content2+=content;
					temp.setContent(content2);
					}
				} else {
					if(m.getContent().toString().equals(null)||m.getContent().toString().equals("")) {
						temp.setContent("(내용 없음)");
					}else {
						temp.setContent(m.getContent().toString());
					}
				}
				
				temp.setSentdate(m.getReceivedDate().toString());
				
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
				}else if(mbp.isMimeType("text/html")&&mbp.getDataHandler().getName()==null){
					content += mbp.getContent().toString();
				}
			}
		} catch (MessagingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return content;
	}
	public String saveText(MimeMultipart mmp) {
		int check = 0;
		String content = "";
		
		try {
			for (int i = 0; i < mmp.getCount(); i++) {
				MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
				if (mbp.getContent() instanceof Multipart) {
					MimeMultipart multi = (MimeMultipart) mbp.getContent();
					saveParts(multi);
				}else if(mbp.isMimeType("text/plain")&&mbp.getDataHandler().getName()==null){
					content += mbp.getContent();
				}
			}
		} catch (MessagingException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return content;
	}
	
	@RequestMapping(value = "/mailDown", method = RequestMethod.GET)
	public void mailDown(int msgNum, String emailAddress, HttpServletResponse response) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		email e = mapper.getAddress(emailAddress);
		String host = e.getHost();
		String emailID = e.getEmailId();
		String emailPassword = e.getEmailPassword();
		IMAPAgent mailagent = new IMAPAgent(host, emailID, emailPassword);
		try {
			mailagent.open();
			Folder folder = mailagent.getFolder("inbox");
			Message m = mailagent.getMessage(msgNum);
			MimeMultipart mmp = (MimeMultipart) m.getContent();
			for (int i = 0; i < mmp.getCount(); i++) {
				MimeBodyPart mbp = (MimeBodyPart) mmp.getBodyPart(i);
				if (mbp.getFileName() != null) {
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition", "attachment; fileName=" 
					+ URLEncoder.encode(MimeUtility.decodeText(mbp.getFileName()), "UTF-8"));
					BufferedOutputStream out = null; 
					BufferedInputStream in = null;
					
					out = new BufferedOutputStream(response.getOutputStream()); 
					in = new BufferedInputStream(mbp.getInputStream()); 
					int k; 
					while ((k = in.read()) != -1) 
					{ out.write(k); }
					out.flush();
					out.close();
					in.close();
					
				}
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	private String fileSize(String name) {
		File file = new File(name);
		if (name.length() > (1024 * 1024 * 2.5)) {
			name = "";
		}
		return name;
	}
	
	@RequestMapping(value = "/delMail", method = RequestMethod.POST)
	public @ResponseBody void delMail(String emailAddress,String msgNum) {
		MailMapper mapper = session.getMapper(MailMapper.class);
		
		email e = mapper.getAddress(emailAddress);
		String host = e.getHost();
		String emailID = e.getEmailId();
		String emailPassword = e.getEmailPassword();
		IMAPAgent mailagent = new IMAPAgent(host, emailID, emailPassword);
		int[] msg = new int[msgNum.split(",").length];
		inbox ee= new inbox();
		for(int i=0;i<msgNum.split(",").length;i++) {
			msg[i]=Integer.parseInt(msgNum.split(",")[i]);
			ee.setEmailAddress(emailAddress);
			ee.setMsgNum(Integer.parseInt(msgNum.split(",")[i]));
			mapper.delMail(ee);
		}
		try {
			mailagent.open();
			Folder folder = mailagent.getFolder("inbox");
			for(int j=0;j<msg.length;j++) {
				mailagent.setDelFlag(mailagent.getMessage(msg[j]));
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
