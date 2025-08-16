# Use official Tomcat with JDK 11
FROM tomcat:9.0-jdk11

# Remove the default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file (change the name if different)
COPY dist/HotelReservationSystem.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
