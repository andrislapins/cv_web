package com.andrefeuille.cv_web_backend.temporal;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.andrefeuille.cv_web_backend.temporal.hello_activity.HelloActivityImpl;
import com.andrefeuille.cv_web_backend.temporal.hello_workflow.HelloWorkflowImpl;

import io.temporal.client.WorkflowClient;
import io.temporal.worker.Worker;
import io.temporal.worker.WorkerFactory;

@Component
@Slf4j
@RequiredArgsConstructor
public class HelloWorker {

    private final WorkflowClient workflowClient;

    @PostConstruct
    public void startWorker() {
        new Thread(() -> {
            log.info("🛠️ Starting Temporal worker in background thread...");

            WorkerFactory factory = WorkerFactory.newInstance(workflowClient);
            Worker worker = factory.newWorker(HelloNames.HELLO_WORLD_TASK_QUEUE);

            worker.registerWorkflowImplementationTypes(HelloWorkflowImpl.class);
            worker.registerActivitiesImplementations(new HelloActivityImpl());

            factory.start();
            log.info("🛠️ Temporal worker started and polling {}", HelloNames.HELLO_WORLD_TASK_QUEUE);
        }).start();
    }
}
