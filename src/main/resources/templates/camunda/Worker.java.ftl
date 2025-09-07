package ${basePackage}.ui;

import io.camunda.zeebe.client.api.worker.JobClient;
import io.camunda.zeebe.client.api.response.ActivatedJob;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;
import io.camunda.zeebe.spring.client.annotation.JobWorker;

@Component
public class ${aggregateName}Worker {

@Autowired
public ${aggregateName}Worker() {
// you can inject services here
}

@JobWorker(type = "${serviceName}-task", autoComplete = true)
public void handle(JobClient client, ActivatedJob job) {
System.out.println("⚡ Handling job in ${aggregateName}Worker: " + job);
// TODO: implement your business logic
}
}
