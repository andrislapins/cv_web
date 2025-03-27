package com.andrefeuille.cv_web_backend.temporal;

public class ExampleActivitiesImpl implements ExampleActivities {
    @Override
    public String composeGreeting(String name) {
        return "Hello, " + name + "!";
    }
}
