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
		<title>评论</title>
	</head>
	
<body>
	<a href="index.jsp">返回</a>
	<jsp:include page="loginRef.jsp"/>
	<hr>
	<div id="pageWindow">
		<div id="textArea">
			<textarea id="text" rows="5" cols="50" ></textarea>
			<input type="button" onclick="checkLogBeforeWrite()" value="评论">
		</div>
		<div id="commentsArea">
			<h2>
				${message.time }<br/>
				${message.user.username }:${message.message }
			</h2>
			<hr/>
			<p>评论列表</p>
			<ol id="commentList">
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
		</div>
	</div>
	<script type="text/javascript" src = "${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
			function writeComment(){
				var element = document.getElementById("text");
				var comment = element.value;
				var messageId = ${message.id};
				var userId = ${sessionScope.user.id};
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
				var isLogin = ${sessionScope.user != null};
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