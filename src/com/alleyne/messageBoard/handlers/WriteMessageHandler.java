package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.IMessageService;

@Controller
public class WriteMessageHandler {
	@Autowired
	@Qualifier("messageService")
	private IMessageService service;

	public void setService(IMessageService service) {
		this.service = service;
	}
	@RequestMapping("writeMessage.do")
	public void handleRequest(String message, Integer userId,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		Message msg = new Message();
		msg.setMessage(message);
		msg.setUser(new User(userId));
		service.addMessage(msg);
		Message newMessage = service.selectMessageById(msg.getId());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("time", newMessage.getTime());
		jsonObject.accumulate("messageId", newMessage.getId());
		jsonObject.accumulate("userName", newMessage.getUser().getUsername());
		jsonObject.accumulate("message", newMessage.getMessage());
		response.getWriter().println(jsonObject);
	}
}
