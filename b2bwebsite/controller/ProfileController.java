package com.myshop.b2bwebsite.controller;

import com.myshop.b2bwebsite.dbaccess.User;

import com.myshop.b2bwebsite.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @GetMapping("/profile/{uid}")
    public String getUserProfile(@PathVariable String uid, Model model) {
        User user = userService.getUser(uid);
        model.addAttribute("user", user);
        return "profile";
    }
}
