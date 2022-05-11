package comment;

public class Comment {
	private int commentID;
	private int cafeteriaID;
	private String memberID;
	private String commentDate;
	private String commentContent;
	
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public int getCafeteriaID() {
		return cafeteriaID;
	}
	public void setCafeteriaID(int cafeteriaID) {
		this.cafeteriaID = cafeteriaID;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

}
