<%@page import="java.net.URLDecoder"%>
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
    IMessageService messageService = (IMessageService)ac.getBean("messageService");
	
	List<Message> messages = messageService.getAllMessage();
	
	/* 0是游客Id */
	pageContext.setAttribute("loginUserId",0); 
	pageContext.setAttribute("isLogin", false); 
	User loginUser = null;
	String loginUserName = "";
	Cookie cookie = null;
	Cookie[] cookies = null;
	cookies = request.getCookies();
	if(cookies != null){
		for(int i=0; i<cookies.length;i++){
			cookie = cookies[i];
			if(cookie.getName().equals("userName")){
				String userName = URLDecoder.decode(cookie.getValue(), "utf-8");
				loginUserName = userName;
				loginUser = userService.selectUserByName(userName);
				pageContext.setAttribute("loginUserId", loginUser.getId()); 
				pageContext.setAttribute("isLogin", true); 
				break;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="/messageBoard/css/mycss.css" />
		<title>电子留言板</title>
	</head>
	
<body>
	<h1>电子留言板</h1>
	<div id="loginInf">
	<%
		if(loginUser != null){
			out.println("<span>"+loginUser.getUserName()+",已登录</span>");
			out.print("<span><a id='logOut' href='/messageBoard/jsp/doLogout.jsp'>退出</a></span>");
		}else{
			out.print("<span><a id='loginref' href='/messageBoard/html/login.html'>登录/</a></span>");
			out.print("<span><a id='registref' href='/messageBoard/html/register.html'>注册</a></span>");
		}
	%>
	</div>
	<hr>
	<div id="pageWindow">
		<div id="textArea">
			<textarea id="text" rows="5" cols="50" ></textarea>
			<input type="button" onclick="checkLogBeforeWrite()" value="留言">
		</div>
		<div id="messagesArea">
				<ol id="messageList" >
					<%
						if(messages != null){
							for(Message message:messages){
								String userName = message.getUser().getUserName();
								String delMsgHtml = "";
								String delCmtHtml = "";
								if(userName.equals(loginUserName ) || loginUserName.equals("admin")){
									delMsgHtml = "<a href='javascript:delMsg("+message.getId()+")'>/删除</a>";
								}
								out.println("<li id='msg"+message.getId()+"'>"+message.getTime()+"<br/>"
											+userName+":"
											+message.getMessage()
											+"<br/>"
											+"<a href='/messageBoard/jsp/doComment.jsp?messageId="+message.getId()+"'>评论</a>"
											+delMsgHtml
											+"<br/>"
											+"<ol>");
								for(Comment comment:message.getComments()){
								String cmtUserName = comment.getUser().getUserName();
								if(cmtUserName.equals(loginUserName) || loginUserName.equals("admin")){
									delCmtHtml = "<a href='javascript:delCmt("+comment.getId()+")'>删除</a>";
									}
									out.println("<li id='cmt"+comment.getId()+"'>"+comment.getTime()+"<br/>"
												+comment.getUser().getUserName()+":"+comment.getComment()
												+"<br>"
												+delCmtHtml
												+"<hr>"
												+"</li>");
									}
									out.println("</ol>"
												+"<hr>"
												+"</li>");
							}
						}
					 %>
				</ol>
		</div>
	</div>
	<script type="text/javascript" src = "js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
			function writeMessage(userId){
				var element = document.getElementById("text");
				var msg = element.value;
				$.ajax({
					url:"${pageContext.request.contextPath}/writeMessage.do",
					type:"post",
					data:{"userId":userId,"message":msg},
					dataType:"json",
					success:function(message){
						var a = document.getElementById("messageList").innerHTML;
						var html ="<li id='msg"+message.messageId+"'>"+message.time+"<br/>"
										+message.userName+":"+msg
										+"<br/>"
										+"<a href='/messageBoard/jsp/doComment.jsp?messageId="+message.messageId+"'>评论</a>"
										+"<a href='javascript:delMsg("+message.messageId+")'>/删除</a>"
										+"<br/>"
										+"</ol>"+"<hr>"
										+a; 
						$("#messageList").html(html);
					}
				});
				element.value = "";
			}
			
			function checkLogBeforeWrite(){
				var isLogin = ${isLogin};
				var loginUserId = ${loginUserId};
				if(isLogin){
					writeMessage(loginUserId);
				}
				else{
					var r = confirm("以访客身份留言?");
					if(r){writeMessage(0);}
				}
			}
			
			function delMsg(id){
				var r = confirm("确定删除本条信息？");
				if(r){
					elmId = "#msg"+id;
					$.ajax({
					url:"${pageContext.request.contextPath}/delMessage.do",
					type:"post",
					data:{"messageId":id},
					dataType:"json",
					success:function(result){
						if(result.isDone){
							$(elmId).remove();
						}else{
							alert("删除失败！");
						}
					}
					});
				}
			}
 			function delCmt(id){
				var r = confirm("确定删除本条信息？");
				if(r){
					elmId = "#cmt"+id;
					$.ajax({
						url:"${pageContext.request.contextPath}/delComment.do",
						type:"post",
						data:{"commentId":id},
						dataType:"json",
						success:function(result){
							if(result.isDone){$(elmId).remove();}
							else{alert("删除失败！");}	
						}					
					});
				}
			}
	</script>

</body>
</html>