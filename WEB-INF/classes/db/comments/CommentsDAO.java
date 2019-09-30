package db.comments;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import db.users.UsersDTO;

public class CommentsDAO {
	public int createComment(CommentsDTO comment)
	{
		int result = 0;

		String content = comment.getContent();
		int user = comment.getUser();
		int write = comment.getWrite();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("INSERT INTO pet_comments (`content`, `user`, `write`) VALUES(?, ?, ?);");
			pstmt.setString(1, content);
			pstmt.setInt(2, user);
			pstmt.setInt(3, write);
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

	public int dropComment(int commentid)
	{
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("delete from pet_comments where id = ?");
			pstmt.setInt(1, commentid);
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
	
	public int updateComment(CommentsDTO comment)
	{
		int result = 0;

		int id = comment.getId();
		String content = comment.getContent();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("update pet_comments set content = ? where id = ?");
			pstmt.setString(1, content);
			pstmt.setInt(2, id);
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
	
	public Vector<CommentsDTO> getComment(int writeid)
	{
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		Vector<CommentsDTO> mlist = new Vector<CommentsDTO>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select * from pet_comments where `write` = ?");
			pstmt.setInt(1, writeid);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				CommentsDTO cdto = new CommentsDTO();
				cdto.setId(rs.getInt("id"));
				cdto.setContent(rs.getString("content"));
				cdto.setUser(rs.getInt("user"));
				cdto.setWrite(rs.getInt("write"));
				cdto.setCommentdatetime(rs.getTimestamp("commentdatetime").toString());
				mlist.add(cdto);
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
