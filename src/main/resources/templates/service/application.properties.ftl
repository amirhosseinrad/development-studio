# ===============================
# Spring Boot Application Config
# ===============================

spring.application.name=${serviceName}-service
server.port=8080

# ===============================
# Datasource (Projection Database)
# ===============================
spring.datasource.url=jdbc:${database}://localhost:5432/${serviceName}
spring.datasource.username=${serviceName}_user
spring.datasource.password=secret
spring.datasource.driver-class-name=<#if database == "postgres">org.postgresql.Driver
<#elseif database == "oracle">oracle.jdbc.OracleDriver
<#elseif database == "h2">org.h2.Driver</#if>

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# ===============================
# Axon Config (CQRS/ES)
# ===============================
axon.axonserver.servers=localhost:8124
axon.axonserver.token=
axon.eventhandling.processors.${serviceName}.mode=subscribing

# ===============================
# Camunda 8 (Zeebe)
# ===============================
<#if camunda == true>
    zeebe.client.broker.gateway-address=127.0.0.1:26500
    zeebe.client.security.plaintext=true
</#if>

# ===============================
# Logging
# ===============================
logging.level.org.springframework=INFO
logging.level.${basePackage}=DEBUG
