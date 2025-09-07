package ${basePackage}.projection;

import ${basePackage}.api.events.${aggregateName}CreatedEvent;
import ${basePackage}.api.dto.${aggregateName}Dto;
import ${basePackage}.domain.${aggregateName};
import ${basePackage}.domain.${aggregateName}Id;
import ${basePackage}.infra.${aggregateName}Repository;
import ${basePackage}.infra.${aggregateName}Mapper;
import org.axonframework.eventhandling.EventHandler;
import org.axonframework.queryhandling.QueryHandler;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Component
public class ${aggregateName}Projection {

private final ${aggregateName}Repository repository;
private final ${aggregateName}Mapper mapper;

public ${aggregateName}Projection(${aggregateName}Repository repository,
${aggregateName}Mapper mapper) {
this.repository = repository;
this.mapper = mapper;
}

@EventHandler
@Transactional
public void on(${aggregateName}CreatedEvent event) {
${aggregateName} entity = new ${aggregateName}();
entity.setId(event.getId());
entity.setName(event.getName()); // TODO: map all event fields
repository.save(entity);
}

@QueryHandler(queryName = "find${aggregateName}ById")
public Optional<${aggregateName}Dto> handleFindById(${aggregateName}Id id) {
    return repository.findById(id).map(mapper::toDto);
    }

    @QueryHandler(queryName = "findAll${aggregateName}")
    public List<${aggregateName}Dto> handleFindAll(Void query) {
        return mapper.toDtoList(repository.findAll());
        }
        }
