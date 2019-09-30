package db.comments;

public class CommentsDTO {
	int id;
	String content;
	String commentdatetime;
	int user;
	int write;
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
	public String getCommentdatetime() {
		return commentdatetime;
	}
	public void setCommentdatetime(String commentdatetime) {
		this.commentdatetime = commentdatetime;
	}
	public int getUser() {
		return user;
	}
	public void setUser(int user) {
		this.user = user;
	}
	public int getWrite() {
		return write;
	}
	public void setWrite(int write) {
		this.write = write;
	}
}
