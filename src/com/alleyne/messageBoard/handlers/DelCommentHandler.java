package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alleyne.messageBoard.service.ICommentService;

@Controller
public class DelCommentHandler {
	@Autowired
	@Qualifier("commentService")
	private ICommentService service;

	public void setService(ICommentService service) {
		this.service = service;
	}
	
	@RequestMapping("/delComment.do")
	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int commentId = Integer.parseInt(request.getParameter("commentId"));
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("isDone", service.deleteCommentById(commentId));
		response.getWriter().println(jsonObject);
	}
}
