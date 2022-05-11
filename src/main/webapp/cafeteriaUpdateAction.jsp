<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cafeteria.CafeteriaDB" %>
<%@ page import="cafeteria.Cafeteria" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자격증 공부 게시판</title>
</head>
<body>
	<%	
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
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
		
		if(memberID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'memberLogin.jsp'");
			script.println("</script>");
		} else {
		if(cafeteria.getCafeteriaTitle() == null || cafeteria.getCafeteriaContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			CafeteriaDB cafeteriaDB = new CafeteriaDB();
			int result = cafeteriaDB.update(cafeteriaID, request.getParameter("cafeteriaTitle"), request.getParameter("cafeteriaContent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시물이 수정되었습니다.')");
					String url="cafeteriaView.jsp?cafeteriaID="+cafeteriaID;
					script.println("location.href='"+url+"'");
					script.println("</script>");
			}
		}
	}
	%>
</body>
</html>