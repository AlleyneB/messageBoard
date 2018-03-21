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
    ICommentService commentService = (ICommentService)ac.getBean("commentService");
    IMessageService messageService = (IMessageService)ac.getBean("messageService");
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	
	Message message = messageService.selectMessageById(messageId);
	List<Comment> comments = commentService.selectCommentByMessageId(messageId);
	
	User loginUser = null;
	String loginUserName = "";
	Cookie cookie = null;
	Cookie[] cookies = null;
	int loginUserId = 49;
	cookies = request.getCookies();
	if(cookies != null){
		for(int i=0; i<cookies.length;i++){
			cookie = cookies[i];
			if(cookie.getName().equals("userName")){
				String userName = URLDecoder.decode(cookie.getValue(), "utf-8");
				loginUserName = userName;
				loginUser = userService.selectUserByName(loginUserName);
				loginUserId = loginUser.getId();
				break;
			}
		}
	}
	pageContext.setAttribute("loginUserId", loginUserId); 
	pageContext.setAttribute("isLogin", loginUser != null); 
	pageContext.setAttribute("messageId", messageId); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="/messageBoard/css/mycss.css" />
		<title>评论</title>
	</head>
	
<body>
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
	<a href="/messageBoard">主页</a>
	</div>
	<hr>
	<div id="pageWindow">
		<div id="textArea">
			<textarea id="text" rows="5" cols="50" ></textarea>
			<input type="button" onclick="checkLogBeforeWrite()" value="评论">
		</div>
		<div id="commentsArea">
			<h2>
				<%
				out.println(message.getTime()+"<br/>"
							+message.getUser().getUserName()+"："+message.getMessage()+"<br/>");
				 %>
			</h2>
			<p>评论列表</p>
				<ol id="commentList" >
					<%
							for(Comment comment:message.getComments()){
									String delCmtHtml = "";
									String commentUserName = comment.getUser().getUserName();
									if(loginUserName.equals(commentUserName) || loginUserName.equals("admin")){
									delCmtHtml = "<a href='javascript:delCmt("+comment.getId()+")'>删除</a>";
									}
							out.println("<li id='cmt"+comment.getId()+"'>"+comment.getTime()+"<br/>"
										+comment.getUser().getUserName()+"："+comment.getComment()
										+"<br>"
										+delCmtHtml
										+"<hr>"
										+"</li>");
							}
					 %>
				</ol>
		</div>
	</div>
	<script type="text/javascript" src = "${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
			function writeComment(){
				var element = document.getElementById("text");
				var comment = element.value;
				var messageId = ${messageId};
				var userId = ${loginUserId};
				$.ajax({
					url:"${pageContext.request.contextPath}/writeComment.do",
					type:"get",
					data:{"comment":comment,"messageId":messageId,"userId":userId},
					dataType:"json",
					success:function(value){
						var a = document.getElementById("commentList").innerHTML;
						html =("<li id='cmt"+value.commentId+"'>"+value.time+"<br/>"
										+value.userName+"："+comment
										+"<br>"
										+"<a href='javascript:delCmt("+value.commentId+")'>删除</a>"
										+"<hr>"
										+"</li>")
										+a; 
						$("#commentList").html(html);
					}
				});
				element.value = "";
			}
			
			function checkLogBeforeWrite(){
				var isLogin = ${isLogin};
				if(isLogin){
					writeComment();
				}else{
					alert("登录或注册后才能评论！");
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
						if(result.isDone){
							$(elmId).remove();
						}else{
							alert("删除失败！");
						}	
					}					
					});
				}
			}
	</script>
</body>
</html>