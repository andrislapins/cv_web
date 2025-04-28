package com.andrefeuille.cv_web_backend.temporal;

import io.temporal.activity.ActivityInterface;
import io.temporal.activity.ActivityMethod;

@ActivityInterface
public interface ExampleActivities {
    @ActivityMethod
    String composeGreeting(String name);
}