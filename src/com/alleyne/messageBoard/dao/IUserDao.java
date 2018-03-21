package com.alleyne.messageBoard.dao;

import com.alleyne.messageBoard.beans.User;

public interface IUserDao {
	int insertUser(User user);
	int deleteUserById(int id);
	int updateUser(User user);
	User selectUserById(int id);
	User selectUserByName(String name);
}
