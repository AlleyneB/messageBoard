<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>

<%@page import="com.alleyne.messageBoard.beans.*"%>
<%@page import="com.alleyne.messageBoard.service.*"%>
<%@page import="com.alleyne.messageBoard.service.impl.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>  
<%@page import="org.springframework.context.ApplicationContext"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

    ServletContext sc = this.getServletContext();  
    ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(sc);  
    IUserService userService = (IUserService)ac.getBean("userService");
    
	  String username = new String(request.getParameter("username"));
	  String password = new String(request.getParameter("password"));
	  String confirm = new String(request.getParameter("confirm")); 
	  String result = "注册失败！";
	  if(userService.selectUserByName(username) != null){
		  result = "该用户已存在！";
	  }else{
		  if(password.equals(confirm)){
			  User user = new User();
			  user.setUserName(username);
			  user.setPassWord(password);
			  if(userService.addUser(user)){
				  result = "注册成功！";
				  String userNameString = URLEncoder.encode(username, "utf-8");
				  Cookie cookie = new Cookie("userName",userNameString);
				  cookie.setMaxAge(3600);
				  cookie.setPath("/messageBoard/");
				  cookie.setDomain("localhost");
				  response.addCookie(cookie);
				  response.setHeader("Refresh","1;url=/messageBoard/index.jsp");
		 	  }else{
			  	  result = "注册失败！";
		 	  }

			}else{
			  	  result = "两次输入密码不同！";
				 }
			}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/messageBoard/css/mycss.css" />
<title>注册结果</title>
</head>
<body>
	<%=result%>
</body>
</html>