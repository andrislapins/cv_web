package com.andrefeuille.cv_web_backend.temporal;

import io.temporal.workflow.WorkflowInterface;
import io.temporal.workflow.WorkflowMethod;

@WorkflowInterface
public interface ExampleWorkflow {
    @WorkflowMethod
    String sayHello(String name);
}