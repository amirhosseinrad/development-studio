package ir.ipaam.scaffolder;

import picocli.CommandLine;

import java.util.*;
import java.util.concurrent.Callable;

@CommandLine.Command(name = "generate-entity", description = "Generate a JPA entity with fields")
public class GenerateEntityCommand implements Callable<Integer> {
    @Override
    public Integer call() throws Exception {
        Scanner scanner = new Scanner(System.in);

        System.out.print("👉 Entity name: ");
        String entityName = scanner.nextLine();

        System.out.print("👉 Base package (e.g., ir.ipaam.customer): ");
        String basePackage = scanner.nextLine();

        // Collect fields
        List<Map<String, String>> fields = new ArrayList<>();
        while (true) {
            System.out.print("➕ Add field? (y/n): ");
            String add = scanner.nextLine();
            if (!add.equalsIgnoreCase("y")) break;

            System.out.print("   Field name: ");
            String fieldName = scanner.nextLine();

            System.out.print("   Field type [String, int, boolean, LocalDateTime, BigDecimal]: ");
            String fieldType = scanner.nextLine();

            System.out.print("   Validation (nullable, unique, length=, min=, max=): ");
            String validation = scanner.nextLine();

            Map<String, String> field = new HashMap<>();
            field.put("name", fieldName);
            field.put("type", fieldType);
            field.put("validation", validation);
            fields.add(field);
        }

        // TODO: collect relationships later (OneToMany, ManyToOne)

        Map<String, Object> model = Map.of(
                "entityName", entityName,
                "basePackage", basePackage,
                "fields", fields
        );

        TemplateGenerator generator = new TemplateGenerator();
        String out = "./generated/" + entityName + ".java";
        generator.generate("/domain/BaseEntity.java.ftl", model,
                out);

        System.out.println("✅ Generated entity " + entityName + " at " + out);
        return 0;
    }
}
