FROM openjdk:17-slim

RUN apt-get update && apt-get install -y maven git curl unzip && apt-get clean

WORKDIR /plugin

COPY . .

RUN mvn clean install -DskipTests

CMD ["mvn", "test"]
