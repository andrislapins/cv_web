package com.andrefeuille.cv_web_backend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "home";
    }

    @GetMapping("/success")
    public String success() {
        return "stripe/success";
    }

    @GetMapping("/cancel")
    public String cancel() {
        return "stripe/cancel";
    }
}
