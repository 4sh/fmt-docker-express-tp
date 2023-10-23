# Use an official Maven image as the build environment
FROM maven:3.8.3-openjdk-11-slim as dependencies

# Set the working directory inside the container
WORKDIR /code

# Copy the project's POM file and download dependencies
COPY pom.xml pom.xml
RUN mvn dependency:go-offline

FROM dependencies AS build

# Copy the entire project source code into the container
COPY src src

# Build the application
RUN mvn package -DskipTests

# Use an official Tomcat image for deployment
FROM tomcat:9.0.41-jdk11-openjdk-slim as prod

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/
RUN rm -rf /usr/local/tomcat/webapps.dist/

# Copy your built WAR to the Tomcat webapps directory
COPY --from=build /code/target/real-world-backend-0.0.1.war /usr/local/tomcat/webapps/ROOT.war

# Set JAVA_OPTS based on the ARG value
ENV JAVA_OPTS="-Dspring.profiles.active=dev"

# Starts Tomcat
ENTRYPOINT ["catalina.sh"]
CMD ["run"]
