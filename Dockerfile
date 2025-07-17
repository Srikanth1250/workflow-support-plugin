# Use OpenJDK 17 slim image (public, no auth issue)
FROM openjdk:17-slim

# Install Maven and dependencies
RUN apt-get update && \
    apt-get install -y maven git curl unzip && \
    apt-get clean

# Set working directory
WORKDIR /plugin

# Copy everything
COPY . .

# Build the Jenkins plugin
RUN mvn clean install -DskipTests

# Optional default command
CMD ["mvn", "test"]
