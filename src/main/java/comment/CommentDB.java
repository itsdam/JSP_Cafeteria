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
	
	 public String getDate() {//����� �ۼ��� �� ���� �ð�
		   String SQL = "SELECT NOW()";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getString(1); //��ȯ
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
				   return rs.getInt(1)+1; //��ȯ
			   }
			   return 1; //ù ��° ����� ��� 
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	   }
	
		public int write(int cafeteriaID, String commentContent, String memberID){ //��� �ۼ� ���
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
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //���� ����Ǿ��ִ� conn��ü�� �̿��ؼ� SQL�� ������ ���� �غ�ܰ�� ������ش�. 
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
	
	public int update(int commentID, String commentContent) { //��� ���� ���
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
	public int delete(int commentID) { //��� ���� ���
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
