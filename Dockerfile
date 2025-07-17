# Stage 1: Build the Jenkins plugin
FROM maven:3.9.9-eclipse-temurin-17 AS builder

# Set working directory inside container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Build the plugin (skip tests for speed; remove -DskipTests to run tests)
RUN mvn clean package -DskipTests

# Stage 2: Create Jenkins image with the plugin installed
FROM jenkins/jenkins:lts

USER root

# Optional: Install curl or other CLI tools
RUN apt-get update && apt-get install -y curl && apt-get clean

# Create plugin directory if it doesn't exist
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the built plugin from builder stage
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Switch back to Jenkins user
USER jenkins
