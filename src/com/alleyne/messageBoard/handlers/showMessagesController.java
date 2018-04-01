package com.alleyne.messageBoard.handlers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.service.IMessageService;

@Controller
public class showMessagesController {
	@Autowired
	@Qualifier("messageService")
	private IMessageService service;
	
	@RequestMapping("/showMessages.do")
	public ModelAndView handleRequest(){
		List<Message> allMessage = service.getAllMessage();
		ModelAndView mv = new ModelAndView();
		mv.addObject("messages", allMessage);
		mv.setViewName("/jsp/showMessages.jsp");
		return mv;
	}
}
