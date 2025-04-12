package com.andrefeuille.cv_web_backend.temporal.hello_workflow;

import io.temporal.workflow.WorkflowInterface;
import io.temporal.workflow.WorkflowMethod;

@WorkflowInterface
public interface HelloWorkflow {
    @WorkflowMethod
    String sayHello(String name);
}