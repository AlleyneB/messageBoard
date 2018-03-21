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
      
	  String userName = new String(request.getParameter("username"));
	  String passWord = new String(request.getParameter("password")); 
	  String result = "用户名或密码错误！请重新登录！";
	  User user = userService.selectUserByName(userName);
	  if(user != null && user.getPassWord().equals(passWord)){
		  out.println(userName);
		  result = ",welcome！";
		  String userNameString = URLEncoder.encode(userName, "utf-8");
		  Cookie cookie = new Cookie("userName",userNameString);
		  cookie.setMaxAge(3600);
		  cookie.setPath("/messageBoard/");
		  cookie.setDomain("localhost");
		  response.addCookie(cookie);
		  response.setHeader("Refresh","1;url=/messageBoard/index.jsp");
	  } 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/messageBoard/css/mycss.css" />
<title>登录结果</title>
</head>
<body>
	<%=result%>
</body>
</html>