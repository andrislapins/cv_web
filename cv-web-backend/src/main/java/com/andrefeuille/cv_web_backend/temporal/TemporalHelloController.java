package com.andrefeuille.cv_web_backend.temporal;

// import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.temporal.api.common.v1.WorkflowExecution;
import io.temporal.client.WorkflowClient;
import io.temporal.client.WorkflowOptions;
import io.temporal.serviceclient.WorkflowServiceStubs;
import io.temporal.serviceclient.WorkflowServiceStubsOptions;
import lombok.extern.slf4j.Slf4j;

import com.andrefeuille.cv_web_backend.temporal.hello_workflow.HelloWorkflow;

import io.temporal.api.enums.v1.WorkflowIdReusePolicy;

@RestController
@Slf4j
public class TemporalHelloController {

    // @Value("${temporal.target}")
    // private String temporalTarget;

    private final WorkflowClient workflowClient;

    WorkflowOptions workflowOptions = WorkflowOptions.newBuilder()
        .setTaskQueue(HelloNames.HELLO_WORLD_TASK_QUEUE)
        .setWorkflowId("hello-world-workflow")
        .setWorkflowIdReusePolicy(WorkflowIdReusePolicy.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE)
        .build();

    public TemporalHelloController() {
        WorkflowServiceStubsOptions options = WorkflowServiceStubsOptions.newBuilder()
            .setTarget("temporal:7233")
            .build();
        WorkflowServiceStubs serviceStub = WorkflowServiceStubs.newConnectedServiceStubs(options, java.time.Duration.ofSeconds(10));
        this.workflowClient = WorkflowClient.newInstance(serviceStub);
    }

    @GetMapping("/temporal/hello")
    public String startWorkflow() {
        HelloWorkflow workflow = workflowClient.newWorkflowStub(HelloWorkflow.class, workflowOptions);
        WorkflowExecution we = WorkflowClient.start(workflow::sayHello, "Temporal!");
        log.info("✅ cv-web-backend HelloWorkflow executed! {}, {}", we.getWorkflowId(), we.getRunId());
        return "HelloWorkflow started";
    }
}