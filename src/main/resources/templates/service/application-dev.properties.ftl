# ===============================
# DEV PROFILE
# ===============================
spring.datasource.url=jdbc:${database}://localhost:5432/${serviceName}_dev
spring.datasource.username=${serviceName}_dev
spring.datasource.password=devpass
spring.datasource.driver-class-name=<#if database == "postgres">org.postgresql.Driver
<#elseif database == "oracle">oracle.jdbc.OracleDriver
<#elseif database == "h2">org.h2.Driver</#if>

spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Axon
axon.axonserver.servers=localhost:8124
axon.eventhandling.processors.${serviceName}.mode=subscribing

<#if camunda == true>
    # Camunda Zeebe
    zeebe.client.broker.gateway-address=127.0.0.1:26500
    zeebe.client.security.plaintext=true
</#if>
