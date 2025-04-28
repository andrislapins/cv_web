package com.andrefeuille.cv_web_backend.temporal;

import jakarta.annotation.PostConstruct;

// import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Component;

import com.andrefeuille.cv_web_backend.temporal.hello_activity.HelloActivityImpl;
import com.andrefeuille.cv_web_backend.temporal.hello_workflow.HelloWorkflowImpl;

import io.temporal.client.WorkflowClient;
import io.temporal.serviceclient.WorkflowServiceStubs;
import io.temporal.serviceclient.WorkflowServiceStubsOptions;
import io.temporal.worker.Worker;
import io.temporal.worker.WorkerFactory;
import org.springframework.beans.factory.annotation.Value;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class HelloWorker {

    @Value("${spring.temporal.connection.target}")
    private String temporalTarget;

    @PostConstruct
    public void startWorker() {
        new Thread(() -> {
            log.info("🛠️ Starting Temporal worker in background thread...");

            // Create a stub that accesses a Temporal Service on the local development machine
            WorkflowServiceStubs serviceStub = WorkflowServiceStubs.newServiceStubs(
                WorkflowServiceStubsOptions.newBuilder()
                .setTarget(temporalTarget)
                .build()
            );

            // The Worker uses the Client to communicate with the Temporal Service
            WorkflowClient client = WorkflowClient.newInstance(serviceStub);

            // A WorkerFactory creates Workers
            WorkerFactory factory = WorkerFactory.newInstance(client);

            // A Worker listens to one Task Queue.
            // This Worker processes both Workflows and Activities
            Worker worker = factory.newWorker(HelloNames.HELLO_WORLD_TASK_QUEUE);

            // Register a Workflow implementation with this Worker
            // The implementation must be known at runtime to dispatch Workflow tasks
            // Workflows are stateful so a type is needed to create instances.
            worker.registerWorkflowImplementationTypes(HelloWorkflowImpl.class);

            // Register Activity implementation(s) with this Worker.
            // The implementation must be known at runtime to dispatch Activity tasks
            // Activities are stateless and thread safe so a shared instance is used.
            worker.registerActivitiesImplementations(new HelloActivityImpl());

            // Start all registered Workers. The Workers will start polling the Task Queue.
            log.info("🛠️ Temporal worker started and polling {}", HelloNames.HELLO_WORLD_TASK_QUEUE);
            factory.start();
        }).start();
    }
}
