FROM ubuntu:20.04
RUN apt update
RUN apt install openjdk-11-jdk wget -y
RUN wget https://sonarnew.jfrog.io/artifactory/libs-release-local/org/springframework/samples/spring-petclinic/2.7.3/spring-petclinic-2.7.3.jar --user=harikasatish2019@gmail.com --password=AKCp8nyhpRy4fjFft2j92n9DiWVLNfgZjacDTSvZ5Z7gbhqMFAZYc5W43KxTF9idTda7i7S8u
EXPOSE 8080
CMD ["java","-jar","/spring-petclinic-2.7.3.jar"]
