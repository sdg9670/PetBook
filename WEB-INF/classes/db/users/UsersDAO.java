package db.users;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Vector;

public class UsersDAO {
	
	public Vector<UsersDTO> searchUser(String text) {
		  Connection conn=null;
		  PreparedStatement pstmt=null;
		  ResultSet rs=null;
		  ResultSet rs2=null;
		  Vector<UsersDTO> mlist = new Vector<UsersDTO>();
		  try{
			  Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			  pstmt=conn.prepareStatement("SELECT email, name, birthday, introduce, profile_picture FROM users WHERE email LIKE ? or name LIKE ? or introduce LIKE ? ORDER BY current_login DESC;");

			  pstmt.setString(1, "%" + text + "%" );
			  pstmt.setString(2, "%" + text + "%" );
			  pstmt.setString(3, "%" + text + "%" );
			  rs=pstmt.executeQuery();

			  while(rs.next()){
				  UsersDTO user = new UsersDTO();
				  user.setEmail(rs.getString("email"));
				  user.setName(rs.getString("name"));
				  user.setBirthday(rs.getString("birthday"));
				  user.setIntroduce(rs.getString("introduce"));
				  pstmt=conn.prepareStatement("SELECT path FROM pictures WHERE id = ?");
				  pstmt.setString(1, rs.getString("profile_picture"));
				  rs2=pstmt.executeQuery();
				  rs2.next();
				  user.setProfilepicture(rs2.getString("path"));
				  mlist.add(user);
			  }
		  }catch(Exception e){ 
			  e.printStackTrace();
		  }finally{
			 if(rs2 != null) 
				    try{rs2.close();}catch(SQLException sqle){}
			 if(rs != null) 
			    try{rs.close();}catch(SQLException sqle){}
			 if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle){}
			 if(conn != null) 
				try{conn.close();}catch(SQLException sqle){}
		  }
		  return mlist;
	}
	public int  dropUser(String email) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {			
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt=conn.prepareStatement("delete from users where email = ?;");
			pstmt.setString(1, email);
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
	public int  loginUser(String email, String password) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {			
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt=conn.prepareStatement("select email, password from users where email = ? and password = sha2(?, 256);");
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pstmt=conn.prepareStatement("update users set current_login = CURRENT_TIMESTAMP where email = ?");
				pstmt.setString(1, email);
				pstmt.executeUpdate();
				result = 1;
			}
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

	public int  registerUser(UsersDTO users) {
		int result = 0;
		
		String email = users.getEmail();
		String password = users.getPassword();
		String name = users.getName();
		String birthday = users.getBirthday();
		String introduce = users.getIntroduce();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select email from users where email = ?");
			pstmt.setString(1, email);
			 rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 0;
			}
			else {
				pstmt = conn.prepareStatement("insert into users(email, password, name, birthday, introduce) values(?, sha2(?, 256), ?, ?, ?);");
				pstmt.setString(1, email);
				pstmt.setString(2, password);
				pstmt.setString(3, name);
				pstmt.setString(4, birthday);
				pstmt.setString(5, introduce);
				pstmt.executeUpdate();
				result = 1;
			}
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
	
	public int changePassword(UsersDTO users) {
		int result = 0;

		String email = users.getEmail();
		String password = users.getPassword();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("update users set password = sha2(?, 256) where email = ?");
			pstmt.setString(1, password);
			pstmt.setString(2, email);
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

	public int  updatePicture(String email, int pic_id) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("update users set profile_picture = ? where email = ?");
			pstmt.setInt(1, pic_id);
			pstmt.setString(2, email);
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
	
	public int  updateUser(UsersDTO users) {
		int result = 0;
		
		String email = users.getEmail();
		String name = users.getName();
		String birthday = users.getBirthday();
		String introduce = users.getIntroduce();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("update users set name = ?, birthday = ?, introduce = ? where email = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, birthday);
			pstmt.setString(3, introduce);
			pstmt.setString(4, email);
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

	public UsersDTO getUser(String email) {
		UsersDTO ud = new UsersDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select id, email, name, birthday, introduce, regdatetime, admin, profile_picture from users where email = ?");
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ud.setId(rs.getInt("id"));
				ud.setEmail(rs.getString("email"));
				ud.setName(rs.getString("name"));
				ud.setBirthday(rs.getDate("birthday").toString());
				ud.setIntroduce(rs.getString("introduce"));
				ud.setRegdatetime(rs.getTimestamp("regdatetime"));
				ud.setAdmin(rs.getInt("admin"));
				pstmt=conn.prepareStatement("SELECT path FROM pictures WHERE id = ?");
				pstmt.setString(1, rs.getString("profile_picture"));
				rs2=pstmt.executeQuery();
				rs2.next();
				ud.setProfilepicture(rs2.getString("path"));
			}
			else
				ud = null;
		} catch (SQLException e) {
			e.printStackTrace();
			ud = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			ud = null;
		} finally {
			 if(rs != null) 
				    try{rs.close();}catch(SQLException sqle){}
			 if(rs2 != null) 
				    try{rs.close();}catch(SQLException sqle){}
			if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(conn != null) 
				try{conn.close();}catch(SQLException sqle) {}
		}
		return ud;
	}
	public UsersDTO getUser(int id) {
		UsersDTO ud = new UsersDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select id, email, name, birthday, introduce, regdatetime, admin, profile_picture from users where id = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ud.setId(rs.getInt("id"));
				ud.setEmail(rs.getString("email"));
				ud.setName(rs.getString("name"));
				ud.setBirthday(rs.getDate("birthday").toString());
				ud.setIntroduce(rs.getString("introduce"));
				ud.setRegdatetime(rs.getTimestamp("regdatetime"));
				ud.setAdmin(rs.getInt("admin"));
				pstmt=conn.prepareStatement("SELECT path FROM pictures WHERE id = ?");
				pstmt.setString(1, rs.getString("profile_picture"));
				rs2=pstmt.executeQuery();
				rs2.next();
				ud.setProfilepicture(rs2.getString("path"));
			}
			else
				ud = null;
		} catch (SQLException e) {
			e.printStackTrace();
			ud = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			ud = null;
		} finally {
			 if(rs != null) 
				    try{rs.close();}catch(SQLException sqle){}
			 if(rs2 != null) 
				    try{rs.close();}catch(SQLException sqle){}
			if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(conn != null) 
				try{conn.close();}catch(SQLException sqle) {}
		}
		return ud;
	}
}
