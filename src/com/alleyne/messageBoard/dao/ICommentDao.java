package com.alleyne.messageBoard.dao;

import java.util.List;
import com.alleyne.messageBoard.beans.Comment;

public interface ICommentDao {
	List<Comment> selectCommentsByMessageId(int messageId);
	int insertComment(Comment comment);
	int deleteCommentById(int id);
	Comment selectCommentById(int id);
}
