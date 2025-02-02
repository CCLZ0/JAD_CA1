package com.shinepro.admin.controller;

import java.sql.SQLException;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.shinepro.admin.dbaccess.User;
import com.shinepro.admin.dbaccess.UserDAO;

@RestController
@RequestMapping("/user") // Link: http://localhost:8081/admin/user/<path>
public class UserController {

	@RequestMapping(method = RequestMethod.GET, path = "/getUser/{uid}")
	public User getUser(@PathVariable("uid") String uid) {
		User user = null;
		try {
			UserDAO db = new UserDAO();
			user = db.getUserDetails(uid);
		} catch (Exception e) {
			System.out.println("Error: " + e);
		}
		return user;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getAllUsers")
	public List<User> getAllUsers() {
		List<User> myList = null;
		try {
			UserDAO db = new UserDAO();
			myList = db.listAllUsers(); // Retrieve all users from the database
		} catch (SQLException e) {
			System.out.println("Error retrieving all users: " + e);
		}
		return myList; // Return the list of users as a JSON array
	}

	@RequestMapping(path = "/createUser", consumes = "application/json", method = RequestMethod.POST)
	public int createUser(@RequestBody User user) {
		int rec = 0;
		try {
			UserDAO db = new UserDAO();
			rec = db.insertUser(user);
			System.out.print("...done create user.." + rec);
		} catch (Exception e) {
			System.out.print(e.toString());
		}
		return rec; // <-- using the default ResponseBody with custom status from Spring
	}

	@RequestMapping(path = "/updateUser/{uid}", consumes = "application/json", method = RequestMethod.PUT)
	public int updateUser(@PathVariable String uid, @RequestBody User user) {
		int rec = 0;
		try {
			UserDAO db = new UserDAO();
			rec = db.updateUser(uid, user);
			System.out.print("...in UserController - done updating user: " + rec);
		} catch (Exception e) {
			System.out.print("Error: " + e.toString());
		}
		return rec;
	}

	@RequestMapping(path = "/deleteUser/{uid}", method = RequestMethod.DELETE)
	public int deleteUser(@PathVariable String uid) {
		int rec = 0;
		try {
			UserDAO db = new UserDAO();
			rec = db.deleteUser(uid);
			System.out.print("...in UserController - done deleting user: " + rec);
		} catch (Exception e) {
			System.out.print("Error: " + e.toString());
		}
		return rec;
	}

	@RequestMapping(path = "/login", consumes = "application/json", method = RequestMethod.POST)
	public User login(@RequestBody User user) {
		User authenticatedUser = null;
		try {
			UserDAO db = new UserDAO();
			authenticatedUser = db.verifyUser(user.getEmail(), user.getPassword());
			if (authenticatedUser != null) {
				System.out.print("...login successful for user: " + authenticatedUser.getEmail());
			} else {
				System.out.print("...login failed for user: " + user.getEmail());
			}
		} catch (Exception e) {
			System.out.print("Error: " + e.toString());
		}
		return authenticatedUser;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/isAdmin/{userid}")
	public boolean isAdmin(@PathVariable("userid") int userid) {
		boolean isAdmin = false;
		try {
			UserDAO db = new UserDAO();
			isAdmin = db.isAdmin(userid);
		} catch (SQLException e) {
			System.out.println("Error verifying admin status: " + e);
		}
		return isAdmin;
	}
}