package ir.ipaam.scaffolder;

import picocli.CommandLine.Command;

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

        // Prepare data model for templates
        Map<String, Object> model = Map.of(
                "serviceName", serviceName,
                "basePackage", basePackage,
                "aggregateName", capitalize(serviceName),
                "cqrs", cqrs,
                "camunda", camunda,
                "database", database
        );

        try {
            TemplateGenerator generator = new TemplateGenerator();
            String baseDir = "./generated/" + serviceName + "-service";
            generator.generate("pom.xml.ftl", model, baseDir + "/pom.xml");
            generator.generate("Aggregate.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') + "/domain/" + capitalize(serviceName) + "Aggregate.java");
            generator.generate("Application.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') + "/" + capitalize(serviceName) + "Application.java");
            generator.generate("HelloController.java.ftl", model,
                    baseDir + "/src/main/java/" + basePackage.replace('.', '/') + "/ui/HelloController.java");

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
