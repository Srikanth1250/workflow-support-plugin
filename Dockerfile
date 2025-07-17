# Use official OpenJDK 17 slim image
FROM openjdk:17-jdk-slim

# Set environment variables to reduce prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install Maven, Git, Curl, and Unzip
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        maven \
        git \
        curl \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /plugin

# Copy all project files into the container
COPY . .

# Build the Jenkins plugin, skipping tests for faster builds
RUN mvn clean install -DskipTests

# Optional: Set the default command
CMD ["mvn", "test"]
