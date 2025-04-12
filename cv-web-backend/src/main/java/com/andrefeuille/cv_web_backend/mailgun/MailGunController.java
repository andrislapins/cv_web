package com.andrefeuille.cv_web_backend.mailgun;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/mailgun")
@RequiredArgsConstructor
@Slf4j
public class MailGunController {

    private final MailGunService mailService;
    
    @GetMapping("/send")
    public String sendMail(@RequestParam(required = false) String to) {
        if (to == null || to.isBlank()) {
            to = System.getenv("MAILGUN_EMAIL_TO");
        }
        log.info("📧 Request on /mailgun/send to {}", to);
        mailService.sendTemplatedEmail(to, "Andre Feuille");
        return "Templated email sent!";
    }
}