package ${basePackage}.api.dto;

public class ${aggregateName}Dto {

<#list fields as f>
    private ${f.type} ${f.name};
</#list>

// Getters & Setters
<#list fields as f>
    public ${f.type} get${f.name?cap_first}() { return ${f.name}; }
    public void set${f.name?cap_first}(${f.type} ${f.name}) { this.${f.name} = ${f.name}; }
</#list>
}
