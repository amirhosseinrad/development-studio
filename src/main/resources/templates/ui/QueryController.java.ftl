package ${basePackage}.ui;

import ${basePackage}.api.dto.${aggregateName}Dto;
import ${basePackage}.domain.${aggregateName}Id;
import org.axonframework.queryhandling.QueryGateway;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/${serviceName}/queries")
public class ${aggregateName}QueryController {

private final QueryGateway queryGateway;

public ${aggregateName}QueryController(QueryGateway queryGateway) {
this.queryGateway = queryGateway;
}

@GetMapping("/{id}")
public CompletableFuture<Optional<${aggregateName}Dto>> getById(@PathVariable String id) {
    return queryGateway.query(
    "find${aggregateName}ById",
    new ${aggregateName}Id(id),
    Optional.class
    );
    }

    @GetMapping
    public CompletableFuture<List<${aggregateName}Dto>> getAll() {
        return queryGateway.query(
        "findAll${aggregateName}",
        null,
        List.class
        );
        }
        }
