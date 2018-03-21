<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Cookie cookie = null;
Cookie[] cookies = null;
cookies = request.getCookies();
if(cookies != null){
	for(int i=0; i<cookies.length;i++){
		cookie = cookies[i];
		if(cookie.getName().equals("userName")){
			 cookie.setMaxAge(0);
			 cookie.setPath("/messageBoard/");
			 cookie.setDomain("localhost");
	         response.addCookie(cookie);
	         break;
		}
	}
	response.setHeader("Refresh","1;url=/messageBoard/index.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/messageBoard/css/mycss.css" />
<title>退出登录</title>
</head>
<body>
已注销登录
</body>
</html>