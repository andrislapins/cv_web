package com.andrefeuille.cv_web_backend.temporal.hello_workflow;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

import com.andrefeuille.cv_web_backend.temporal.hello_activity.HelloActivity;

import io.temporal.activity.ActivityOptions;
import io.temporal.common.RetryOptions;
import io.temporal.workflow.Workflow;

public class HelloWorkflowImpl implements HelloWorkflow {

    private final RetryOptions retryoptions = RetryOptions.newBuilder()
        .setInitialInterval(Duration.ofSeconds(1))
        .setMaximumInterval(Duration.ofSeconds(10)) //set to 10 seconds for demo, default is 100 seconds
        .setBackoffCoefficient(2)
        .setMaximumAttempts(500)
        .build();

    private final ActivityOptions defaultActivityOptions = ActivityOptions.newBuilder()
        .setStartToCloseTimeout(Duration.ofSeconds(5))
        .setRetryOptions(retryoptions)
        .build();

    private final Map<String, ActivityOptions> methodOptions = new HashMap<>() {{
        put("HelloTaskQueue", ActivityOptions.newBuilder().setHeartbeatTimeout(Duration.ofSeconds(5)).build());
    }};
            
    private final HelloActivity activities = Workflow.newActivityStub(
            HelloActivity.class,
            defaultActivityOptions,
            methodOptions
    );

    @Override
    public String sayHello(String name) {
        String greeting = activities.composeGreeting(name);
        Workflow.getLogger(HelloWorkflowImpl.class).info("🎯 Activity result: {}", greeting);
        return greeting;
    }
}