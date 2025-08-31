<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>${basePackage}</groupId>
    <artifactId>${serviceName}-service</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>
        <#if cqrs>
            <dependency>
                <groupId>org.axonframework</groupId>
                <artifactId>axon-spring-boot-starter</artifactId>
                <version>4.10</version>
            </dependency>
        </#if>
        <#if camunda>
            <dependency>
                <groupId>io.camunda</groupId>
                <artifactId>spring-zeebe-starter</artifactId>
                <version>8.5.0</version>
            </dependency>
        </#if>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
