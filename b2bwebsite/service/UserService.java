package com.myshop.b2bwebsite.service;

import com.myshop.b2bwebsite.dbaccess.User;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Service
public class UserService {
    private final String BASE_URL = "http://localhost:8081/user";

    public User getUser(String uid) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(BASE_URL + "/getUser/" + uid, User.class);
    }

    public List<User> getAllUsers() {
        RestTemplate restTemplate = new RestTemplate();
        User[] users = restTemplate.getForObject(BASE_URL + "/getAllUsers", User[].class);
        return Arrays.asList(users);
    }

    public int createUser(User user) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.postForObject(BASE_URL + "/createUser", user, Integer.class);
    }

    public int updateUser(String uid, User user) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.put(BASE_URL + "/updateUser/" + uid, user);
        return 1; // Assuming the update is successful
    }

    public int deleteUser(String uid) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.delete(BASE_URL + "/deleteUser/" + uid);
        return 1; // Assuming the deletion is successful
    }

    public User loginUser(User user) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.postForObject(BASE_URL + "/login", user, User.class);
    }
}

