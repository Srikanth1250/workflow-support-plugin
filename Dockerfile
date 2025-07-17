# Stage 1: Build the Jenkins plugin
FROM maven:3.9.9-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2: Jenkins with plugin
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y curl
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/
USER jenkins
