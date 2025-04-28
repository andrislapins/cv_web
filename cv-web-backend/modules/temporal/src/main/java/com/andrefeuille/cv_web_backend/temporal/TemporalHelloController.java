package com.andrefeuille.cv_web_backend.temporal;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import io.temporal.client.WorkflowClient;
import io.temporal.client.WorkflowOptions;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import com.andrefeuille.cv_web_backend.temporal.hello_workflow.HelloWorkflow;
import io.temporal.api.enums.v1.WorkflowIdReusePolicy;

@RestController
@Slf4j
@RequiredArgsConstructor
public class TemporalHelloController {

    private final WorkflowClient workflowClient; 

    @GetMapping("/temporal/hello")
    public String startWorkflow() {
        WorkflowOptions workflowOptions = WorkflowOptions.newBuilder()
            .setTaskQueue(HelloNames.HELLO_WORLD_TASK_QUEUE)
            .setWorkflowId("hello-world-workflow")
            .setWorkflowIdReusePolicy(WorkflowIdReusePolicy.WORKFLOW_ID_REUSE_POLICY_ALLOW_DUPLICATE)
            .build();

        HelloWorkflow workflow = workflowClient.newWorkflowStub(HelloWorkflow.class, workflowOptions);
        workflow.sayHello("Temporal!");
        log.info("✅ cv-web-backend HelloWorkflow executed!");
        return "HelloWorkflow started";
    }
}
