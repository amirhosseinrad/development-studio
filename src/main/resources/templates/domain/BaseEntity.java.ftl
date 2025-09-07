package ${basePackage}.domain;

import jakarta.persistence.*;
import java.time.Instant;

@MappedSuperclass
public abstract class BaseEntity {

@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private Long id;

@Column(nullable = false, updatable = false)
private Instant createdAt = Instant.now();

@Column(nullable = false)
private Instant updatedAt = Instant.now();

@PreUpdate
protected void onUpdate() {
updatedAt = Instant.now();
}

public Long getId() { return id; }
public Instant getCreatedAt() { return createdAt; }
public Instant getUpdatedAt() { return updatedAt; }
}
