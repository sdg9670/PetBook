package db.pictures;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PicturesDAO {

	public PicturesDTO getPicture(int id) {
		PicturesDTO pd = new PicturesDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select * from pictures where id = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pd.setId(rs.getInt("id"));
				pd.setPath(rs.getString("path"));
			}
			else
				pd = null;
		} catch (SQLException e) {
			e.printStackTrace();
			pd = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			pd = null;
		} finally {
			 if(rs != null) 
				    try{rs.close();}catch(SQLException sqle){}
			if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(conn != null) 
				try{conn.close();}catch(SQLException sqle) {}
		}
		return pd;
	}
	
	public int createPictures(PicturesDTO picture) {
		int result = 0;
		
		String path = picture.getPath();
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");

			pstmt = conn.prepareStatement("insert into pictures(path) values(?);");
			pstmt.setString(1, path);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select id from pictures where id= (select max(id) from pictures);");
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
			result = -1;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = -2;
		} finally {
			 if(rs != null) 
				    try{rs.close();}catch(SQLException sqle) {
		 				result = -5;
		 	}
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
}
