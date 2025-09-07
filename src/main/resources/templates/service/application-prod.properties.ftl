# ===============================
# PROD PROFILE
# ===============================
spring.datasource.url=jdbc:${database}://prod-db:5432/${serviceName}
spring.datasource.username=${serviceName}_user
spring.datasource.password=changeMeSecure
spring.datasource.driver-class-name=<#if database == "postgres">org.postgresql.Driver
<#elseif database == "oracle">oracle.jdbc.OracleDriver
<#elseif database == "h2">org.h2.Driver</#if>

spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false

# Axon
axon.axonserver.servers=axon-prod:8124
axon.eventhandling.processors.${serviceName}.mode=tracking

<#if camunda == true>
    # Camunda Zeebe
    zeebe.client.broker.gateway-address=zeebe-prod:26500
    zeebe.client.security.plaintext=true
</#if>

# Logging
logging.level.org.springframework=INFO
logging.level.${basePackage}=INFO

