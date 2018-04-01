package com.alleyne.messageBoard.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.service.IMessageService;

@Controller
public class doCommentController {
	@Autowired
	@Qualifier("messageService")
	private IMessageService service;
	
	@RequestMapping("/doComment.do")
	public ModelAndView handleRequest(Integer messageId){
		Message message = service.selectMessageById(messageId);
		ModelAndView mv = new ModelAndView();
		mv.addObject("message", message);
		mv.setViewName("/jsp/doComment.jsp");
		return mv;
	}
}
