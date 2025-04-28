package com.andrefeuille.cv_web_backend.temporal;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.temporal.client.WorkflowClient;
import io.temporal.client.WorkflowOptions;
import io.temporal.serviceclient.WorkflowServiceStubs;

@RestController
public class TemporalTestController {

    private final WorkflowClient workflowClient;

    public TemporalTestController(WorkflowClient workflowClient) {
        this.workflowClient = workflowClient;
    }

    @GetMapping("/temporal/hello")
    public String startWorkflow() {
        ExampleWorkflow workflow = workflowClient.newWorkflowStub(
                ExampleWorkflow.class,
                WorkflowOptions.newBuilder()
                        .setTaskQueue("cv-web-task-queue")
                        .build());

        return workflow.sayHello("Temporal!");
    }
}