package db.pets;

import java.sql.Timestamp;

public class PetsDTO {
	int id;
	String name;
	String Birthday;
	String type;
	String introduce;
	int petuser;
	String profilepicture;
	Timestamp createdatetime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirthday() {
		return Birthday;
	}
	public void setBirthday(String birthday) {
		Birthday = birthday;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public int getPetuser() {
		return petuser;
	}
	public void setPetuser(int petuser) {
		this.petuser = petuser;
	}
	public String getProfilepicture() {
		return profilepicture;
	}
	public void setProfilepicture(String profilepicture) {
		this.profilepicture = profilepicture;
	}
	public Timestamp getCreatedatetime() {
		return createdatetime;
	}
	public void setCreatedatetime(Timestamp createdatetime) {
		this.createdatetime = createdatetime;
	}
}
