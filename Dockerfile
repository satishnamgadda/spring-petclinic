FROM ubuntu:20.04
RUN apt update
RUN apt install openjdk-11-jdk wget -y
RUN wget https://sonarnew.jfrog.io/artifactory/libs-release-local/org/springframework/samples/spring-petclinic/2.7.3/spring-petclinic-2.7.3.jar 
EXPOSE 8080
CMD ["java","-jar","/spring-petclinic-2.7.3.jar"]