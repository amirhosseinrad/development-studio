package ${basePackage}.infra;

import ${basePackage}.domain.${aggregateName};
import ${basePackage}.domain.${aggregateName}Id;
import ir.ipaam.base.infra.BaseRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ${aggregateName}Repository
extends BaseRepository<${aggregateName}, ${aggregateName}Id>,
JpaSpecificationExecutor<${aggregateName} > {
// Custom query methods go here
}
