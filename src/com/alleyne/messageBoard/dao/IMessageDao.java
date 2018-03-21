package com.alleyne.messageBoard.dao;

import java.util.List;

import com.alleyne.messageBoard.beans.Message;


public interface IMessageDao {
	List<Message> selectAll();
	List<Message> selectMessagesByUserId(int userId);
	Message selectMessageById(int id);
	int deleteMessageById(int id);
	int deleteMessagesByUserId(int userId);
	int insertMessage(Message message);
}
