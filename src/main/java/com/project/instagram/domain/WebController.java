package com.project.instagram.domain;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String main(Model model){

        System.out.println("main start-----");

        return "index";

    }
}
