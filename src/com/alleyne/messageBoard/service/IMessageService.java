package com.alleyne.messageBoard.service;

import java.util.List;

import com.alleyne.messageBoard.beans.Message;

public interface IMessageService {
	boolean addMessage(Message message);
	boolean deleteMessageById(int id);
	List<Message> getAllMessage();
	Message selectMessageById(int id);
}
