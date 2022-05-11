<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="cafeteria.CafeteriaDB" %>
<%@ page import="cafeteria.Cafeteria" %>
<%@ page import="comment.CommentDB" %>
<%@ page import="comment.Comment" %>

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
	%>
	<div>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top: 10px; width:50px; height:50px;"></a>
	</div>
	<br>
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">오늘의 학식 메뉴</th>
						</tr>
					</thead>
					<tbody style="background-color : white;">
						<tr>
							<td style="width: 20%;">학식 정보</td>
							<td colspan="2"><%= cafeteria.getCafeteriaTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= cafeteria.getMemberID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= cafeteria.getCafeteriaDate().substring(0, 11) + cafeteria.getCafeteriaDate().substring(11, 13) + ":" + cafeteria.getCafeteriaDate().substring(14, 16) %></td>
						</tr>
						<tr>
							<td>메뉴</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= cafeteria.getCafeteriaContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
					</tbody>
				</table>
		<% if (memberID != null) { 	%>
		<form method="post" action="commentWriteAction.jsp?cafeteriaID=<%=cafeteriaID%>">
			<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">댓글</th>
						</tr>
					</thead>
					<tbody style="background-color: white;">
					
						<%
							CommentDB commentDB = new CommentDB();
							ArrayList<Comment> list = commentDB.getList(cafeteriaID, pageNumber);
							for(int i=list.size()-1;i>=0;i--)

							{
							
						%>
						
						<tr>
							<td style="text-align: left; width: 50%"><%= list.get(i).getCommentContent() %></td>
							<td style="text-align: center; width: 20% "><%= list.get(i).getCommentDate() %></td>
							<td style="text-align: right; width: 20%"><%= list.get(i).getMemberID() %>
						
						<%
               				if(memberID != null && memberID.equals(list.get(i).getMemberID())) {
                  
            			%>
							
							<a href="commentUpdate.jsp?cafeteriaID=<%=cafeteriaID%>&commentID=<%=list.get(i).getCommentID()%>&commentContent=<%=list.get(i).getCommentContent()%>" class="button">수정</a>
							<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?commentID=<%=list.get(i).getCommentID()%>&cafeteriaID=<%=cafeteriaID%>"class="button">삭제</a>
							</td>
							
						<%
               				}
						%>
							</tr>
						<%
							}
						%>

						<td colspan = "3" style= "text-align: left;" ><textarea type="text" class="form-control"
								placeholder="댓글을 입력하세요." name="commentContent" maxlength="2048" style= "background-color: white;"></textarea></td>
						
				
					</tbody>
				</table>
				<input type="submit" class="button3" value="댓글작성">
			</form>
	<%
			}
	%>
   
				<!-- 글쓰기 버튼 생성 -->
				<br>
				<a href="cafeteria.jsp" class="button">목록</a>
				<%
					if(memberID != null && memberID.equals(cafeteria.getMemberID())) {
						
				%>
					<a href="cafeteriaUpdate.jsp?cafeteriaID=<%= cafeteriaID %>" class="button">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="cafeteriaDeleteAction.jsp?cafeteriaID=<%= cafeteriaID %>" class="button">삭제</a>
				<%
					}
				%>
				
				<% if (memberID != null) { 	%>
				<a href="cafeteriaWrite.jsp" class="button pull-right">메뉴 작성하기</a>
				<%
					}
				%>
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