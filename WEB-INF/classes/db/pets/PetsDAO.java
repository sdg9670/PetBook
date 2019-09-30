package db.pets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import db.users.UsersDTO;



public class PetsDAO {
	public int  getFollowingCount(int petid) {
		int result = 0;
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("SELECT count(*) count FROM pet_followings WHERE pet = ?;");
			pstmt.setInt(1, petid);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				result = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { }
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) { }
	 	}
		return result;
	}
	public int  setFollowing(int userid, int petid) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			if(getFollowing(userid, petid))
				pstmt = conn.prepareStatement("DELETE FROM pet_followings WHERE pet = ? and user = ?");
			else	
				pstmt = conn.prepareStatement("INSERT INTO pet_followings (pet, user) VALUES(?, ?)");
			pstmt.setInt(1, petid);
			pstmt.setInt(2, userid);
			pstmt.executeUpdate();
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { }
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) { }
	 	}
		return result;
	}
	public boolean  getFollowing(int userid, int petid) {
		boolean result = false;
		
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("SELECT * FROM pet_followings WHERE pet = ? and user = ?");
			pstmt.setInt(1, petid);
			pstmt.setInt(2, userid);
			rs = pstmt.executeQuery();
			if(rs.next())
				result = true;
			else
				result = false;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
	 		if(rs != null) 
	 			try{rs.close();}catch(SQLException sqle) { }
	 		if(pstmt != null) 
	 			try{pstmt.close();}catch(SQLException sqle) { }
	 		if(conn != null) 
	 			try{conn.close();}catch(SQLException sqle) { }
	 	}
		return result;
	}
	public int  updatePicture(int id, int pic_id) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("update pets set profile_picture = ? where id = ?");
			pstmt.setInt(1, pic_id);
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
	
	public int  dropPet(int petid) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {			
			Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt=conn.prepareStatement("delete from pets where id = ?;");
			pstmt.setInt(1, petid);
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
	public int  updatePet(PetsDTO pet) {
		int result = 0;

		String name = pet.getName();
		String type = pet.getType();
		String birthday = pet.getBirthday();
		String introduce = pet.getIntroduce();
		int petid = pet.getId();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("UPDATE pets SET name = ?, type = ?, birthday = ?, introduce = ? WHERE id = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, type);
			pstmt.setString(3, birthday);
			pstmt.setString(4, introduce);
			pstmt.setInt(5, petid);
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
	
	public int  createPet(PetsDTO pet) {
		int result = 0;

		String name = pet.getName();
		String type = pet.getType();
		String birthday = pet.getBirthday();
		String introduce = pet.getIntroduce();
		int petuser = pet.getPetuser();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("insert into pets(name, type, birthday, introduce, pet_user) values(?, ?, ?, ?, ?);");
			pstmt.setString(1, name);
			pstmt.setString(2, type);
			pstmt.setString(3, birthday);
			pstmt.setString(4, introduce);
			pstmt.setInt(5, petuser);
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
	
	public PetsDTO getPet(int id) {
		PetsDTO pets = new PetsDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			pstmt = conn.prepareStatement("select * from pets where id = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				  pets.setId(rs.getInt("id"));
				  pets.setName(rs.getString("name"));
				  pets.setBirthday(rs.getString("birthday"));
				  pets.setType(rs.getString("type"));
				  pets.setIntroduce(rs.getString("introduce"));
				  pets.setPetuser(rs.getInt("pet_user"));
				  pets.setProfilepicture(rs.getString("profile_picture"));
				  pets.setCreatedatetime(rs.getTimestamp("createdatetime"));
				  pstmt=conn.prepareStatement("SELECT path FROM pictures WHERE id = ?");
				  pstmt.setString(1, rs.getString("profile_picture"));
				  rs2=pstmt.executeQuery();
				  rs2.next();
				  pets.setProfilepicture(rs2.getString("path"));
			}
			else
				pets = null;
		} catch (SQLException e) {
			e.printStackTrace();
			pets = null;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			pets = null;
		} finally {
			if(rs != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(rs2 != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle) {}
			if(conn != null) 
				try{conn.close();}catch(SQLException sqle) {}
		}
		return pets;
	}
	
	public Vector<PetsDTO> getPetsList(int id) {
		  Connection conn=null;
		  PreparedStatement pstmt=null;
		  ResultSet rs=null;
		  ResultSet rs2=null;
		  Vector<PetsDTO> mlist = new Vector<PetsDTO>();
		  try{
			  Class.forName("com.mysql.cj.jdbc.Driver");
			  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SDG_PetBook?serverTimezone=UTC&useUnicode=yes&characterEncoding=UTF-8&useSSL=false", "root", "dongyang");
			  pstmt=conn.prepareStatement("SELECT * FROM pets WHERE pet_user = ? ORDER BY createdatetime ASC;");

			  pstmt.setInt(1, id );
			  rs=pstmt.executeQuery();

			  while(rs.next()){
				  PetsDTO pets = new PetsDTO();
				  pets.setId(rs.getInt("id"));
				  pets.setName(rs.getString("name"));
				  pets.setBirthday(rs.getString("birthday"));
				  pets.setType(rs.getString("type"));
				  pets.setIntroduce(rs.getString("introduce"));
				  pets.setPetuser(rs.getInt("pet_user"));
				  pets.setProfilepicture(rs.getString("profile_picture"));
				  pets.setCreatedatetime(rs.getTimestamp("createdatetime"));
				  pstmt=conn.prepareStatement("SELECT path FROM pictures WHERE id = ?");
				  pstmt.setString(1, rs.getString("profile_picture"));
				  rs2=pstmt.executeQuery();
				  rs2.next();
				  pets.setProfilepicture(rs2.getString("path"));
				  mlist.add(pets);
			  }
		  }catch(Exception e){ 
			  e.printStackTrace();
		  }finally{
			 if(rs != null) 
				    try{rs.close();}catch(SQLException sqle){}
			 if(rs2 != null) 
				    try{rs.close();}catch(SQLException sqle){}
			 if(pstmt != null) 
				try{pstmt.close();}catch(SQLException sqle){}
			 if(conn != null) 
				try{conn.close();}catch(SQLException sqle){}
		  }
		  return mlist;
	}
}
