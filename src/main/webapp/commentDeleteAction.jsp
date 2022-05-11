<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDB" %>
<%@ page import="comment.Comment" %>
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
		int commentID = 0;
		if (request.getParameter("commentID") != null) {
			commentID = Integer.parseInt(request.getParameter("commentID"));
		}
		if (cafeteriaID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'cafeteria.jsp'");
			script.println("</script>");
		}
		if(memberID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'memberLogin.jsp'");
			script.println("</script>");
		} 
		 else {
				if (commentID == 0) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('유효하지 않은 글입니다.')");
					script.println("location.href = 'cafeteria.jsp'");
					script.println("</script>");
				}
				Comment comment = new CommentDB().getComment(commentID);
				if (!memberID.equals(comment.getMemberID())) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('권한이 없습니다.')");
					script.println("location.href = 'cafeteria.jsp'");
					script.println("</script>");
				} else {
						CommentDB commentDAO = new CommentDB();
						int result = commentDAO.delete(commentID);
						if (result == -1) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('댓글 삭제에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} 
						else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('댓글이 삭제되었습니다.')");
							String url="cafeteriaView.jsp?cafeteriaID="+cafeteriaID;
							script.println("location.href='"+url+"'");
							script.println("</script>");
							
						}
					}
	}
	%>
</body>
</html>