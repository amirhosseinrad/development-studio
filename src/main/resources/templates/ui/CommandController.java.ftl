package ${basePackage}.ui;

import ${basePackage}.api.commands.Create${aggregateName}Command;
import ${basePackage}.domain.${aggregateName}Id;
import org.axonframework.commandhandling.gateway.CommandGateway;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;
import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/${serviceName}/commands")
public class ${aggregateName}CommandController {

private final CommandGateway commandGateway;

public ${aggregateName}CommandController(CommandGateway commandGateway) {
this.commandGateway = commandGateway;
}

@PostMapping
public CompletableFuture<String> create(@RequestBody String name) {
    String id = UUID.randomUUID().toString();
    return commandGateway.send(new Create${aggregateName}Command(new ${aggregateName}Id(id), name));
    }

    // Add update/delete endpoints when you scaffold more commands
    }
