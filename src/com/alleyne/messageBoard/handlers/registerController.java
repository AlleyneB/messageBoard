package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.IUserService;

@Controller
public class registerController {
	@Autowired
	@Qualifier("userService")
	private IUserService service;
	
	@RequestMapping("/doRegister.do")
	public ModelAndView handleRequest(String username, String password,
			HttpServletRequest request) throws ServletException, IOException  {
		User user = new User();
		user.setUsername(username);
		user.setPassWord(password);
		boolean isDone = service.addUser(user);
		ModelAndView mv = new ModelAndView();
		mv.addObject("result", isDone?"×¢²á³É¹¦£¡":"×¢²áÊ§°Ü£¡");
		if(isDone){
			request.getSession().setAttribute("user", user);
		}
		mv.setViewName("/jsp/doRegister.jsp");
		return mv;
	}
}