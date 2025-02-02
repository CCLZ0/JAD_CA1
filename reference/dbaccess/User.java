package com.myshop.user_ws.dbaccess;

public class User {
	// Instance variables
    private String userid;
    private int age;
    private String gender;
    
    //public UserDetails() {
    //}
    
    // Getter and Setter for userid
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    // Getter and Setter for age
    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    // Getter and Setter for gender
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}