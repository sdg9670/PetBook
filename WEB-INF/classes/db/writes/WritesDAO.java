package db.writes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WritesDAO {
	public int createWrite(WritesDTO write)
	{
		int result = 0;

		String content = write.getContent();
		int pet = write.getPet();
		int picture = write.getPicture();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("insert into pet_writes(content, pet, picture) values(?, ?, ?);");
			pstmt.setString(1, content);
			pstmt.setInt(2, pet);
			pstmt.setInt(3, picture);
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

	public int dropWrite(int writeid)
	{
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("delete from pet_writes where id = ?");
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
	
	public int updateWrite(WritesDTO write)
	{
		int result = 0;

		int id = write.getId();
		String content = write.getContent();
		int picture = write.getPicture();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			if(picture == -100)
			{
				pstmt = conn.prepareStatement("update pet_writes set content = ? where id = ?");
				pstmt.setString(1, content);
				pstmt.setInt(2, id);
			}
			else
			{
				pstmt = conn.prepareStatement("update pet_writes  set content = ?, picture = ? where id = ?");
				pstmt.setString(1, content);
				pstmt.setInt(2, picture);
				pstmt.setInt(3, id);
			}
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
	
	public WritesDTO getWrite(String type, int id, int upid)
	{
		WritesDTO write = new WritesDTO();
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			if(type.equals("pet"))
			{
				pstmt = conn.prepareStatement("select * from pet_writes where pet = ? and id <= ? order by id desc limit 1;");
				pstmt.setInt(1, upid);
				pstmt.setInt(2, id);
			} else if(type.equals("index"))
			{
				pstmt = conn.prepareStatement("Select * from (SELECT pet_writes.* " + 
						"FROM pet_writes " + 
						"INNER JOIN pet_followings " + 
						"ON pet_writes.pet = pet_followings.pet " + 
						"WHERE pet_followings.user = ? " + 
						"UNION " + 
						"SELECT pet_writes.* " + 
						"FROM pet_writes " + 
						"INNER JOIN pets " + 
						"WHERE pet_writes.pet = pets.id and pets.pet_user = ? )names where id <= ? ORDER BY id DESC limit 1;");
				pstmt.setInt(1, upid);
				pstmt.setInt(2, upid);
				pstmt.setInt(3, id);
			} else if(type.equals("view"))
			{
				pstmt = conn.prepareStatement("select * from pet_writes where id = ?;");
				pstmt.setInt(1, id);
			} else if(type.equals("report"))
			{
				pstmt = conn.prepareStatement("Select distinct * from (SELECT pet_writes.* " + 
						"FROM pet_writes " + 
						"INNER JOIN reports " + 
						"ON pet_writes.id = reports.write) " + 
						"names where id <= ? ORDER BY id DESC limit 1;");
				pstmt.setInt(1, id);
			}
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				write.setId(rs.getInt("id"));
				write.setContent(rs.getString("content"));
				write.setWritedatetime(rs.getString("writedatetime"));
				write.setPet(rs.getInt("pet"));
				write.setPicture(rs.getInt("picture"));
			}
			else
				write = null;
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
		return write;
	}
}
