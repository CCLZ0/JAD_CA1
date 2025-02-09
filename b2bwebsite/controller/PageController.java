package com.myshop.b2bwebsite.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }
    
    @GetMapping("/index")
    public String showIndexPage() {
        return "index";
    }
    
    @GetMapping("/editService")
    public String showEditServicePage() {
        return "editService";
    }
}