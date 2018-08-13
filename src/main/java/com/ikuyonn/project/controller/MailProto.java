package com.ikuyonn.project.controller;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Store;

public interface MailProto {

	abstract public void open(String host, String id, String passwd) throws MessagingException;
	
	abstract public void close() throws MessagingException;
	
	abstract public Message getmessages(int msgNum) throws MessagingException;
	
	abstract public Message[] getMessages() throws MessagingException;
	
	abstract public Message[] getRecentMessages(int count) throws MessagingException;
	
	abstract public int getMessageCount() throws MessagingException;
	
	abstract public String getUID(Message msg) throws MessagingException;
	
	abstract public Folder getFolder() throws MessagingException;
	
	abstract public Store getStore() throws MessagingException;
	
}
