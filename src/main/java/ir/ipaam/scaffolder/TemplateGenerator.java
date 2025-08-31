package ir.ipaam.scaffolder;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.FileWriter;
import java.util.Map;

public class TemplateGenerator {

    private final Configuration cfg;

    public TemplateGenerator() throws Exception {
        cfg = new Configuration(Configuration.VERSION_2_3_33);
        cfg.setClassLoaderForTemplateLoading(getClass().getClassLoader(), "templates");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }

    public void generate(String templateName, Map<String, Object> dataModel, String outputPath) throws Exception {
        Template template = cfg.getTemplate(templateName);
        File outFile = new File(outputPath);
        outFile.getParentFile().mkdirs();
        try (FileWriter writer = new FileWriter(outFile)) {
            template.process(dataModel, writer);
        }
        System.out.println("✅ Generated " + outputPath);
    }
}
