package responses;
 
import dbaccess.User;
 
public class AddUserResponse {
    private String test;
    private int rowsAffected;
    private String status;
    private User user;
 
	public String getTest() {
		return test;
	}
	public void setTest(String test) {
		this.test = test;
	}
	public int getRowsAffected() {
		return rowsAffected;
	}
	public void setRowsAffected(int rowsAffected) {
		this.rowsAffected = rowsAffected;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public User getMember() {
		return user;
	}
	public void setMember(User member) {
		this.user = user;
	}
 
}
