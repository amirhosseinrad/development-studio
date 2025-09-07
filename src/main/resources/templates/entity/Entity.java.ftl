package ${basePackage}.domain.model.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Entity
@Table(name = "${entityName?lower_case}")
public class ${entityName} implements Serializable {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

<#-- Loop over fields -->
<#list fields as f>
    private ${f.type} ${f.name};
</#list>

// Getters and setters
public Long getId() { return id; }
public void setId(Long id) { this.id = id; }

<#list fields as f>
    public ${f.type} get${f.name?cap_first}() { return ${f.name}; }
    public void set${f.name?cap_first}(${f.type} ${f.name}) { this.${f.name} = ${f.name}; }
</#list>
}
