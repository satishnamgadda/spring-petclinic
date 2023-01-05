pipeline {
    agent { label 'JDK11'} 
    stages {
        stage('vcs') {
            steps {    
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
        stage('Build the Code') {
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
      
    }
    
}
