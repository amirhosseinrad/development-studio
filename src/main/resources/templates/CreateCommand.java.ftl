package ${basePackage}.api.commands;

import org.axonframework.modelling.command.TargetAggregateIdentifier;

public class Create${aggregateName}Command {

@TargetAggregateIdentifier
private final String id;
private final String name;

public Create${aggregateName}Command(String id, String name) {
this.id = id;
this.name = name;
}

public String getId() { return id; }
public String getName() { return name; }
}
