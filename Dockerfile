# Use a slim OpenJDK 17 image instead of Maven
FROM openjdk:17-slim

# Install Maven and required tools
RUN apt-get update && apt-get install -y maven git curl unzip && apt-get clean

# Set the working directory
WORKDIR /plugin

# Copy your plugin source code into the image
COPY . .

# Build the plugin (skip tests)
RUN mvn clean install -DskipTests

# Optional: default command
CMD ["mvn", "test"]
