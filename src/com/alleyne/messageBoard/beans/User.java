package com.alleyne.messageBoard.beans;

public class User {
	
	private Integer id;
	private String username;
	private String password;
	
	public User(String userName, String passWord) {
		super();
		this.username = userName;
		this.password = passWord;
	}

	public User(Integer id) {
		super();
		this.id = id;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the userName
	 */
	public String getUserName() {
		return username;
	}

	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.username = userName;
	}

	/**
	 * @return the passWord
	 */
	public String getPassWord() {
		return password;
	}

	/**
	 * @param passWord the passWord to set
	 */
	public void setPassWord(String passWord) {
		this.password = passWord;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + username + ", passWord="
				+ password + "]";
	}
	
	
}
