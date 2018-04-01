package com.alleyne.messageBoard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alleyne.messageBoard.beans.Comment;
import com.alleyne.messageBoard.dao.ICommentDao;
import com.alleyne.messageBoard.service.ICommentService;

@Service("commentService")
public class CommentServiceImpl implements ICommentService {
	@Autowired
	private ICommentDao dao;
	
	/**
	 * @return the dao
	 */
	public ICommentDao getDao() {
		return dao;
	}

	/**
	 * @param dao the dao to set
	 */
	public void setDao(ICommentDao dao) {
		this.dao = dao;
	}

	public boolean addComment(Comment comment) {
		return dao.insertComment(comment) == 1;
	}

	public boolean deleteCommentById(int id) {
		return dao.deleteCommentById(id) == 1;
	}

	public List<Comment> selectCommentByMessageId(int messageId) {
		return dao.selectCommentsByMessageId(messageId);
	}

	public Comment selectCommentById(int id) {
		return dao.selectCommentById(id);
	}


}
