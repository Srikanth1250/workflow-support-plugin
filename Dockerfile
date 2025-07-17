# ----------------------------
# Stage 1: Build the plugin with Maven
# ----------------------------
FROM maven:3.9.6-openjdk-17 AS builder

WORKDIR /app

# Copy source files
COPY . .

# Build the Jenkins plugin
RUN mvn clean install -DskipTests

# ----------------------------
# Stage 2: Create Jenkins with the plugin installed
# ----------------------------
FROM jenkins/jenkins:lts

USER root

# Install any required OS packages
RUN apt-get update && apt-get install -y curl

# Create plugins directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy built .hpi plugin from builder stage
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Optionally pre-install other plugins (like unique-id)
RUN jenkins-plugin-cli --plugins unique-id

# Set back to Jenkins user
USER jenkins
