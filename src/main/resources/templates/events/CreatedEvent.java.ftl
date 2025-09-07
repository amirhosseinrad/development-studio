package ${basePackage}.api.events;

import ${basePackage}.domain.${aggregateName}Id;

public class ${aggregateName}CreatedEvent {

private final ${aggregateName}Id id;
private final String name;

public ${aggregateName}CreatedEvent(${aggregateName}Id id, String name) {
this.id = id;
this.name = name;
this.name = name;
}

public ${aggregateName}Id getId() { return id; }
public String getName() { return name; }
}
