package com.alleyne.messageBoard.dao.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.alleyne.messageBoard.beans.Message;
import com.alleyne.messageBoard.dao.IMessageDao;
import com.alleyne.messageBoard.utils.MyBatisUtils;

public class IMessageDaoTest {
	private SqlSession sqlSession;
	private IMessageDao dao;

	@Before
	public void before() {
		sqlSession = MyBatisUtils.getSqlSession();
		dao = sqlSession.getMapper(IMessageDao.class);
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
		Message message = new Message();
		System.out.println(dao.insertMessage(message));
	}
	@Test
	public void test2(){
		System.out.println(dao.deleteMessageById(56));
	}
	@Test
	public void test3(){
		System.out.println(dao.deleteMessagesByUserId(45));
	}
	@Test
	public void test4(){
		System.out.println(dao.selectAll());
	}
	@Test
	public void test5(){
		System.out.println(dao.selectMessageById(56));
	}
	@Test
	public void test6(){
		System.out.println(dao.selectMessagesByUserId(45));
	}
}
