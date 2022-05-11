package cafeteria;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import cafeteria.Cafeteria;

public class CafeteriaDB {

	private Connection conn;
	private ResultSet rs;
	
	public CafeteriaDB() {
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
	
	 public String getDate() {//게시판을 작성할 때 현재 시간
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
		   String SQL = "SELECT cafeteriaID FROM CAFETERIA ORDER BY cafeteriaID DESC";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getInt(1)+1; //반환
			   }
			   return 1; //첫 번째 게시물인 경우 
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	   }
	
		public int write(String cafeteriaTitle,String memberID,String cafeteriaContent){ //게시글 작성 기능
			   String SQL = "INSERT INTO CAFETERIA VALUES(?, ?, ?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setString(2, cafeteriaTitle);
				   pstmt.setString(3, memberID);
				   pstmt.setString(4, getDate());
				   pstmt.setString(5, cafeteriaContent);
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Cafeteria> getList(int pageNumber) {
			String SQL = "SELECT * FROM CAFETERIA WHERE cafeteriaID < ? ORDER BY cafeteriaID DESC LIMIT 10";
			ArrayList<Cafeteria> list = new ArrayList<Cafeteria>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Cafeteria cafeteria = new Cafeteria(); 
					  cafeteria.setCafeteriaID(rs.getInt(1));
					  cafeteria.setCafeteriaTitle(rs.getString(2));
					  cafeteria.setMemberID(rs.getString(3));
					  cafeteria.setCafeteriaDate(rs.getString(4));
					  cafeteria.setCafeteriaContent(rs.getString(5));
					  list.add(cafeteria);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM CAFETERIA WHERE cafeteriaID < ?";
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
		
	public Cafeteria getCafeteria(int cafeteriaID) {
		String SQL = "SELECT * FROM CAFETERIA WHERE cafeteriaID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, cafeteriaID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Cafeteria cafeteria = new Cafeteria(); 
				  cafeteria.setCafeteriaID(rs.getInt(1));
				  cafeteria.setCafeteriaTitle(rs.getString(2));
				  cafeteria.setMemberID(rs.getString(3));
				  cafeteria.setCafeteriaDate(rs.getString(4));
				  cafeteria.setCafeteriaContent(rs.getString(5));
				  return cafeteria;
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return null;
	}
	
	public int update(int cafeteriaID, String cafeteriaTitle, String cafeteriaContent) { //게시글 수정 기능
		   String SQL = "UPDATE CAFETERIA SET cafeteriaTitle = ?, cafeteriaContent = ? WHERE cafeteriaID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setString(1, cafeteriaTitle);
			   pstmt.setString(2, cafeteriaContent);
			   pstmt.setInt(3, cafeteriaID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	} 
	public int delete(int cafeteriaID) {
		   String SQL = "DELETE FROM CAFETERIA WHERE cafeteriaID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, cafeteriaID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
	public int getSrchCount (String srchKey, String srchText) { 
		String SQL = "select count(*) from cafeteria where " + srchKey + " like ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 검색 결과 없음
	}
	
	public ArrayList<Cafeteria> getSrchList (String srchKey, String srchText, int pageNumber) {
		ArrayList<Cafeteria> searchList = new ArrayList<Cafeteria>();
		String SQL = "select * from cafeteria where " + srchKey + " like ? order by cafeteriaID desc limit ?, 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				  Cafeteria cafeteria = new Cafeteria(); 
				  cafeteria.setCafeteriaID(rs.getInt(1));
				  cafeteria.setCafeteriaTitle(rs.getString(2));
				  cafeteria.setMemberID(rs.getString(3));
				  cafeteria.setCafeteriaDate(rs.getString(4));
				  cafeteria.setCafeteriaContent(rs.getString(5));
				searchList.add(cafeteria);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchList;
	}
	
	public boolean srchNextPage(String srchKey, String srchText, int pageNumber) {
		String SQL = "select * from cafeteria where " + srchKey + " like ? order by cafeteriaID desc limit ?, 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return false;
	}
	

}
