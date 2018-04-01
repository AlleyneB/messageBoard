package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alleyne.messageBoard.beans.Comment;
import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.ICommentService;

@Controller
public class WriteCommentHandler {
	@Autowired
	@Qualifier("commentService")
	private ICommentService service;

	public void setService(ICommentService service) {
		this.service = service;
	}
	
	@RequestMapping("/writeComment.do")
	public void handleRequest(String comment, Integer userId, Integer messageId,
			HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8");
		
		Comment cmt = new Comment();
		cmt.setComment(comment);
		cmt.setUser(new User(userId));
		cmt.setMessage(new Message(messageId));
		service.addComment(cmt);
		Comment newComment = service.selectCommentById(cmt.getId());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("commentId", cmt.getId());
		jsonObject.accumulate("time", newComment.getTime());
		jsonObject.accumulate("userName", newComment.getUser().getUsername());
		response.getWriter().println(jsonObject);
	}
}
