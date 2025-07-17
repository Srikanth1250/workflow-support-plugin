# Stage 1: Build the Jenkins plugin using Maven
FROM maven:3.9.6-openjdk-17 AS builder

WORKDIR /app

# Copy everything and build the plugin
COPY . .
RUN mvn clean package

# Stage 2: Create a Jenkins image with the plugin installed
FROM jenkins/jenkins:lts

USER root

# Optional: Install dependencies like curl if needed
RUN apt-get update && apt-get install -y curl

# Create plugin directory if it doesn't exist
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the built plugin from the builder stage
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Switch back to Jenkins user
USER jenkins
