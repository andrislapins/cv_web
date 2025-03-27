package com.andrefeuille.cv_web_backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
@Slf4j
// @EnableAutoConfiguration(exclude = {ErrorMvcAutoConfiguration.class})
public class CvWebBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(CvWebBackendApplication.class, args);
	}

	@PostConstruct
	public void logStartup() {
		log.info("✅ cv-web-backend is up and running, ready to accept requests");
	}

	@EventListener(ApplicationReadyEvent.class)
    public void onReady() {
        log.info("✅ cv-web-backend is ready to accept HTTP requests!");
    }

}
