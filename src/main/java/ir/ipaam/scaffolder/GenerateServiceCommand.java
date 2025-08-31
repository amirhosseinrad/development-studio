package ir.ipaam.scaffolder;

import picocli.CommandLine.Command;
import picocli.CommandLine.Option;

import java.util.concurrent.Callable;

@Command(name = "generate-service", description = "Generate a new DDD + CQRS/ES + Camunda microservice scaffold")
public class GenerateServiceCommand implements Callable<Integer> {

    @Option(names = {"-n", "--name"}, description = "Service name", required = true)
    private String serviceName;

    @Option(names = {"-p", "--package"}, description = "Base package (e.g., com.company.customer)", required = true)
    private String basePackage;

    @Option(names = {"--cqrs"}, description = "Enable Axon CQRS/ES?")
    private boolean cqrs = true;

    @Option(names = {"--camunda"}, description = "Add Camunda 8 workers?")
    private boolean camunda = false;

    @Option(names = {"--db"}, description = "Projection database (postgres, oracle, h2)", defaultValue = "postgres")
    private String database;

    @Override
    public Integer call() {
        System.out.println("📦 Generating service scaffold...");
        System.out.println("  Service name: " + serviceName);
        System.out.println("  Package: " + basePackage);
        System.out.println("  CQRS/ES: " + cqrs);
        System.out.println("  Camunda workers: " + camunda);
        System.out.println("  Database: " + database);

        // Later: pass these to Freemarker template processor
        return 0;
    }
}
