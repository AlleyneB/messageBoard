package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alleyne.messageBoard.service.IMessageService;

@Controller
public class DelMessageHandler {
	@Autowired
	@Qualifier("messageService")
	private IMessageService service;

	public void setService(IMessageService service) {
		this.service = service;
	}
	
	@RequestMapping("/delMessage.do")
	public void handleRequest(Integer messageId ,HttpServletResponse response) 
			throws ServletException, IOException{
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("isDone", service.deleteMessageById(messageId));
		response.getWriter().println(jsonObject);
	}
}
