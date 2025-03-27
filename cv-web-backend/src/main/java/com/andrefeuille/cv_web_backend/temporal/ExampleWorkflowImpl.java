package com.andrefeuille.cv_web_backend.temporal;

import java.time.Duration;

import io.temporal.activity.ActivityOptions;
import io.temporal.workflow.Workflow;

public class ExampleWorkflowImpl implements ExampleWorkflow {
    private final ExampleActivities activities = Workflow.newActivityStub(
            ExampleActivities.class,
            ActivityOptions.newBuilder()
                    .setStartToCloseTimeout(Duration.ofSeconds(10))
                    .build());

    @Override
    public String sayHello(String name) {
        return activities.composeGreeting(name);
    }
}