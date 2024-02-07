# Depend on the data-connector-agent service
# Modify or remove this depending on your actual needs


# Use the Hasura GraphQL Data Connector image for the data-connector-agent service
FROM hasura/graphql-data-connector:v2.36.0

# Expose port 8081 for the data-connector-agent service
EXPOSE 8081

# Set environment variables for the data-connector-agent service
ENV QUARKUS_LOG_LEVEL=ERROR
ENV QUARKUS_OPENTELEMETRY_ENABLED=false

# Define health checks for the data-connector-agent service
HEALTHCHECK --interval=5s --timeout=10s --retries=5 --start-period=5s CMD curl -f http://localhost:8081/api/v1/athena/health

# Define volumes
VOLUME /var/lib/postgresql/data



# Use the official PostgreSQL image for the postgres service
FROM postgres:15

# Set environment variables
ENV POSTGRES_PASSWORD=cC1ebgb6CGG1B-Gba434*6FceD1-5-*c

# Create a volume for PostgreSQL data
VOLUME /var/lib/postgresql/data

# Switch to the root directory
WORKDIR /

# Use the Hasura GraphQL Engine image for the graphql-engine service
FROM hasura/graphql-engine:v2.36.0

# Expose port 8080 for Hasura GraphQL Engine
EXPOSE 8080

# Set environment variables for Hasura
ENV HASURA_GRAPHQL_METADATA_DATABASE_URL=postgresql://postgres:cC1ebgb6CGG1B-Gba434*6FceD1-5-*c@roundhouse.proxy.rlwy.net:49328/railway
ENV PG_DATABASE_URL=postgresql://postgres:cC1ebgb6CGG1B-Gba434*6FceD1-5-*c@roundhouse.proxy.rlwy.net:49328/railway
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=true
ENV HASURA_GRAPHQL_DEV_MODE=true
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES=startup,http-log,webhook-log,websocket-log,query-log
ENV HASURA_GRAPHQL_METADATA_DEFAULTS='{"backend_configs":{"dataconnector":{"athena":{"uri":"http://data-connector-agent:8081/api/v1/athena"},"mariadb":{"uri":"http://data-connector-agent:8081/api/v1/mariadb"},"mysql8":{"uri":"http://data-connector-agent:8081/api/v1/mysql"},"oracle":{"uri":"http://data-connector-agent:8081/api/v1/oracle"},"snowflake":{"uri":"http://data-connector-agent:8081/api/v1/snowflake"}}}}'


