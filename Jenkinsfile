pipeline {
    agent { label 'JDK11'} 
    stages {
        stage('checkout') {
            steps { 
                mail subject: 'build started',
                     body: 'build started',
                     to: 'qtdevops@gmail.com'   
                git branch: "main", url: 'https://github.com/satishnamgadda/spring-petclinic.git'
            }

        }
         stage('artifactory configuaration') {
             steps {
                rtMavenDeployer(
                   id : "MAVEN_DEPLOYER",
                   releaseRepo : "libs-release-local",
                   snapshotRepo : "libs-snapshot-local",
                   serverId : "JFROG_ID"
                )

           }
        }
        stage('Exec Maven') {
            steps {
                rtMavenRun(
                    pom : "pom.xml",
                    goals : "clean install",
                    tool : "mvn",
                    deployerId : "MAVEN_DEPLOYER"
                    
                )
          
            }
        }
        stage('sonar scan') {
            steps {
               withSonarQubeEnv('SONAR_SH') {
                    sh script: 'mvn clean package sonar:sonar'
               }
            }
        }
     
        stage('publish build info') {
            steps {
               rtPublishBuildInfo(
                serverId : "JFROG_ID"
              )
           }
        }
        stage('build the docker image') {
            steps {
                sh 'docker image build -t sonarnew.jfrog.io/spc-docker/spc:1.8 .'

            }
        }
        stage('push the image') {
            steps {
                sh 'docker login -uharikasatish2019@gmail.com sonarnew.jfrog.io'
                sh 'docker tag <IMAGE_ID> sonarnew.jfrog.io/spc-docker/<DOCKER_IMAGE>:<DOCKER_TAG>'
            }
        }
        }
      
    }
    

