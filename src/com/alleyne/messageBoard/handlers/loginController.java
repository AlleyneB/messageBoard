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
public class loginController {
	@Autowired
	@Qualifier("userService")
	private IUserService service;
	
	@RequestMapping("/login.do")
	public ModelAndView handleRequest(String username, String password,
			HttpServletRequest request) throws ServletException, IOException {
		String result = "用户名或密码错误！";
		User user = service.selectUserByName(username);
		if((user != null) && (user.getPassword().equals(password))){
			result = "登录成功！";
			request.getSession().setAttribute("user", user);
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("result", result);
		mv.setViewName("/jsp/doLogin.jsp");
		return mv;
	}
}

