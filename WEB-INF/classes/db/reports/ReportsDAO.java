package db.reports;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ReportsDAO {
	public int createReport(ReportsDTO report)
	{
		int result = 0;

		String content = report.getContent();
		int write = report.getWrite();
		int user = report.getUser();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("insert into reports(content, `write`, user) values(?, ?, ?);");
			pstmt.setString(1, content);
			pstmt.setInt(2, write);
			pstmt.setInt(3, user);
			pstmt.executeUpdate();
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = -2;
		} finally {
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { 
	 				result = -3; 
	 		}
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) {
	 				result = -4;
	 		}
	 	}
		return result;
	}

	public int dropReport(int writeid)
	{
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("delete from reports where `write` = ?");
			pstmt.setInt(1, writeid);
			pstmt.executeUpdate();
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = -2;
		} finally {
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { 
	 				result = -3; 
	 		}
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) {
	 				result = -4;
	 		}
	 	}
		return result;
	}
	public Vector<ReportsDTO> getReport(int writeid)
	{
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		Vector<ReportsDTO> mlist = new Vector<ReportsDTO>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select * from reports where `write` = ?");
			pstmt.setInt(1, writeid);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				ReportsDTO rdto = new ReportsDTO();
				rdto.setContent(rs.getString("content"));
				rdto.setUser(rs.getInt("user"));
				rdto.setWrite(rs.getInt("write"));
				mlist.add(rdto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
	 		if(rs != null) 
	 			try{rs.close();}catch(SQLException sqle) { 
	 		}
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { 
	 		}
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) {
	 		}
	 	}
		return mlist;
	}
}
