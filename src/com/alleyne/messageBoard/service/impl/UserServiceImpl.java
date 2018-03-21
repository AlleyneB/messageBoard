package com.alleyne.messageBoard.service.impl;

import com.alleyne.messageBoard.beans.User;
import com.alleyne.messageBoard.dao.IUserDao;
import com.alleyne.messageBoard.service.IUserService;

public class UserServiceImpl  implements IUserService{

	private IUserDao dao;
	
	/**
	 * @param dao the dao to set
	 */
	public void setDao(IUserDao dao) {
		this.dao = dao;
	}

	public boolean addUser(User user) {
		return dao.insertUser(user) == 1;
	}

	public boolean deleteUser(User user) {
		return dao.deleteUserById(user.getId()) == 1;
	}

	public boolean updateUser(User user) {
		return dao.updateUser(user) == 1;
	}

	public User selectUserById(int id) {
		return dao.selectUserById(id);
	}

	public User selectUserByName(String name) {
		return dao.selectUserByName(name);
	}

}
