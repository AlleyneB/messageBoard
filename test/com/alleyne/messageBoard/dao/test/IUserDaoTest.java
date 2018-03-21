package com.alleyne.messageBoard.dao.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.dao.IUserDao;
import com.alleyne.messageBoard.utils.MyBatisUtils;

public class IUserDaoTest {
	private SqlSession sqlSession;
	private IUserDao dao;

	@Before
	public void before() {
		sqlSession = MyBatisUtils.getSqlSession();
		dao = sqlSession.getMapper(IUserDao.class);
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
		System.out.println(dao.insertUser(new User("qq1","443234")));
	}
	@Test
	public void test2(){
		System.out.println(dao.deleteUserById(47));
	}
	@Test
	public void test3(){
		User user = new User("qq1","443234");
		user.setId(47);
		System.out.println(dao.updateUser(user ));
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
