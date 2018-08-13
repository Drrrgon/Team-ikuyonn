package com.ikuyonn.project.controller;

import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.URLName;

import com.sun.mail.imap.IMAPStore;

public class IMAP implements MailProto{
	
	protected Session session;
	
	protected Store store;
	
	protected Folder folder;
	
	private static String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

	@Override
	public void open(String host, String id, String passwd) throws MessagingException {
		// TODO Auto-generated method stub
		Properties props = new Properties();
		props.setProperty("mail.imap.socketFactory.class", SSL_FACTORY);
		props.setProperty("mail.imap.socketFactory.fallback", "false");
		props.setProperty("mail.imap.port", "993");
		session = Session.getInstance(props,null);
		URLName urlName = new URLName("imap",host,993,"",id,passwd);
		store = new IMAPStore(session, urlName);
		store.connect();
		folder = store.getDefaultFolder().getFolder("INBOX");
		folder.open(Folder.READ_WRITE);
	}

	@Override
	public void close() throws MessagingException {
		// TODO Auto-generated method stub
		if(folder !=null&&folder.isOpen()) {
			folder.close(true);
		}
		if(store!=null&&store.isConnected()) {
			store.close();
		}
	}

	@Override
	public Message getmessages(int msgNum) throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}
		return folder.getMessage(msgNum);
	}

	@Override
	public Message[] getMessages() throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}
		return folder.getMessages();
	}

	@Override
	public Message[] getRecentMessages(int count) throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}
		int folderSize = folder.getMessageCount();
		return folder.getMessages(folderSize-count+1,folderSize);
	}

	@Override
	public int getMessageCount() throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}
		return folder.getMessageCount();
	}

	@Override
	public String getUID(Message msg) throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}else {
			throw new MessagingException("Cannot support");
		}
	}

	@Override
	public Folder getFolder() throws MessagingException {
		// TODO Auto-generated method stub
		if(!folder.isOpen()) {
			throw new MessagingException("Already closed folder");
		}
		return folder;
	}

	@Override
	public Store getStore() throws MessagingException {
		// TODO Auto-generated method stub
		if(!store.isConnected()) {
			throw new MessagingException("Already closed store");
		}
		return store;
	}

}
