package com.myshop.user_ws.controller;

import java.sql.SQLException;


import java.util.ArrayList;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myshop.user_ws.dbaccess.User;
import com.myshop.user_ws.dbaccess.UserDAO;

@RestController

public class UserController {

	@RequestMapping(method = RequestMethod.GET, path = "/getUser/{uid}")
	public User getUser(@PathVariable("uid") String uid) {
		User user = new User();
		try {
			UserDAO db = new UserDAO();
			user = db.getUserDetails(uid);
		} catch (Exception e) {
			System.out.println("Error: " + e);
		}
		return user;
	}

	@RequestMapping(method = RequestMethod.GET, path = "/getAllUsers")
	public ArrayList<User> getAllUsers() {
		ArrayList<User> myList = new ArrayList<>();
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
			String uId = user.getUserid();
			System.out.print("...inside UserController...uId: " + uId);

			int uAge = user.getAge();
			String uGender = user.getGender();

			rec = db.insertUser(uId, uAge, uGender);
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

}
