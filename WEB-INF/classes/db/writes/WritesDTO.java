package db.writes;

public class WritesDTO {
	int id;
	String content;
	String writedatetime;
	int pet;
	int picture;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWritedatetime() {
		return writedatetime;
	}
	public void setWritedatetime(String writedatetime) {
		this.writedatetime = writedatetime;
	}
	public int getPet() {
		return pet;
	}
	public void setPet(int pet) {
		this.pet = pet;
	}
	public int getPicture() {
		return picture;
	}
	public void setPicture(int picture) {
		this.picture = picture;
	}
}
