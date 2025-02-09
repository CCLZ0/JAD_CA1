package com.myshop.b2bwebsite.controller;

import com.myshop.b2bwebsite.dbaccess.User;
import com.myshop.b2bwebsite.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class UserControllerClient {

    @Autowired
    private UserService userService;

    @GetMapping("/b2b/user/{uid}")
    public User getUser(@PathVariable String uid) {
        return userService.getUser(uid);
    }

    @GetMapping("/b2b/users")
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @PutMapping("/b2b/user/{uid}")
    public int updateUser(@PathVariable String uid, @RequestBody User user) {
        return userService.updateUser(uid, user);
    }

    @DeleteMapping("/b2b/user/{uid}")
    public int deleteUser(@PathVariable String uid) {
        return userService.deleteUser(uid);
    }

    @PostMapping("/b2b/login")
    public ModelAndView loginUser(@RequestParam("email") String email, @RequestParam("password") String password) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        User loggedInUser = userService.loginUser(user);

        if (loggedInUser == null) {
            ModelAndView modelAndView = new ModelAndView("login");
            modelAndView.addObject("message", "Invalid email or password. Please try again.");
            return modelAndView;
        } else if (!"b2b".equals(loggedInUser.getRole())) {
            ModelAndView modelAndView = new ModelAndView("login");
            modelAndView.addObject("message", "You are not a b2b user. Please login as a b2b user, or create a b2b account.");
            return modelAndView;
        } else {
            return new ModelAndView("redirect:/index");
        }
    }
    
    @PostMapping("/b2b/register")
    public ModelAndView registerUser(@RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("name") String name) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setName(name);
        user.setRole("b2b"); // Set the role to "b2b"
        int result = userService.createUser(user);

        if (result > 0) {
            return new ModelAndView("redirect:/login");
        } else {
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("message", "Registration failed. Please try again.");
            return modelAndView;
        }
    }
    
    @PostMapping("/b2b/logout")
    public ModelAndView logoutUser(HttpSession session) {
        session.invalidate();
        return new ModelAndView("redirect:/login");
    }

}