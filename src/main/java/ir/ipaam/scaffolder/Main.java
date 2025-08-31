package ir.ipaam.scaffolder;


import picocli.CommandLine;

@CommandLine.Command(name = "ipaam-cli", mixinStandardHelpOptions = true, version = "1.0",
        description = "Scaffolding CLI for DDD + CQRS/ES + Camunda microservices",
        subcommands = {GenerateServiceCommand.class, GenerateWizardCommand.class})
public class Main implements Runnable {
    @Override
    public void run() {
        System.out.println("Welcome to IPPAM CLI 🚀");
        System.out.println("Next step: ask user for service info...");
    }

    public static void main(String[] args) {
        int exitCode = new CommandLine(new Main()).execute(args);
        System.exit(exitCode);
    }
}