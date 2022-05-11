<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDB" %>
<%@ page import="comment.Comment" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="commentContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자격증 공부 게시판</title>
</head>
<body>
	<%	
		int cafeteriaID = 1;
		if(request.getParameter("cafeteriaID")!=null){
			cafeteriaID=Integer.parseInt(request.getParameter("cafeteriaID"));
		}
		String memberID = null;
		if(session.getAttribute("memberID") != null) {
			memberID = (String) session.getAttribute("memberID");
		}
		if(memberID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'memberLogin.jsp'");
			script.println("</script>");
		} else {
			if(comment.getCommentContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		} else {
			CommentDB commentDB = new CommentDB();
			int result = commentDB.write(cafeteriaID, comment.getCommentContent(), memberID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 작성에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else {
					String url="cafeteriaView.jsp?cafeteriaID="+cafeteriaID;
					PrintWriter script= response.getWriter();
					script.println("<script>");
					script.println("alert('댓글을 작성했습니다!')");
					script.println("location.href='"+url+"'");
					script.println("</script>");
			}
		}
	}
	%>
</body>
</html>