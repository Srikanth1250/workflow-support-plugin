# Use official Maven image with Java 17 (Temurin is required for Jenkins plugins)
FROM maven:3.9.6-eclipse-temurin-17

# Set working directory inside the container
WORKDIR /plugin

# Copy all source files into the container
COPY . .

# Build the Jenkins plugin (skip tests if needed)
RUN mvn clean install -DskipTests

# Optional: Run tests as the default command
CMD ["mvn", "test"]
