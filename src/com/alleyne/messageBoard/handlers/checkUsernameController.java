package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.IUserService;

@Controller
public class checkUsernameController {
	@Autowired
	@Qualifier("userService")
	private IUserService service;
	
	@RequestMapping("/checkUsername.do")
	public void handleRequest(String username, 
			HttpServletResponse response) throws ServletException, IOException  {
		boolean isHit = false;
		User user = service.selectUserByName(username);
		System.out.println(user);
		if(user != null){
			isHit = true;
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("isHit", isHit);
		response.getWriter().println(jsonObject);
	}
}