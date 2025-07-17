# Use openjdk instead of maven image
FROM openjdk:17-slim

# Install Maven manually
RUN apt-get update && apt-get install -y maven git curl unzip && apt-get clean

WORKDIR /app

# Copy project files
COPY . .

# Build the project (Jenkins plugin, for example)
RUN mvn clean install -DskipTests

CMD ["mvn", "test"]
