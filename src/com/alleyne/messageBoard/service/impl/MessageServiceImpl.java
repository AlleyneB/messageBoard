package com.alleyne.messageBoard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.dao.IMessageDao;
import com.alleyne.messageBoard.service.IMessageService;

@Service("messageService")
public class MessageServiceImpl implements IMessageService {
	
	@Autowired
	private IMessageDao dao;
	
	/**
	 * @return the dao
	 */
	public IMessageDao getDao() {
		return dao;
	}

	/**
	 * @param dao the dao to set
	 */
	public void setDao(IMessageDao dao) {
		this.dao = dao;
	}

	public boolean addMessage(Message message) {
		return dao.insertMessage(message) == 1;
	}

	public boolean deleteMessageById(int id) {
		return dao.deleteMessageById(id) == 1;
	}

	public List<Message> getAllMessage() {
		return dao.selectAll();
	}

	public Message selectMessageById(int id) {
		return dao.selectMessageById(id);
	}

}
