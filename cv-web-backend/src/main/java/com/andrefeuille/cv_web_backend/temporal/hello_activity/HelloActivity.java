package com.andrefeuille.cv_web_backend.temporal.hello_activity;

import io.temporal.activity.ActivityInterface;
import io.temporal.activity.ActivityMethod;

@ActivityInterface
public interface HelloActivity {
    @ActivityMethod
    String composeGreeting(String name);
}