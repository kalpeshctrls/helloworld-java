# Use OpenJDK base image
FROM openjdk:17-alpine

# Create app directory
WORKDIR /app

# Copy Java source file
COPY HelloWorld.java .

# Compile Java program
RUN javac HelloWorld.java

# Run the compiled Java program
CMD ["java", "HelloWorld"]
