package com.andrefeuille.cv_web_backend.temporal.hello_activity;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HelloActivityImpl implements HelloActivity {
    @Override
    public String composeGreeting(String name) {
        String result = "Hello, " + name + "!";
        log.info("👋 Activity executed with result: " + result);
        return result;
    }
}
