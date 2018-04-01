<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<span id="logInf">
		<c:if test="${sessionScope.user != null }">
			<span>
				${sessionScope.user.username},已登录
			</span>
			<span>
				<a id="doLogout" href="jsp/doLogout.jsp">退出</a>
			</span>
		</c:if>
		<c:if test="${sessionScope.user == null }">
			<span>
				<a id="doLogin" href="html/login.html">登录</a>			
			</span>
			<span>	
				<a id="doRegister" href="html/register.html">注册</a>	
			</span>
		</c:if>
	</span>
	<br/>
</body>
</html>