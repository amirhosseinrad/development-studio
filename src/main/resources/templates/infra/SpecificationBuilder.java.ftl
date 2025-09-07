package ${basePackage}.infra;

import ${basePackage}.domain.${aggregateName};
import org.springframework.data.jpa.domain.Specification;

import java.util.Map;

public class ${aggregateName}SpecificationBuilder {

public static Specification<${aggregateName}> build(Map<String, Object> filters) {
return (root, query, cb) -> {
// Start with TRUE predicate
var predicate = cb.conjunction();

if (filters != null) {
for (Map.Entry<String, Object> entry : filters.entrySet()) {
String field = entry.getKey();
Object value = entry.getValue();

if (value == null) continue;

switch (field) {
case "name":
predicate = cb.and(predicate,
cb.like(root.get("name"), "%" + value.toString() + "%"));
break;
case "id":
predicate = cb.and(predicate,
cb.equal(root.get("id"), value));
break;
// TODO: extend for more fields or types
default:
// ignore unknown filters
break;
}
}
}
return predicate;
};
}
}
