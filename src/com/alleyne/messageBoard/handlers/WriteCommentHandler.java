package com.alleyne.messageBoard.handlers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.HttpRequestHandler;

import com.alleyne.messageBoard.beans.Comment;
import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.service.ICommentService;

public class WriteCommentHandler implements HttpRequestHandler{

	private ICommentService service;

	public void setService(ICommentService service) {
		this.service = service;
	}

	public void handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		Comment comment = new Comment();
		comment.setComment((String)request.getParameter("comment"));
		int userId = Integer.parseInt(request.getParameter("userId"));
		int messageId = Integer.parseInt(request.getParameter("messageId"));
		comment.setUser(new User(userId));
		comment.setMessage(new Message(messageId));
		service.addComment(comment);
		Comment newComment = service.selectCommentById(comment.getId());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.accumulate("commentId", comment.getId());
		jsonObject.accumulate("time", newComment.getTime());
		jsonObject.accumulate("userName", newComment.getUser().getUserName());
		response.getWriter().println(jsonObject);
	}
}
