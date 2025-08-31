package ir.ipaam.customer.domain;

import org.axonframework.modelling.command.AggregateIdentifier;
import org.axonframework.spring.stereotype.Aggregate;

@Aggregate
public class CustomerAggregate {

@AggregateIdentifier
private String id;

public CustomerAggregate() {
// default constructor
}
}
