package dbaccess;

import java.io.Serializable;

public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String email;
	private String name;
	private String password;
	private String role;

	// Constructors, getters, and setters
	public User(int id, String email, String name, String password, String role) {
		this.id = id;
		this.email = email;
		this.name = name;
		this.password = password;
		this.role = role;
	}

	public int getid() {
		return id;
	}

	public void setid(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "User{" + "userid=" + id + ", email='" + email + '\'' + ", name='" + name + '\'' + ", password='"
				+ password + '\'' + ", role='" + role + '\'' + '}';
	}
}
