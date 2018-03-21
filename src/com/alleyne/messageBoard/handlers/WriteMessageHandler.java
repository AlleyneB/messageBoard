package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.HttpRequestHandler;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.IMessageService;

public class WriteMessageHandler implements HttpRequestHandler{

	private IMessageService service;

	public void setService(IMessageService service) {
		this.service = service;
	}

	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		Message message = new Message();
		message.setMessage((String)request.getParameter("message"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		message.setUser(new User(userId));
		service.addMessage(message);
		Message newMessage = service.selectMessageById(message.getId());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("time", newMessage.getTime());
		jsonObject.accumulate("messageId", newMessage.getId());
		jsonObject.accumulate("userName", newMessage.getUser().getUserName());
		jsonObject.accumulate("message", newMessage.getMessage());
		response.getWriter().println(jsonObject);
	}
}
