<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*,java.text.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="C:\Users\User\eclipse-workspace\BBS\src\css\custom.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<style>
	
	.button 
	{
			background-color: #555555;
			color: white;
			font-size: 15px;
		  border: none;
		  padding: 4px 6px;
		  text-decoration: none;
		  display: inline-block;
		  margin: 1px 1px;
		  cursor: pointer;
		  border-top-left-radius: 5px;
		  border-bottom-left-radius: 5px;
		  border-top-right-radius: 5px;
		  border-bottom-right-radius: 5px;
	}
	.info
	{
		margin-left: 470px;
		font-size:25px;
	}
	.info2
	{
		margin-left: 50px;
		font-size:25px;
	}
	
	.info3
	{
		margin-left: 530px;
		font-size:25px;
	}
	
	.info4
	{
		text-align:center;
		font-size:30px;
	}
	
	.info5
	{
		text-align:center;
		font-size:25px;
	}
	
	.jumbotron
	{
		background-color : Lavender;
	}
	
	
</style>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<title>학식 공유 게시판</title>
</head>
<body style="background-color : White; font-family: 'Gowun Dodum', sans-serif;">
	<%
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
	%>
	<div>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top: 10px; width:50px; height:50px;"></a>
	</div>
	<br>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>배고프다! 오늘 학식 뭘까?</h1>
				<p> 가입하고 다양한 학식 정보를 얻어보세요!</p>
			</div>
		</div>
	</div>
	<p class="info4"><strong>TODAY</strong></p>
	<p class="info5"><%=strdate%></p>
	<br>
			<% 
				if(memberID == null) {
					
				
			%>
				<button class="info" style="background-color : MintCream;"><a href="memberJoin.jsp">회원가입</a></button>
				<button class="info2" style="background-color : AliceBlue;"><a href="memberLogin.jsp">로그인</a></button>
				<button class="info2" style="background-color : LavenderBlush;"><a href="cafeteria.jsp">메뉴 보러가기</a></button>
				<button class="info2" style="background-color : FloralWhite;"><a href="cafeteriaAll.jsp">학식 모아보기</a></button>
			<%
				} else {
			%>
				<button class="info3" style="background-color : AliceBlue;"><a href="memberLogoutAction.jsp">로그아웃</a></button>
				<button class="info2" style="background-color : LavenderBlush;"><a href="cafeteria.jsp">메뉴 보러가기</a></button>
				<button class="info2" style="background-color : FloralWhite;"><a href="cafeteriaAll.jsp">학식 모아보기</a></button>
			<%
				}
			%>	
			
	<br><br><br><br>
	<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
		<br><br><br><br>
		

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>