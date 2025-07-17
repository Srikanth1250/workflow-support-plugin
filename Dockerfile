FROM jenkins/jenkins:lts

USER root

# Install curl (optional but good for debugging)
RUN apt-get update && apt-get install -y curl && apt-get clean

# Switch back to the jenkins user
USER jenkins

# Install the unique-id plugin
RUN jenkins-plugin-cli --plugins unique-id
