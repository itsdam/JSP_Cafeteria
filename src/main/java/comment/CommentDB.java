package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import comment.Comment;

public class CommentDB {
	
	private Connection conn;
	private ResultSet rs;
	
	public CommentDB() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/CAFETERIA?serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "tooj0521^^";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	 public String getDate() {//댓글을 작성할 때 현재 시간
		   String SQL = "SELECT NOW()";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getString(1); //반환
			   }
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return "";
	   }

	
	public int getNext() { 
		   String SQL = "SELECT commentID FROM COMMENT ORDER BY commentID DESC";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   System.out.println(rs.getInt(1));
				   return rs.getInt(1)+1; //반환
			   }
			   return 1; //첫 번째 댓글인 경우 
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	   }
	
		public int write(int cafeteriaID, String commentContent, String memberID){ //댓글 작성 기능
			   String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setInt(2, cafeteriaID);
				   pstmt.setString(3, memberID);
				   pstmt.setString(4, getDate());
				   pstmt.setString(5, commentContent); 
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Comment> getList(int cafeteriaID,int pageNumber) {
			String SQL = "SELECT * FROM COMMENT WHERE commentID < ? AND cafeteriaID = ? ORDER BY commentID DESC LIMIT 10";
			ArrayList<Comment> list = new ArrayList<Comment>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  pstmt.setInt(2, cafeteriaID);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Comment comment = new Comment(); 
					  comment.setCommentID(rs.getInt(1));
					  comment.setCafeteriaID(cafeteriaID);
					  comment.setMemberID(rs.getString(3));
					  comment.setCommentDate(rs.getString(4));
					  comment.setCommentContent(rs.getString(5));
					  list.add(comment);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM COMMENT WHERE commentID < ?";
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL);
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  if (rs.next()) {
					  return true;
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return false;
	}
		
	public Comment getComment(int commentID) {
		String SQL = "SELECT * FROM COMMENT WHERE commentID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, commentID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Comment comment = new Comment(); 
				  comment.setCommentID(rs.getInt(1));
				  comment.setCafeteriaID(rs.getInt(2));
				  comment.setMemberID(rs.getString(3));
				  comment.setCommentDate(rs.getString(4));
				  comment.setCommentContent(rs.getString(5));
				  return comment;
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return null;
	}
	
	public int update(int commentID, String commentContent) { //댓글 수정 기능
		   String SQL = "UPDATE COMMENT SET commentContent = ? WHERE commentID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setString(1, commentContent);
			   pstmt.setInt(2, commentID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	} 
	public int delete(int commentID) { //댓글 삭제 기능
		   String SQL = "DELETE FROM COMMENT WHERE commentID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, commentID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
}
