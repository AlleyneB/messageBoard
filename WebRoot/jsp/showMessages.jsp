<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="css/mycss.css" />
		<title>电子留言板</title>
	</head>
	
<body>
	<h1>电子留言板</h1>
	<jsp:include page="loginRef.jsp"/>
	<hr>
	<div id="pageWindow">
		<div id="textArea">
			<textarea id="text" rows="5" cols="50" ></textarea>
			<input type="button" onclick="checkLogBeforeWrite()" value="留言">
		</div>
		<div id="messagesArea">
				<ol id="messageList" >
					<c:forEach var="message" items="${messages }">
						<li id="msg${message.user.id }">
							${message.time }<br/>
							${message.user.username }:${message.message }<br/>
							<a href="doComment.do?messageId=${message.id }">评论</a>
							<c:if test="${sessionScope.user.username == message.user.username }">
								<a href="javascript:delMsg(${message.id })">/删除</a><br/>
							</c:if>
							<ol>
								<c:forEach var="comment" items="${message.comments }">
									<li id ="cmt${comment.id }">
									${comment.time }<br/>
									${comment.user.username }:${comment.comment }<br/>
									<c:if test="${comment.user.username == sessionScope.user.username }">
										<a href="javascript:delCmt(${comment.id })">删除</a>
									</c:if>
									<hr>
									</li>
								</c:forEach>
							</ol> 
						</li>
					</c:forEach>
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
			    var isLogin = ${ sessionScope.user != null};
			    var userId = ${ sessionScope.user.id};
				if(isLogin){
					writeMessage(userId);
				}else{
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
							if(result.isDone){
								$(elmId).remove();
							}
							else{
								alert("删除失败！");
							}	
						}					
					});
				}
			}
	</script>

</body>
</html>