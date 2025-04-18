package com.andrefeuille.cv_web_backend.temporal;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.temporal.client.WorkflowClient;
import io.temporal.serviceclient.WorkflowServiceStubs;
import io.temporal.worker.Worker;
import io.temporal.worker.WorkerFactory;

@Configuration
public class TemporalConfig {

    @Bean
    public WorkflowServiceStubs workflowServiceStubs() {
        return WorkflowServiceStubs.newLocalServiceStubs();
    }

    @Bean
    public WorkerFactory workerFactory(WorkflowServiceStubs serviceStubs) {
        WorkflowClient client = WorkflowClient.newInstance(serviceStubs);
        WorkerFactory factory = WorkerFactory.newInstance(client);
        Worker worker = factory.newWorker("cv-web-task-queue");

        worker.registerWorkflowImplementationTypes(ExampleWorkflowImpl.class);
        worker.registerActivitiesImplementations(new ExampleActivitiesImpl());

        factory.start();
        return factory;
    }
}
