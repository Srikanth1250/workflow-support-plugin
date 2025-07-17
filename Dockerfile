# Use official OpenJDK 17 base image
FROM openjdk:17-jdk-slim

# Install Maven and other required tools
RUN apt-get update && \
    apt-get install -y maven git curl unzip && \
    apt-get clean

# Set working directory
WORKDIR /plugin

# Copy project files
COPY . .

# Build the Jenkins plugin (skipping tests to speed it up)
RUN mvn clean install -DskipTests

# Default command (optional)
CMD ["mvn", "test"]
