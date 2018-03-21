package com.alleyne.messageBoard.dao.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.alleyne.messageBoard.beans.Comment;
import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.dao.ICommentDao;
import com.alleyne.messageBoard.utils.MyBatisUtils;

public class ICommentDaoTest {
	private SqlSession sqlSession;
	private ICommentDao dao;

	@Before
	public void before() {
		sqlSession = MyBatisUtils.getSqlSession();
		dao = sqlSession.getMapper(ICommentDao.class);
	}
	
	@After
	public void after() {
		if(sqlSession != null) {
			sqlSession.commit();
			sqlSession.close();
		}
	}
	
	@Test
	public void test1(){
		Comment comment = new Comment("2223",new User(45),new Message(56));
		System.out.println(dao.insertComment(comment));
	}
	@Test
	public void test2(){
		System.out.println(dao.deleteCommentById(6));
	}
	@Test
	public void test3(){
		System.out.println(dao.selectCommentsByMessageId(56));
	}
	@Test
	public void test4(){
		System.out.println(dao);
	}
	@Test
	public void test5(){
		System.out.println(dao);
	}
	@Test
	public void test6(){
		System.out.println(dao);
	}
}
