package ir.ipaam.scaffolder;

import picocli.CommandLine.Command;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.Callable;


@Command(name = "wizard", description = "Step-by-step wizard to generate a microservice")
public class GenerateWizardCommand implements Callable<Integer> {

    @Override
    public Integer call() {
        Scanner scanner = new Scanner(System.in);

        System.out.println("📦 Service Generator Wizard 🚀");

        System.out.print("👉 Service name: ");
        String serviceName = scanner.nextLine();

        System.out.print("👉 Base package (e.g., ir.ipaam.customer): ");
        String basePackage = scanner.nextLine();

        System.out.print("👉 Enable CQRS/ES with Axon? (y/n): ");
        boolean cqrs = scanner.nextLine().trim().equalsIgnoreCase("y");

        System.out.print("👉 Add Camunda 8 workers? (y/n): ");
        boolean camunda = scanner.nextLine().trim().equalsIgnoreCase("y");

        System.out.print("👉 Projection database [postgres/oracle/h2]: ");
        String database = scanner.nextLine().trim();
        if (database.isEmpty()) {
            database = "postgres";
        }

        System.out.print("📦 Do you want to create entities now? (y/n): ");
        boolean createEntities = scanner.nextLine().trim().equalsIgnoreCase("y");

        while (createEntities) {
            System.out.print("📦 Entity name: ");
            String entityName = scanner.nextLine();

            // Ask fields
            List<Map<String, String>> fields = new ArrayList<>();
            boolean addMore = true;
            while (addMore) {
                System.out.print("📦 Add field? (y/n): ");
                if (!scanner.nextLine().trim().equalsIgnoreCase("y")) {
                    addMore = false;
                    break;
                }
                System.out.print("📦 Field name: ");
                String fieldName = scanner.nextLine();

                System.out.print("📦 Field type [String,int,boolean,LocalDateTime,BigDecimal]: ");
                String fieldType = scanner.nextLine();

                System.out.print("📦 Validation (nullable, unique, length=, min=, max=): ");
                String validation = scanner.nextLine();

                fields.add(Map.of(
                        "name", fieldName,
                        "type", fieldType,
                        "validation", validation
                ));
            }

            Map<String, Object> model = Map.of(
                    "entityName", capitalize(entityName),
                    "basePackage", basePackage,
                    "fields", fields
            );

            try {
                TemplateGenerator generator = new TemplateGenerator();
                String baseDir = "./generated/" + serviceName + "-service";

                if (cqrs) {
                    // Generate Axon CQRS templates
                    generator.generate("commands/CreateCommand.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/domain/command/Create" + entityName + "Command.java");

                    generator.generate("events/CreatedEvent.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/domain/event/" + entityName + "CreatedEvent.java");

                    generator.generate("domain/Aggregate.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/domain/model/aggregate/" + entityName + "Aggregate.java");

                    generator.generate("eventHandler/projection/Projection.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/eventHandler/projection/" + entityName + "Projection.java");

                    generator.generate("api/controller/CommandController.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/api/controller/" + entityName + "CommandController.java");

                    generator.generate("api/controller/QueryController.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/api/controller/" + entityName + "QueryController.java");
                } else {
                    // Generate classic CRUD stack
                    generator.generate("entity/Entity.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/domain/model/entity/" + entityName + ".java");

                    generator.generate("dto/Dto.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/api/dto/" + entityName + "Dto.java");

                    generator.generate("mapper/Mapper.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/infra/" + entityName + "Mapper.java");

                    generator.generate("repository/Repository.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/domain/repository/" + entityName + "Repository.java");

                    generator.generate("service/Service.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/application/service/" + entityName + "Service.java");

                    generator.generate("service/ServiceImpl.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/application/service/" + entityName + "ServiceImpl.java");

                    generator.generate("controller/Controller.java.ftl", model,
                            baseDir + "/src/main/java/" + basePackage + "/api/controller/" + entityName + "Controller.java");
                }


            } catch (Exception e) {
                e.printStackTrace();
            }

            System.out.print("📦 Add another entity? (y/n): ");
            createEntities = scanner.nextLine().trim().equalsIgnoreCase("y");
        }


        // Prepare data model for templates
        Map<String, Object> model = Map.of(
                "serviceName", serviceName,
                "basePackage", basePackage,
                "aggregateName", capitalize(serviceName),
                "cqrs", cqrs,
                "camunda", camunda,
                "database", database,
                "javaVersion", "21"
        );

        try {
            TemplateGenerator generator = new TemplateGenerator();
            String baseDir = "./generated/" + serviceName + "-service";

            // Controllers
            generator.generate("ui/CommandController.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/api/controller/" + capitalize(serviceName) + "CommandController.java");

            generator.generate("ui/QueryController.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/api/controller/" + capitalize(serviceName) + "QueryController.java");

            // DTO
            generator.generate("infra/Dto.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/api/dto/" + capitalize(serviceName) + "Dto.java");

            // Service
            generator.generate("infra/Service.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/application/service/" + capitalize(serviceName) + "Service.java");

            generator.generate("infra/ServiceImpl.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/application/service/" + capitalize(serviceName) + "ServiceImpl.java");

            // Commands & Events
            generator.generate("commands/CreateCommand.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/domain/command/Create" + capitalize(serviceName) + "Command.java");

            generator.generate("events/CreatedEvent.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/domain/event/" + capitalize(serviceName) + "CreatedEvent.java");

            // Aggregate
            generator.generate("domain/Aggregate.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/domain/model/aggregate/" + capitalize(serviceName) + "Aggregate.java");

            // Repository
            generator.generate("infra/Repository.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/domain/repository/" + capitalize(serviceName) + "Repository.java");

            // Projection
            generator.generate("projection/Projection.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                            "/eventHandler/projection/" + capitalize(serviceName) + "Projection.java");

            // Camunda Worker
            if (camunda) {
                generator.generate("camunda/Worker.java.ftl", model,
                        baseDir + "/src/main/java/" + basePackage.replace('.', '/') +
                                "/application/workflow/" + capitalize(serviceName) + "Worker.java");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("\n🎉 Project scaffold generated in ./generated/" + serviceName + "-service");
        return 0;
    }

    private String capitalize(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
}
