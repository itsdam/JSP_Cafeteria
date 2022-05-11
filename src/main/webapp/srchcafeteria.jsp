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
		font-size:25px;
		margin-top: 30px;
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
		String srchKey = null;
		if (request.getParameter("srchKey") != null) {
			srchKey = java.net.URLDecoder.decode(request.getParameter("srchKey"), "utf-8"); //디코딩해서 받기 시도 해봤으나 디코딩 해서 받아도 같은 현상 발생 그냥 디코딩 안하고 해도 됨
			//System.out.println(srchKey);
		}
		
		String srchText = null;	
		if (request.getParameter("srchText") != null) {
			srchText = java.net.URLDecoder.decode(request.getParameter("srchText"), "utf-8") ;
			//System.out.println(srchText);
		}
	%>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top:10px; width:50px; height:50px;"></a>
	<p class="info4"><strong>TODAY</strong> <%=strdate%></p>
		<div>
		<form method="post" class="pull-right" action="srchcafeteria.jsp">
			<fieldset style="margin-right: 180px;">
                   <label>검색분류</label>
                       <select name = "srchKey">
                           <option ${(param.srchKey == "cafeteriaTitle")? "selected" : ""} value = "cafeteriaTitle">날짜</option>
                           <option ${(param.srchKey == "memberID")? "selected" : ""} value = "memberID">학번</option>
                       </select>
                   <label>검색어</label>
                       <input type = "text" name = "srchText" value = "${param.srchText}"/>
                       <input class= "button" type = "submit" value = "검색">                
               </fieldset>        
		</form>	
	</div>	
	<br>
	<h3><p style="text-align:center"><strong>검색 결과</strong></p></h3>
	<br>
		<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: right; border: 1px solid #dddddd">
				<colgroup>
          			<col width="*">
          			<col width="450px">
            		<col width="400px">
     			</colgroup>
				<thead style="background-color : Lavender">
					<tr>
						<th style="background-color: #eeeeee; text-align: center">학식 정보</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</thead>
				<tbody style="background-color : white;">
					<%
						CafeteriaDB cafeteriaDB = new CafeteriaDB();
						ArrayList<Cafeteria> searchList = cafeteriaDB.getSrchList(srchKey, srchText, pageNumber);
						int cnt = cafeteriaDB.getSrchCount(srchKey, srchText) - ((pageNumber - 1) * 10);
						for (int i=0; i<searchList.size(); i++) {
					%>
					<tr>
						<td style="text-align: center;"><a href="cafeteriaView.jsp?cafeteriaID=<%= searchList.get(i).getCafeteriaID() %>"><%= searchList.get(i).getCafeteriaTitle() %></a></td>
						<td style="text-align: center;"><%= searchList.get(i).getMemberID() %></td>
						<td style="text-align: center;"><%= searchList.get(i).getCafeteriaDate().substring(0, 11) + searchList.get(i).getCafeteriaDate().substring(11, 13) + ":" + searchList.get(i).getCafeteriaDate().substring(14, 16)%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="cafeteria.jsp?pageNumber=<%=pageNumber - 1%>" class="button btn-arraw-Left">이전</a>
			<%
				} if(cafeteriaDB.nextPage(pageNumber + 1)) {
			%>
				<a href="cafeteria.jsp?pageNumber=<%=pageNumber + 1%>" class="button btn-arraw-Left">다음</a>
			<%
				}
			%>
			<a href="cafeteria.jsp" class="button pull-right">목록</a>
			<a href="cafeteriaWrite.jsp" class="button pull-right">메뉴 작성하기</a>
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