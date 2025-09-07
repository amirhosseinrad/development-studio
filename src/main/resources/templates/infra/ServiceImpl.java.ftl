package ${basePackage}.infra;

import ${basePackage}.domain.${aggregateName};
import ${basePackage}.domain.${aggregateName}Id;
import ${basePackage}.api.dto.${aggregateName}Dto;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ${aggregateName}ServiceImpl implements ${aggregateName}Service {

private final ${aggregateName}Repository repository;
private final ${aggregateName}Mapper mapper;

public ${aggregateName}ServiceImpl(${aggregateName}Repository repository,
${aggregateName}Mapper mapper) {
this.repository = repository;
this.mapper = mapper;
}

@Override
public ${aggregateName}Dto save(${aggregateName}Dto dto) {
${aggregateName} entity = mapper.toEntity(dto);
return mapper.toDto(repository.save(entity));
}

@Override
public Optional<${aggregateName}Dto> findById(${aggregateName}Id id) {
    return repository.findById(id).map(mapper::toDto);
    }

    @Override
    public List<${aggregateName}Dto> findAll() {
        return repository.findAll()
        .stream()
        .map(mapper::toDto)
        .collect(Collectors.toList());
        }

        @Override
        public void deleteById(${aggregateName}Id id) {
        repository.deleteById(id);
        }

        @Override
        public List<${aggregateName}Dto> search(Specification<?> spec) {
            return repository.findAll((Specification<${aggregateName}>) spec)
            .stream()
            .map(mapper::toDto)
            .collect(Collectors.toList());
            }
            }
