package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.HttpRequestHandler;

import com.alleyne.messageBoard.service.IMessageService;

public class DelMessageHandler implements HttpRequestHandler{

	private IMessageService service;

	public void setService(IMessageService service) {
		this.service = service;
	}

	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int messageId = Integer.parseInt(request.getParameter("messageId"));
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("isDone", service.deleteMessageById(messageId));
		response.getWriter().println(jsonObject);
	}
}
