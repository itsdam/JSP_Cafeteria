<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="cafeteria.CafeteriaDB" %>
<%@ page import="cafeteria.Cafeteria" %>

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
		margin-left: 550px;
		font-size:25px;
	}
	.info2
	{
		margin-left: 50px;
		font-size:25px;
	}
	
	.info3
	{
		margin-left: 610px;
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
		int cafeteriaID = 0;
		if (request.getParameter("cafeteriaID") != null) {
			cafeteriaID = Integer.parseInt(request.getParameter("cafeteriaID"));
		}
		if (cafeteriaID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'cafeteria.jsp'");
			script.println("</script>");
		}
		Cafeteria cafeteria = new CafeteriaDB().getCafeteria(cafeteriaID);
		if (!memberID.equals(cafeteria.getMemberID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'cafeteria.jsp'");
			script.println("</script>");
		}
	%>
	<div>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top: 10px; width:50px; height:50px;"></a>
	</div>
	<br>
		<div class="container">
		<div class="row">
			<form method="post" action="cafeteriaUpdateAction.jsp?cafeteriaID=<%=cafeteriaID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">[수정] 오늘의 학식은?</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="양식: 날짜(ex.20211202) + 학교명" name="cafeteriaTitle"  value=<%=cafeteria.getCafeteriaTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="학식 메뉴를 입력해주세요!" name="cafeteriaContent" maxlength="2048" style="height: 350px;"><%=cafeteria.getCafeteriaContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="button pull-right" value="메뉴 수정">
			</form>
		</div>
	</div>
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