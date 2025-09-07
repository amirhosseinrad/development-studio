package ${basePackage}.domain;

import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.spring.stereotype.Aggregate;

@Aggregate
public class ${aggregateName}Aggregate {

@AggregateIdentifier
private String id;

public ${aggregateName}Aggregate() {
// default constructor
}
}
