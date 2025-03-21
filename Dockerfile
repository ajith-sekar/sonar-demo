# Base Image
FROM openjdk:8

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 8082

# Install required dependencies and SonarScanner
RUN apt-get update && apt-get install -y unzip wget \
    && wget -O sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-5.0.1.3006-linux.zip \
    && unzip sonar-scanner.zip -d /opt \
    && ln -s /opt/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && rm -rf sonar-scanner.zip

# Copy the application JAR/WAR file
ADD target/petclinic.war petclinic.war

# Define entrypoint
ENTRYPOINT ["java", "-jar", "/petclinic.war"]
