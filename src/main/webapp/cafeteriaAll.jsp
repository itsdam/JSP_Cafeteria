<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDB" %>
<%@ page import="cafeteria.CafeteriaDB" %>
<%@ page import="cafeteria.Cafeteria" %>
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
		margin-left: 590px;
		font-size:20px;
	}
	.info2
	{
		margin-left: 50px;
		font-size:20px;
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<div>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top: 10px; width:50px; height:50px;"></a>
	</div>
	<br>
	<div style="text-align:center;"><h3 style="color:Lavender; text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;" ><strong>학식 모아보기</strong></h3></div><br>
	<div class="container">
			<table class="table table-striped" style="text-align: right; border: 1px solid #dddddd">
				<colgroup>
         			<col width="200px">
          			<col width="*">
     			</colgroup>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">날짜&학교</th>
						<th style="background-color: #eeeeee; text-align: center;">메뉴</th>
				</thead>
				<tbody style="background-color : white;">
					<%
						MemberDB memberDB = new MemberDB();
						CafeteriaDB cafeteriaDB = new CafeteriaDB();
						ArrayList<Cafeteria> list = cafeteriaDB.getList(pageNumber);
						int pageNum = (pageNumber - 1) * 10 + 1; //글 번호 순번
						for (int i = 0; i < list.size(); i++) {
					%>
					
					<tr>
						<td style="text-align: center;"><strong><%= list.get(i).getCafeteriaTitle()%></strong></td>
						<td style="text-align: center;"><%= list.get(i).getCafeteriaContent()%></td>

					</tr>			
					<%
						}
					%>

				
			</tbody>
		</table>
		</div>
		<button class="info" style="background-color : MintCream;"><a href="memberJoin.jsp">회원가입</a></button>
		<button class="info2" style="background-color : AliceBlue;"><a href="memberLogin.jsp">로그인</a></button>
		<button class="info2" style="background-color : LavenderBlush;"><a href="cafeteria.jsp">메뉴 보러가기</a></button>
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