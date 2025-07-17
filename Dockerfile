# Use Maven with Java 17 (based on slim OpenJDK image)
FROM maven:3.9.6-eclipse-temurin-17 as builder

# Set working directory
WORKDIR /app

# Copy all project files into container
COPY . .

# Build the Jenkins plugin (skip tests for speed; remove if needed)
RUN mvn clean install -DskipTests

# Optional: use a runtime container if you want to run something with the plugin
# For Jenkins plugin builds only, you typically only need the .hpi file
FROM eclipse-temurin:17-jdk-slim as runtime

# Copy the built HPI from the builder stage
COPY --from=builder /app/target/*.hpi /plugin/

# Set working directory to where the plugin is copied
WORKDIR /plugin

# List plugin file (optional) when container runs
CMD ["ls", "-l", "/plugin"]
