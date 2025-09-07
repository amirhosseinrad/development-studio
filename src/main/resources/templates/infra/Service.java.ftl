package ${basePackage}.infra;

import ${basePackage}.api.dto.${aggregateName}Dto;
import ${basePackage}.domain.${aggregateName}Id;
import ir.ipaam.base.infra.BaseService;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface ${aggregateName}Service extends BaseService<${aggregateName}Dto, ${aggregateName}Id> {
List<${aggregateName}Dto> search(Specification<?> spec);
    }
