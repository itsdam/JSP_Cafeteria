package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDB {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDB() {
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
	
	public int login(String memberID, String memberPassword) {
		String SQL = "SELECT memberPassword FROM MEMBER WHERE memberID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(memberPassword)) {
					return 1; //로그인 성공
				} else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -2; //데이터베이스 오류
	}
	
	public int join(Member member) {
		String SQL = "INSERT INTO MEMBER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getMemberID());
			pstmt.setString(2, member.getMemberPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getMemberSchool());
			pstmt.setString(5, member.getMemberEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getName(String memberID) {
		String SQL = "select name from member where memberID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return "";
	}
	
	public ArrayList<Member> getList(int pageNumber, String memberID) {
		String SQL = "SELECT * FROM MEMBER WHERE memberID < ? ORDER BY memberID DESC LIMIT 10";
		ArrayList<Member> list = new ArrayList<Member>();  
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
			  pstmt.setString(1, memberID);
			  rs = pstmt.executeQuery();
			  while (rs.next()) {
				  Member member = new Member(); 
				  member.setMemberID(rs.getString(1));
				  member.setMemberPassword(rs.getString(2));
				  member.setMemberName(rs.getString(3));
				  member.setMemberSchool(rs.getString(4));
				  member.setMemberEmail(rs.getString(5));
				  list.add(member);
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return list;
		}
	
}
