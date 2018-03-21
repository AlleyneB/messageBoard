package com.alleyne.messageBoard.service;

import java.util.List;

import com.alleyne.messageBoard.beans.Comment;

public interface ICommentService {
	Comment selectCommentById(int id);
	boolean addComment(Comment comment);
	boolean deleteCommentById(int id);
	List<Comment> selectCommentByMessageId(int messageId);
}
