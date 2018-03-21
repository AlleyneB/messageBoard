package com.alleyne.messageBoard.service;

import com.alleyne.messageBoard.beans.User;

public interface IUserService {
	boolean addUser(User user);
	boolean deleteUser(User user);
	boolean updateUser(User user);
	User selectUserById(int id);
	User selectUserByName(String name);
}
